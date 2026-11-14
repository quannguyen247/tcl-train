# Lab 7: boundary scan and instrument access

These small software examples illustrate terms used in JTAG and IJTAG. They do not establish standards conformance.

Enter an exercise directory and run its Tcl file:

```sh
cd eda/dft/lab7_boundary_scan_jtag_ijtag/<exercise>
tclsh <exercise>.tcl
```

Replace `<exercise>` with a directory name from the table. Run from the repository root before using `cd`.

| Exercise | Task and expected observation |
| --- | --- |
| [lab7_1_tap_controller_16state](lab7_1_tap_controller_16state/) | Model all 16 TAP state transitions and exercise a reset-to-Shift-IR-to-Update-IR path. |
| [lab7_2_bsr_cell_boundary_scan](lab7_2_bsr_cell_boundary_scan/) | List three fixture boundary-cell instances; the fixture does not define a serial ring. |
| [lab7_3_extest_board_interconnect](lab7_3_extest_board_interconnect/) | Read a synthetic interconnect report with a flagged short. |
| [lab7_4_bypass_idcode_verify](lab7_4_bypass_idcode_verify/) | Decode the sample IDCODE fields and model a one-bit bypass register. |
| [lab7_5_ijtag_1687_sib_network](lab7_5_ijtag_1687_sib_network/) | Compute a hypothetical active-path length from annotated SIB states. |
