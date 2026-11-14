onerror {quit -code 1 -f}
onbreak {quit -code 1 -f}
# Run this script from the repository root. Questa's "do" does not set
# [info script] to the path of the do-file.
set project [file normalize [file join [pwd] eda dft capstone_scan]]
set build [file join $project build questa]
file mkdir $build
cd $build
if {![file exists work]} {vlib work}
set dut [file join $project rtl scan_counter.v]
if {[info exists ::env(SCAN_NETLIST)]} {
    set dut [file normalize $::env(SCAN_NETLIST)]
    if {![file isfile $dut]} {error "SCAN_NETLIST does not name a file: $dut"}
}
if {[info exists ::env(SCAN_CELL_MODELS)]} {
    set models [file normalize $::env(SCAN_CELL_MODELS)]
    if {![file isfile $models]} {error "SCAN_CELL_MODELS does not name a file: $models"}
    vlog -sv $models
}
vlog -sv $dut [file join $project tb tb_scan_counter.sv]
vsim -c -onfinish stop -voptargs=+acc work.tb_scan_counter
run 200 ns
set done [examine -radix binary /tb_scan_counter/done]
puts "Testbench completion flag: $done"
if {$done ne "1"} {
    error "Testbench did not complete"
}
quit -code 0 -f
