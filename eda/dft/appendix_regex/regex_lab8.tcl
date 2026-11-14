# regex lab8: see the lesson README for the task and inputs.

set codes {
    "assign a = b; // Day la lenh gan"
    "wire clk; // clock signal"
    "reg data; "
}

puts "Example step completed; inspect the output above."
foreach code $codes {
    regsub {//.*} $code {} result
    puts $result
}
