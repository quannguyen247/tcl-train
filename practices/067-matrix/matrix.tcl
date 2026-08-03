proc matrixFrom {inputString} {
    return [split $inputString "\n"]
}

proc row {matrix n} {
    return [lindex $matrix $n-1]
}

proc column {matrix n} {
    return [lmap x $matrix {lindex $x $n-1}]
}
