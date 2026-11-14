# Lab 8: logic BIST

A PRPG supplies patterns and a signature register compacts responses. These exercises use software and illustrative inputs.

Enter an exercise directory and run its Tcl file:

```sh
cd eda/dft/lab8_logic_bist_lbist_stumps/<exercise>
tclsh <exercise>.tcl
```

Replace `<exercise>` with a directory name from the table. Run from the repository root before using `cd`.

| Exercise | Task and expected observation |
| --- | --- |
| [lab8_1_lfsr_prpg_generator](lab8_1_lfsr_prpg_generator/) | Generate an 8-bit sequence and verify its 255-state period from a nonzero seed. |
| [lab8_2_misr_signature_analyzer](lab8_2_misr_signature_analyzer/) | Compare sample signatures and calculate the ideal uniform-error aliasing estimate. |
| [lab8_3_stumps_architecture](lab8_3_stumps_architecture/) | Read STUMPS configuration annotations; no self-test is executed. |
| [lab8_4_pr_resistant_test_points](lab8_4_pr_resistant_test_points/) | Inspect candidate test points and example coverage numbers without inserting hardware. |
| [lab8_5_automotive_iso26262_lbist](lab8_5_automotive_iso26262_lbist/) | Compare sample POST time and SPFM with sample thresholds; this is not a compliance assessment. |
