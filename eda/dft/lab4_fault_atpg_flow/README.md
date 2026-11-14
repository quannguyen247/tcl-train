# Lab 4: faults, patterns, and reports

A stuck-at fault fixes a selected net or pin at 0 or 1. A pattern detects it when the faulty and fault-free outputs differ.

Enter an exercise directory and run its Tcl file:

```sh
cd eda/dft/lab4_fault_atpg_flow/<exercise>
tclsh <exercise>.tcl
```

Replace `<exercise>` with a directory name from the table. Run from the repository root before using `cd`.

| Exercise | Task and expected observation |
| --- | --- |
| [lab4_1_fault_atpg_run](lab4_1_fault_atpg_run/) | Run Fault on a two-gate combinational fixture. `exhaustive_stuck_at.tcl` independently enumerates a five-net toy model. |
| [lab4_2_coverage_extractor](lab4_2_coverage_extractor/) | Validate counts in an invented coverage report. DPM is a sample field; coverage alone cannot determine it. |
| [lab4_3_random_fault_sim](lab4_3_random_fault_sim/) | Compare two internally consistent sample reports in percentage points. |
| [lab4_4_tristate_isolation](lab4_4_tristate_isolation/) | Gate enable with `~test_mode` in a restricted fixture and inspect the output. This is not a general netlist transformer. |
| [lab4_5_full_dft_pipeline](lab4_5_full_dft_pipeline/) | Summarize prewritten sample files. The script does not run synthesis, scan insertion, or ATPG. |

For 4.1, install Fault and its dependencies. The result is specific to the named gate-level fixture. `exhaustive_stuck_at.tcl` has no Fault dependency.
