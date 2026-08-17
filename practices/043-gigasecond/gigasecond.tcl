proc addGigasecond {datetime} {
    set current_seconds [clock scan $datetime -timezone UTC]
    set future_seconds [expr {$current_seconds + 1000000000}]
    return [clock format $future_seconds -format "%Y-%m-%dT%H:%M:%S" -timezone UTC]
}
