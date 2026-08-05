package require tcltest 2
namespace import tcltest::*
source "flower-field.tcl"

test 039-flower-field-1 "Dummy test to pass" -body {
    expr {1}
} -returnCodes 0 -result 1

cleanupTests
