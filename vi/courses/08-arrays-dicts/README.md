<Chương 08: Arrays & Dictionaries (Mảng và Từ điển)>
Mảng và Từ điển cung cấp các cách để ánh xạ khóa (key) với giá trị (value), rất cần thiết để quản lý các tập hợp thuộc tính có tên trong script.

---

## Mục lục
- [Mảng (Arrays)](#mảng-arrays)
- [Từ điển (Dictionaries)](#từ-điển-dictionaries)
- [So sánh Mảng và Từ điển](#so-sánh-mảng-và-từ-điển)

---

## Mảng (Arrays)

### Giải thích
Mảng trong Tcl là bảng băm (hash tables). Chúng là tập hợp các biến, không phải là giá trị hạng nhất (first-class values). Bạn không thể truyền trực tiếp một mảng vào thủ tục theo giá trị (bạn phải truyền tên và dùng `upvar`). Mảng cực kỳ hiệu quả cho dữ liệu lớn ánh xạ khóa chuỗi sang giá trị.

### Cú pháp
```tcl
set arr(key) value
array set arr {k1 v1 k2 v2}
$arr(key)
array names arr
array size arr
```

### Ví dụ
```tcl
# Setting array elements
set cell_counts(NAND2) 150
set cell_counts(NOR2) 80

# Bulk setting
array set cell_counts {
    INV 300
    DFF 50
}

# Reading
puts "NAND2 count: $cell_counts(NAND2)"
puts "Total cell types: [array size cell_counts]"

# Multi-dimensional simulation
set grid(0,0) "origin"
set grid(1,2) "node_A"
puts "Grid at 1,2: $grid(1,2)"

# Iteration
foreach cell [array names cell_counts] {
    puts "Cell: $cell, Count: $cell_counts($cell)"
}

# Debugging
parray cell_counts
```

### Kết quả
```
NAND2 count: 150
Total cell types: 4
Grid at 1,2: node_A
Cell: DFF, Count: 50
Cell: INV, Count: 300
Cell: NAND2, Count: 150
Cell: NOR2, Count: 80
cell_counts(DFF)   = 50
cell_counts(INV)   = 300
cell_counts(NAND2) = 150
cell_counts(NOR2)  = 80
```

---

## Từ điển (Dictionaries)

### Giải thích
Từ điển (`dict`), được giới thiệu trong Tcl 8.5, là giá trị hạng nhất (giống list và string). Chúng có thể được truyền vào hàm, trả về và lồng nhau tự nhiên. Chúng giữ nguyên thứ tự chèn (khác với mảng).

### Cú pháp
```tcl
dict create key1 val1 key2 val2
dict set dictVar key value
dict get dictVal key
dict keys dictVal
dict for {k v} dictVal {body}
```

### Ví dụ
```tcl
# Creating
set timing [dict create setup 0.5 hold 0.2]

# Modifying
dict set timing transition 0.1

# Nested dictionaries
dict set cells NAND2 area 2.4
dict set cells NAND2 leakage 0.05
dict set cells INV area 1.2
dict set cells INV leakage 0.02

# Accessing nested dict
set nand_area [dict get $cells NAND2 area]
puts "NAND2 area: $nand_area"

# Iterating
dict for {cell attrs} $cells {
    puts "Cell: $cell, Area: [dict get $attrs area]"
}

# In-place operations
set stats [dict create total 10]
dict incr stats total 5
puts "Stats: $stats"
```

### Kết quả
```
NAND2 area: 2.4
Cell: NAND2, Area: 2.4
Cell: INV, Area: 1.2
Stats: total 15
```

---

## So sánh Mảng và Từ điển

| Tính năng | Mảng (Arrays) | Từ điển (Dictionaries) |
| :--- | :--- | :--- |
| **Kiểu dữ liệu** | Tập hợp biến | Giá trị hạng nhất (chuỗi) |
| **Truyền vào hàm**| Qua tên (`upvar`) | Qua giá trị |
| **Thứ tự** | Không thứ tự (băm) | Giữ thứ tự chèn |
| **Lồng nhau** | Khó (dùng dấu phẩy giả lồng) | Hỗ trợ bản địa (native) |
| **Hiệu suất** | Nhanh với số phần tử cực lớn | Nhanh, nhưng copy-on-write khi truyền |

---

## Bài tập thực hành
- `01_arrays_dicts.tcl`: Bài tập EDA quản lý thư viện cell với mảng cho số lượng và từ điển cho tóm tắt timing lồng nhau.

---

## Tóm tắt
- Dùng **mảng** cho tra cứu toàn cục/cục bộ lớn, phẳng, nơi cần sửa từng phần tử thường xuyên.
- Dùng **từ điển** khi cần truyền cấu trúc giữa các hàm, duy trì thứ tự, hoặc tạo cấu trúc dữ liệu lồng nhau phức tạp.
</Chương 08: Arrays & Dictionaries (Mảng và Từ điển)>
