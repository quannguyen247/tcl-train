# Tcl for EDA, DFT, and Problem Solving

An English-language Tcl learning repository combining:

- focused language lessons in [`courses/`](courses/);
- 135 active Exercism solutions in [`practices/`](practices/);
- Vivado automation examples in [`vivado/`](vivado/);
- an applied project in [`capstone/`](capstone/).

The examples emphasize readable Tcl that transfers to ASIC/FPGA, EDA,
physical-design, and DFT automation.

## Repository layout

```text
tcl-train/
|-- .github/workflows/ci.yml
|-- README.md
|-- NOTE.md
|-- roadmap.md
|-- courses/
|-- practices/
|-- vivado/
`-- capstone/
```

## Practice collection

The repository follows the 135 exercises marked active by the Exercism Tcl
track on August 11, 2026. Tests and instructions were refreshed from
`exercism/tcl` commit `c42295e0b80f25ec0241d0d49756544c89e3f828`.

The repository contains 135 practice exercises, aligning perfectly with the active exercises currently published on the Exercism web platform for the Tcl track.

Historically, the upstream `exercism/tcl` repository contained 140 exercises. Five of these were subsequently deprecated and removed by the track maintainers. To maintain stable directory identifiers and preserve existing references, the local directories have not been renumbered. Consequently, the directory prefixes range up to `140`, intentionally skipping the five deprecated exercises:

- `accumulate`
- `beer-song`
- `diffie-hellman`
- `minesweeper`
- `scale-generator`

Solutions were compared against the author's Exercism GitHub Syncer backup.
The latest synced iteration is used after removing comments and normalizing
formatting. Two compatibility additions are retained:

- `paasio` normalizes file output to LF so byte counts are stable on Windows.
- `zebra-puzzle` includes its required upstream `lib/permutations` package.

## Requirements

- Tcl 9.0 or newer
- Thread extension 3.0 or newer

The verified local environment is Tcl 9.0.4 with Thread 3.0.6.

## Run one exercise

PowerShell:

```powershell
$env:RUN_ALL = "1"
cd practices/002-acronym
C:\Users\Quan\AppData\Local\Apps\Tcl90\bin\tclsh90.exe acronym.test.tcl -verbose p
```

The `-verbose p` option prints every passing test case. A failing case already
prints its body, actual result, expected result, and stack trace through
`tcltest`.

## Continuous integration

GitHub Actions builds pinned Tcl 9.0.4 and Thread 3.0.6 releases, then runs all
135 suites directly. The workflow:

- enables every Exercism case with `RUN_ALL=1`;
- prints every passing case as `++++ case-name PASSED`;
- preserves full failure details;
- groups logs by exercise;
- writes a suite summary to the Actions job summary;
- fails if fewer than 135 suites are found or any suite fails.

## Coding conventions

- Use four spaces for indentation.
- Brace expressions passed to `if`, `while`, and `expr`.
- Use list and dictionary commands instead of string-shaped data manipulation.
- Keep required exercise APIs unchanged.
- Prefer clear control flow over code golf.
- Keep problem statements in `README.md`, not in solution comments.

## Attribution

Practice statements and tests come from the open-source
[Exercism Tcl track](https://github.com/exercism/tcl). Solutions are the
author's submitted iterations backed up through Exercism GitHub Syncer.

Maintained by [quannguyen247](https://github.com/quannguyen247).
