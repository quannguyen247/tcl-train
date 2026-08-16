proc countWords {sentence} {
    set counts {}

    foreach word [regexp -all -inline {[[:alnum:]]+(?:'[[:alnum:]]+)*} \
        [string tolower $sentence]] {
        dict incr counts $word
    }

    return $counts
}
