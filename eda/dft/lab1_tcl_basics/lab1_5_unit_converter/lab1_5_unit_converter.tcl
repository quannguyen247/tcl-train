# lab1 5 unit converter: see the lesson README for the task and inputs.
# Lab 1.5: Unit Converter Procedure

proc convert_to_ns {val unit} {
    set res [switch -exact -- $unit {
        "ps"    { expr {$val * 1e-3} }
        "ns"    { expr {$val} }
        "us"    { expr {$val * 1e3} }
        "s"     { expr {$val * 1e9} }
        default { error "Unsupported unit: $unit" }
    }]

    return [format "%.3f" $res]
}

# --- Test cases ---
puts [convert_to_ns 5000 "ps"]
puts [convert_to_ns 0.25 "ns"]
puts [convert_to_ns 0.01 "us"]
