# Bài học Vivado Tcl: 05_custom_drc_and_hooks
# -------------------------------------------------------------------------
# Mô tả: Tạo các bộ kiểm tra luật thiết kế (DRC) tùy chỉnh và sử dụng Tcl hooks.
# -------------------------------------------------------------------------

# 1. create_drc_rule / create_drc_violation
# Tạo các quy tắc tùy chỉnh để bắt buộc tuân thủ yêu cầu thiết kế cụ thể.
# Ví dụ: Đảm bảo không có thanh ghi nào dùng chân reset bất đồng bộ.
# create_drc_rule -name {MY_RULE-1} -msg {Registers must not use async reset} -desc {Avoid async reset} -severity {Warning}
# create_drc_violation -name {MY_RULE-1} -msg {Found async reset on cell %CEL} [get_cells bad_reg]

# 2. report_drc -ruledeck
# Chạy các tập quy tắc DRC cụ thể (có sẵn hoặc tự tạo).
# report_drc -ruledeck timing_checks -file ./drc_timing.rpt

# 3. Tcl Pre và Post Hooks
# Gắn các script Tcl để chạy trước hoặc sau các bước tổng hợp/thực thi.
# Trong quy trình project, điều này được thực hiện qua các thuộc tính của run:
# set_property STEPS.SYNTH_DESIGN.TCL.PRE [get_files pre_synth_hook.tcl] [get_runs synth_1]
# set_property STEPS.ROUTE_DESIGN.TCL.POST [get_files post_route_hook.tcl] [get_runs impl_1]

# Trong quy trình non-project (batch), chỉ cần source script trước/sau lệnh:
# source pre_synth_hook.tcl
# synth_design -top my_top
# source post_synth_hook.tcl
