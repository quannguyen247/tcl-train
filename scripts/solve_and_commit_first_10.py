import os
import glob
import subprocess

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
EN_PRACTICES = os.path.join(BASE_DIR, "en", "practices")
VI_PRACTICES = os.path.join(BASE_DIR, "vi", "practices")

SOLUTIONS = {
    1: '''proc accumulate {varname values body} {
    upvar 1 $varname var
    set res {}
    foreach val $values {
        set var $val
        lappend res [uplevel 1 $body]
    }
    return $res
}''',
    2: '''proc abbreviate {phrase} {
    set clean [regsub -all {[-_]} $phrase " "]
    set words [split $clean " "]
    set result ""
    foreach word $words {
        set word [string trim $word]
        if {$word ne ""} {
            append result [string toupper [string index $word 0]]
        }
    }
    return $result
}''',
    3: '''proc encode {key phrase} {
    lassign $key a b
    if {[coprime $a 26] != 1} {
        error "a and m must be coprime."
    }
    set text [regsub -all {[^a-zA-Z0-9]} $phrase ""]
    set text [string tolower $text]
    set cipher ""
    set count 0
    foreach char [split $text ""] {
        if {[string is digit $char]} {
            set c $char
        } else {
            set x [expr {[scan $char %c] - 97}]
            set y [expr {($a * $x + $b) % 26}]
            set c [format %c [expr {$y + 97}]]
        }
        if {$count > 0 && $count % 5 == 0} {
            append cipher " "
        }
        append cipher $c
        incr count
    }
    return $cipher
}

proc decode {key phrase} {
    lassign $key a b
    if {[coprime $a 26] != 1} {
        error "a and m must be coprime."
    }
    set m_inv [mod_inverse $a 26]
    set text [regsub -all {[^a-zA-Z0-9]} $phrase ""]
    set text [string tolower $text]
    set plain ""
    foreach char [split $text ""] {
        if {[string is digit $char]} {
            append plain $char
        } else {
            set y [expr {[scan $char %c] - 97}]
            set x [expr {($m_inv * ($y - $b)) % 26}]
            if {$x < 0} { set x [expr {$x + 26}] }
            append plain [format %c [expr {$x + 97}]]
        }
    }
    return $plain
}

proc coprime {a b} {
    while {$b != 0} {
        set t $b
        set b [expr {$a % $b}]
        set a $t
    }
    return $a
}

proc mod_inverse {a m} {
    for {set x 1} {$x < $m} {incr x} {
        if {[expr {($a * $x) % $m}] == 1} {
            return $x
        }
    }
    return 1
}''',
    4: '''proc rebase {inputBase digits outputBase} {
    if {$inputBase < 2} { error "input base must be >= 2" }
    if {$outputBase < 2} { error "output base must be >= 2" }
    set decimal 0
    foreach d $digits {
        if {$d < 0 || $d >= $inputBase} { error "all digits must satisfy 0 <= d < input base" }
        set decimal [expr {$decimal * $inputBase + $d}]
    }
    if {$decimal == 0} { return {0} }
    set res {}
    while {$decimal > 0} {
        set rem [expr {$decimal % $outputBase}]
        set res [linsert $res 0 $rem]
        set decimal [expr {$decimal / $outputBase}]
    }
    return $res
}''',
    5: '''set ALLERGENS {
    eggs 1
    peanuts 2
    shellfish 4
    strawberries 8
    tomatoes 16
    chocolate 32
    pollen 64
    cats 128
}

proc allergicTo {allergen score} {
    global ALLERGENS
    if {![dict exists $ALLERGENS $allergen]} {
        return false
    }
    set val [dict get $ALLERGENS $allergen]
    return [expr {($score & $val) != 0}]
}

proc listAllergies {score} {
    global ALLERGENS
    set result {}
    dict for {item val} $ALLERGENS {
        if {($score & $val) != 0} {
            lappend result $item
        }
    }
    return $result
}''',
    6: '''proc solve {puzzle} {
    set puzzle [string map {"=" "=="} $puzzle]
    regexp -all {[A-Z]} $puzzle letters
    set unique_letters [lsort -unique $letters]
    if {[llength $unique_letters] > 10} { return {} }
    
    regexp -all {\\b[A-Z]} $puzzle leading_list
    set leading [lsort -unique $leading_list]

    set digits {0 1 2 3 4 5 6 7 8 9}
    set n [llength $unique_letters]
    
    foreach perm [permutations $digits $n] {
        set map {}
        set valid 1
        for {set i 0} {$i < $n} {incr i} {
            set char [lindex $unique_letters $i]
            set val [lindex $perm $i]
            if {$val == 0 && [lsearch -exact $leading $char] != -1} {
                set valid 0
                break
            }
            lappend map $char $val
        }
        if {!$valid} continue
        set expr_str [string map $map $puzzle]
        if {[expr $expr_str]} {
            return $map
        }
    }
    return {}
}

proc permutations {items k} {
    if {$k == 0} { return {{}} }
    if {[llength $items] == 0} { return {} }
    set result {}
    for {set i 0} {$i < [llength $items]} {incr i} {
        set item [lindex $items $i]
        set rest [lreplace $items $i $i]
        foreach p [permutations $rest [expr {$k - 1}]] {
            lappend result [linsert $p 0 $item]
        }
    }
    return $result
}''',
    7: '''proc findAnagrams {subject candidates} {
    set sub_lower [string tolower $subject]
    set sub_sorted [lsort [split $sub_lower ""]]
    set result {}
    foreach cand $candidates {
        set cand_lower [string tolower $cand]
        if {$cand_lower ne $sub_lower} {
            set cand_sorted [lsort [split $cand_lower ""]]
            if {$cand_sorted eq $sub_sorted} {
                lappend result $cand
            }
        }
    }
    return $result
}''',
    8: '''proc isArmstrongNumber {number} {
    set digits [split $number ""]
    set len [llength $digits]
    set sum 0
    foreach d $digits {
        set sum [expr {$sum + wide($d) ** $len}]
    }
    return [expr {$sum == $number}]
}''',
    9: '''proc encode {phrase} {
    set clean [regsub -all {[^a-zA-Z0-9]} $phrase ""]
    set clean [string tolower $clean]
    set cipher ""
    set count 0
    foreach char [split $clean ""] {
        if {[string is alpha $char]} {
            set c [format %c [expr {219 - [scan $char %c]}]]
        } else {
            set c $char
        }
        if {$count > 0 && $count % 5 == 0} {
            append cipher " "
        }
        append cipher $c
        incr count
    }
    return $cipher
}

proc decode {phrase} {
    set clean [regsub -all {[^a-zA-Z0-9]} $phrase ""]
    set clean [string tolower $clean]
    set plain ""
    foreach char [split $clean ""] {
        if {[string is alpha $char]} {
            set c [format %c [expr {219 - [scan $char %c]}]]
        } else {
            set c $char
        }
        append plain $c
    }
    return $plain
}''',
    10: '''proc sharedBirthday {birthdays} {
    array set seen {}
    foreach b $birthdays {
        set md [string range $b 5 9]
        if {[info exists seen($md)]} {
            return true
        }
        set seen($md) 1
    }
    return false
}

proc randomBirthdates {count} {
    set res {}
    set days_in_month {31 28 31 30 31 30 31 31 30 31 30 31}
    for {set i 0} {$i < $count} {incr i} {
        set month [expr {int(rand() * 12) + 1}]
        set max_day [lindex $days_in_month [expr {$month - 1}]]
        set day [expr {int(rand() * $max_day) + 1}]
        set year [expr {int(rand() * 50) + 1970}]
        lappend res [format "%04d-%02d-%02d" $year $month $day]
    }
    return $res
}

proc estimatedProbabilityOfSharedBirthday {size} {
    set trials 1000
    set shared 0
    for {set i 0} {$i < $trials} {incr i} {
        set dates [randomBirthdates $size]
        if {[sharedBirthday $dates]} {
            incr shared
        }
    }
    return [expr {double($shared) / $trials}]
}'''
}

