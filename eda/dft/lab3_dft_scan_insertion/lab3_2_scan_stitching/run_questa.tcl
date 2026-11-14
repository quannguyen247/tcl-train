# From the repository root, run the stitching Tcl first, then this do-file.
onerror {quit -code 1 -f}
onbreak {quit -code 1 -f}
set here [file normalize [file join [pwd] eda dft lab3_dft_scan_insertion lab3_2_scan_stitching]]
set build [file join $here build questa]
file mkdir $build
cd $build
if {![file exists work]} {vlib work}
vlog -sv [file join $here build stitched_scan_netlist.v] [file join $here tb_stitched_scan.sv]
vsim -c -onfinish stop -voptargs=+acc work.tb_stitched_scan
run 150 ns
if {[examine -radix binary /tb_stitched_scan/done] ne "1"} {error "Testbench did not complete"}
quit -code 0 -f
