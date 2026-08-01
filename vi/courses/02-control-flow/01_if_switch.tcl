# Exercise 02: Rẽ nhánh và điều kiện
# Mục tiêu: Dùng if/elseif/else và switch để phân loại trạng thái timing và đề xuất hướng tối ưu.

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
        set recommendation "Uu tien toi uu timing"
    }
    power {
        set recommendation "Uu tien giam cong suat"
    }
    area {
        set recommendation "Uu tien giam dien tich"
    }
    default {
        set recommendation "Dung flow mac dinh"
    }
}

puts "Slack: $slack_ps ps"
puts "Wire Delay: $wire_delay_pct%"
puts "Timing Status: $timing_status"
puts "Recommendation: $recommendation"
