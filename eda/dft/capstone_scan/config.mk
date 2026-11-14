# External design configuration for OpenROAD-flow-scripts.
DESIGN_ROOT := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
export DESIGN_NAME = scan_counter
export PLATFORM = sky130hd
export VERILOG_FILES = $(DESIGN_ROOT)/rtl/scan_counter.v
export SDC_FILE = $(DESIGN_ROOT)/constraint.sdc
export CORE_UTILIZATION = 20
export PLACE_DENSITY = 0.35
export CORE_ASPECT_RATIO = 1
export CORE_MARGIN = 5
