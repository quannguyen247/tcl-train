source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# Rank one candidate from an illustrative report.
set d [lab::fields tpi_candidates.txt]
set net [lab::required $d NET_NAME]
set score [lab::required $d T_TOTAL]
set threshold [lab::required $d THRESHOLD_T]
set sum [expr {[lab::required $d CC0]+[lab::required $d CC1]+[lab::required $d CO]}]
if {$score != $sum} {error "Candidate score does not match CC0+CC1+CO"}
puts "$net: score=$score threshold=$threshold selected=[expr {$score > $threshold}]"
puts "Fixture post-change score: [lab::required $d NEW_T_AFTER_CP]"
puts "No point was inserted and the new score was not recomputed."
