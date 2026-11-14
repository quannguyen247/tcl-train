# Learn DFT with Tcl

Start with [why a chip needs DFT](START_HERE.md). You need basic logic and flip-flops; the first lab introduces the Tcl used in this course.

## Learning order

| Step | Lesson | What to do |
| --- | --- | --- |
| 1 | [Tcl basics](lab1_tcl_basics/README.md) | Read inputs, calculate slack and write a small constraints file. |
| 2 | [Synthesis](lab2_yosys_synthesis/README.md) | Run Yosys, then inspect the netlist and cell reports. |
| 3 | [Scan chains](lab3_dft_scan_insertion/README.md) | Replace toy cells, stitch a chain and simulate shifting. |
| 4 | [Faults and ATPG](lab4_fault_atpg_flow/README.md) | Detect stuck-at faults and read coverage reports. |
| 5 | [Scan-counter capstone](capstone_scan/README.md) | Simulate and synthesize one complete four-bit scan design. Try physical implementation after these checks pass. |
| 6 | [Compression and at-speed test](lab5_advanced_dft_compression/README.md) | Study clocking examples and calculate shift-cycle estimates. |
| 7 | [Memory test](lab6_memory_bist_mbist_bisr/README.md) | Run March C-, inject a fault and explore spare allocation. |
| 8 | [Boundary scan and IJTAG](lab7_boundary_scan_jtag_ijtag/README.md) | Follow TAP transitions and instrument-access examples. |
| 9 | [Logic BIST](lab8_logic_bist_lbist_stumps/README.md) | Generate an LFSR sequence and compare signatures. |
| 10 | [Testability and power](lab9_scoap_testability_lowpower/README.md) | Calculate SCOAP values and compare X filling. |
| 11 | [Diagnosis](diagnosis/README.md) | Find the modeled single faults that match a set of observations. |

For each exercise, read its input and predict the result. Run it, change one value, then explain the difference. The directory numbers remain stable so existing links still work.

## Run

From the repository root:

```sh
python3 eda/dft/run_labs.py
python3 eda/dft/run_labs.py --fault --questa
```

The first command needs Python 3, Tcl 8.6+ and Yosys. `--fault` requires native Fault and its dependencies. `--questa` requires `vlog` and `vsim` with a usable license. Checks run in a temporary copy and failures return a nonzero status.

To run one exercise, enter its directory and execute the listed Tcl file. Labs 2.1 and 3.5 use `yosys -c` instead of `tclsh`. Generated files go under `build/`.

Command references: [regex](appendix_regex/README.md), [Yosys](appendix_yosys/README.md), and [Fault / Fault+](appendix_fault/README.md).

## Understand the outputs

Labs distinguish real tool runs from software models and sample reports. A text-based scan transformation handles its supplied fixture. It is not a general Verilog parser or a full DFT rule checker. The memory and BIST models run in Tcl; sample power and coverage reports are labeled as examples.

The capstone describes scan multiplexers in RTL. Yosys maps that logic to cells; it does not automatically insert a production scan architecture. Its optional Fault campaign cuts flip-flops into pseudo-I/O and uses fixed scan controls. Those patterns still need serialization and timing work before use on a tester.

Direct RTL simulations use Questa. Fault's internal fault-simulation backend uses Icarus because that is how Fault implements the step. The [recorded ASIC run](capstone_scan/RUN_RESULTS.md) documents its own DRC, LVS, timing and simulation scope.
