# Capstone: a four-bit scan counter

The counter increments or holds a four-bit state. In scan mode, `scan_in` enters bit 0 and bit 3 exits through `scan_out`. An active-low asynchronous reset clears the state. Keep reset inactive while shifting or capturing.

Complete Labs 1–4 before this exercise. The scan muxes are written in RTL so you can inspect the shift path directly.

## Simulate and synthesize

Run from the repository root with Questa and Yosys installed:

```sh
vsim -c -l /dev/null -do eda/dft/capstone_scan/sim/run_questa.tcl
yosys -Q -T -c eda/dft/capstone_scan/sim/synth.tcl
SCAN_NETLIST="$PWD/eda/dft/capstone_scan/build/yosys/netlist.v" \
  vsim -c -l /dev/null -do eda/dft/capstone_scan/sim/run_questa.tcl
```

The testbench checks reset, counting, hold, shifting `1011` and functional capture. The last command runs the same checks on the generic synthesized netlist. Yosys may use ordinary flip-flops and mux logic; this does not demonstrate automatic scan-cell insertion.

1. Shift a different word and predict each bit at `scan_out`.
2. Assert reset during shifting and explain what happens to the loaded state.
3. Change the counter width and update the testbench before synthesis.

## Optional physical implementation

The included `config.mk` and `constraint.sdc` target SKY130HD in [OpenROAD Flow Scripts](https://openroad-flow-scripts.readthedocs.io/en/latest/tutorials/FlowTutorial.html). With a complete ORFS installation:

```sh
export ORFS=/absolute/path/to/OpenROAD-flow-scripts
make -C "$ORFS/flow" DESIGN_CONFIG="$PWD/eda/dft/capstone_scan/config.mk"
```

Inspect the resulting netlist, timing reports and GDS in ORFS's output directories. Check that the scan pins remain connected. The SDC provides a simple functional clock. A complete scan-shift/capture constraint set and a pad ring are separate work.

The [recorded reference run](RUN_RESULTS.md) describes an earlier run with pinned tools and its measured results. The [local reproduction guide](local/README.md) explains the compatibility script used for that run. Its BEOL/off-grid DRC, diagnostic LVS and functional simulation have limited scopes; they do not establish foundry signoff.
