# Vivado Tcl Lesson: 05_custom_drc_and_hooks
# -------------------------------------------------------------------------
# Description: Creating custom Design Rule Checks and using Tcl hook scripts.
# -------------------------------------------------------------------------

# 1. create_drc_rule / create_drc_violation
# Create custom rules to enforce specific design requirements.
# Example: Ensure no registers use a specific reset pin.
# create_drc_rule -name {MY_RULE-1} -msg {Registers must not use async reset} -desc {Avoid async reset} -severity {Warning}
# create_drc_violation -name {MY_RULE-1} -msg {Found async reset on cell %CEL} [get_cells bad_reg]

# 2. report_drc -ruledeck
# Run specific sets of DRC rules (built-in or custom).
# report_drc -ruledeck timing_checks -file ./drc_timing.rpt

# 3. Tcl Pre and Post Hooks
# Attach Tcl scripts to run before or after synthesis/implementation steps.
# In a project flow, this is done via properties on the run:
# set_property STEPS.SYNTH_DESIGN.TCL.PRE [get_files pre_synth_hook.tcl] [get_runs synth_1]
# set_property STEPS.ROUTE_DESIGN.TCL.POST [get_files post_route_hook.tcl] [get_runs impl_1]

# In non-project mode, simply source the script before or after the command:
# source pre_synth_hook.tcl
# synth_design -top my_top
# source post_synth_hook.tcl
