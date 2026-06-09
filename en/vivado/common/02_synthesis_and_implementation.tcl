# Vivado Tcl Lesson: 02_synthesis_and_implementation
# -------------------------------------------------------------------------
# Description: Running compilation steps in Vivado (Synthesis, Implementation).
# -------------------------------------------------------------------------

# 1. synth_design
# Used in non-project batch flows to run synthesis directly.
# synth_design -top my_top_module -part xc7a35tcpg236-1

# 2. launch_runs
# Used in project-based flows to start synthesis or implementation runs in the background.
# The 'synth_1' and 'impl_1' are default run names created by Vivado.
puts "Launching synthesis..."
# launch_runs synth_1 -jobs 4

# 3. wait_on_run
# Blocks the Tcl script execution until the specified run completes. 
# Crucial for script automation to prevent running implementation before synthesis finishes.
# wait_on_run synth_1
# puts "Synthesis completed."

# 4. current_run / get_runs
# Gets the currently active run, or lists all available runs.
# set my_run [current_run -synthesis]
# puts "Current synthesis run: $my_run"

# 5. open_run
# Opens the synthesized or implemented design into memory for analysis (Netlist).
# open_run synth_1 -name netlist_1

# 6. reset_runs
# Clears the results of a run so it can be re-run cleanly.
# reset_runs synth_1
