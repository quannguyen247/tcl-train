# ==============================================================================
# EXERCISM TCL PRACTICE: HANGMAN
# ==============================================================================
# # Instructions
#
# Implement the logic of the hangman game using functional reactive programming.
#
# [Hangman][hangman] is a simple word guessing game.
#
# [Functional Reactive Programming][frp] is a way to write interactive programs.
# It differs from the usual perspective in that instead of saying "when the button is pressed increment the counter", you write "the value of the counter is the sum of the number of times the button is pressed."
#
# Implement the basic logic behind hangman using functional reactive programming.
# You'll need to install an FRP library for this, this will be described in the language/track specific files of the exercise.
#
# [hangman]: https://en.wikipedia.org/wiki/Hangman_%28game%29
# [frp]: https://en.wikipedia.org/wiki/Functional_reactive_programming

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

# This exercise is less structured than others
throw {NOT_IMPLEMENTED} "Implement this program."

# For starting the server, use a proc like this:
#
proc startServer {} {
    # use port 0 to allow Tcl to find an unused port
    set s [socket -server yourCallbackProc 0]

    # communicate the port number in use
    set sockInfo [chan configure $s -sockname]
    set ::env(HANGMAN_PORT) [lindex $sockInfo 2]
    puts "server started on port $::env(HANGMAN_PORT)"

    # enter the event loop
    vwait aGlobalVarname
}

# get the word from the $argv list, then:
startServer

