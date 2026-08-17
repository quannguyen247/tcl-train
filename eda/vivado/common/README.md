# Vivado Common Tcl Scripting Guide

> **Note:** These scripts are reference templates and working drafts (`WIP`) illustrating standard automation patterns in AMD Xilinx Vivado. They are designed for educational reference and customizable batch integration.

This directory provides essential, production-proven Tcl command patterns and workflows for managing Vivado projects, controlling synthesis and implementation runs, establishing timing and physical constraints, analyzing design metrics, and running basic simulations.

---

## 📁 Topic Overview & Script Index

| Script | Category | Description | Key Vivado Commands |
| :--- | :--- | :--- | :--- |
| **`01_project_management.tcl`** | Project Management | Creating, loading, configuring projects, setting target parts, and managing HDL source files. | `create_project`, `current_project`, `set_property`, `add_files`, `import_files` |
| **`02_synthesis_and_implementation.tcl`** | Flow Execution | Launching non-project or project-based synthesis and implementation runs with strategy selection. | `launch_runs`, `wait_on_run`, `open_run`, `synth_design`, `opt_design`, `place_design`, `route_design` |
| **`02_reporting_and_timing.tcl`** | Timing & Reporting | Generating timing summary, clock utilization, power, and DRC reports post-implementation. | `report_timing_summary`, `report_utilization`, `report_power`, `report_drc`, `report_clock_utilization` |
| **`03_timing_constraints.tcl`** | SDC / XDC Constraints | Defining primary clocks, generated clocks, clock groups, input/output delays, and false paths. | `create_clock`, `create_generated_clock`, `set_clock_groups`, `set_input_delay`, `set_output_delay`, `set_false_path` |
| **`04_physical_constraints.tcl`** | Floorplanning & I/O | Pin placement (LOC), I/O standards (IOSTANDARD), drive strength, and Pblock floorplanning. | `set_property PACKAGE_PIN`, `set_property IOSTANDARD`, `create_pblock`, `add_cells_to_pblock` |
| **`05_reports_and_analysis.tcl`** | Design Analytics | Automated extraction of worst negative slack (WNS), LUT/FF utilization tables, and power breakdown. | `get_property SLACK`, `get_property STATS`, `report_high_fanout_nets`, `report_design_analysis` |
| **`06_ip_management.tcl`** | IP Core Automation | Customizing, generating, and upgrading Xilinx IP cores (FIFO, Block Memory, Clocking Wizard). | `create_ip`, `set_property -dict`, `generate_target`, `export_ip_user_files`, `upgrade_ip` |
| **`07_simulation_basics.tcl`** | Behavioral Simulation | Configuring XSim simulation properties, compiling testbenches, and running automated test runs. | `set_property target_simulator`, `launch_simulation`, `run`, `current_time`, `restart` |
| **`08_basic_netlist_queries.tcl`** | Netlist Navigation | Querying cells, nets, pins, and ports using hierarchical filters and pattern matching. | `get_cells`, `get_nets`, `get_pins`, `get_ports`, `-filter`, `-hierarchical` |

---

## 🛠️ Usage & Execution Modes

### 1. Interactive Vivado Tcl Shell
```bash
# Start Vivado in Tcl batch/shell mode
vivado -mode tcl

# Source any script inside the Vivado shell:
Vivado% source 01_project_management.tcl
Vivado% source 03_timing_constraints.tcl
```

### 2. Standalone Batch Execution
```bash
# Execute in batch mode without opening the GUI:
vivado -mode batch -source 02_synthesis_and_implementation.tcl -tclargs xc7a35tcpg236-1
```

### 3. Sourcing within Vivado GUI
In the Vivado GUI Tcl Console at the bottom:
```tcl
source {C:/path/to/eda/vivado/common/08_basic_netlist_queries.tcl}
```

---

## 💡 Best Practices

1. **Always verify active run states** with `wait_on_run` before querying post-synthesis or post-route checkpoints.
2. **Use `-hierarchical` and specific filters** (e.g., `REF_NAME =~ FD*`) rather than unbounded wildcard queries to optimize runtime on large designs.
3. **Keep timing constraints (`.xdc`) modular**, separating primary clocks, asynchronous clock crossings, and board-specific I/O pin assignments.
