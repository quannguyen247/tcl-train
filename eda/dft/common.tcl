# Small helpers for the self-contained text-processing exercises.
namespace eval lab {
    proc read_input {name} {
        set input [file join [file dirname [file normalize $::argv0]] $name]
        set channel [open $input r]
        try {return [read $channel]} finally {close $channel}
    }
    proc fields {name} {
        set result [dict create]
        foreach line [split [read_input $name] "\n"] {
            if {[regexp {^\s*#} $line]} continue
            set pairs [regexp -all -inline {([A-Z][A-Z_0-9]*)\s*=\s*([^|#]+)} $line]
            foreach {whole key value} $pairs {
                dict set result $key [string trim $value]
            }
        }
        return $result
    }
    proc required {values key} {
        if {![dict exists $values $key]} {error "Missing required field: $key"}
        return [dict get $values $key]
    }
    proc match_one {text pattern label} {
        if {![regexp $pattern $text -> value]} {error "Missing $label"}
        return $value
    }
}
