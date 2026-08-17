oo::class create CircularBuffer {
    variable capacity buffer

    constructor {cap} {
        set capacity $cap
        set buffer {}
    }

    method empty? {} {
        return [expr {[llength $buffer] == 0}]
    }

    method full? {} {
        return [expr {[llength $buffer] == $capacity}]
    }

    method read {} {
        if {[my empty?]} {
            error "buffer is empty"
        }
        set val [lindex $buffer 0]
        set buffer [lrange $buffer 1 end]
        return $val
    }

    method write {value} {
        if {[my full?]} {
            error "buffer is full"
        }
        lappend buffer $value
    }

    method overwrite {value} {
        if {[my full?]} {
            set buffer [lrange $buffer 1 end]
        }
        lappend buffer $value
    }

    method clear {} {
        set buffer {}
    }
}
