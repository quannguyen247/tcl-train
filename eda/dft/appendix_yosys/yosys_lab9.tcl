# yosys lab9: see the lesson README for the task and inputs.
# ==============================================================================
# ==============================================================================
#
# ==============================================================================

yosys -import
puts "Example step completed; inspect the output above."

read_verilog sample_design.v
synth -top sample_comb

abc -liberty tech_lib.lib
clean

stat -liberty tech_lib.lib
puts "Example step completed; inspect the output above."
