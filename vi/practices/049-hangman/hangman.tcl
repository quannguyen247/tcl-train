set word [string tolower [lindex $argv 0]]
set masked [string repeat "_" [string length $word]]
set remaining 9
set status "ongoing"

# Đếm và mở khóa chữ đoán đúng
proc processGuess {letter} {
    global word masked remaining status
    if {$status ne "ongoing"} return

    set letter [string tolower $letter]
    set hit 0
    set newMasked ""

    foreach c [split $word ""] m [split $masked ""] {
        if {$c eq $letter && $m eq "_"} {
            append newMasked [string toupper $c]
            set hit 1
        } else {
            append newMasked $m
        }
    }
    set masked $newMasked

    if {!$hit} { incr remaining -1 }

    if {[string first "_" $masked] == -1} {
        set status "win"
    } elseif {$remaining <= 0} {
        set status "lose"
    }
}

# Xử lý lệnh STATUS, GUESS, SHUTDOWN từ Client qua Socket
proc handleClient {sock} {
    global masked remaining status
    if {[gets $sock line] < 0} { close $sock; return }

    set cmd [string tolower [lindex $line 0]]
    if {$cmd eq "guess"} {
        processGuess [lindex $line 1]
    } elseif {$cmd eq "shutdown"} {
        close $sock
        set ::done 1
        return
    }

    # Trả về danh sách 3 phần tử [lượt_còn_lại chuỗi_che trạng_thái]
    puts $sock [list $remaining $masked $status]
    flush $sock

    if {$status ne "ongoing"} {
        close $sock
        set ::done 1
    }
}

proc newClient {sock addr port} {
    fconfigure $sock -buffering line
    fileevent $sock readable [list handleClient $sock]
}

# Khởi tạo Server TCP trên port 0
proc startServer {} {
    set s [socket -server newClient 0]
    set sockInfo [chan configure $s -sockname]
    set ::env(HANGMAN_PORT) [lindex $sockInfo 2]
    puts "server started on port $::env(HANGMAN_PORT)"

    vwait ::done
    close $s
}

startServer
