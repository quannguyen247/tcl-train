# Exercism Tcl practice collection

This directory contains the 135 exercises marked active by the Exercism Tcl
track on August 11, 2026.

## Exercise layout

```text
NNN-exercise-slug/
|-- README.md
|-- exercise-slug.tcl
|-- exercise-slug.test.tcl
`-- testHelpers.tcl
```

`README.md` contains the problem statement. The solution is in
`exercise-slug.tcl`; the test suite and shared test support are in
`exercise-slug.test.tcl` and `testHelpers.tcl`.

Required exceptions:

- `zipper` also contains `tree.tcl`.
- `zebra-puzzle` also contains `lib/permutations.tcl` and `lib/pkgIndex.tcl`.

Numeric gaps are expected because these deprecated exercises were removed:

- `001-accumulate`
- `012-beer-song`
- `031-diffie-hellman`
- `070-minesweeper`
- `111-scale-generator`

## Run an exercise

Set `RUN_ALL=1` so tests marked with Exercism's progressive `skip` statements
also run:

```powershell
$env:RUN_ALL = "1"
cd 002-acronym
C:\Users\Quan\AppData\Local\Apps\Tcl90\bin\tclsh90.exe acronym.test.tcl -verbose p
```

GitHub Actions runs the same command for every suite and shows every individual
case in its log.

Tests and instructions were refreshed from `exercism/tcl` commit
`c42295e0b80f25ec0241d0d49756544c89e3f828`.
