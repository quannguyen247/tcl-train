# regex lab7: see the lesson README for the task and inputs.

set logs {
    "[2026/08/14 08:30:00] Build started"
    "Log created on 2026/01/01 and updated on 2026/02/15"
}

puts "Example step completed; inspect the output above."
foreach log $logs {
    regsub -all {(\d{4})/(\d{2})/(\d{2})} $log {\1-\2-\3} result
    puts $result
}
