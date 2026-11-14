#!/usr/bin/env python3
"""Run the DFT teaching examples in a temporary copy of the course."""

from __future__ import annotations

import argparse
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile


DFT = Path(__file__).resolve().parent
EXPECTED = {
    "lab1_5_unit_converter.tcl": ("5.000", "0.250", "10.000"),
    "lab3_3_clock_drc.tcl": ("direct=1 review=1",),
    "lab3_4_reset_drc.tcl": ("overrides=1 review=1",),
    "lab4_2_coverage_extractor.tcl": ("147/150", "98.00%"),
    "lab4_3_random_fault_sim.tcl": ("72.00%", "98.00%", "26.00 percentage points"),
    "lab6_2_march_c_minus_engine.tcl": ("10240 operations, 0 read mismatches",),
    "lab6_4_bisr_redundancy_alloc.tcl": ("row=42, column=7; uncovered=0",),
    "lab7_4_bypass_idcode_verify.tcl": ("part=0xBA00", "manufacturer=0x23B"),
    "lab8_1_lfsr_prpg_generator.tcl": ("period=255",),
    "lab9_1_scoap_controllability_cc.tcl": ("N_AND: CC0=2 CC1=3",),
    "lab9_2_scoap_observability_co.tcl": ("A: CO=2; B: CO=2",),
    "lab9_5_adjacent_x_filling_flow.tcl": ("adjacent-fill=100001111110001 transitions=4",),
    "exhaustive_stuck_at.tcl": ("Detected 10/10 modeled stuck-at faults",),
}


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--fault", action="store_true", help="also run the installed Fault examples")
    parser.add_argument("--questa", action="store_true", help="also run RTL and synthesized-netlist simulations")
    args = parser.parse_args()

    required = ["tclsh", "yosys"]
    if args.fault:
        required.append("fault")
    if args.questa:
        required += ["vlog", "vsim"]
    missing = [tool for tool in required if shutil.which(tool) is None]
    if missing:
        print("Missing required tools: " + ", ".join(missing), file=sys.stderr)
        return 2

    failures: list[str] = []
    checks = 0
    with tempfile.TemporaryDirectory(prefix="tcl-train-dft-") as temp:
        repo = Path(temp) / "repo"
        course = repo / "eda" / "dft"
        course.parent.mkdir(parents=True)
        shutil.copytree(DFT, course, ignore=shutil.ignore_patterns("build", "work", "__pycache__"))

        def run(name: str, command: list[str], cwd: Path, *, expected: tuple[str, ...] = (),
                should_fail: bool = False, env: dict[str, str] | None = None) -> None:
            nonlocal checks
            checks += 1
            try:
                result = subprocess.run(command, cwd=cwd, env=env, text=True,
                                        stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                                        timeout=120, check=False)
            except (OSError, subprocess.TimeoutExpired) as exc:
                failures.append(f"{name}: {exc}")
                print(f"FAIL {name}: {exc}")
                return
            code_ok = result.returncode != 0 if should_fail else result.returncode == 0
            absent = [item for item in expected if item not in result.stdout]
            if code_ok and not absent:
                print(f"PASS {name}")
            else:
                failures.append(name)
                print(f"FAIL {name}: exit={result.returncode}, missing={absent}")
                print("\n".join(result.stdout.splitlines()[-12:]))

        examples = sorted(course.glob("lab[1-9]*/*/lab*.tcl"))
        for script in examples:
            if script.name == "lab4_1_fault_atpg_run.tcl" and not args.fault:
                print("SKIP Fault ATPG (pass --fault to run it)")
                continue
            yosys = script.name in {"lab2_1_yosys_batch.tcl", "lab3_5_scan_lib_map.tcl"}
            command = ["yosys", "-Q", "-T", "-c", script.name] if yosys else ["tclsh", script.name]
            run(script.name, command, script.parent, expected=EXPECTED.get(script.name, ()))

        for appendix in ("appendix_regex", "appendix_yosys"):
            for script in sorted((course / appendix).glob("*_lab*.tcl")):
                command = (["yosys", "-Q", "-T", "-c", script.name]
                           if appendix == "appendix_yosys" else ["tclsh", script.name])
                run(script.name, command, script.parent)

        fault_model = course / "lab4_fault_atpg_flow" / "lab4_1_fault_atpg_run" / "exhaustive_stuck_at.tcl"
        run(fault_model.name, ["tclsh", fault_model.name], fault_model.parent,
            expected=EXPECTED[fault_model.name])

        benchmark = course / "lab5_advanced_dft_compression" / "benchmark"
        run("Ideal scan shift cycles", ["tclsh", "run_compression_benchmark.tcl"], benchmark,
            expected=("serial=70000000 parallel=700000",))

        march = course / "lab6_memory_bist_mbist_bisr" / "lab6_2_march_c_minus_engine"
        run("March detects stuck-at-0", ["tclsh", "lab6_2_march_c_minus_engine.tcl", "stuck-at-0"],
            march, should_fail=True, expected=("read mismatches",))
        retention = course / "lab6_memory_bist_mbist_bisr" / "lab6_3_retention_test_pause"
        run("Retention detects injected flip", ["tclsh", "lab6_3_retention_test_pause.tcl", "inject-bitflip"],
            retention, should_fail=True, expected=("mismatches=1",))

        reset_lab = course / "lab3_dft_scan_insertion" / "lab3_4_reset_drc"
        reset_fixture = reset_lab / "reset_drc_netlist.v"
        reset_fixture.write_text(reset_fixture.read_text().replace("unblocked_rst_n", "unsafe_rst_n"))
        run("Reset check rejects misleading name", ["tclsh", "lab3_4_reset_drc.tcl"], reset_lab,
            expected=("overrides=1 review=1",))

        diagnosis = course / "diagnosis"
        run("Diagnosis candidates", ["tclsh", "single_fault.tcl"], diagnosis,
            expected=("Candidates: a/0, b/0, n/0",))
        run("Diagnosis rejects inconsistent observations", ["tclsh", "single_fault.tcl", "inconsistent"],
            diagnosis, should_fail=True, expected=("No single modeled fault explains",))

        if args.fault:
            for script in sorted((course / "appendix_fault").glob("fault_lab*.tcl")):
                run(script.name, ["tclsh", script.name], script.parent)
        else:
            print("SKIP Fault appendix (pass --fault to run it)")

        if args.questa:
            stitch = "eda/dft/lab3_dft_scan_insertion/lab3_2_scan_stitching/run_questa.tcl"
            capstone = "eda/dft/capstone_scan/sim/run_questa.tcl"
            run("Questa stitched scan", ["vsim", "-c", "-l", os.devnull, "-do", stitch], repo,
                expected=("PASS: stitched three-cell scan chain",))
            run("Questa scan RTL", ["vsim", "-c", "-l", os.devnull, "-do", capstone], repo,
                expected=("PASS: reset, functional count, hold, scan shift and capture",))
            run("Yosys capstone synthesis", ["yosys", "-Q", "-T", "-c",
                "eda/dft/capstone_scan/sim/synth.tcl"], repo)
            env = os.environ.copy()
            env["SCAN_NETLIST"] = str(course / "capstone_scan" / "build" / "yosys" / "netlist.v")
            run("Questa synthesized scan netlist", ["vsim", "-c", "-l", os.devnull, "-do", capstone],
                repo, expected=("PASS: reset, functional count, hold, scan shift and capture",), env=env)
            rtl = course / "capstone_scan" / "rtl" / "scan_counter.v"
            original = rtl.read_text()
            mutant_text = original.replace("assign scan_out = state[3];", "assign scan_out = state[2];")
            if mutant_text == original:
                failures.append("Could not prepare scan-out mutation")
            else:
                mutant = course / "capstone_scan" / "build" / "scan_out_mutant.v"
                mutant.write_text(mutant_text)
                env["SCAN_NETLIST"] = str(mutant)
                run("Questa catches broken scan-out", ["vsim", "-c", "-l", os.devnull, "-do", capstone],
                    repo, should_fail=True, expected=("scan_out: expected",), env=env)
        else:
            print("SKIP Questa simulations (pass --questa to run them)")

    print(f"Checks: {checks}, failures: {len(failures)}")
    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main())
