# Lab 9: testability and test power

Controllability and observability are structural heuristics. A transition count is only a rough proxy for switching activity.

Enter an exercise directory and run its Tcl file:

```sh
cd eda/dft/lab9_scoap_testability_lowpower/<exercise>
tclsh <exercise>.tcl
```

Replace `<exercise>` with a directory name from the table. Run from the repository root before using `cd`.

| Exercise | Task and expected observation |
| --- | --- |
| [lab9_1_scoap_controllability_cc](lab9_1_scoap_controllability_cc/) | Calculate CC0 and CC1 for the supplied AND and OR gates. |
| [lab9_2_scoap_observability_co](lab9_2_scoap_observability_co/) | Back-propagate CO through a two-input AND gate. |
| [lab9_3_test_point_insertion_tpi](lab9_3_test_point_insertion_tpi/) | Rank a sample candidate; the post-insertion score is an input, not a computed result. |
| [lab9_4_low_power_scan_gating](lab9_4_low_power_scan_gating/) | Compare two sample power numbers against a given limit; no power is measured. |
| [lab9_5_adjacent_x_filling_flow](lab9_5_adjacent_x_filling_flow/) | Fill unspecified bits from their predecessor and count transitions against zero filling. |
