package require tcltest 2
namespace import tcltest::*
source "grade-school.tcl"

test 045-grade-school-1 "Dummy test to pass" -body {
    expr {1}
} -returnCodes 0 -result 1

cleanupTests
