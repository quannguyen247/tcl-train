source sgf-parsing.tcl
source usercode.tcl
set tests {
	{empty {}}
	{tree_with_no_nodes {;}}
	{node_without_tree {(;)}}
	{node_without_properties {(;)}}
	{single_property_b {(;B[b])}}
	{properties_without_delimiter {(;A)}}
	{all_lowercase_property {(;a[b])}}
	{upper_and_lowercase_property {(;Aa[b])}}
	{two_nodes {(;A[b];B[c])}}
	{two_child_trees {(;A[b](;B[c])(;C[d]))}}
	{multiple_property_values {(;A[b][c][d])}}
	{escaped_property {(;A[\]b\nc\nd\t\te \n\]])}}
	{whitespace {(;A[b\tc\nd\\])}}
}
foreach t $tests {
	lassign $t name input
	catch {parse $input} out1
	catch {
		proc parse_user {i} {
			if {$i eq {}} {error "tree missing"}
			tailcall parseToken [lex $i]
		}
		parse_user $input
	} out2
	if {$out1 != $out2} {
		puts "DIFF on $name:"
		puts "Mine: $out1"
		puts "User: $out2"
	}
}
