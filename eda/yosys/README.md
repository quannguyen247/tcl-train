# Yosys Tcl synthesis template

`synth_report.tcl` loads one Verilog/SystemVerilog source, checks its top module,
runs generic synthesis, checks the resulting netlist, and writes a cell report
and JSON netlist. It is a learning template, not a device-mapped PPA flow.

Run from the repository root with Yosys's Tcl interpreter:

```sh
yosys -Q -p "tcl eda/yosys/synth_report.tcl my_top rtl/my_top.v build/yosys"
```

Replace the module and file path with a real RTL source. The output directory
will contain `cells.rpt` and `netlist.json`. Run it with a small module first and inspect the cell report before adapting it.
