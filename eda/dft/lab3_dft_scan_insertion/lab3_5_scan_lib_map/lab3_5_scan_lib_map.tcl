# Run with: yosys -c lab3_5_scan_lib_map.tcl (from this directory).
# This maps normal logic to an illustrative Liberty file; it does not insert scan.
yosys -import
read_liberty -lib my_scan_lib.lib
read_verilog raw_logic.v
hierarchy -check -top raw_logic
synth -top raw_logic
dfflibmap -liberty my_scan_lib.lib
abc -liberty my_scan_lib.lib
clean
check -assert
stat -liberty my_scan_lib.lib
file mkdir build
write_verilog -noattr build/mapped.v
puts "Mapped teaching netlist: build/mapped.v (scan insertion not performed)"
