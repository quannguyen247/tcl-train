# ==============================================================================
# VIVADO ADVANCED LESSON 02: TCL HOOK SCRIPTS AND CUSTOM DRC RULE CREATION
# ==============================================================================
# In enterprise CI/CD chip flows, engineers inject automated Tcl check scripts
# between execution stages (Hook Scripts) and define Custom Design Rule Checks (DRC).
# ==============================================================================

# 1. CONFIGURING TCL HOOK SCRIPTS FOR RUN STEPS (PRE & POST HOOKS)
# ------------------------------------------------------------------------------
# Automatically run a Tcl script BEFORE Synthesis starts (Pre-Synthesis Hook)
set_property STEPS.SYNTH_DESIGN.TCL.PRE ./scripts/pre_synth_check.tcl [get_runs synth_1]

# Automatically run a Tcl script AFTER Write Bitstream finishes (Post-Bitstream Hook)
# Useful for sending automated Slack/Email build notifications to the team!
set_property STEPS.WRITE_BITSTREAM.TCL.POST ./scripts/notify_team.tcl [get_runs impl_1]

puts "--> Successfully registered Pre/Post Tcl Hook Scripts for synth_1 and impl_1."

# 2. CREATING CUSTOM DESIGN RULE CHECKS (CUSTOM DRC RULES)
# ------------------------------------------------------------------------------
# Define a custom Tcl procedure to check for unbuffered high-fanout nets
proc check_unbuffered_high_fanout {} {
    set violated_nets [get_nets -hierarchical -filter {FLAT_PIN_COUNT > 1000}]
    
    if {[llength $violated_nets] > 0} {
        foreach net $violated_nets {
            # Issue a CRITICAL WARNING DRC violation if unbuffered high fanout net is found
            create_drc_violation -name {USR_DRC-1} \
                -msg "High Fanout Net detected [$net] ([get_property FLAT_PIN_COUNT $net] loads) without buffering!" \
                -approval "User Approval Required" \
                $net
        }
    }
}

# Register the Tcl procedure as an official custom DRC Rule in Vivado
create_drc_ruledeck my_custom_drc_rules
add_drc_checks -ruledeck my_custom_drc_rules [create_drc_check -name USR_DRC-1 -description "Check for Unbuffered High Fanout Nets" -hierarchy USER -procedure check_unbuffered_high_fanout]

puts "--> Successfully registered Custom DRC Ruledeck [my_custom_drc_rules]!"
