# Tcl training

Learn Tcl through small exercises, then use it to automate EDA tools.

## Choose a starting point

| Track | Start here |
| --- | --- |
| Tcl language | [Courses](courses/01-introduction/README.md), then the exercises in `practices/`. |
| Design for test | [DFT learning path](eda/dft/README.md): synthesis, scan, fault tests and a small ASIC capstone. |
| FPGA automation | [Vivado Tcl examples](eda/vivado/README.md). |
| Synthesis scripts | [Yosys template](eda/yosys/README.md). |

Each DFT lesson identifies the input files, the command to run and what to inspect. Start with Labs 1-4 and the scan-counter capstone. The later labs introduce compression, memory test, JTAG, logic BIST and testability through small models.

## Run an exercise

Most language lessons need Tcl only:

```sh
tclsh path/to/exercise.tcl
```

The algorithm practice suites need Tcl 9.0+ and Thread 3.0+. CI tests Tcl 9.1.0 with Thread 3.0.7. From the repository root:

```sh
cd practices/002-acronym
RUN_ALL=1 tclsh acronym.test.tcl -verbose p
```

There are 135 practice directories. Their numbering ends at 140 because five deprecated exercises retain their old numbers as gaps.

For the DFT checks, install Python 3, Tcl 8.6 or newer and Yosys, then run:

```sh
python3 eda/dft/run_labs.py
```

Use `--fault` to include native Fault examples and `--questa` to include RTL and scan-chain simulations. Those options require the corresponding installed tools and, for Questa, a usable license. The runner works in a temporary copy so it keeps generated files out of the course.

## Repository layout

```text
courses/         Tcl lessons
practices/       Algorithm exercises and Tcltest suites
eda/dft/         DFT lessons, fixtures and scan-counter capstone
eda/vivado/      Vivado automation examples
eda/yosys/       Generic synthesis template
capstone/        Tcl application project
NOTE.md          Tcl reference notes
```

GitHub Actions runs the Tcl practice suites and the DFT lesson checks. Physical implementation and licensed-tool simulations are optional local runs.

[MIT License](LICENSE). Fault+ itself is maintained in the separate [fault-plus repository](https://github.com/quannguyen247/fault-plus).
