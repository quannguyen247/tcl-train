# Recorded local run: 10 November 2026

The command in the [capstone guide](local/README.md) was run from a fresh build directory with `--fault --questa`. This page records what that run did, not a general guarantee for other tool versions or designs.

| Item | Observation |
| --- | --- |
| RTL | Four-bit counter with one RTL-described serial scan path |
| Tools | Yosys 0.68+, OpenROAD v2.0-17598, KLayout 0.26.9, Questa 2025.2 |
| Flow and platform | ORFS `68b1f26134c63d072a19b3a514c5a99effd08501`, SKY130HD |
| RTL simulation | Reset, count, hold, scan shift and capture passed in Questa |
| Generic synthesis simulation | The same test passed on Yosys's generic netlist in Questa |
| Post-route simulation | The same test passed on `6_final.v` using functional SKY130 models, without SDF |
| Fault campaign | On the cut pre-layout netlist, 129 of 144 modeled stuck-at faults were reported covered (89.5833%), with 8 compacted pseudo-I/O vectors |
| Routing | Final detailed-route iteration reported 0 routing violations; the antenna check reported 0 violations |
| Extracted functional timing | With the example 10 ns clock, the report gives worst setup slack 8.20 ns and TNS 0.00 ns; the reported minimum-delay path slack is 0.57 ns |
| GDS DRC | 0 items from the ORFS BEOL and off-grid deck; FEOL checks are disabled in that deck |
| Diagnostic LVS | 13 circuit pairs, including the top, matched. The reference excludes 13 physical-only tap instances and extraction uses a virtual substrate layer |

The deliverable GDS has SHA-256 `457a4f9b4f902d89d364ce624e39067c41a0c4d34ac3284747e1676100d9cef9`. Local generated files are ignored by Git and can be regenerated; on this machine the run is under `build/local_20261110_211445_183583/`. Its `summary.json`, `driver_logs/`, `atpg/`, and `reports/` contain the checks. `results/sky130hd/scan_counter/base/scan_counter.gds` is the GDS, and `6_final.v` is the post-route netlist.

The Fault campaign fixes `scan_enable=0` and `scan_in=0` and uses cut flip-flop pseudo-I/Os. It does not test the serial scan chain or produce ATE-ready scan vectors. Fault's reported uncovered lists were inconsistent with its covered lists; the flow instead checked covered sites against the compacted vectors and computed the 129/144 figure from those sets. The ORFS deck is not a full foundry DRC deck. The diagnostic LVS makes the assumptions listed above and does not independently validate tap-cell connectivity. There is no pad ring, scan-mode STA, SDF simulation, manufacturing test of this counter, or tapeout signoff in this run.
