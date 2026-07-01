# ==============================================================================
# EXERCISM TCL PRACTICE: TWELVE-DAYS
# ==============================================================================
# # Instructions
#
# Your task in this exercise is to write code that returns the lyrics of the song: "The Twelve Days of Christmas."
#
# "The Twelve Days of Christmas" is a common English Christmas carol.
# Each subsequent verse of the song builds on the previous verse.
#
# The lyrics your code returns should _exactly_ match the full song text shown below.
#
# ## Lyrics
#
# ```text
# On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.
#
# On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.
#
# On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
#
# On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
#
# On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
#
# On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
#
# On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
#
# On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
#
# On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
#
# On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
#
# On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
#
# On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
# ```

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

proc verse {n} {
    # Tên các ngày trong bài hát
    set days {
        first second third fourth fifth sixth
        seventh eighth ninth tenth eleventh twelfth
    }

    # Danh sách quà theo từng ngày
    set gifts {
        {a Partridge in a Pear Tree.}
        {two Turtle Doves}
        {three French Hens}
        {four Calling Birds}
        {five Gold Rings}
        {six Geese-a-Laying}
        {seven Swans-a-Swimming}
        {eight Maids-a-Milking}
        {nine Ladies Dancing}
        {ten Lords-a-Leaping}
        {eleven Pipers Piping}
        {twelve Drummers Drumming}
    }

    # Lấy quà từ ngày hiện tại về ngày đầu tiên
    set lines {}
    for {set i [expr {$n - 1}]} {$i >= 0} {incr i -1} {
        set line [lindex $gifts $i]
        if {$i > 0} {
            append line ,
        } elseif {$n > 1} {
            set line "and $line"
        }
        lappend lines $line
    }

    return "On the [lindex $days [expr {$n - 1}]] day of Christmas my true love gave to me: [join $lines " "]"
}

proc sing {from to} {
    # Ghép các verse bằng xuống dòng
    set song {}
    for {set day $from} {$day <= $to} {incr day} {
        lappend song [verse $day]
    }
    return [join $song \n]
}

