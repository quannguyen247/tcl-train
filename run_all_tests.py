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


def find_tclsh() -> str:
    """Return a usable Tcl interpreter or fail with a clear message."""
    candidates = [
        shutil.which("tclsh"),
        shutil.which("tclsh.exe"),
        r"C:\Tcl\bin\tclsh.exe",
        r"C:\Program Files\Tcl\bin\tclsh.exe",
    ]
    for candidate in candidates:
        if candidate and Path(candidate).exists():
            return str(candidate)
    raise FileNotFoundError("tclsh was not found in PATH or a standard Windows location")


def classify(test_file: Path, tclsh: str, timeout: int) -> Result:
    """Run one suite and classify it from the Tcltest summary."""
    env = os.environ.copy()
    env["RUN_ALL"] = "1"
    try:
        completed = subprocess.run(
            [tclsh, test_file.name],
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
    parser = argparse.ArgumentParser(description=__doc__)
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
        tclsh = find_tclsh()
    except FileNotFoundError as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        return 2

    print(f"Tcl interpreter: {tclsh}")
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
