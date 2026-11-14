# Diagnosis: match observations to faults

A detecting test shows that something failed. Diagnosis asks which faults could explain the observed responses.

This exercise reuses the five-net circuit from [Lab 4.1](../lab4_fault_atpg_flow/lab4_1_fault_atpg_run/exhaustive_stuck_at.tcl). It compares hypothetical measurements with each single stuck-at fault in that model.

From the repository root:

```sh
tclsh eda/dft/diagnosis/single_fault.tcl
tclsh eda/dft/diagnosis/single_fault.tcl inconsistent
```

The first run finds `a/0, b/0, n/0`. These candidates produce the same observations, so the available tests cannot distinguish them. The second run changes one measurement. No single modeled fault explains it, and the program exits with status 1.

Try changing one observation in a copy of the file. Predict the candidates before rerunning it. Then consider which internal signal would help distinguish the candidates. This is a small logic model; it does not locate physical defects or analyze silicon fail logs.
