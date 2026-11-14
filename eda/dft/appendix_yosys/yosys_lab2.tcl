# yosys lab2: see the lesson README for the task and inputs.
# ==============================================================================
# ==============================================================================
#
# ==============================================================================

yosys -import
puts "Example step completed; inspect the output above."

read_verilog sample_design.v

hierarchy -check -top sample_top

puts "Example step completed; inspect the output above."
