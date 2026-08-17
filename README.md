# Tcl for EDA, DFT, and Problem Solving

This repository is an English-language Tcl learning path that combines:

- focused language lessons in [`courses/`](courses/);
- 135 active Exercism Tcl exercises in [`practices/`](practices/);
- Vivado-oriented automation examples in [`vivado/`](vivado/);
- a larger applied project in [`capstone/`](capstone/).

The material emphasizes readable, idiomatic Tcl that transfers to ASIC/FPGA,
EDA, physical-design, and DFT automation.

## Repository layout

```text
tcl-train/
├── README.md
├── NOTE.md
├── roadmap.md
├── run_all_tests.py
├── courses/
├── practices/
├── vivado/
└── capstone/
```

## Practice exercises

The collection follows the 135 active practice exercises in the Exercism Tcl
track as checked on August 11, 2026. Exercise tests and instructions were
refreshed from `exercism/tcl` commit
`c42295e0b80f25ec0241d0d49756544c89e3f828`.

Five exercises present in the older 140-exercise snapshot are now deprecated
and are intentionally excluded:

- `accumulate`
- `beer-song`
- `diffie-hellman`
- `minesweeper`
- `scale-generator`

Exercism can update the track later, so 135 is a verified snapshot rather than
a permanent platform guarantee.

Each exercise directory contains its instructions, solution, test suite, and
the upstream test helper required to enable the full test set.

## Run the complete practice suite

Install Tcl 9.0 or newer and ensure `tclsh90` is available in `PATH`, then run:

```powershell
python run_all_tests.py
```

The runner enables every Exercism test case and returns a non-zero exit code
when any suite fails, errors, times out, or remains unimplemented.

To use a portable Tcl 9 build without changing `PATH`:

```powershell
python run_all_tests.py --tclsh C:\path\to\tclsh90.exe
```

## Coding conventions

- Use four spaces for indentation.
- Brace expressions passed to `if`, `while`, and `expr`.
- Prefer Tcl list and dictionary commands over string-shaped data handling.
- Keep procedures small and explicit about mutation.
- Comment decisions and edge cases, not obvious syntax.
- Preserve an exercise's required public API.

## Attribution

The practice statements and tests come from the open-source
[Exercism Tcl track](https://github.com/exercism/tcl). Solutions in this
repository are the author's work, including iterations backed up through the
Exercism GitHub Syncer.

Maintained by [quannguyen247](https://github.com/quannguyen247).
