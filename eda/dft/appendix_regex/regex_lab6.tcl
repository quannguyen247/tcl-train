# regex lab6: see the lesson README for the task and inputs.

set sdc_lines {
    "create_clock -name clk [get_ports clk]"
    "set_input_delay 2.0 [get_ports data_in]"
}

puts "Example step completed; inspect the output above."
foreach sdc $sdc_lines {
    regsub {get_ports (\w+)} $sdc {get_ports [list \1]} result
    puts $result
}
