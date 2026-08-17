oo::class create ComplexNumber {
    variable r i

    constructor {real imag} {
        set r $real
        set i $imag
    }

    method real {} { return $r }
    method imag {} { return $i }
    method toList {} { list $r $i }

    method add {other} {
        if {[info object is object $other]} {
            return [ComplexNumber new [expr {$r + [$other real]}] [expr {$i + [$other imag]}]]
        }
        ComplexNumber new [expr {$r + $other}] $i
    }

    method sub {other} {
        if {[info object is object $other]} {
            return [ComplexNumber new [expr {$r - [$other real]}] [expr {$i - [$other imag]}]]
        }
        ComplexNumber new [expr {$r - $other}] $i
    }

    method mul {other} {
        if {[info object is object $other]} {
            set ar [$other real]; set ai [$other imag]
            return [ComplexNumber new [expr {$r*$ar - $i*$ai}] [expr {$r*$ai + $i*$ar}]]
        }
        ComplexNumber new [expr {$r * $other}] [expr {$i * $other}]
    }

    method div {other} {
        if {[info object is object $other]} {
            set ar [expr {double([$other real])}]; set ai [expr {double([$other imag])}]
            set d [expr {$ar*$ar + $ai*$ai}]
            return [ComplexNumber new [expr {($r*$ar + $i*$ai)/$d}] [expr {($i*$ar - $r*$ai)/$d}]]
        }
        ComplexNumber new [expr {$r / double($other)}] [expr {$i / double($other)}]
    }

    method abs {} { expr {hypot($r, $i)} }
    method conj {} { ComplexNumber new $r [expr {-$i}] }
    method exp {} {
        set er [expr {exp($r)}]
        ComplexNumber new [expr {$er * cos($i)}] [expr {$er * sin($i)}]
    }
}

proc tcl::mathfunc::cr_add {a b} {
    if {[info object is object $a]} { return [$a add $b] }
    [ComplexNumber new $a 0] add $b
}

proc tcl::mathfunc::cr_sub {a b} {
    if {[info object is object $a]} { return [$a sub $b] }
    [ComplexNumber new $a 0] sub $b
}

proc tcl::mathfunc::cr_mul {a b} {
    if {[info object is object $a]} { return [$a mul $b] }
    [ComplexNumber new $a 0] mul $b
}

proc tcl::mathfunc::cr_div {a b} {
    if {[info object is object $a]} { return [$a div $b] }
    [ComplexNumber new $a 0] div $b
}
