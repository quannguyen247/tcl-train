# Exercise 03: Loops and Procedures
# Goal: Write a proc to compute an average and use foreach to tag a list of instances.

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

proc tag_instances {instance_list prefix} {
    set tagged_list {}

    foreach instance $instance_list {
        lappend tagged_list "${prefix}_${instance}"
    }

    return $tagged_list
}

set gate_delays {0.12 0.18 0.10 0.14}
set cell_names {U1 U2 U3 U4}

set avg_delay [average_delay $gate_delays]
set tagged_cells [tag_instances $cell_names scan]

puts "Average gate delay: [format %.3f $avg_delay] ns"
puts "Tagged cells: $tagged_cells"
