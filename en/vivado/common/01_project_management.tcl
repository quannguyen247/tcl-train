# ==============================================================================
# VIVADO COMMON LESSON 01: ENTERPRISE PROJECT MANAGEMENT VIA TCL FLOW
# ==============================================================================
# In corporate environments, using the Vivado GUI to click buttons is error-prone
# and impossible to automate. Everything is executed using Tcl scripts!
# ==============================================================================

# 1. CREATE OR OPEN PROJECT
# ------------------------------------------------------------------------------
set proj_name "my_fpga_project"
set proj_dir "./build_output"
set target_part "xc7z020clg400-1" ;# Zynq-7000 FPGA Part Number

# Check if build directory exists, clean up if needed
if {[file exists $proj_dir]} {
    puts "--> Build directory exists, cleaning up..."
    file delete -force $proj_dir
}

puts "--> Initializing new Vivado Project..."
create_project $proj_name $proj_dir -part $target_part -force

# Set target language (Verilog / SystemVerilog / VHDL)
set_property target_language Verilog [current_project]

# 2. ADD SOURCE CODE AND CONSTRAINTS
# ------------------------------------------------------------------------------
puts "--> Adding RTL source files and timing constraints..."

# Add Verilog/SystemVerilog files
# add_files [glob ./src/*.v]
# add_files [glob ./src/*.sv]

# Add Timing and Pin Constraints (XDC File)
# add_files -fileset constrs_1 ./constraints/top_pins.xdc

# 3. RUN SYNTHESIS
# ------------------------------------------------------------------------------
puts "--> Launching Design Synthesis..."
launch_runs synth_1 -jobs 4

# Mandatory: wait_on_run blocks the script until Synthesis finishes
wait_on_run synth_1

if {[get_property PROGRESS [get_runs synth_1]] != "100%"} {
    error "ERROR: Synthesis failed! Please check synth_1 log."
}

# 4. RUN IMPLEMENTATION (PLACE & ROUTE)
# ------------------------------------------------------------------------------
puts "--> Launching Implementation (Place & Route)..."
launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1

if {[get_property PROGRESS [get_runs impl_1]] != "100%"} {
    error "ERROR: Implementation failed! Please check impl_1 log."
}

puts "--> AUTOMATION FLOW COMPLETED! Bitstream generated successfully."
