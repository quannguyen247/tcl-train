proc plants {diagram student} {
    set student_dict {
        Alice 0 Bob 1 Charlie 2 David 3
        Eve 4 Fred 5 Ginny 6 Harriet 7
        Ileana 8 Joseph 9 Kincaid 10 Larry 11
    }

    set plant_names {
        G grass C clover R radishes V violets
    }

    set k [dict get $student_dict $student]

    lassign [split $diagram "\n"] row1 row2

    set i1 [expr {$k * 2}]
    set i2 [expr {$k * 2 + 1}]

    set codes [split "[string range $row1 $i1 $i2][string range $row2 $i1 $i2]" ""]

    return [lmap c $codes {dict get $plant_names $c}]
}
