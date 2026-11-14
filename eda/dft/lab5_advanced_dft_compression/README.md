# Lab 5: compression and at-speed examples

These exercises inspect annotated fixtures and calculate estimates; they do not perform timing signoff or run a compression circuit.

Enter an exercise directory and run its Tcl file:

```sh
cd eda/dft/lab5_advanced_dft_compression/<exercise>
tclsh <exercise>.tcl
```

Replace `<exercise>` with a directory name from the table. Run from the repository root before using `cd`.

| Exercise | Task and expected observation |
| --- | --- |
| [lab5_1_at_speed_loc_pulse](lab5_1_at_speed_loc_pulse/) | Identify the fixture OCC and its clock connections; pulse count still needs simulation. |
| [lab5_2_scan_decompressor_xor](lab5_2_scan_decompressor_xor/) | List XOR equations and calculate the number of internal chains per external input. |
| [lab5_3_x_masking_compactor](lab5_3_x_masking_compactor/) | Locate one mask gate. An unknown is blocked only when the associated mask control has the required value. |
| [lab5_4_compression_cost_analyzer](lab5_4_compression_cost_analyzer/) | Estimate shift-only time and tester cost using the provided assumptions. |
| [lab5_5_loc_los_timing_drc](lab5_5_loc_los_timing_drc/) | Compare annotated delays with two periods. Actual LOC/LOS timing needs clocks, constraints, and STA. |

The optional `benchmark/run_compression_benchmark.tcl` compares ideal shift-cycle counts only.
