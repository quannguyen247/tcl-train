# lab1 3 verilog parser: see the lesson README for the task and inputs.
# Lab 1.3: Verilog Parser (Regex)
set verilog_code {
module full_adder (
    input clk,
    input rst_n,
    input [7:0] a, b,
    input [7:0] c,
    output reg [8:0] sum,
    output reg cout
);
    // Logic internal
endmodule
}

regexp {module\s+(\w+)} $verilog_code _ module_name

set inputs  [list]
set outputs [list]

foreach line [split $verilog_code "\n"] {
    regsub {//.*} $line {} line
    set line [string trim $line]

    if {[regexp {^input\s+(?:\[[^\]]+\]\s+)?(.*)} $line _ chunk]} {
        lappend inputs {*}[regexp -all -inline {\w+} $chunk]
    }

    if {[regexp {^output\s+(?:reg\s+)?(?:\[[^\]]+\]\s+)?(.*)} $line _ chunk]} {
        lappend outputs {*}[regexp -all -inline {\w+} $chunk]
    }
}

puts "Module Name : $module_name"
puts "Inputs      : [join $inputs ", "]"
puts "Outputs     : [join $outputs ", "]"
