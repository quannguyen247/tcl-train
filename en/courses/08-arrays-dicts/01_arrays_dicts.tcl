# Exercise: Arrays and Dictionaries in EDA
# Scenario: Managing cell statistics and timing paths

# 1. ARRAYS: Cell instantiation counts
# Create an array 'instances' and set some counts
array set instances {
    BUF_X1 1500
    INV_X2 3200
    DFF_X1 450
}

# Update the count for DFF_X1 to 460
set instances(DFF_X1) 460

# Add a new cell type NAND2_X1 with count 800
set instances(NAND2_X1) 800

# Print all cell types and their counts
puts "--- Instance Counts ---"
foreach cell [array names instances] {
    puts "$cell: $instances($cell)"
}

# 2. DICTIONARIES: Timing path summaries
# Create a nested dictionary for paths
set paths [dict create]
dict set paths Path1 from FF1/CK
dict set paths Path1 to FF2/D
dict set paths Path1 slack -0.15

dict set paths Path2 from IN_A
dict set paths Path2 to FF3/D
dict set paths Path2 slack 0.20

puts "\n--- Timing Paths ---"
# Iterate over dict and print paths with negative slack (violating paths)
dict for {path_name info} $paths {
    set slack [dict get $info slack]
    if {$slack < 0.0} {
        puts "VIOLATION: $path_name (Slack: $slack)"
        puts "  From: [dict get $info from]"
        puts "  To:   [dict get $info to]"
    }
}
