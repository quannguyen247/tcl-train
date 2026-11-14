# regex lab2: see the lesson README for the task and inputs.

set constants [list "8'hFF" "16'H12345678" "32'hA5_B6" "64'h1234" "128'hA556_9" "4'b1010" "8'hFZ" "0'hAA" "hFF" "1'h0"]

foreach val $constants {
    if {[regexp {^[1-9]\d*'[hH][a-fA-F0-9_]+$} $val]} {
        puts $val
    }
}
