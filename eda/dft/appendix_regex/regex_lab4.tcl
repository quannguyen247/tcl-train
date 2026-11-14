# regex lab4: see the lesson README for the task and inputs.

set slacks [list "0.05" "-1.25" "+3.14" "12" ".5" "1.2.3" "-.99" "-0.99"]

puts "Example step completed; inspect the output above."
foreach slack $slacks {
    if ([regexp {^[+-]?[0-9]+\.[0-9]+$} $slack]) {
        puts $slack
    }
}
