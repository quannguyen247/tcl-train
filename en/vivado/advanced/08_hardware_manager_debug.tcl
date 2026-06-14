# Vivado Tcl Lesson: 08_hardware_manager_debug
# -------------------------------------------------------------------------
# Description: Programming the FPGA and analyzing on-chip logic via Hardware Manager.
# -------------------------------------------------------------------------

# 1. open_hw_manager / connect_hw_server
# Open the hardware manager and connect to the local or remote JTAG server.
# open_hw_manager
# connect_hw_server -url localhost:3121

# 2. open_hw_target / current_hw_device
# Connect to the specific programming cable and select the FPGA device.
# current_hw_target [get_hw_targets */xilinx_tcf/Digilent/*]
# open_hw_target
# set device [current_hw_device [get_hw_devices xc7z020_1]]

# 3. set_property PROGRAM.FILE / program_hw_devices
# Specify the bitstream and program the FPGA.
# set_property PROGRAM.FILE {./output.bit} $device
# set_property PROBES.FILE {./debug_nets.ltx} $device
# program_hw_devices $device

# 4. create_hw_ila / create_hw_vio
# Interact with Integrated Logic Analyzer (ILA) and Virtual I/O (VIO) cores on the FPGA.
# Usually, Vivado detects ILAs automatically when the LTX file is provided.
# set ila [get_hw_ilas hw_ila_1]

# 5. run_hw_ila / display_hw_ila_data
# Trigger the ILA to capture data, and display it in the waveform viewer.
# run_hw_ila $ila
# wait_on_hw_ila $ila
# display_hw_ila_data [upload_hw_ila_data $ila]
