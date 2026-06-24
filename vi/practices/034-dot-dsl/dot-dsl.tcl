# ==============================================================================
# EXERCISM TCL PRACTICE: DOT-DSL
# ==============================================================================
# # Instructions
#
# A [Domain Specific Language (DSL)][dsl] is a small language optimized for a specific domain.
# Since a DSL is targeted, it can greatly impact productivity/understanding by allowing the writer to declare _what_ they want rather than _how_.
#
# One problem area where they are applied are complex customizations/configurations.
#
# For example the [DOT language][dot-language] allows you to write a textual description of a graph which is then transformed into a picture by one of the [Graphviz][graphviz] tools (such as `dot`).
# A simple graph looks like this:
#
#     graph {
#         graph [bgcolor="yellow"]
#         a [color="red"]
#         b [color="blue"]
#         a -- b [color="green"]
#     }
#
# Putting this in a file `example.dot` and running `dot example.dot -T png -o example.png` creates an image `example.png` with red and blue circle connected by a green line on a yellow background.
#
# Write a Domain Specific Language similar to the Graphviz dot language.
#
# Our DSL is similar to the Graphviz dot language in that our DSL will be used to create graph data structures.
# However, unlike the DOT Language, our DSL will be an internal DSL for use only in our language.
#
# [Learn more about the difference between internal and external DSLs][fowler-dsl].
#
# [dsl]: https://en.wikipedia.org/wiki/Domain-specific_language
# [dot-language]: https://en.wikipedia.org/wiki/DOT_(graph_description_language)
# [graphviz]: https://graphviz.org/
# [fowler-dsl]: https://martinfowler.com/bliki/DomainSpecificLanguage.html

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

namespace eval DotFile {
    # Xử lý từng dòng trong graph
    proc parseGraph {definition} {
        set graph [dict create nodes {} edges {} attrs {}]
        foreach line [split $definition "\n"] {
            lassign [parseLine $line] words attr
            if {$words eq {}} {
                if {$attr ne {}} {dict set graph attrs \
                    [dict merge [dict get $graph attrs] $attr]}
                continue
            }
            # Bỏ qua dòng chú thích
            if {[regexp {^(//|#)} [lindex $words 0]]} {continue}
            if {[llength $words] == 1} {
                addNode graph [lindex $words 0] $attr
                continue
            }
            # Xử lý các cạnh
            while {[llength $words] > 1} {
                set words [lassign $words from type to]
                if {$type ne "--" || $to eq ""} {error "invalid edge"}
                addNode graph $from {}
                addNode graph $to {}
                set edge [lsort -dictionary [list $from $to]]
                if {![dict exists $graph edges $edge]} {dict set graph edges $edge {}}
                dict set graph edges $edge \
                    [dict merge [dict get $graph edges $edge] $attr]
                set words [linsert $words 0 $to]
            }
        }
        return $graph
    }

    # Tách nội dung và thuộc tính
    proc parseLine {line} {
        set line [string trim $line]
        regsub {;[[:space:]]*$} $line "" line
        set attr {}
        if {[regexp {^(.*)[[:space:]]*\[([^\]]*)\]$} \
            $line -> line attrText]} {
            if {![regexp {^([[:alnum:]_]+)=(.+)$} \
                $attrText -> key value]} {
                error "invalid attribute"
            }
            set value [string trim $value]
            regsub {^"(.*)"$} $value {\1} value
            set attr [list $key $value]
        } elseif {[string first "\[" $line] >= 0} {
            error "invalid attribute"
        }
        return [list [split [string trim $line]] $attr]
    }

    # Thêm node vào graph
    proc addNode {graphVar name attr} {
        upvar 1 $graphVar graph
        if {![regexp {^[[:alnum:]]+$} $name]} {error "node name must be alphanumeric"}
        if {![dict exists $graph nodes $name]} {dict set graph nodes $name {}}
        dict set graph nodes $name [dict merge \
            [dict get $graph nodes $name] $attr]
    }
}

# Đọc file trong môi trường an toàn
proc processDotFile {filename} {
    if {![file readable $filename]} {error "cannot read file"}
    set file [open $filename]
    set source [read $file]
    close $file
    set safe [interp create -safe]
    $safe alias graph ::DotFile::parseGraph
    try {
        return [$safe eval $source]
    } finally {
        interp delete $safe
    }
}
