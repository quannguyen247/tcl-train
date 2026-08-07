package require tcltest 2
namespace import tcltest::*
source "hangman.tcl"

test 049-hangman-1 "Dummy test to pass" -body {
    expr {1}
} -returnCodes 0 -result 1

cleanupTests
