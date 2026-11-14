source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# Decode the sample IDCODE and exercise a software one-bit bypass model.
set d [lab::fields idcode_spec.txt]
set raw [lab::required $d RAW_IDCODE]
set version [expr {($raw >> 28) & 0xf}]
set part [expr {($raw >> 12) & 0xffff}]
set manufacturer [expr {($raw >> 1) & 0x7ff}]
if {($raw & 1) != 1} {error "IDCODE bit 0 must be one"}
if {$version != [lab::required $d VERSION] || $part != [lab::required $d PART_NUMBER] || $manufacturer != [lab::required $d MANUFACTURER_ID]} {error "Sample IDCODE fields disagree"}
puts [format "IDCODE=%s version=0x%X part=0x%04X manufacturer=0x%03X" $raw $version $part $manufacturer]
set bypass 0; set observed [list]
foreach tdi {1 0 1 1} {lappend observed $bypass; set bypass $tdi}
if {$observed ne {0 1 0 1}} {error "Bypass model failed"}
puts "One-bit model output: $observed; this does not test a hardware TAP."
