# ==============================================================================
# EXERCISM TCL PRACTICE: MATCHING-BRACKETS
# ==============================================================================
# # Instructions
#
# Given a string containing brackets `[]`, braces `{}`, parentheses `()`, or any combination thereof, verify that any and all pairs are matched and nested correctly.
# Any other characters should be ignored.
# For example, `"{what is (42)}?"` is balanced and `"[text}"` is not.

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

proc bracketsMatch {input} {
    # Các dấu cùng vị trí là một cặp
    set opens "(\[\{"
    set closes ")]\}"
    set stack {}

    foreach char [split $input ""] {
        set index [string first $char $opens]

        # Gặp dấu mở thì thêm vào stack
        if {$index >= 0} {
            lappend stack $char
            continue
        }

        set index [string first $char $closes]

        # Bỏ qua ký tự không phải dấu ngoặc
        if {$index < 0} {
            continue
        }

        # So sánh với dấu mở cuối stack
        if {$stack eq {}
            || [lindex $stack end] ne [string index $opens $index]} {
            return false
        }

        # Xóa dấu mở đã ghép cặp
        set stack [lrange $stack 0 end-1]
    }

    # Đúng khi stack đã rỗng
    return [expr {$stack eq {}}]
}
