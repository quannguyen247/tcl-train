# Vivado Tcl Lesson: 06_ip_management
# -------------------------------------------------------------------------
# Description: Managing, configuring, and generating Xilinx IP cores.
# -------------------------------------------------------------------------

# 1. create_ip
# Creates a new IP core from the Vivado IP catalog.
# -name sets the instance name. -vendor, -library, -name, -version specify the core type.
# create_ip -name blk_mem_gen_0 -vendor xilinx.com -library ip -version 8.4 -module_name my_bram

# 2. set_property (on IP)
# Configures the parameters of the generated IP.
# set_property -dict [list CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.Use_Byte_Write_Enable {true}] [get_ips my_bram]

# 3. generate_target
# Generates the required files for the IP (instantiation template, synthesis, simulation).
# generate_target all [get_ips my_bram]

# 4. export_ip_user_files
# Exports the generated files to a centralized location for revision control.
# export_ip_user_files -of_objects [get_ips my_bram] -no_script -sync -force -quiet

# 5. get_ips
# Lists all IPs currently in the project.
# puts "Project IPs: [get_ips]"

# 6. report_ip_status / upgrade_ip
# Checks if IPs need upgrading (e.g., after migrating to a newer Vivado version) and upgrades them.
# report_ip_status -name ip_status
# upgrade_ip [get_ips]
