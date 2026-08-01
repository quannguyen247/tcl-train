# ==============================================================================
# BÀI HỌC VIVADO ADVANCED 02: TCL HOOK SCRIPTS VÀ QUY TẮC DRC TỰ ĐỊNH NGHĨA
# ==============================================================================
# Trong luồng CI/CD chip tự động, kỹ sư cần nhét các đoạn script kiểm tra vào giữa
# các bước chạy (Hook Scripts) và tự tạo luật kiểm tra quy tắc thiết kế (DRC Rules).
# ==============================================================================

# 1. CẤU HÌNH TCL HOOK SCRIPTS CHO CÁC BƯỚC RUN (PRE & POST HOOKS)
# ------------------------------------------------------------------------------
# Chèn một Tcl script chạy tự động TRƯỚC KHI bước Synthesis bắt đầu (Pre-Synthesis Hook)
set_property STEPS.SYNTH_DESIGN.TCL.PRE ./scripts/pre_synth_check.tcl [get_runs synth_1]

# Chèn một Tcl script chạy tự động SAU KHI bước Write Bitstream hoàn tất (Post-Bitstream Hook)
# Dùng để gửi thông báo Slack / Email cho team sau khi build thành công!
set_property STEPS.WRITE_BITSTREAM.TCL.POST ./scripts/notify_team.tcl [get_runs impl_1]

puts "--> Đã đăng ký thành công Pre/Post Tcl Hook Scripts cho synth_1 và impl_1."

# 2. KHỞI TẠO NGUYÊN TẮC KIỂM TRA MẠCH TỰ ĐỊNH NGHĨA (CUSTOM DRC RULE)
# ------------------------------------------------------------------------------
# Tạo một quy tắc DRC mới kiểm tra xem thiết kế có bị bỏ quên không đặt DONT_TOUCH không
proc check_unbuffered_high_fanout {} {
    set violated_nets [get_nets -hierarchical -filter {FLAT_PIN_COUNT > 1000}]
    
    if {[llength $violated_nets] > 0} {
        foreach net $violated_nets {
            # Báo lỗi DRC mức độ CRITICAL WARNING nếu tìm thấy net vi phạm
            create_drc_violation -name {USR_DRC-1} \
                -msg "Phát hiện Net [$net] có Fanout quá lớn ([get_property FLAT_PIN_COUNT $net] pins) mà chưa được chèn Buffer!" \
                -approval "User Approval Required" \
                $net
        }
    }
}

# Đăng ký hàm Tcl vừa tạo thành một DRC Check Rule chính thức trong Vivado
create_drc_ruledeck my_custom_drc_rules
add_drc_checks -ruledeck my_custom_drc_rules [create_drc_check -name USR_DRC-1 -description "Kiểm tra High Fanout Nets" -hierarchy USER -procedure check_unbuffered_high_fanout]

puts "--> Đã đăng ký quy tắc Custom DRC Ruledeck [my_custom_drc_rules] thành công!"
