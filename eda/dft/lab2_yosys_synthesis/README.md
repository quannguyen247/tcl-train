# Lab 2: synthesis and reports

Only 2.1 runs synthesis. The other exercises inspect local fixtures; their numbers are not measurements of the capstone.

Enter an exercise directory and run its Tcl file:

```sh
cd eda/dft/lab2_yosys_synthesis/<exercise>
tclsh <exercise>.tcl
```

Replace `<exercise>` with a directory name from the table. Run from the repository root before using `cd`.

| Exercise | Task and expected observation |
| --- | --- |
| [lab2_1_yosys_batch](lab2_1_yosys_batch/) | Synthesize `counter.v` with Yosys; write the netlist under `build/`. |
| [lab2_2_gate_reporter](lab2_2_gate_reporter/) | Classify cell counts from the supplied `stat.txt` sample. |
| [lab2_3_latch_checker](lab2_3_latch_checker/) | Find latch instances already named in a fixture; this does not infer latches from arbitrary RTL. |
| [lab2_4_rename_dff](lab2_4_rename_dff/) | Rename the supported sample instances and write the result under `build/`. |
| [lab2_5_area_vs_speed](lab2_5_area_vs_speed/) | Compare two invented synthesis report areas. Area alone does not establish timing or power. |
| [lab2_6_multi_synth_analysis](lab2_6_multi_synth_analysis/) | Rank the supplied sample reports by area and inspect the comparison. |

For 2.1, run `yosys -c lab2_1_yosys_batch.tcl` instead of `tclsh`.
