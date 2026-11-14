# yosys lab1: see the lesson README for the task and inputs.
# ==============================================================================
# ==============================================================================
#
# ==============================================================================

yosys -import
puts "Example step completed; inspect the output above."

read_verilog sample_design.v
procs

file mkdir build
write_verilog -noattr build/exported_sample.v

puts "Example step completed; inspect the output above."
