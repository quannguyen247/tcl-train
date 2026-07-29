# Exercism Tcl practice collection

This directory contains the 135 exercises marked active by the Exercism Tcl
track on August 11, 2026.

## Exercise layout

```text
NNN-exercise-slug/
├── README.md
├── exercise-slug.tcl
├── exercise-slug.test.tcl
└── testHelpers.tcl
```

`README.md` contains the upstream problem statement. The `.tcl` file contains
the solution, while `.test.tcl` and `testHelpers.tcl` contain the complete
upstream test harness. `zipper` additionally needs `tree.tcl`.

The numeric prefixes preserve the historical ordering. Gaps are expected
because these deprecated exercises were removed:

- `001-accumulate`
- `012-beer-song`
- `031-diffie-hellman`
- `070-minesweeper`
- `111-scale-generator`

## Run all exercises

From the repository root:

```powershell
python run_all_tests.py
```

To inspect output from failing suites:

```powershell
python run_all_tests.py --verbose
```

Tests and instructions were refreshed from `exercism/tcl` commit
`c42295e0b80f25ec0241d0d49756544c89e3f828`.
