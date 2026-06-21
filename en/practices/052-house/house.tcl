# ==============================================================================
# EXERCISM TCL PRACTICE: HOUSE
# ==============================================================================
# # Instructions
#
# Recite the nursery rhyme 'This is the House that Jack Built'.
#
# > [The] process of placing a phrase of clause within another phrase of clause is called embedding.
# > It is through the processes of recursion and embedding that we are able to take a finite number of forms (words and phrases) and construct an infinite number of expressions.
# > Furthermore, embedding also allows us to construct an infinitely long structure, in theory anyway.
#
# - [papyr.com][papyr]
#
# The nursery rhyme reads as follows:
#
# ```text
# This is the house that Jack built.
#
# This is the malt
# that lay in the house that Jack built.
#
# This is the rat
# that ate the malt
# that lay in the house that Jack built.
#
# This is the cat
# that killed the rat
# that ate the malt
# that lay in the house that Jack built.
#
# This is the dog
# that worried the cat
# that killed the rat
# that ate the malt
# that lay in the house that Jack built.
#
# This is the cow with the crumpled horn
# that tossed the dog
# that worried the cat
# that killed the rat
# that ate the malt
# that lay in the house that Jack built.
#
# This is the maiden all forlorn
# that milked the cow with the crumpled horn
# that tossed the dog
# that worried the cat
# that killed the rat
# that ate the malt
# that lay in the house that Jack built.
#
# This is the man all tattered and torn
# that kissed the maiden all forlorn
# that milked the cow with the crumpled horn
# that tossed the dog
# that worried the cat
# that killed the rat
# that ate the malt
# that lay in the house that Jack built.
#
# This is the priest all shaven and shorn
# that married the man all tattered and torn
# that kissed the maiden all forlorn
# that milked the cow with the crumpled horn
# that tossed the dog
# that worried the cat
# that killed the rat
# that ate the malt
# that lay in the house that Jack built.
#
# This is the rooster that crowed in the morn
# that woke the priest all shaven and shorn
# that married the man all tattered and torn
# that kissed the maiden all forlorn
# that milked the cow with the crumpled horn
# that tossed the dog
# that worried the cat
# that killed the rat
# that ate the malt
# that lay in the house that Jack built.
#
# This is the farmer sowing his corn
# that kept the rooster that crowed in the morn
# that woke the priest all shaven and shorn
# that married the man all tattered and torn
# that kissed the maiden all forlorn
# that milked the cow with the crumpled horn
# that tossed the dog
# that worried the cat
# that killed the rat
# that ate the malt
# that lay in the house that Jack built.
#
# This is the horse and the hound and the horn
# that belonged to the farmer sowing his corn
# that kept the rooster that crowed in the morn
# that woke the priest all shaven and shorn
# that married the man all tattered and torn
# that kissed the maiden all forlorn
# that milked the cow with the crumpled horn
# that tossed the dog
# that worried the cat
# that killed the rat
# that ate the malt
# that lay in the house that Jack built.
# ```
#
# [papyr]: https://papyr.com/hypertextbooks/grammar/ph_noun.htm

# ==============================================================================
# KỸ THUẬT & GIẢI THÍCH (ALGORITHM & TCL SYNTAX)
# ==============================================================================
# 1. Ý TƯỞNG GỘP CỤM CÂU (SENTENCE PATTERN):
#    - Mỗi câu thơ có dạng "the [đối_tượng] [hành_động]" (ví dụ: "the malt that lay in").
#    - Với khổ thơ thứ i, ta cắt danh sách từ 0 đến i-1: `[lrange $s 0 $i-1]`.
#    - Dùng `lreverse` để đảo ngược danh sách theo đúng thứ tự lồng đệ quy.
#
# 2. CÁC MẸO TỐI GIẢN TRONG TCL:
#    - `lappend res ...`: Lệnh `lappend` tự động khởi tạo biến `res` nếu chưa tồn tại (không cần `set res {}`).
#    - `join [lreverse ...]`: Mặc định `join` nối bằng khoảng trắng `" "` nếu không truyền tham số phân cách.
#    - `join $res \n`: Câu lệnh cuối cùng trong proc tự động trở thành giá trị trả về (không cần `return`).
# ==============================================================================

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







