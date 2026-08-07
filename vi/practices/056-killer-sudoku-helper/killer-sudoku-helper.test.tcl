package require tcltest 2
namespace import tcltest::*
source "killer-sudoku-helper.tcl"

test 056-killer-sudoku-helper-1 "Dummy test to pass" -body {
    expr {1}
} -returnCodes 0 -result 1

cleanupTests
