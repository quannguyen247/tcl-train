# audit_cdc_synchronizers.tcl
# Tự động hóa kiểm tra đồng bộ hóa CDC và xuất báo cáo

proc get_cdc_paths {} {
    set cdc_paths [list]
    # Lấy tất cả các timing paths giữa các clock khác nhau
    set clocks [get_clocks]
    if {[llength $clocks] < 2} {
        return $cdc_paths
    }
    
    # Tìm các cell tuần tự
    set seq_cells [get_cells -hierarchical -filter {IS_SEQUENTIAL == 1}]
    
    foreach cell $seq_cells {
        set d_pin [get_pins -filter {REF_PIN_NAME == D} -of_objects $cell]
        if {[llength $d_pin] == 0} continue
        
        # Lấy clock của chân D thông qua timing path
        set t_path [get_timing_paths -to $d_pin -max_paths 1]
        if {[llength $t_path] == 0} continue
        
        set src_clk [get_property STARTPOINT_CLOCK $t_path]
        set dst_clk [get_property ENDPOINT_CLOCK $t_path]
        
        if {$src_clk != "" && $dst_clk != "" && $src_clk != $dst_clk} {
            lappend cdc_paths $t_path
        }
    }
    return $cdc_paths
}

proc check_synchronizer {path} {
    set dest_pin [get_property ENDPOINT_PIN $path]
    set ff1 [get_cells -of_objects $dest_pin]
    
    set is_async1 [get_property ASYNC_REG $ff1]
    
    # Trace to next FF
    set q_pin [get_pins -filter {REF_PIN_NAME == Q} -of_objects $ff1]
    set nets [get_nets -of_objects $q_pin]
    set next_pins [get_pins -filter {DIRECTION == IN && IS_LEAF == 1} -of_objects $nets]
    
    set ff2 ""
    set is_async2 0
    foreach p $next_pins {
        set c [get_cells -of_objects $p]
        if {[get_property IS_SEQUENTIAL $c]} {
            set ff2 $c
            set is_async2 [get_property ASYNC_REG $ff2]
            break
        }
    }
    
    if {$ff2 == ""} {
        return "UNSAFE_SINGLE_STAGE"
    } elseif {($is_async1 == "TRUE" || $is_async1 == "1") && ($is_async2 == "TRUE" || $is_async2 == "1")} {
        return "SAFE"
    } else {
        return "WARNING_MISSING_PROP"
    }
}

proc audit_cdc {} {
    puts "===================================================================================="
    puts "                       CDC SYNCHRONIZER AUDIT REPORT"
    puts "===================================================================================="
    puts [format "%-3s | %-12s | %-10s | %-25s | %-12s | %s" "ID" "Source Clock" "Dest Clock" "Dest Cell (Stage 1)" "Status" "Slack"]
    puts "------------------------------------------------------------------------------------"
    
    set cdc_paths [get_cdc_paths]
    set id 1
    
    set fp ""
    catch {set fp [open "cdc_audit_report.csv" w]}
    if {$fp != ""} {
        puts $fp "No., Source_Cell, Dest_Cell_Stage1, Dest_Cell_Stage2, Src_Clock, Dest_Clock, Status, Slack, Constraint_Type"
    }

    foreach path $cdc_paths {
        set src_clk [get_property STARTPOINT_CLOCK $path]
        set dst_clk [get_property ENDPOINT_CLOCK $path]
        set slack [get_property SLACK $path]
        set dest_pin [get_property ENDPOINT_PIN $path]
        set ff1 [get_cells -of_objects $dest_pin]
        
        set status [check_synchronizer $path]
        
        puts [format "%-3d | %-12s | %-10s | %-25s | %-12s | %s" $id $src_clk $dst_clk $ff1 $status $slack]
        
        if {$fp != ""} {
            set src_cell [get_cells -of_objects [get_property STARTPOINT_PIN $path]]
            set ff2 "UNKNOWN"
            set constraint "UNKNOWN"
            puts $fp "$id, $src_cell, $ff1, $ff2, $src_clk, $dst_clk, $status, $slack, $constraint"
        }
        incr id
    }
    puts "===================================================================================="
    puts "\[INFO\] Audit completed. Found [expr {$id - 1}] CDC paths."
    if {$fp != ""} {
        close $fp
        puts "\[INFO\] Detailed report written to: cdc_audit_report.csv"
    }
}

# Run the audit
audit_cdc
