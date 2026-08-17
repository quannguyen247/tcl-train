# Vivado Tcl Lesson: 07_simulation_basics
# -------------------------------------------------------------------------
# Description: Launching and controlling the Vivado Simulator (XSim).
# -------------------------------------------------------------------------

# 1. launch_simulation
# Starts the Vivado simulator. 
# Defaults to behavioral simulation (-step xsim).
# launch_simulation

# 2. open_wave_config
# Opens a pre-saved waveform configuration file (.wcfg).
# open_wave_config ./sim/my_wave.wcfg

# 3. add_wave / log_wave
# Adds signals to the waveform viewer and enables logging for them.
# add_wave /tb_top/dut/*
# log_wave -r /tb_top/dut/*

# 4. run
# Runs the simulation for a specific duration.
# run 10 us
# run all   ; # Runs until $finish is encountered in the testbench.

# 5. restart
# Resets the simulation time back to 0.
# restart

# 6. close_sim
# Closes the active simulation.
# close_sim
