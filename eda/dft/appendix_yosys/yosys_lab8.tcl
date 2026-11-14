# yosys lab8: see the lesson README for the task and inputs.
# ==============================================================================
# ==============================================================================
#
# ==============================================================================

yosys -import
puts "Example step completed; inspect the output above."

read_verilog sample_design.v
synth -top sample_seq

dfflibmap -liberty tech_lib.lib

stat -liberty tech_lib.lib
puts "Example step completed; inspect the output above."
