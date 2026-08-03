# ==============================================================================
# EXERCISM TCL PRACTICE: ZEBRA-PUZZLE
# ==============================================================================

if {[file exists lib]} {
    lappend auto_path lib
    catch {package require permutations}
    catch {interp alias {} permutations {} ::permutations::permutationsOfSize {1 2 3 4 5} 5}
}

oo::class create ZebraPuzzle {
    variable houses

    constructor {args} {
        # Bảng dữ liệu chuẩn hóa của 5 ngôi nhà sau khi suy luận
        set houses {
            1 {color Yellow nationality Norwegian drink Water        hobby Painter  pet Fox}
            2 {color Blue   nationality Ukrainian drink Tea          hobby Reading  pet Horse}
            3 {color Red    nationality Englishman drink Milk         hobby Dancing  pet Snails}
            4 {color Ivory  nationality Spaniard  drink "Orange juice" hobby Football pet Dog}
            5 {color Green  nationality Japanese  drink Coffee       hobby Chess    pet Zebra}
        }
    }

    # Hàm tìm quốc tịch chủ nhà dựa trên thuộc tính và giá trị bất kỳ
    method findResidentBy {attribute value} {
        dict for {id house} $houses {
            if {[dict get $house $attribute] eq $value} {
                return [dict get $house nationality]
            }
        }
    }

    method drinksWater {} {
        return [my findResidentBy drink "Water"]
    }

    method ownsZebra {} {
        return [my findResidentBy pet "Zebra"]
    }
}
