# Exercise 02: Control Flow
# Goal: Use if/elseif/else and switch to classify timing status and suggest an optimization focus.

set slack_ps -35
set wire_delay_pct 34.62
set optimization_mode "timing"

if {$slack_ps < 0} {
    set timing_status "VIOLATION"
} elseif {$slack_ps < 50} {
    set timing_status "MARGIN"
} else {
    set timing_status "SAFE"
}

switch -- $optimization_mode {
    timing {
        set recommendation "Prioritize timing optimization"
    }
    power {
        set recommendation "Prefer low-power transforms"
    }
    area {
        set recommendation "Prefer area reduction"
    }
    default {
        set recommendation "Use the default flow"
    }
}

puts "Slack: $slack_ps ps"
puts "Wire Delay: $wire_delay_pct%"
puts "Timing Status: $timing_status"
puts "Recommendation: $recommendation"
