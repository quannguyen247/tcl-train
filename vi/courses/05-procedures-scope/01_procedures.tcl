# Exercise 01: Procedures and Scope
# Goal: Define procedures with default arguments, global scope, and pass-by-reference using upvar.

# 1. Basic procedure and default parameters
proc tag_instances {instance_list {prefix "scan"}} {
    set tagged_list {}
    foreach instance $instance_list {
        lappend tagged_list "${prefix}_${instance}"
    }
    return $tagged_list
}

# 2. Using global variables
set violation_count 0

proc check_timing {slack} {
    global violation_count
    if {$slack < 0} {
        incr violation_count
    }
}

# 3. Pass-by-reference using upvar
proc scale_delay {delay_var scale_factor} {
    upvar 1 $delay_var local_delay
    set local_delay [expr {$local_delay * $scale_factor}]
}

# 4. Compute average delay (from previous module)
proc average_delay {delay_list} {
    set total_delay 0.0
    set count 0

    foreach delay $delay_list {
        set total_delay [expr {$total_delay + $delay}]
        incr count
    }

    if {$count == 0} {
        return 0.0
    }

    return [expr {$total_delay / $count}]
}

# --- Testing the procedures ---
set cell_names {U1 U2 U3}
puts "Tagged (default): [tag_instances $cell_names]"
puts "Tagged (custom): [tag_instances $cell_names clock]"

check_timing -15
check_timing 5
check_timing -2
puts "Total timing violations: $violation_count"

set gate_delay 1.5
scale_delay gate_delay 1.2
puts "Scaled gate delay: $gate_delay ns"

set gate_delays {0.12 0.18 0.10 0.14}
puts "Average gate delay: [format %.3f [average_delay $gate_delays]] ns"
