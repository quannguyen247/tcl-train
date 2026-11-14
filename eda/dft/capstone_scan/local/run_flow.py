#!/usr/bin/env python3
"""Reproduce the checked SKY130HD flow with the local container toolchain.

This compatibility route is intentionally pinned to the ORFS revision in
EXPECTED_ORFS and KLayout 0.26.9. It never modifies the ORFS checkout, the PDK,
or the installed containers. Each invocation creates a fresh build directory.
"""
from __future__ import annotations

import argparse
from datetime import datetime
import hashlib
import json
import os
from pathlib import Path
import re
import shlex
import shutil
import subprocess
import sys
import xml.etree.ElementTree as ET


HERE = Path(__file__).resolve().parent
PROJECT = HERE.parent
REPO = PROJECT.parents[2]
EXPECTED_ORFS = "68b1f26134c63d072a19b3a514c5a99effd08501"
IMAGE = "docker.io/efabless/openlane:v0.22"


def quoted(value: Path | str) -> str:
    return shlex.quote(str(value))


def run(name: str, command: list[str], cwd: Path, logs: Path,
        env: dict[str, str] | None = None) -> str:
    log = logs / (name + ".log")
    print(f"Running {name}...", flush=True)
    with log.open("w") as output:
        result = subprocess.run(command, cwd=cwd, env=env, stdout=output, stderr=subprocess.STDOUT, check=False)
    text = log.read_text(errors="replace")
    if result.returncode:
        raise RuntimeError(f"{name} failed (exit {result.returncode}); see {log}\n" + "\n".join(text.splitlines()[-15:]))
    return text


