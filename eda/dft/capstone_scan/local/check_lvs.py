"""Verify the circuit-pair statuses in a KLayout LVS database."""
import pya

database = pya.LayoutVsSchematic()
database.read(lvs_file)
reference = database.xref()
matched = 0
top_matched = False
for pair in reference.each_circuit_pair():
    first, second, status = pair.first(), pair.second(), pair.status()
    if first is None or second is None or status != reference.Match:
        raise RuntimeError("Unmatched circuit pair in LVS database")
    matched += 1
    if first.name.lower() == "scan_counter" and second.name.lower() == "scan_counter":
        top_matched = True
if not top_matched or matched < 2:
    raise RuntimeError("Top or standard-cell comparisons missing")
print("LVS database: %d matching circuit pairs including scan_counter" % matched)
