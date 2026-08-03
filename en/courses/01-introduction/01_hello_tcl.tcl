#!/usr/bin/env tclsh
# ==============================================================================
# Exercise: 01_hello_tcl
# Description: First Tcl script covering basic output, channels, and globals
#              in an EDA (Electronic Design Automation) context.
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. Basic Output
# ------------------------------------------------------------------------------
# Instruction: Use 'puts' to print a welcome message for a mock EDA tool.
puts "Welcome to MockSynthesis Compiler!"

# Instruction: Use 'puts' with '-nonewline' to print a status message without
# breaking the line, then complete it with another 'puts'.
puts -nonewline "Loading standard cell library... "
puts "Done."

# ------------------------------------------------------------------------------
# 2. Output Channels
# ------------------------------------------------------------------------------
# Instruction: Print a warning message to the standard error channel (stderr).
puts stderr "WARNING: Timing constraints are not fully met in the current design."

# ------------------------------------------------------------------------------
# 3. Global Variables
# ------------------------------------------------------------------------------
# Instruction: Print the name of this script using a built-in global variable.
puts "Executing script: $argv0"

# Instruction: Print the current Tcl version.
puts "Tcl Interpreter Version: $tcl_version"

# Instruction: Print the number of command line arguments and the arguments themselves.
puts "Number of arguments provided: $argc"
puts "Arguments list: $argv"

# Note: Try running this script from the terminal with extra arguments:
# e.g., tclsh 01_hello_tcl.tcl -design top_module -technology 28nm
