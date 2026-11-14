# lab2 1 yosys batch: see the lesson README for the task and inputs.
# Lab 2.1: Yosys Batch Synthesis Script


yosys read_verilog counter.v
yosys synth -top counter
yosys opt
yosys clean
file mkdir build
yosys write_verilog build/netlist_synth.v

# [YOSYS] Reading counter.v ...
# [YOSYS] Synthesizing top module 'counter' ...
# [YOSYS] Optimization done. Netlist written to 'netlist_synth.v'.
