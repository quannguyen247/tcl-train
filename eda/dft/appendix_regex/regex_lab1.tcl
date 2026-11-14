# regex lab1: see the lesson README for the task and inputs.

set signals [list "clk" "_reset_n" "123data" "data_in" "my-sig" "valid_1_2"]

puts "Example step completed; inspect the output above."
foreach sig $signals {
    if {[regexp {^[a-zA-Z_]\w*$} $sig]} {
        puts $sig
    }
}
