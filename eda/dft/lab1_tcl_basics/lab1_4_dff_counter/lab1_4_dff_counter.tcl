# lab1 4 dff counter: see the lesson README for the task and inputs.
# Lab 1.4: DFF Counter & Classification

set cells {
    u_gate1/AND2X1
    u_reg1/DFFX1
    u_gate2/OR2X1
    u_reg2/DFFX2
    u_reg3/SDFFX1
    u_reg4/SDFFX2
    u_mux1/MUX2X1
}

set total_cells 0
set dff_count 0
set sdff_count 0
set gate_count 0

foreach cell $cells {
    set total_cells [expr {$total_cells + 1}]
    if {[string match *SDFF* $cell]} {
        set sdff_count [expr {$sdff_count + 1}]
    } elseif {[string match *DFF* $cell]} {
        set dff_count [expr {$dff_count + 1}]
    } else {
        set gate_count [expr {$gate_count + 1}]
    }
}

puts "Total Cells : $total_cells"
puts "DFF Count   : $dff_count"
puts "SDFF Count  : $sdff_count"
puts "Gate Count  : $gate_count"
