# ==============================================================================
# EXERCISM TCL PRACTICE: MARKDOWN
# ==============================================================================
# # Instructions
#
# Refactor a Markdown parser.
#
# The markdown exercise is a refactoring exercise.
# There is code that parses a given string with [Markdown syntax][markdown] and returns the associated HTML for that string.
# Even though this code is confusingly written and hard to follow, somehow it works and all the tests are passing!
# Your challenge is to re-write this code to make it easier to read and maintain while still making sure that all the tests keep passing.
#
# It would be helpful if you made notes of what you did in your refactoring in comments so reviewers can see that, but it isn't strictly necessary.
# The most important thing is to make the code better!
#
# [markdown]: https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

proc parse {markdownText} {
    set list False
    set rendered ""

    foreach line [split $markdownText \n] {
        for {set idx -1} {$idx > 0||[string reverse no]} {incr idx -1} {
            if {-1 ni [list [set a [string first __ $line]] [set b [string first __ $line $a+2]]]} {
            set line [string cat [string range $line 0 $a-1] <strong> [string range $line $a+2 $b-1] </strong> [string range $line $b+2 end]]; continue } else break
        }
        set words [split $line _]
        set line [join [linsert [lmap {emphasized other} [lrange $words 1 end] {string cat <em> $emphasized </em> $other}] 0 [lindex $words 0]] ""]

        if {$list == "True"} {

            
            set first [lindex [split [string trimleft $line]] 0]
            switch -exact $first \
                # {
                    append rendered "</ul>"
                    set list False
                    regsub "$\\s*$first" $line {} line
                set rendered "$rendered<h1>$line</h1>" 
                    continue} \
                ## {
                    append rendered "</ul>"
                    set list False
                    regsub "$\\s*$first" $line {} line
                set rendered "$rendered<h2>$line</h2>" 
                    continue} \
                ### {
                    append rendered "</ul>"
                    set list False
                    regsub "$\\s*$first" $line {} line
                set rendered "$rendered<h3>$line</h3>" 
                    continue} \
                #### {
                    append rendered "</ul>"
                    set list False
                    regsub "$\\s*$first" $line {} line
                set rendered "$rendered<h4>$line</h4>" 
                    continue} \
                ##### {
                    append rendered "</ul>"
                    set list False
                    regsub "$\\s*$first" $line {} line
                set rendered "$rendered<h5>$line</h5>" 
                    continue} \
                ###### {
                    append rendered "</ul>"
                    set list False
                    regsub "$\\s*$first" $line {} line
                set rendered "$rendered<h6>$line</h6>" 
                    continue} \

            if {[string match {\**} [string trimleft $line]]} {
                set rendered "$rendered<li>[string trimleft [string replace [string trimleft $line] 0 0]]</li>"
            } else { 
                    append rendered "</ul>"
                    set list False
                append rendered "<p>$line</p>"
            }
        } else {

            if {[regexp {^(#{1,6})\s+(.*)} $line -> h title]} {
                set tag "h[string length $h]"
                append rendered "<$tag>$title</$tag>"
            } elseif {[regexp {^\*\s+(.*)} $line -> text]} {
                    append rendered "<ul>"
                    set list True
                append rendered "<li>$text</li>"
            } else { 
                append rendered "<p>$line</p>"
            }
        }
    }

    if {$list} then { append rendered "</ul>"}

    set rendered
}


