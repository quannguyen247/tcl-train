# Fault command examples

These eight short exercises use [Fault](https://fault.readthedocs.io/en/latest/) with the local toy Liberty and simulation models. Run each from anywhere with `tclsh eda/dft/appendix_fault/fault_labN.tcl`, replacing `N` with 1 through 8. Generated files are kept in a separate `build/` directory for each run. A failing command returns an error instead of creating substitute results.

| Example | Operation |
| --- | --- |
| 1 | Show the installed version and available subcommands. |
| 2 | Synthesize the sequential fixture. |
| 3 | Cut its flip-flops into pseudo-inputs and outputs. |
| 4 | Ask Fault to construct a scan chain. Inspect the generated ports and metadata. |
| 5 | Add a TAP to the chained fixture. |
| 6 | Run stuck-at fault simulation on two explicit gates. |
| 7 | Repeat with coverage metadata enabled. |
| 8 | Explore a bypassed input on a separate example. |

Fault's default generator is pseudo-random; external deterministic generators depend on the installed tool options. Coverage and pattern counts belong to the exact fixture, fault model, and run. The tool invokes its own Icarus-based backend, while the course's direct RTL simulations use Questa. The small Liberty file is educational and has no physical layout or characterized timing.

## Use Cadence-style commands with Fault+

[Fault+](https://github.com/quannguyen247/fault-plus) is the separate tool fork. Clone it outside this course and run `./install.sh` there. It installs the backend and the Tcl interface together.

From the Fault+ checkout, try:

```sh
faultplus -f faultplus/examples/genus_scan.tcl
faultplus -f faultplus/examples/atpg.tcl
```

Read each script before running it. Identify the synthesis settings, scan controls, testmode and fault model. Inspect `chained.v` and the JSON/YAML files under `.faultplus/`.

Compare the native Fault commands in this appendix with the mapped commands in those scripts. `syn_map` runs Fault/Yosys synthesis. `connect_scan_chains` invokes Fault's chain operation. `create_logic_tests` invokes its stuck-at engine. Command names alone do not establish Cadence-equivalent results. The fork's command reference lists the supported forms and rejected operations.

The course runner's `--fault` option uses the native `fault` command. The Fault+ container installation exposes `faultplus`; it does not replace the host's native Fault installation.
