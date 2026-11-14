# Run from the repository root: yosys -c eda/dft/capstone_scan/sim/synth.tcl
yosys -import
set root [file normalize [file join [pwd] eda dft capstone_scan]]
set build [file join $root build yosys]
file mkdir $build
read_verilog [file join $root rtl scan_counter.v]
hierarchy -check -top scan_counter
synth -top scan_counter
check -assert
stat
write_verilog -noattr [file join $build netlist.v]
write_json [file join $build netlist.json]
puts "Generic synthesis netlist: $build/netlist.v"
