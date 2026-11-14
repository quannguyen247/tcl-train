# regex lab3: see the lesson README for the task and inputs.

set instances [list "u_dff_1" "u_mux" "dff_clk" "U_and2" "u_or" "core_reg"]

puts "Example step completed; inspect the output above."
foreach inst $instances {
    if {![regexp {^u_} $inst]} {
        puts $inst
    }
}
