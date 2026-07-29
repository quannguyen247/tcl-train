proc recite {from to} {
    set s {
        "the house that Jack built."
        "the malt that lay in"
        "the rat that ate"
        "the cat that killed"
        "the dog that worried"
        "the cow with the crumpled horn that tossed"
        "the maiden all forlorn that milked"
        "the man all tattered and torn that kissed"
        "the priest all shaven and shorn that married"
        "the rooster that crowed in the morn that woke"
        "the farmer sowing his corn that kept"
        "the horse and the hound and the horn that belonged to"
    }
    
    # Lặp qua từng khổ thơ từ $from đến $to
    for {set i $from} {$i <= $to} {incr i} {
        # [lrange $s 0 $i-1]: Cắt danh sách từ 0 đến i-1
        # [lreverse ...]: Đảo ngược danh sách các câu
        # [join ...]: Nối các câu bằng khoảng trắng mặc định
        # lappend tự động khởi tạo biến res
        lappend res "This is [join [lreverse [lrange $s 0 $i-1]]]"
    }
    
    # Nối các khổ thơ bằng dấu xuống dòng "\n"
    return [join $res "\n"]
}







