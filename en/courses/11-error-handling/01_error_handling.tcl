# Exercise: Error Handling
# 1. Use catch for safe parsing.
# 2. Trace variable changes.
# 3. Introspect procedures.

proc safe_divide {a b} {
    if {$b == 0} {
        return -code error "Division by zero"
    }
    return [expr {$a / $b}]
}

puts "--- 1. Catching errors ---"
if {[catch {safe_divide 10 0} result]} {
    puts "Caught exception: $result"
}

puts "\n--- 2. Variable Tracing ---"
proc trace_var {name element op} {
    upvar $name var
    puts "TRACE: Variable $name changed to '$var' ($op)"
}
set my_slack 1.2
trace add variable my_slack write trace_var
set my_slack -0.5
set my_slack 0.1

puts "\n--- 3. Introspection ---"
puts "Procs matching 'safe_*': [info procs safe_*]"
puts "Args of safe_divide: [info args safe_divide]"
