# Start here: why a chip needs DFT

A chip can simulate correctly and still contain a manufacturing defect. A production test applies input values to each manufactured part and observes the responses. **Design for testability (DFT)** adds access and control so that this test can reach logic buried inside the chip.

You need basic binary logic, flip-flops, and a terminal. No prior DFT experience is assumed. Start with [Lab 1](lab1_tcl_basics/README.md) if Tcl is unfamiliar. The examples below explain the hardware concepts used in later labs.

## 1. A fault and a detecting pattern

Suppose `y = a AND b`. A stuck-at-0 fault on `y` forces that wire to zero, regardless of the good circuit's value.

| a | b | Good y | Faulty y | Detects the fault? |
| --- | --- | --- | --- | --- |
| 0 | 0 | 0 | 0 | No |
| 0 | 1 | 0 | 0 | No |
| 1 | 0 | 0 | 0 | No |
| 1 | 1 | 1 | 0 | Yes |

A test must both **activate** a fault and **observe** the effect. Fault simulation checks how a defined set of patterns behaves against a defined fault list. ATPG searches for patterns to detect faults; implementations can use different algorithms. A reported coverage percentage is meaningful only with its fault model, population, classification rules, and constraints. It does not directly give the number of defective chips that escape test.

Try [Lab 4.1](lab4_fault_atpg_flow/lab4_1_fault_atpg_run/) after the Tcl and synthesis introductions. Its small software model enumerates every input of `y = (a & b) ^ c`. The separate Fault command runs a real fault campaign on a two-gate fixture.

## 2. Why scan helps

The input of a flip-flop deep in a chip may be difficult to set, and its output may not reach a chip pin. A scan cell adds a multiplexer to its data input. With scan enable `SE=0` it captures normal functional data. With `SE=1` it captures the previous scan cell's output (or `scan_in` for the first cell).

```text
scan_in -> [scan FF 0] -> [scan FF 1] -> [scan FF 2] -> scan_out
                 ^              ^              ^
                 +--------------+--------------+---- scan_enable
```

A simplified scan test proceeds as follows:

1. Deassert reset, assert scan enable, and shift a known state into the chain.
2. Deassert scan enable and apply a capture clock so the functional logic updates the registers.
3. Assert scan enable again and shift the captured response out for comparison.

Clock control, reset polarity, test-mode isolation, multiple clocks and timing constraints matter. A name-based text check cannot establish full controllability. In [Lab 3](lab3_dft_scan_insertion/README.md), stitch three teaching cells and simulate the resulting chain. The [capstone](capstone_scan/README.md) includes a four-bit scan counter and a self-checking Questa testbench.

## 3. Where DFT fits in an ASIC flow

```text
RTL -> simulation -> synthesis -> scan-aware netlist -> floorplan/place/CTS/route
                                                   -> extraction/timing -> GDS
```

Real projects can insert scan after synthesis or build limited test logic in RTL. The capstone uses the latter so that every beginner can see the mux and shift behavior. Its ASIC run uses SKY130HD standard cells. Inspect the final netlist to see the scan pins and the cell-level implementation; a GDS file alone does not show test coverage.

The capstone can also cut its mapped flip-flops into pseudo-inputs and outputs and run a small Fault campaign on the resulting combinational logic. Translating those patterns into scan shifts and validating production test timing are additional steps.

Physical verification has distinct scopes. Routing checks, a selected DRC deck, LVS, functional simulation, and timing each answer different questions. Read the capstone's run notes for the exact checks and their limitations.

## 4. Continue learning

Work through [Labs 1-4 and the capstone](README.md#learning-order) first. Labs 5-9 introduce compression, at-speed test, memory BIST, boundary scan, logic BIST, and testability as small models. For each exercise, read its input, predict the result, run it, then change one value and explain the difference. The automated runner is useful for checking the shipped examples after you experiment.
