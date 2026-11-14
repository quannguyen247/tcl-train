# Lab 3: scan cells and connectivity

A functional DFF captures D. A scan cell selects D or serial input SI using SE. An actual flow must also connect the chain and verify clock and reset controllability.

Enter an exercise directory and run its Tcl file:

```sh
cd eda/dft/lab3_dft_scan_insertion/<exercise>
tclsh <exercise>.tcl
```

Replace `<exercise>` with a directory name from the table. Run from the repository root before using `cd`.

| Exercise | Task and expected observation |
| --- | --- |
| [lab3_1_scan_cell_replace](lab3_1_scan_cell_replace/) | Convert the supported two-cell fixture to behavioral scan cells, with scan inputs tied inactive. This is a replacement demonstration, not a stitched chain. |
| [lab3_2_scan_stitching](lab3_2_scan_stitching/) | Connect three fixture cells from `scan_in` to `scan_out`. The generated behavioral model has a Questa testbench. |
| [lab3_3_clock_drc](lab3_3_clock_drc/) | Identify direct clocks and flag other fixture connections for review. A name match cannot prove clock controllability. |
| [lab3_4_reset_drc](lab3_4_reset_drc/) | Recognize the fixture active-low reset forced inactive by an OR gate; flag other resets for review. |
| [lab3_5_scan_lib_map](lab3_5_scan_lib_map/) | Map logic and ordinary flip-flops to the toy Liberty library. This exercise does not insert scan cells. |

For 3.5, run `yosys -c lab3_5_scan_lib_map.tcl` in its exercise directory. For the stitched-chain simulation, return to the repository root and run:

```sh
tclsh eda/dft/lab3_dft_scan_insertion/lab3_2_scan_stitching/lab3_2_scan_stitching.tcl
vsim -c -l /dev/null -do eda/dft/lab3_dft_scan_insertion/lab3_2_scan_stitching/run_questa.tcl
```
