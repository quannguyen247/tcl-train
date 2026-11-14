# regex lab10: see the lesson README for the task and inputs.

set reports {
    "Path 1: status = VIOLATED, slack = -0.45 ns"
    "Path 2: status = VIOLATED, slack = -1.204 ns"
}

puts "Example step completed; inspect the output above."
foreach log $reports {
    regsub {slack = -\d+\.\d+} $log {slack = <REDACTED>} result

    puts $result
}
