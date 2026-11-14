# regex lab9: see the lesson README for the task and inputs.

set macs {
    "00-1A-2B-3C-4D-5E"
    "AA-BB-CC-DD-EE-FF"
}

puts "Example step completed; inspect the output above."
foreach mac $macs {
    regsub -all -- {-} $mac {:} result
    puts $result
}
