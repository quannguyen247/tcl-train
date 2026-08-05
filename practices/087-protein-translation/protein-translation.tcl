proc proteins {strand} {
    set res {}
    foreach {a b c} [split $strand ""] {
        switch -exact -- "$a$b$c" {
            AUG { lappend res "Methionine" }
            UUU - UUC { lappend res "Phenylalanine" }
            UUA - UUG { lappend res "Leucine" }
            UCU - UCC - UCA - UCG { lappend res "Serine" }
            UAU - UAC { lappend res "Tyrosine" }
            UGU - UGC { lappend res "Cysteine" }
            UGG { lappend res "Tryptophan" }
            UAA - UAG - UGA { break }
            default { return -code error "Invalid codon" }
        }
    }
    return $res
}
