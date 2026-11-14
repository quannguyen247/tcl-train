# Lab 6: memory test and repair models

The exercises model memory operations in Tcl. They do not access a physical SRAM or eFuse.

Enter an exercise directory and run its Tcl file:

```sh
cd eda/dft/lab6_memory_bist_mbist_bisr/<exercise>
tclsh <exercise>.tcl
```

Replace `<exercise>` with a directory name from the table. Run from the repository root before using `cd`.

| Exercise | Task and expected observation |
| --- | --- |
| [lab6_1_sram_fault_models](lab6_1_sram_fault_models/) | Read sample stuck-at, transition, coupling, and address fault descriptions. |
| [lab6_2_march_c_minus_engine](lab6_2_march_c_minus_engine/) | Run the 10N March C- software model. Append `stuck-at-0` to inject a fault and expect failure. |
| [lab6_3_retention_test_pause](lab6_3_retention_test_pause/) | Check modeled readback. Append `inject-bitflip` to observe a failure; no analog retention is simulated. |
| [lab6_4_bisr_redundancy_alloc](lab6_4_bisr_redundancy_alloc/) | Use a simple greedy spare-row/spare-column choice on a sample map; it is not generally optimal. |
| [lab6_5_efuse_repair_programmer](lab6_5_efuse_repair_programmer/) | Format sample repair addresses as register values. Nothing is programmed. |
