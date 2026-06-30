source sgf-parsing.tcl
set a [parse {(;A[\]])}]
source usercode.tcl
set b [parse {(;A[\]])}]
puts "Mine: $a"
puts "User: $b"
if {$a == $b} {puts MATCH} else {puts DIFFERENT}
