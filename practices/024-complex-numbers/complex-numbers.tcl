oo::class create ComplexNumber {
    variable r
    variable i

    constructor {real_part imag_part} {
        set r $real_part
        set i $imag_part
    }

    method real {} { return $r }
    method imag {} { return $i }
    method toList {} { return [list $r $i] }

    method add {other} {
        if {[info object is object $other]} {
            set ar [$other real]
            set ai [$other imag]
        } else {
            set ar $other
            set ai 0
        }
        return [ComplexNumber new [expr {$r + $ar}] [expr {$i + $ai}]]
    }

    method sub {other} {
        if {[info object is object $other]} {
            set ar [$other real]
            set ai [$other imag]
        } else {
            set ar $other
            set ai 0
        }
        return [ComplexNumber new [expr {$r - $ar}] [expr {$i - $ai}]]
    }

    method mul {other} {
        if {[info object is object $other]} {
            set ar [$other real]
            set ai [$other imag]
            set nr [expr {$r * $ar - $i * $ai}]
            set ni [expr {$r * $ai + $i * $ar}]
        } else {
            set nr [expr {$r * $other}]
            set ni [expr {$i * $other}]
        }
        return [ComplexNumber new $nr $ni]
    }

    method div {other} {
        if {[info object is object $other]} {
            set ar [expr {double([$other real])}]
            set ai [expr {double([$other imag])}]
            set denom [expr {$ar * $ar + $ai * $ai}]
            set nr [expr {($r * $ar + $i * $ai) / $denom}]
            set ni [expr {($i * $ar - $r * $ai) / $denom}]
        } else {
            set o [expr {double($other)}]
            set nr [expr {$r / $o}]
            set ni [expr {$i / $o}]
        }
        return [ComplexNumber new $nr $ni]
    }

    method abs {} {
        return [expr {hypot($r, $i)}]
    }

    method conj {} {
        return [ComplexNumber new $r [expr {-$i}]]
    }

    method exp {} {
        set er [expr {exp($r)}]
        set nr [expr {$er * cos($i)}]
        set ni [expr {$er * sin($i)}]
        return [ComplexNumber new $nr $ni]
    }
}

proc tcl::mathfunc::cr_add {a b} {
    if {[info object is object $a] && [info object is object $b]} {
        return [$a add $b]
    } elseif {[info object is object $a]} {
        return [$a add $b]
    } else {
        return [[ComplexNumber new $a 0] add $b]
    }
}

proc tcl::mathfunc::cr_sub {a b} {
    if {[info object is object $a] && [info object is object $b]} {
        return [$a sub $b]
    } elseif {[info object is object $a]} {
        return [$a sub $b]
    } else {
        return [[ComplexNumber new $a 0] sub $b]
    }
}

proc tcl::mathfunc::cr_mul {a b} {
    if {[info object is object $a] && [info object is object $b]} {
        return [$a mul $b]
    } elseif {[info object is object $a]} {
        return [$a mul $b]
    } else {
        return [[ComplexNumber new $a 0] mul $b]
    }
}

proc tcl::mathfunc::cr_div {a b} {
    if {[info object is object $a] && [info object is object $b]} {
        return [$a div $b]
    } elseif {[info object is object $a]} {
        return [$a div $b]
    } else {
        return [[ComplexNumber new $a 0] div $b]
    }
}
