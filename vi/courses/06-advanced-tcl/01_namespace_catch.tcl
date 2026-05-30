# Exercise 06: Tcl nâng cao
# Mục tiêu: Dùng namespace để đóng gói proc và catch để xử lý trường hợp thiếu dữ liệu.

namespace eval ::lesson6 {
    proc safe_get_dict_value {data key default_value} {
        if {[catch {dict get $data $key} value]} {
            return $default_value
        }

        return $value
    }

    proc classify_slack {slack_ps} {
        if {$slack_ps < 0} {
            return "VIOLATION"
        }

        if {$slack_ps < 50} {
            return "MARGIN"
        }

        return "SAFE"
    }
}

set timing_summary [dict create endpoint U1/D slack_ps -12.5]

set endpoint [::lesson6::safe_get_dict_value $timing_summary endpoint "UNKNOWN"]
set launch_clock [::lesson6::safe_get_dict_value $timing_summary launch_clock "core_clk"]
set status [::lesson6::classify_slack [dict get $timing_summary slack_ps]]

puts "Endpoint: $endpoint"
puts "Launch clock: $launch_clock"
puts "Status: $status"
