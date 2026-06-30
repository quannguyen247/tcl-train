source sgf-parsing.tcl; source testHelpers.tcl; set expected { properties { A {{]}} } children {} }; set actual [parse {(;A[\]])}]; puts [sgfTreeMatch  ]
