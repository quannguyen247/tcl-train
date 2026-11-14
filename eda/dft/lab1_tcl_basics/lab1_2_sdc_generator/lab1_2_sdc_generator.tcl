# lab1 2 sdc generator: see the lesson README for the task and inputs.
# Lab 1.2: SDC Constraint Generator

set clocks {
    clk_main 3.0
    clk_io   10.0
}
set inputs {
    data_in[0] 0.5
    data_in[1] 0.5
    valid_in   0.2
}
set outputs {
    data_out[0] 0.4
    data_out[1] 0.4
    ready_out   0.3
}

file mkdir build
set fp [open "build/out_constraints.sdc" w]
puts $fp "# Generated SDC Constraints"

foreach {clk_name period} $clocks {
    puts $fp "create_clock -name $clk_name -period $period \[get_ports {$clk_name}\]"
}

puts $fp ""
foreach {port delay} $inputs {
    puts $fp "set_input_delay -clock clk_main $delay \[get_ports {$port}\]"
}

puts $fp ""
foreach {port delay} $outputs {
    puts $fp "set_output_delay -clock clk_main $delay \[get_ports {$port}\]"
}

close $fp
puts "Example constraints written to build/out_constraints.sdc"
