# Vivado Advanced Tcl Scripting & Flow Automation

> **Note:** These scripts are reference templates and working drafts (`WIP`) illustrating advanced FPGA implementation, design analysis, and automation patterns in AMD Xilinx Vivado. They are intended for educational reference and custom CAD pipeline integration.

This directory covers advanced Vivado Tcl automation workflows including object-oriented netlist database exploration, ECO (Engineering Change Order) netlist manipulation, non-project batch checkpoints, IP Integrator Block Design (BD) scripting, custom DRC rule creation, Clock Domain Crossing (CDC) analysis, Dynamic Function eXchange (DFX / Partial Reconfiguration), and Hardware Manager JTAG debugging.

---

## 📁 Topic Overview & Script Index

| Script | Category | Description | Key Vivado Commands |
| :--- | :--- | :--- | :--- |
| **`01_advanced_netlist_querying.tcl`** | Netlist Database | Deep hierarchical queries, fanin/fanout path tracing, pin connectivity inspection, and cell property filtering. | `get_cells`, `get_pins -of_objects`, `all_fanin`, `all_fanout`, `get_bel_pins`, `filter_collection` |
| **`01_design_analysis.tcl`** | Timing & Congestion Analysis | Analyzing routing congestion levels, logic depth distribution, clock skew distribution, and critical path breakdown. | `report_design_analysis`, `-complexity`, `-congestion`, `-logic_level_distribution`, `report_high_fanout_nets` |
| **`02_netlist_manipulation.tcl`** | ECO & Gate-Level Rewiring | Modifying gate-level netlists in-memory without re-synthesizing: disconnecting nets, creating cells, inserting buffers, rewiring pins. | `create_cell`, `create_net`, `connect_net`, `disconnect_net`, `remove_cell`, `write_checkpoint` |
| **`02_custom_hooks_and_drc.tcl`** | Tcl Hooks & Custom DRC | Attaching pre/post step hooks (e.g., `STEPS.ROUTE_DESIGN.TCL.POST`) and authoring custom user-defined DRC rule checkers. | `create_drc_check`, `create_drc_violation`, `set_property STEPS.ROUTE_DESIGN.TCL.PRE`, `report_drc` |
| **`03_batch_flow_checkpoints.tcl`** | Non-Project Batch Flow | Complete in-memory non-project flow scripting (`synth_design` -> `opt_design` -> `place_design` -> `route_design`) using Design Checkpoints (DCP). | `read_verilog`, `read_xdc`, `synth_design`, `write_checkpoint`, `read_checkpoint`, `write_bitstream` |
| **`04_ip_integrator_bd.tcl`** | Block Design Automation | Programmatic creation and connection of IP Integrator block designs (AXI interconnects, MicroBlaze/Zynq processing systems, interface pins). | `create_bd_design`, `create_bd_cell`, `connect_bd_net`, `connect_bd_intf_net`, `validate_bd_design`, `generate_target` |
| **`05_custom_drc_and_hooks.tcl`** | Quality-of-Result Checks | Custom Quality-of-Result (QoR) gating scripts preventing bitstream generation if timing violations or unconstrained clocks exist. | `get_property SLACK`, `get_property IS_UNCONSTRAINED`, `send_msg_id`, `set_property IS_ENABLED` |
| **`06_advanced_timing_and_cdc.tcl`** | CDC & Constraint Verification | Verifying Clock Domain Crossing synchronization (2-FF, MUX-D, Handshake), running structural CDC checks, and reporting unconstrained paths. | `report_cdc`, `report_clock_interaction`, `set_max_delay -datapath_only`, `set_bus_skew` |
| **`07_partial_reconfiguration_dfx.tcl`** | Dynamic Function eXchange | Configuring Reconfigurable Modules (RM), defining Pblocks, creating DFX configurations, and implementing partial bitstreams. | `set_property HD.RECONFIGURABLE`, `create_pblock`, `resize_pblock`, `pr_sub_design`, `write_bitstream -cell` |
| **`08_hardware_manager_debug.tcl`** | Silicon Debug & JTAG | Programmatic hardware target connection, FPGA device programming, ILA core arming, trigger setup, and waveform data capture. | `open_hw_manager`, `connect_hw_server`, `open_hw_target`, `program_hw_devices`, `run_hw_ila`, `upload_hw_ila_data` |

---

## 🛠️ Execution & Integration Guidelines

### 1. Non-Project Batch Checkpoint Pipeline
Run a headless, deterministic compile pipeline using `03_batch_flow_checkpoints.tcl`:
```bash
vivado -mode batch -source 03_batch_flow_checkpoints.tcl -tclargs top.v constraints.xdc xc7a35tcpg236-1
```

### 2. Sourcing Custom DRC Checks inside Vivado Shell
```tcl
# Load design checkpoint
open_checkpoint post_route.dcp

# Source and register custom DRC rules
source 02_custom_hooks_and_drc.tcl

# Run DRC check and evaluate return code
report_drc -checks {USER_DRC_NO_UNBUFFERED_GATED_CLK} -file custom_drc_report.txt
```

---

## 💡 Key Takeaways for Senior FPGA Engineers

* **In-Memory Non-Project Flow:** Bypasses Vivado project `.xpr` overhead, providing exact control over optimization phases, memory usage, and checkpoint snapshots (`.dcp`).
* **ECO Gate-Level Surgery:** Allows rapid timing bug fixes or debug probe insertions on routed netlists in minutes without risking routing churn from a full re-compile.
* **Automated CDC Quality Gates:** Essential for high-reliability military, automotive, and datacenter FPGA designs to guarantee zero metastability escapes.
