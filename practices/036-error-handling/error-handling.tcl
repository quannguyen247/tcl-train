proc custom_error_message {message} {
    error $message
}

proc handle_error {script} {
    set code [catch {uplevel 1 $script} msg]

    if {$code == 0} {
        return "success"
    }

    if {[string match "*zero*" $msg] || [string match "*divide*" $msg]} {
        return "division by zero"
    }
    if {[string match "*open*" $msg] || [string match "*file*" $msg]} {
        return "file does not exist"
    }
    if {[string match "*invalid command name*" $msg]} {
        return "proc does not exist"
    }

    return $msg
}
