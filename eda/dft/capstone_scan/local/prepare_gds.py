"""KLayout 0.26 post-processing; invoked by local/run_flow.py.

Input variables are supplied by KLayout's -rd option. The virtual substrate
is written only to the separate LVS input, not to the deliverable GDS.
"""
import re
import pya

layout = pya.Layout()
layout.read(in_gds)
top = layout.cell("scan_counter")
if top is None:
    raise RuntimeError("scan_counter missing from GDS")

# KLayout 0.26 emits top-level DEF pins on purpose 16 but does not always
# duplicate their geometry on drawing purpose 20. Both are needed here.
pin_count = 0
for number in (67, 68, 69, 70, 71, 72):
    pin = layout.find_layer(number, 16)
    if pin is None:
        continue
    drawing = layout.layer(number, 20)
    for shape in top.shapes(pin).each():
        if not shape.is_text():
            top.shapes(drawing).insert(shape)
            pin_count += 1
if pin_count != 10:
    raise RuntimeError("Expected 10 top-level signal pin shapes, got %s" % pin_count)

# Add net labels to actual power straps at locations read from the final DEF.
with open(in_def) as f:
    text = f.read()
numbers = {"met1": 68, "met2": 69, "met3": 70, "met4": 71, "met5": 72}
for net in ("VDD", "VSS"):
    block = re.search(r"(?ms)^\s*-\s+%s\s+\(.*?;" % net, text)
    if block is None:
        raise RuntimeError("Missing power special net " + net)
    route = re.search(
        r"\+\s+ROUTED\s+(met[1-5])\s+\d+.*?\(\s*(-?\d+)\s+(-?\d+)\s*\)\s*\(\s*(-?\d+)\s+(-?\d+)\s*\)",
        block.group(0), re.S)
    if route is None:
        raise RuntimeError("Missing power stripe geometry for " + net)
    layer, x1, y1, x2, y2 = route.groups()
    x, y = (int(x1) + int(x2)) // 2, (int(y1) + int(y2)) // 2
    number = numbers[layer]
    metal = layout.find_layer(number, 20)
    point = pya.Point(x, y)
    if metal is None or not any(s.bbox().contains(point) for s in top.shapes(metal).each()):
        raise RuntimeError("No matching drawing geometry at " + net + " stripe")
    top.shapes(layout.layer(number, 5)).insert(pya.Text(net, pya.Trans(x, y)))

# This is the usable output. It contains no artificial substrate layer.
layout.write(out_gds)

# The educational LVS deck uses 236/0 as a virtual substrate. This layer is
# present only in the diagnostic extraction input.
top.shapes(layout.layer(236, 0)).insert(top.bbox())
layout.write(lvs_gds)
print("Prepared GDS: %d signal pin shapes; VDD and VSS labels added" % pin_count)
