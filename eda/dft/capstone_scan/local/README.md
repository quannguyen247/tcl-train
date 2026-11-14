# Reproduce the reference flow

`run_flow.py` supports the older tool combination used in [the recorded run](../RUN_RESULTS.md). It needs:

- ORFS revision `68b1f26134c63d072a19b3a514c5a99effd08501` and its complete SKY130HD platform files.
- Apptainer and an OpenROAD SIF compatible with that ORFS revision.
- Podman and a local image containing KLayout 0.26.9.
- Native Yosys, Python with PyYAML, and the normal ORFS runtime dependencies.
- Native Fault for `--fault`; a licensed Questa installation for `--questa`.

Run from the repository root, replacing the input paths:

```sh
python3 eda/dft/capstone_scan/local/run_flow.py \
  --orfs /path/to/orfs-68b1f261 \
  --openroad-image /path/to/openroad.sif --fault --questa
```

Read `--help` for the KLayout image option. The script checks the ORFS revision and KLayout version, then creates a fresh `build/` directory containing logs, reports, `summary.json` and `scan_counter.gds`. Containers run without network access. The script does not install tools or a PDK.

Compatibility steps map SKY130 layers, add pin metal and power labels from the DEF, and create a separate LVS GDS with an artificial substrate layer. DRC checks BEOL and off-grid rules with FEOL disabled. Diagnostic LVS omits physical-only tap instances from its reference. Post-route Questa simulation uses functional cell models without SDF.

Fault analyzes the pre-layout mapped netlist after cutting four flip-flops. Scan enable and scan input are fixed to zero. Its patterns are pseudo-I/O vectors, with coverage limited to the modeled stuck-at sites. The script records an inconsistency in Fault 0.9.4's uncovered-fault lists and cross-checks the covered sites against the compacted vectors.
