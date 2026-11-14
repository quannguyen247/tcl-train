# Run Fault on the small combinational example in appendix_fault.
# Fault uses its own simulator backend; a nonzero exit is an error, not a result.
set here [file dirname [file normalize [info script]]]
set example [file normalize [file join $here .. .. appendix_fault]]
set build [file join $here build "run_[pid]"]
file mkdir $build
cd $build
set cmd [list fault atpg --cell-model [file join $example cells_sim.v] \
    --clock clk --min-coverage 80 --ceiling 150 --tv-count 50 \
    -o patterns.json [file join $example gates.v]]
puts "Running: $cmd"
if {[catch {exec {*}$cmd 2>@1} output options]} {
    puts stderr "Fault failed; no coverage or pattern result will be reported."
    puts stderr $output
    exit 1
}
puts $output
if {![file isfile patterns.json] || [file size patterns.json] == 0} {
    puts stderr "Fault did not produce a nonempty patterns.json"
    exit 1
}
puts "Actual Fault output: [file join $build patterns.json]"
