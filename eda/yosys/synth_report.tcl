# Generic Yosys synthesis example. Run through Yosys's Tcl interpreter.
# Example: yosys -Q -p "tcl eda/yosys/synth_report.tcl my_top rtl/my_top.v build/yosys"

if {$argc != 3} {
    error "usage: synth_report.tcl <top_module> <rtl_file> <output_dir>"
}

lassign $argv top rtl_file output_dir
if {![file isfile $rtl_file]} {
    error "RTL file not found: $rtl_file"
}
file mkdir $output_dir

yosys read_verilog -sv $rtl_file
yosys hierarchy -check -top $top
yosys synth -top $top
yosys check -assert
yosys tee -o [file join $output_dir cells.rpt] stat -top $top
yosys write_json [file join $output_dir netlist.json]
