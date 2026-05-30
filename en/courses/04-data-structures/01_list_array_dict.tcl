# Exercise 04: Data Structures
# Goal: Use list, array, and dict to summarize simple timing information.

set clock_domains {core_clk io_clk test_clk}
set path_slacks [dict create path_a 120.5 path_b -15.2 path_c 48.0 path_d 7.8]

array set cell_count {
    FF   1280
    AND2 540
    INV  220
}

set worst_path ""
set worst_slack 1e9

dict for {path_name slack_ps} $path_slacks {
    if {$slack_ps < $worst_slack} {
        set worst_slack $slack_ps
        set worst_path $path_name
    }
}

set sorted_domains [lsort $clock_domains]

puts "Clock domains: $sorted_domains"
puts "Cell types: [array names cell_count]"
puts "Worst slack path: $worst_path ($worst_slack ps)"