def prepare_reference(top_path: Path, combined_path: Path, out_path: Path) -> int:
    """Build a functional-cell CDL for the old KLayout SPICE reader.

    Tap cells have no signal function and are excluded from this diagnostic
    comparison. Their physical connectivity is not verified by this step.
    """
    top = top_path.read_text()
    top_lines = top.splitlines()
    tap_count = sum(line.startswith("XTAP_TAPCELL_") for line in top_lines)
    if not tap_count:
        raise RuntimeError("No expected tap instances found in the reference CDL")
    top = "\n".join(line for line in top_lines if not line.startswith("XTAP_TAPCELL_")) + "\n"
    source = combined_path.read_text().replace(" topography=normal", "")
    source = "\n".join(line.replace(" / ", " ") if line.lstrip().upper().startswith("X") else line
                       for line in source.splitlines()) + "\n"
    blocks = {m.group(1).lower(): m.group(0) for m in re.finditer(
        r"(?ims)^\.SUBCKT\s+(\S+)[^\n]*\n.*?^\.ENDS[^\n]*\n", source)}
    used = {name.lower() for name in re.findall(r"sky130_fd_sc_hd__\w+", top, re.I)}
    pending = list(used)
    while pending:
        cell = pending.pop()
        if cell not in blocks:
            raise RuntimeError(f"Missing CDL definition: {cell}")
        for dep in re.findall(r"sky130_fd_sc_hd__\w+", blocks[cell], re.I):
            dep = dep.lower()
            if dep != cell and dep not in used:
                used.add(dep)
                pending.append(dep)
    if not used:
        raise RuntimeError("No functional cells found in reference CDL")
    out_path.write_text(top + "\n" + "".join(blocks[cell] for cell in sorted(used)))
    return tap_count


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--orfs", type=Path, required=True, help="ORFS checkout or prepared snapshot")
    parser.add_argument("--openroad-image", type=Path, required=True, help="OpenROAD Apptainer SIF")
    parser.add_argument("--klayout-image", default=IMAGE, help="preinstalled Podman image with KLayout 0.26.9")
    parser.add_argument("--cores", type=int, default=4)
    parser.add_argument("--questa", action="store_true", help="simulate the final netlist with Questa")
    parser.add_argument("--fault", action="store_true", help="run a cut-netlist stuck-at campaign with Fault")
    args = parser.parse_args()
    orfs = args.orfs.resolve()
    image = args.openroad_image.resolve()
    for tool in ("podman", "apptainer", "yosys", "make"):
        if not shutil.which(tool):
            raise RuntimeError(f"Missing tool: {tool}")
    if args.questa and (not shutil.which("vsim") or not shutil.which("vlog")):
        raise RuntimeError("--questa requires vsim and vlog")
    if args.fault and (not shutil.which("fault") or not shutil.which("iverilog")):
        raise RuntimeError("--fault requires Fault and its Icarus backend")
    if args.cores < 1 or not image.is_file() or not (orfs / "flow" / "Makefile").is_file():
        raise RuntimeError("Invalid cores, OpenROAD image, or ORFS path")
    if any(" " in str(path) for path in (REPO, orfs)):
        raise RuntimeError("This pinned ORFS Makefile requires paths without spaces")
    marker = orfs / ".orfs-commit"
    if marker.is_file():
        revision = marker.read_text().strip()
    else:
        revision = subprocess.run(["git", "-C", str(orfs), "rev-parse", "HEAD"],
                                  text=True, capture_output=True, check=True).stdout.strip()
    if revision != EXPECTED_ORFS:
        raise RuntimeError(f"Expected ORFS {EXPECTED_ORFS}, got {revision}")

    try:
        import yaml
    except ImportError as exc:
        raise RuntimeError("The host Python needs PyYAML for the OpenROAD container") from exc

    work = PROJECT / "build" / ("local_" + datetime.now().strftime("%Y%m%d_%H%M%S") + f"_{os.getpid()}")
    tools = work / "tools"
    logs = work / "driver_logs"
    runtime = tools / "runtime"
    runtime.mkdir(parents=True, mode=0o700)
    runtime.chmod(0o700)
    logs.mkdir()
    py_path = tools / "python"
    py_path.mkdir()
    shutil.copytree(Path(yaml.__file__).parent, py_path / "yaml")

    openroad = tools / "openroad"
    openroad.write_text("#!/bin/sh\nexec apptainer exec "
        f"--bind {quoted(str(REPO)+':'+str(REPO))} --bind {quoted(str(orfs)+':'+str(orfs))} "
        f"--env PYTHONPATH={quoted(py_path)} --env QT_QPA_PLATFORM=offscreen "
        f"--env XDG_RUNTIME_DIR={quoted(runtime)} --pwd \"$PWD\" {quoted(image)} openroad \"$@\"\n")
    openroad.chmod(0o755)
    klayout = tools / "klayout"
    klayout.write_text("#!/bin/sh\nexec podman run --rm --pull=never --network none "
        "--security-opt label=disable --userns=keep-id -e QT_QPA_PLATFORM=offscreen "
        "-e HOME=/tmp -e XDG_CONFIG_HOME=/tmp/tcl-train-config "
        f"-v {quoted(str(REPO)+':'+str(REPO)+':rw')} -v {quoted(str(orfs)+':'+str(orfs)+':ro')} "
        f"-w \"$PWD\" --entrypoint /usr/bin/klayout {quoted(args.klayout_image)} -b \"$@\"\n")
    klayout.chmod(0o755)
    flow = orfs / "flow"
    version = run("klayout_version", [str(klayout), "-v"], flow, logs)
    if "KLayout 0.26.9" not in version:
        raise RuntimeError("This compatibility route was validated with KLayout 0.26.9")

    base = Path("sky130hd/scan_counter/base")
    results = work / "results" / base
    objects = work / "objects" / base
    reports = work / "reports" / base
    make = ["make", "-C", str(flow), f"DESIGN_CONFIG={PROJECT / 'config.mk'}", f"WORK_HOME={work}",
            f"OPENROAD_EXE={openroad}", f"YOSYS_EXE={shutil.which('yosys')}",
            f"KLAYOUT_CMD={klayout}", f"NUM_CORES={args.cores}"]
    run("implementation", make + [str(results / "6_final.def"), str(results / "6_final.sdc"),
                                  str(objects / "klayout.lyt"), str(objects / "6_final_concat.cdl")], flow, logs)
    for filename in ("6_final.def", "6_final.v", "6_final.spef", "6_final.cdl"):
        if not (results / filename).is_file():
            raise RuntimeError(f"Missing implementation output: {filename}")

    # ORFS 2025 writes LEF paths relative to RESULTS_DIR; KLayout 0.26
    # interprets these relative to the DEF filename. Use absolute paths.
    tech = objects / "klayout.lyt"
    def absolute_lef(match: re.Match[str]) -> str:
        path = Path(match.group(1))
        path = path if path.is_absolute() else (results / path).resolve()
        if not path.is_file():
            raise RuntimeError(f"Missing LEF: {path}")
        return f"<lef-files>{path}</lef-files>"
    fixed_tech, count = re.subn(r"<lef-files>([^<]+)</lef-files>", absolute_lef, tech.read_text())
    if count != 2:
        raise RuntimeError(f"Expected two LEFs in technology file, found {count}")
    tech.write_text(fixed_tech)

    # KLayout 0.26 uses the older reader property names for routing purposes.
    upstream = (flow / "util" / "def2stream.py").read_text()
    anchor = "layoutOptions = tech.load_layout_options\n"
    if upstream.count(anchor) != 1:
        raise RuntimeError("Unexpected def2stream.py version")
    mapping = ("config = layoutOptions.lefdef_config\n"
               "config.routing_suffix = '.drawing'\nconfig.routing_datatype = 20\n"
               "config.via_geometry_suffix = '.drawing'\nconfig.via_geometry_datatype = 44\n"
               "config.pins_suffix = '.pin'\nconfig.pins_datatype = 16\n")
    converter = tools / "def2stream_compat.py"
    converter.write_text(upstream.replace(anchor, anchor + mapping))
    raw_gds = results / "6_mapped.gds"
    final_gds = results / "scan_counter.gds"
    lvs_gds = results / "lvs_input.gds"
    run("gds_merge", [str(klayout), "-zz", "-rd", "design_name=scan_counter",
        "-rd", f"in_def={results / '6_final.def'}",
        "-rd", f"in_files={flow / 'platforms/sky130hd/gds/sky130_fd_sc_hd.gds'}",
        "-rd", "seal_file=", "-rd", f"out_file={raw_gds}", "-rd", f"tech_file={tech}",
        "-rd", "layer_map=", "-r", str(converter)], flow, logs)
    run("gds_pins", [str(klayout), "-zz", "-rd", f"in_gds={raw_gds}",
        "-rd", f"in_def={results / '6_final.def'}", "-rd", f"out_gds={final_gds}",
        "-rd", f"lvs_gds={lvs_gds}", "-r", str(HERE / "prepare_gds.py")], flow, logs)
    if not final_gds.is_file() or final_gds.stat().st_size == 0:
        raise RuntimeError("The final GDS was not created")

    atpg_result: dict[str, object] | str = "not requested"
    if args.fault:
        atpg_dir = work / "atpg"
        atpg_dir.mkdir()
        liberty = flow / "platforms/sky130hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib"
        model = flow / "platforms/sky130hd/work_around_yosys/formal_pdk.v"
        mapped = results / "1_synth.v"
        normalized = atpg_dir / "normalized.v"
        cut = atpg_dir / "cut.v"
        patterns = atpg_dir / "patterns.json"
        coverage = atpg_dir / "coverage.yml"
        # Fault's cut output needs simple identifiers for its generated testbench.
        yosys_commands = (f"read_liberty -lib {liberty}; read_verilog {mapped}; "
                          "hierarchy -check -top scan_counter; rename -unescape; "
                          f"write_verilog -noattr -noexpr {normalized}")
        run("atpg_normalize", [str(shutil.which("yosys")), "-Q", "-T", "-p", yosys_commands], atpg_dir, logs)
        run("atpg_cut", ["fault", "cut", "--clock", "clk", "--reset", "rst_n", "--reset-active-low",
            "-d", "sky130_fd_sc_hd__dfrtp_1", "-o", str(cut), str(normalized)], atpg_dir, logs)
        if not cut.is_file() or "sky130_fd_sc_hd__dfrtp_1" in cut.read_text():
            raise RuntimeError("Fault did not produce the expected cutaway netlist")
        atpg_log = run("atpg", ["fault", "atpg", "--cell-model", str(model), "--clock", "clk",
            "--reset", "rst_n", "--reset-active-low", "--bypassing", "scan_enable=0",
            "--bypassing", "scan_in=0", "--min-coverage", "80", "--tv-count", "100",
            "--ceiling", "200", "--output-coverage-metadata", str(coverage), "-o", str(patterns),
            str(cut)], atpg_dir, logs)
        if "Simulations concluded: Coverage" not in atpg_log or not patterns.is_file() or not coverage.is_file():
            raise RuntimeError("Fault did not produce a completed campaign and both output files")
        metadata = yaml.safe_load(coverage.read_text())
        vectors = json.loads(patterns.read_text())["coverageList"]
        normalize = lambda name: name.lstrip("\\")
        sites = {normalize(name) for name in metadata["faultPoints"]}
        if not sites or len(sites) != len(metadata["faultPoints"]):
            raise RuntimeError("Fault site names are empty or ambiguous after normalization")
        covered_count = 0
        metadata_consistent = True
        for kind in ("sa0", "sa1"):
            covered = {normalize(name) for name in metadata[kind + "Covered"]}
            reported_uncovered = {normalize(name) for name in metadata[kind + "Uncovered"]}
            vector_coverage = {normalize(name) for vector in vectors for name in vector["coverage"][kind]}
            if not covered <= sites or vector_coverage != covered:
                raise RuntimeError(f"Fault {kind} covered sites do not agree with the compacted vectors")
            if reported_uncovered != sites - covered:
                metadata_consistent = False
            covered_count += len(covered)
        ratio = covered_count / (2 * len(sites))
        if abs(ratio - float(metadata["ratio"])) > 0.00001:
            raise RuntimeError("Fault coverage ratio does not agree with the covered site sets")
        if not metadata_consistent:
            print("WARNING: Fault's uncovered lists are inconsistent; the summary uses set differences.", flush=True)
        atpg_result = {"fault_sites": len(sites), "detected_stuck_faults": covered_count,
            "total_stuck_faults": 2 * len(sites), "coverage_percent": round(100 * ratio, 4),
            "compacted_vectors": len(vectors), "reported_uncovered_lists_consistent": metadata_consistent,
            "scope": "pre-layout cut combinational logic; scan_enable=0, scan_in=0; pseudo-I/O vectors"}

    drc_deck = flow / "platforms/sky130hd/drc/sky130hd.lydrc"
    deck_text = drc_deck.read_text()
    if not all(re.search(pattern, deck_text) for pattern in
               (r"FEOL\s*=\s*false", r"BEOL\s*=\s*true", r"OFFGRID\s*=\s*true")):
        raise RuntimeError("Unexpected DRC deck scope")
    drc_report = reports / "scan_counter_drc.lyrdb"
    run("drc", [str(klayout), "-zz", "-rd", f"in_gds={final_gds}",
        "-rd", f"report_file={drc_report}", "-r", str(drc_deck)], flow, logs)
    drc_count = len(ET.parse(drc_report).getroot().findall(".//item"))
    if drc_count:
        raise RuntimeError(f"DRC reported {drc_count} items; inspect {drc_report}")

    cdl = objects / "functional_reference.cdl"
    tap_count = prepare_reference(results / "6_final.cdl", objects / "6_final_concat.cdl", cdl)
    lvs_source = (flow / "platforms/sky130hd/lvs/sky130hd.lylvs").read_text()
    if lvs_source.count("  report($report_file)") != 1:
        raise RuntimeError("Unexpected LVS deck format")
    lvs_deck = tools / "lvs_report.lylvs"
    lvs_deck.write_text(lvs_source.replace("  report($report_file)", "  report_lvs($report_file)"))
    lvs_report = reports / "scan_counter_lvs.lvsdb"
    lvs_log = run("lvs", [str(klayout), "-b", "-rd", f"in_gds={lvs_gds}",
        "-rd", f"cdl_file={cdl}", "-rd", f"report_file={lvs_report}", "-r", str(lvs_deck)], flow, logs)
    if "Netlists match." not in lvs_log or "Netlists don't match" in lvs_log or not lvs_report.is_file():
        raise RuntimeError(f"LVS did not report a match; inspect {logs / 'lvs.log'}")
    verification = run("lvs_database", [str(klayout), "-zz", "-rd", f"lvs_file={lvs_report}",
        "-r", str(HERE / "check_lvs.py")], flow, logs)
    if "LVS database:" not in verification or "ERROR" in verification:
        raise RuntimeError(f"LVS database check failed; inspect {logs / 'lvs_database.log'}")

    questa_status = "not requested"
    if args.questa:
        env = os.environ.copy()
        env["SCAN_NETLIST"] = str(results / "6_final.v")
        env["SCAN_CELL_MODELS"] = str(flow / "platforms/sky130hd/work_around_yosys/formal_pdk.v")
        sim = run("questa_post_route", ["vsim", "-c", "-l", os.devnull, "-do",
            str(PROJECT / "sim" / "run_questa.tcl")], REPO, logs, env=env)
        if "PASS: reset, functional count, hold, scan shift and capture" not in sim:
            raise RuntimeError(f"Questa did not report test completion; inspect {logs / 'questa_post_route.log'}")
        questa_status = "passed using functional cell models; no SDF"

    timing_report = (reports / "6_finish.rpt").read_text()
    slack_match = re.search(r"worst slack\s+(-?[0-9.]+)", timing_report)
    if slack_match is None:
        raise RuntimeError("Could not find worst slack in the final timing report")

    result = {"orfs_revision": revision, "gds": str(final_gds),
              "gds_sha256": hashlib.sha256(final_gds.read_bytes()).hexdigest(),
              "drc_items": drc_count, "drc_scope": "BEOL and off-grid; FEOL disabled",
              "lvs": "matched with virtual substrate and functional-cell reference",
              "tap_instances_excluded_from_reference": tap_count,
              "functional_worst_slack_ns": float(slack_match.group(1)),
              "questa_post_route": questa_status,
              "fault_atpg": atpg_result,
              "reports": str(reports), "results": str(results)}
    (work / "summary.json").write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps(result, indent=2))
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (OSError, RuntimeError, subprocess.CalledProcessError) as error:
        print(f"ERROR: {error}", file=sys.stderr)
        raise SystemExit(1)
