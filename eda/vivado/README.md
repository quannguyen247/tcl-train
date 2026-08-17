# AMD Xilinx Vivado Tcl Automation Suite

> **Status Notice:** The scripts in this directory are working drafts and reference templates (`WIP`) illustrating standard and advanced automation patterns in AMD Xilinx Vivado. They are designed for educational reference, script reuse, and custom CI/CD CAD pipeline construction.

This module provides a comprehensive collection of production-grade Tcl automation scripts for **AMD Xilinx Vivado**, spanning project creation, non-project batch compilation, constraint management, deep netlist querying, Engineering Change Orders (ECO), Custom DRC rule enforcement, Dynamic Function eXchange (DFX), and in-system JTAG hardware debugging.

---

## 🌳 Directory Organization

```text
eda/vivado/
├── README.md                      # Overview & navigation guide (this file)
│
├── common/                        # Essential Vivado commands & standard workflows
│   ├── README.md                  # Detailed topic guide for common commands
│   ├── 01_project_management.tcl
│   ├── 02_reporting_and_timing.tcl
│   ├── 02_synthesis_and_implementation.tcl
│   ├── 03_timing_constraints.tcl
│   ├── 04_physical_constraints.tcl
│   ├── 05_reports_and_analysis.tcl
│   ├── 06_ip_management.tcl
│   ├── 07_simulation_basics.tcl
│   └── 08_basic_netlist_queries.tcl
│
└── advanced/                      # Advanced flows, ECO netlist editing & CDC analysis
    ├── README.md                  # Detailed topic guide for advanced commands
    ├── 01_advanced_netlist_querying.tcl
    ├── 01_design_analysis.tcl
    ├── 02_custom_hooks_and_drc.tcl
    ├── 02_netlist_manipulation.tcl
    ├── 03_batch_flow_checkpoints.tcl
    ├── 04_ip_integrator_bd.tcl
    ├── 05_custom_drc_and_hooks.tcl
    ├── 06_advanced_timing_and_cdc.tcl
    ├── 07_partial_reconfiguration_dfx.tcl
    └── 08_hardware_manager_debug.tcl
```

---

## 🎯 Learning Tracks

### 1. Common Track (`eda/vivado/common/`)
Targeted at mastering standard day-to-day Vivado operations:
* Project configuration and target device assignment (`01`)
* Synthesis, placement, and routing flow controls (`02`)
* SDC / XDC timing constraints and physical I/O pin assignments (`03`, `04`)
* Design analytics, power estimation, and resource utilization reports (`02`, `05`)
* Xilinx Core Generator IP automation and XSim behavioral simulation (`06`, `07`)
* Basic hierarchical netlist database querying (`08`)

### 2. Advanced Track (`eda/vivado/advanced/`)
Targeted at senior FPGA design and CAD automation engineers:
* Complex netlist querying with fanin/fanout path tracing (`01`)
* Routing congestion analysis and logic level distribution (`01`)
* ECO in-memory netlist rewiring and spare gate insertion (`02`)
* Custom Design Rule Check (DRC) rule definitions and Tcl pre/post hooks (`02`, `05`)
* Headless non-project batch flow with Design Checkpoints (DCP) (`03`)
* IP Integrator (Block Design) programmatic construction (`04`)
* Clock Domain Crossing (CDC) verification and unconstrained clock detection (`06`)
* Dynamic Function eXchange (Partial Reconfiguration) implementation (`07`)
* Automated JTAG hardware target programming and ILA waveform capture (`08`)

---

## 🚀 Execution Modes

### Batch Mode (Headless / CI/CD)
```bash
vivado -mode batch -source eda/vivado/advanced/03_batch_flow_checkpoints.tcl
```

### Interactive Tcl Shell
```bash
vivado -mode tcl
Vivado% source eda/vivado/common/01_project_management.tcl
```

### GUI Tcl Console
Source any script directly inside the Vivado IDE Tcl console at the bottom of the window:
```tcl
source {C:/path/to/eda/vivado/common/08_basic_netlist_queries.tcl}
```
