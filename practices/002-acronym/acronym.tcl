proc abbreviate {phrase} {
    set phrase_cleaned [regsub -all {[^a-zA-Z']} $phrase " "]

    foreach word $phrase_cleaned {
        append acronym [string toupper [string index $word 0]]
    }
    return $acronym
}
