# Ten Yosys commands

From this directory run, for example, `yosys -c yosys_lab1.tcl`. Each script reads `sample_design.v`; mapping examples also use the toy `tech_lib.lib`. Run all ten with `python3 eda/dft/run_labs.py` from the repository root.

| Number | Commands to inspect |
| --- | --- |
| 1 | `read_verilog`, `write_verilog` |
| 2 | `hierarchy` |
| 3 | `procs` |
| 4 | `opt`, `clean` |
| 5 | `fsm` |
| 6 | `memory` |
| 7 | `techmap` |
| 8 | `dfflibmap` |
| 9 | `abc` |
| 10 | `stat` |

The toy Liberty areas are illustrative. They are not estimates for a particular fabrication process or a placed design.
