# Lab 1: Tcl and EDA basics

Work through these examples before using a synthesis tool. The numbers are teaching inputs.

Enter an exercise directory and run its Tcl file:

```sh
cd eda/dft/lab1_tcl_basics/<exercise>
tclsh <exercise>.tcl
```

Replace `<exercise>` with a directory name from the table. Run from the repository root before using `cd`.

| Exercise | Task and expected observation |
| --- | --- |
| [lab1_1_timing_slack](lab1_1_timing_slack/) | Compute setup slack and clock frequency from given values. Change the data delay and predict the new slack. |
| [lab1_2_sdc_generator](lab1_2_sdc_generator/) | Write example clock and I/O constraints into `build/out_constraints.sdc`. Inspect the generated Tcl brackets. |
| [lab1_3_verilog_parser](lab1_3_verilog_parser/) | Extract names from a small, fixed-format module header. Try a different port declaration and note the limits of regex. |
| [lab1_4_dff_counter](lab1_4_dff_counter/) | Count illustrative cell names. Cell naming is library-specific; Yosys `$_SDFF_` means synchronous-reset DFF, not necessarily scan. |
| [lab1_5_unit_converter](lab1_5_unit_converter/) | Convert ps, ns, us and s to ns. Check that 0.25 ns remains 0.250 ns. |
