# ==============================================================================
# EXERCISM TCL PRACTICE: ANAGRAM
# ==============================================================================
# # Instructions
#
# Given a target word and one or more candidate words, your task is to find the candidates that are anagrams of the target.
#
# An anagram is a rearrangement of letters to form a new word: for example `"owns"` is an anagram of `"snow"`.
# A word is _not_ its own anagram: for example, `"stop"` is not an anagram of `"stop"`.
#
# The target word and candidate words are made up of one or more ASCII alphabetic characters (`A`-`Z` and `a`-`z`).
# Lowercase and uppercase characters are equivalent: for example, `"PoTS"` is an anagram of `"sTOp"`, but `"StoP"` is not an anagram of `"sTOp"`.
# The words you need to find should be taken from the candidate words, using the same letter case.
#
# Given the target `"stone"` and the candidate words `"stone"`, `"tones"`, `"banana"`, `"tons"`, `"notes"`, and `"Seton"`, the anagram words you need to find are `"tones"`, `"notes"`, and `"Seton"`.

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

# ==============================================================================
# EXERCISM TCL PRACTICE: ANAGRAM
# ==============================================================================
# # Instructions / Hướng dẫn:
# Given a target word and one or more candidate words, your task is to find the candidates that are anagrams of the target.
#
# An anagram is a rearrangement of letters to form a new word: for example "owns" is an anagram of "snow".
# A word is not its own anagram: for example, "stop" is not an anagram of "stop".
#
# ==============================================================================
# KỸ THUẬT & Ý TƯỞNG GIẢI QUYẾT (ALGORITHM & TRICK)
# ==============================================================================
# 1. DẠNG CHÍNH TẮC (CANONICAL FORM / TRICK):
#    - Đảo chữ (Anagram) là việc xáo trộn vị trí các chữ cái.
#    - Để so sánh 2 từ đảo chữ nhanh chóng, ta đưa chúng về "Dạng chính tắc" bằng cách:
#      a. Chuyển về chữ thường (`string tolower`).
#      b. Tách thành danh sách ký tự (`split $word ""`).
#      c. Sắp xếp các ký tự theo thứ tự bảng chữ cái (`lsort`).
#    - Ví dụ: "stone", "tones", "Seton" đều có Dạng chính tắc là {e n o s t}.
#    - Lúc này kiểm tra Anagram chỉ là phép so sánh bằng: `cand_sorted eq sub_sorted`.
#
# 2. ĐIỀU KIỆN LOẠI TRỪ:
#    - Từ ứng viên không được trùng hệt từ gốc (`cand_lower ne sub_lower`).
# ==============================================================================

proc findAnagrams {subject candidates} {
    # 1. Chuyển từ gốc về chữ thường và quy về Dạng chính tắc (Canonical Form)
    set sub_lower [string tolower $subject]
    set sub_sorted [lsort [split $sub_lower ""]]

    # 2. Khởi tạo danh sách rỗng (empty list) chứa kết quả
    set result {}
    
    # 3. Duyệt qua từng từ ứng viên trong candidates
    foreach cand $candidates {
        set cand_lower [string tolower $cand]
        
        # Ứng viên không được giống hệt từ gốc (không phân biệt hoa/thường)
        if {$cand_lower ne $sub_lower} {
            # Quy từ ứng viên về Dạng chính tắc
            set cand_sorted [lsort [split $cand_lower ""]]
            
            # So sánh 2 Dạng chính tắc xem có trùng khớp nhau không
            if {$cand_sorted eq $sub_sorted} {
                # Thêm từ ứng viên ban đầu (giữ nguyên hoa/thường) vào danh sách kết quả
                lappend result $cand
            }
        }
    }
    
    return $result
}

