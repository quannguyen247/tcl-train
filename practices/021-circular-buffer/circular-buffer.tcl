oo::class create CircularBuffer {
    variable cap
    variable buffer

    constructor {capacity} {
        set cap $capacity
        set buffer {}
    }

    method empty? {} {
        return [expr {[llength $buffer] == 0}]
    }

    method full? {} {
        return [expr {[llength $buffer] == $cap}]
    }

    method read {} {
        if {[my empty?]} {
            error "buffer is empty"
        }
        set item [lindex $buffer 0]
        set buffer [lrange $buffer 1 end]
        return $item
    }

    method write {item} {
        if {[my full?]} {
            error "buffer is full"
        }
        lappend buffer $item
    }

    method overwrite {item} {
        if {[my full?]} {
            set buffer [lrange $buffer 1 end]
        }
        lappend buffer $item
    }

    method clear {} {
        set buffer {}
    }
}
