# ==============================================================================
# EXERCISM TCL PRACTICE: DARTS
# ==============================================================================
# # Instructions
#
# Calculate the points scored in a single toss of a Darts game.
#
# [Darts][darts] is a game where players throw darts at a [target][darts-target].
#
# In our particular instance of the game, the target rewards 4 different amounts of points, depending on where the dart lands:
#
# ![Our dart scoreboard with values from a complete miss to a bullseye](https://assets.exercism.org/images/exercises/darts/darts-scoreboard.svg)
#
# - If the dart lands outside the target, player earns no points (0 points).
# - If the dart lands in the outer circle of the target, player earns 1 point.
# - If the dart lands in the middle circle of the target, player earns 5 points.
# - If the dart lands in the inner circle of the target, player earns 10 points.
#
# The outer circle has a radius of 10 units (this is equivalent to the total radius for the entire target), the middle circle a radius of 5 units, and the inner circle a radius of 1.
# Of course, they are all centered at the same point — that is, the circles are [concentric][] defined by the coordinates (0, 0).
#
# Given a point in the target (defined by its [Cartesian coordinates][cartesian-coordinates] `x` and `y`, where `x` and `y` are [real][real-numbers]), calculate the correct score earned by a dart landing at that point.
#
# ## Credit
#
# The scoreboard image was created by [habere-et-dispertire][habere-et-dispertire] using [Inkscape][inkscape].
#
# [darts]: https://en.wikipedia.org/wiki/Darts
# [darts-target]: https://en.wikipedia.org/wiki/Darts#/media/File:Darts_in_a_dartboard.jpg
# [concentric]: https://mathworld.wolfram.com/ConcentricCircles.html
# [cartesian-coordinates]: https://www.mathsisfun.com/data/cartesian-coordinates.html
# [real-numbers]: https://www.mathsisfun.com/numbers/real-numbers.html
# [habere-et-dispertire]: https://exercism.org/profiles/habere-et-dispertire
# [inkscape]: https://en.wikipedia.org/wiki/Inkscape

# ==============================================================================
# KỸ THUẬT & LƯU Ý BÀI TOÁN (ALGORITHM & GEOMETRY NOTES)
# ==============================================================================
# 1. BÃI BẪY HÌNH TRÒN VS HÌNH VUÔNG:
#    - Bia phi tiêu là HÌNH TRÒN có bán kính r = 10, 5, 1.
#    - KHÔNG ĐƯỢC dùng điều kiện kiểu hình vuông: `x >= 5 && y >= 5 && x <= 10 && y <= 10`
#      vì sẽ tính sai các điểm nằm ở góc (ví dụ (8,8) r = 11.31 văng ra ngoài bia nhưng vẫn lọt hình vuông).
#
# 2. CÔNG THỨC KHOẢNG CÁCH TRONG TCL:
#    - Khoảng cách từ (x,y) tới tâm (0,0): r = sqrt(x^2 + y^2).
#    - Trong Tcl, dùng hàm toán học `hypot($x, $y)` sẵn có trong `expr`:
#      `set r [expr {hypot($x, $y)}]`
#
# 3. LƯU Ý CÚ PHÁP TCL:
#    - Tọa độ âm (x < 0, y < 0) hoàn toàn HOÀN HẢO và HỢP LỆ (nằm ở các góc phần tư 2, 3, 4).
#    - Bắt buộc dùng `elseif` hoặc `} else {` trên CÙNG 1 DÒNG.
# ==============================================================================

proc score {x y} {
    # 1. Tính khoảng cách bán kính r từ (x,y) tới tâm (0,0)
    set r [expr {hypot($x, $y)}]

    # 2. Xử lý điểm dựa trên bán kính r
    if {$r > 10} {
        return 0
    } elseif {$r > 5} {
        return 1
    } elseif {$r > 1} {
        return 5
    } else {
        return 10
    }
}




proc score {x y} {
    set dist [expr {hypot($x, $y)}]
    if {$dist <= 1.0} {
        return 10
    } elseif {$dist <= 5.0} {
        return 5
    } elseif {$dist <= 10.0} {
        return 1
    } else {
        return 0
    }
}
