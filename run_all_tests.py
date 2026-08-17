"""Run every Tcl practice suite and return a CI-friendly exit code."""

from __future__ import annotations

import argparse
import os
import re
import shutil
import subprocess
import sys
from dataclasses import dataclass
from pathlib import Path


EXPECTED_SUITES = 135
SUMMARY_RE = re.compile(
    r"Total\s+(\d+)\s+Passed\s+(\d+)\s+Skipped\s+(\d+)\s+Failed\s+(\d+)",
    re.IGNORECASE,
)
PENDING_MARKERS = (
    "not_implemented",
    "not implemented",
    "implement this procedure",
)


@dataclass(frozen=True)
class Result:
    status: str
    exercise: str
    output: str = ""


def tcl_version(candidate: str) -> tuple[int, int] | None:
    """Return the interpreter's major/minor version."""
    try:
        completed = subprocess.run(
            [candidate],
            input="puts [info tclversion]\n",
            capture_output=True,
            text=True,
            encoding="utf-8",
            errors="replace",
            timeout=10,
            check=False,
        )
        match = re.search(r"(\d+)\.(\d+)", completed.stdout)
        return tuple(map(int, match.groups())) if match else None
    except (OSError, subprocess.TimeoutExpired):
        return None


def find_tclsh(explicit: str | None) -> str:
    """Return a usable tclsh (8.6+) or raise FileNotFoundError."""
    candidates = [
        explicit,
        shutil.which("tclsh90"),
        shutil.which("tclsh9.0"),
        shutil.which("tclsh"),
        shutil.which("tclsh.exe"),
        r"C:\Tcl\bin\tclsh90.exe",
        r"C:\Tcl\bin\tclsh.exe",
        r"C:\Program Files\Tcl\bin\tclsh.exe",
    ]
    best: str | None = None
    for candidate in candidates:
        if not candidate:
            continue
        ver = tcl_version(candidate)
        if ver is None:
            continue
        if ver >= (9, 0):
            return str(candidate)   # prefer Tcl 9 if available
        if ver >= (8, 6) and best is None:
            best = str(candidate)   # fall back to Tcl 8.6
    if best:
        return best
    raise FileNotFoundError(
        "Tcl 8.6 or newer was not found. Install Tcl or pass "
        "--tclsh C:\\path\\to\\tclsh.exe"
    )


def classify(test_file: Path, tclsh: str, timeout: int) -> Result:
    """Run one suite and classify it from the Tcltest summary."""
    env = os.environ.copy()
    env["RUN_ALL"] = "1"
    try:
        completed = subprocess.run(
            [tclsh, "-encoding", "utf-8", test_file.name],
            cwd=test_file.parent,
            capture_output=True,
            text=True,
            encoding="utf-8",
            errors="replace",
            env=env,
            timeout=timeout,
            check=False,
        )
    except subprocess.TimeoutExpired as exc:
        output = (exc.stdout or "") + (exc.stderr or "")
        return Result("ERROR", test_file.parent.name, f"Timed out after {timeout}s\n{output}")
    except OSError as exc:
        return Result("ERROR", test_file.parent.name, str(exc))

    output = completed.stdout + completed.stderr
    summary = SUMMARY_RE.search(output)
    if summary:
        total, passed, skipped, failed = map(int, summary.groups())
        if completed.returncode == 0 and failed == 0 and passed + skipped == total:
            return Result("PASS", test_file.parent.name, output)
        if any(marker in output.lower() for marker in PENDING_MARKERS):
            return Result("PENDING", test_file.parent.name, output)
        return Result("FAIL", test_file.parent.name, output)

    lowered = output.lower()
    if any(marker in lowered for marker in PENDING_MARKERS):
        return Result("PENDING", test_file.parent.name, output)
    if completed.returncode != 0:
        return Result("ERROR", test_file.parent.name, output)
    return Result("PENDING", test_file.parent.name, output)


def main() -> int:
    if hasattr(sys.stdout, 'reconfigure'):
        sys.stdout.reconfigure(encoding='utf-8')
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--tclsh", help="path to a Tcl 9 interpreter")
    parser.add_argument("--timeout", type=int, default=30, help="seconds allowed per suite")
    parser.add_argument("--verbose", action="store_true", help="show output for non-passing suites")
    args = parser.parse_args()

    root = Path(__file__).resolve().parent
    practices = root / "practices"
    test_files = sorted(practices.glob("*/*.test.tcl"))

    if len(test_files) != EXPECTED_SUITES:
        print(
            f"ERROR: expected {EXPECTED_SUITES} suites, found {len(test_files)} in {practices}",
            file=sys.stderr,
        )
        return 2

    try:
        tclsh = find_tclsh(args.tclsh)
    except FileNotFoundError as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        return 2

    tclver = tcl_version(tclsh)
    print(f"Tcl interpreter: {tclsh} (Tcl {'.'.join(map(str, tclver)) if tclver else '?'})")
    if tclver and tclver < (9, 0):
        print(
            f"WARNING: Tcl {'.'.join(map(str, tclver))} detected; "
            "exercises that declare 'package require Tcl 9.0' will fail.\n"
            "         Install Tcl 9 or pass --tclsh to suppress this warning."
        )
    print(f"Exercise suites: {len(test_files)}")

    results = [classify(test_file, tclsh, args.timeout) for test_file in test_files]
    for result in results:
        print(f"[{result.status:<7}] {result.exercise}")
        if args.verbose and result.status != "PASS" and result.output.strip():
            print(result.output.rstrip())

    counts = {
        status: sum(result.status == status for result in results)
        for status in ("PASS", "FAIL", "ERROR", "PENDING")
    }
    print(
        "SUMMARY: "
        f"Total={len(results)} "
        f"PASS={counts['PASS']} "
        f"FAIL={counts['FAIL']} "
        f"ERROR={counts['ERROR']} "
        f"PENDING={counts['PENDING']}"
    )

    return 0 if counts == {"PASS": EXPECTED_SUITES, "FAIL": 0, "ERROR": 0, "PENDING": 0} else 1


if __name__ == "__main__":
    raise SystemExit(main())
