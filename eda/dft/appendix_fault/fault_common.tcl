# Shared setup for the Fault command examples. All outputs stay under build/.
namespace eval faultlab {
    variable source_dir [file dirname [file normalize [info script]]]
    proc setup {name} {
        variable source_dir
        set work [file join $source_dir build "${name}_[pid]"]
        file mkdir $work
        foreach filename {seq_design.v alu_comb.v gates.v tech_lib.lib cells_sim.v unused_blackbox.v} {
            file copy [file join $source_dir $filename] [file join $work $filename]
        }
        cd $work
        puts "Working directory: $work"
    }
    proc run {command expected} {
        puts "Running: $command"
        if {[catch {exec {*}$command 2>@1} output]} {
            puts stderr $output
            error "Command failed; no success or coverage is inferred"
        }
        puts $output
        # Some Fault/Yosys combinations return zero after reporting an error.
        if {[regexp -line {^\s*(ERROR:|Syntax error in command)} $output]} {
            error "Tool reported an error despite its zero exit status"
        }
        if {$expected ne "" && (![file isfile $expected] || [file size $expected] == 0)} {
            error "Expected nonempty output not produced: $expected"
        }
    }
    proc synth {} {
        run {fault synth --liberty tech_lib.lib --top seq_design --blackbox-models unused_blackbox.v -o seq_synth.v seq_design.v} seq_synth.v
    }
    proc chain {} {
        run {fault chain --liberty tech_lib.lib --clock clk --reset rst -d DFFARX1 -o seq_chained.v seq_synth.v} seq_chained.v
    }
}
