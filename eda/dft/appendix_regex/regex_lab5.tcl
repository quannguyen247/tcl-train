# regex lab5: see the lesson README for the task and inputs.

set buses [list "\[7:0\]" "\[31:0\]" "\[0:7\]" "7:0" "\[8\]" "\[15:0\]" "\[7:1\]"]

puts "Example step completed; inspect the output above."
foreach bus $buses {
    if {[regexp {^\[[1-9][0-9]*:0\]$} $bus]} {
        puts $bus
    }
}