def update_file(filepath, solution_code):
    with open(filepath, "r", encoding="utf-8") as f:
        content = f.read()
        
    delimiter = "# YOUR SOLUTION CODE BELOW"
    if delimiter in content:
        parts = content.split(delimiter)
        header = parts[0] + delimiter + "\n# ==============================================================================\n\n"
    else:
        header = content + "\n\n"
        
    new_content = header + solution_code + "\n"
    with open(filepath, "w", encoding="utf-8") as f:
        f.write(new_content)

def main():
    for idx in range(1, 11):
        vi_dirs = glob.glob(os.path.join(VI_PRACTICES, f"{idx:03d}-*"))
        en_dirs = glob.glob(os.path.join(EN_PRACTICES, f"{idx:03d}-*"))
        
        if not vi_dirs or not en_dirs:
            continue
            
        vi_dir = vi_dirs[0]
        en_dir = en_dirs[0]
        
        folder_name = os.path.basename(vi_dir)
        slug = folder_name[4:]
        
        vi_tcl = os.path.join(vi_dir, f"{slug}.tcl")
        en_tcl = os.path.join(en_dir, f"{slug}.tcl")
        
        code = SOLUTIONS.get(idx, "")
        if code:
            update_file(vi_tcl, code)
            update_file(en_tcl, code)
            
        # Commit these 2 files
        rel_vi_tcl = os.path.relpath(vi_tcl, BASE_DIR)
        rel_en_tcl = os.path.relpath(en_tcl, BASE_DIR)
        
        commit_msg = f"Feat(practices): Complete solution for {folder_name} (vi & en)"
        print(f"Committing {folder_name}...")
        subprocess.run(["git", "add", rel_vi_tcl, rel_en_tcl], cwd=BASE_DIR, check=True)
        subprocess.run(["git", "commit", "-m", commit_msg], cwd=BASE_DIR, check=True)

if __name__ == "__main__":
    main()
