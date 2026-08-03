# ==============================================================================
# VIVADO ADVANCED LESSON 01: ADVANCED NETLIST DATABASE ANALYSIS AND QUERYING
# ==============================================================================
# In Vivado, the entire design is stored as an object-oriented Netlist database:
# Cells (Logic Gates/LUTs), Nets (Wires), Pins (Instance Terminals), Ports (I/O Pins).
# Senior engineers use Tcl to filter and query congested or timing-critical areas.
# ==============================================================================

# 1. QUERYING LOGIC CELLS WITH ATTRIBUTE FILTERING (GET_CELLS & -FILTER)
# ------------------------------------------------------------------------------
# Query all Flip-Flop cells across the entire hierarchy
set all_ffs [get_cells -hierarchical -filter {PRIMITIVE_SUBGROUP == flop}]
puts "--> Total Flip-Flops in design: [llength $all_ffs]"

# Find LUT6 cells that have more than 4 inputs connected
set complex_luts [get_cells -hierarchical -filter {REF_NAME == LUT6 && NUM_INPUTS > 4}]
puts "--> Complex LUT6 cells count: [llength $complex_luts]"

# 2. QUERYING NETS AND MANAGING HIGH FANOUT (GET_NETS)
# ------------------------------------------------------------------------------
# Find Nets with high Fanout (> 500 pin loads). High fanout nets cause congestion
# and severe timing violations if not buffered properly!
set high_fanout_nets [get_nets -hierarchical -filter {FLAT_PIN_COUNT > 500}]
puts "--> High Fanout Nets count (>500 loads): [llength $high_fanout_nets]"

foreach net $high_fanout_nets {
    set driver [get_pins -of_objects $net -filter {DIRECTION == OUT}]
    puts "    Net: $net | Driver Pin: $driver | Fanout Count: [get_property FLAT_PIN_COUNT $net]"
}

# 3. QUERYING PINS AND I/O PORTS (GET_PINS & GET_PORTS)
# ------------------------------------------------------------------------------
# Query all clock pins connected across the netlist
set clock_pins [get_pins -hierarchical -filter {TYPE == CLK || NAME =~ *clk*}]
puts "--> Found [llength $clock_pins] clock pins across netlist."

# Query all Output Ports configured with LVCMOS33 I/O standard
set lvcmos33_ports [get_ports -filter {DIRECTION == OUT && IOSTANDARD == LVCMOS33}]
puts "--> LVCMOS33 Output Ports count: [llength $lvcmos33_ports]"

# 4. DYNAMIC NETLIST PROPERTY MUTATION (SET_PROPERTY)
# ------------------------------------------------------------------------------
# Apply DONT_TOUCH attribute to prevent Vivado optimizer from removing critical cores
puts "--> Applying DONT_TOUCH attribute to security core cells..."
set_property DONT_TOUCH true [get_cells -hierarchical -filter {NAME =~ *security_core*}]

puts "--> Advanced Netlist Analysis lesson completed successfully!"
