<Chương 07: Lists (Danh sách)>
Danh sách (List) trong Tcl là cấu trúc dữ liệu cơ bản để lưu trữ tập hợp các phần tử có thứ tự. Một danh sách thực chất là một chuỗi được định dạng theo cú pháp nhất định, phân tách chủ yếu bằng khoảng trắng. Mọi thứ trong Tcl đều có thể được coi là một danh sách nếu định dạng đúng.

---

## Mục lục
- [Tạo và truy cập danh sách](#tạo-và-truy-cập-danh-sách)
- [Sửa đổi danh sách](#sửa-đổi-danh-sách)
- [Trích xuất và tìm kiếm danh sách](#trích-xuất-và-tìm-kiếm-danh-sách)
- [Sắp xếp danh sách](#sắp-xếp-danh-sách)
- [Chuyển đổi danh sách và chuỗi](#chuyển-đổi-danh-sách-và-chuỗi)
- [Các kiểu lặp](#các-kiểu-lặp)

---

## Tạo và truy cập danh sách

### Giải thích
Danh sách có thể được tạo bằng lệnh `list`, tách chuỗi (split), hoặc dùng cặp ngoặc nhọn `{}`. Truy cập các phần tử được thực hiện bằng `lindex`, với chỉ số bắt đầu từ 0. Bạn cũng có thể dùng `end` hoặc `end-N` để chỉ các phần tử từ cuối lên. `llength` trả về số lượng phần tử.

### Cú pháp
```tcl
list arg1 arg2 ...
lindex list index
llength list
```

### Ví dụ
```tcl
# Creating lists
set clk_list [list clk_core clk_mem clk_sys]
set literal_list {pin_A pin_B pin_C}

# Accessing
puts "First clock: [lindex $clk_list 0]"
puts "Last clock: [lindex $clk_list end]"
puts "Second to last: [lindex $clk_list end-1]"

# Length
puts "Number of clocks: [llength $clk_list]"
```

### Kết quả
```
First clock: clk_core
Last clock: clk_sys
Second to last: clk_mem
Number of clocks: 3
```

---

## Sửa đổi danh sách

### Giải thích
Có thể sửa đổi danh sách bằng các lệnh như `lappend` (thêm vào cuối biến), `linsert` (chèn vào chỉ số cụ thể), `lreplace` (thay thế một dải), và `lset` (sửa đổi phần tử trực tiếp trên biến).

### Cú pháp
```tcl
lappend varName arg ...
linsert list index arg ...
lreplace list first last arg ...
lset varName index newValue
```

### Ví dụ
```tcl
set paths {path1 path2 path3}

# lappend modifies the variable in place
lappend paths path4 path5
puts "After lappend: $paths"

# linsert returns a new list
set paths_new [linsert $paths 1 path_inserted]
puts "After linsert: $paths_new"

# lreplace returns a new list
set paths_replaced [lreplace $paths 0 0 path1_new]
puts "After lreplace: $paths_replaced"

# lset modifies the variable in place
lset paths 2 path3_updated
puts "After lset: $paths"
```

### Kết quả
```
After lappend: path1 path2 path3 path4 path5
After linsert: path1 path_inserted path2 path3 path4 path5
After lreplace: path1_new path2 path3 path4 path5
After lset: path1 path2 path3_updated path4 path5
```

---

## Trích xuất và tìm kiếm danh sách

### Giải thích
`lrange` trích xuất một danh sách con dựa trên chỉ số bắt đầu và kết thúc. `lassign` gán các phần tử danh sách cho nhiều biến. `lsearch` tìm kiếm phần tử khớp với mẫu, hỗ trợ các kiểu khớp (`-exact`, `-glob`, `-regexp`) và tùy chọn trả về (`-all`, `-inline`).

### Cú pháp
```tcl
lrange list first last
lassign list varName ?varName ...?
lsearch ?options? list pattern
```

### Ví dụ
```tcl
set nodes {buf1 inv1 nand2 nor3 dff1 buf2}

# Extracting a range
set sub_nodes [lrange $nodes 1 3]
puts "Sub nodes: $sub_nodes"

# Assigning to variables
lassign $nodes first_node second_node
puts "First: $first_node, Second: $second_node"

# Searching
set buf_idx [lsearch -exact $nodes buf1]
puts "Index of buf1: $buf_idx"

# Search with glob, return all matching values inline
set all_bufs [lsearch -all -inline -glob $nodes buf*]
puts "All buffers: $all_bufs"
```

### Kết quả
```
Sub nodes: inv1 nand2 nor3
First: buf1, Second: inv1
Index of buf1: 0
All buffers: buf1 buf2
```

---

## Sắp xếp danh sách

### Giải thích
`lsort` sắp xếp danh sách theo tiêu chí chỉ định. Nó hỗ trợ kiểu dữ liệu (`-ascii`, `-dictionary`, `-integer`, `-real`), thứ tự (`-increasing`, `-decreasing`), và các tùy chọn giữ phần tử duy nhất (`-unique`) hoặc sắp xếp danh sách lồng (`-index`). Thậm chí bạn có thể định nghĩa lệnh so sánh tùy chỉnh (`-command`).

### Cú pháp
```tcl
lsort ?options? list
```

### Ví dụ
```tcl
set delays {2.5 1.1 3.4 1.1 5.0}

# Sort as real numbers
set sorted_delays [lsort -real $delays]
puts "Sorted delays: $sorted_delays"

# Unique and decreasing
set unique_dec_delays [lsort -real -decreasing -unique $delays]
puts "Unique decreasing: $unique_dec_delays"

# Dictionary sort (handles numbers in strings intelligently)
set nets {net10 net2 net1}
puts "ASCII sort: [lsort -ascii $nets]"
puts "Dict sort: [lsort -dictionary $nets]"
```

### Kết quả
```
Sorted delays: 1.1 1.1 2.5 3.4 5.0
Unique decreasing: 5.0 3.4 2.5 1.1
ASCII sort: net1 net10 net2
Dict sort: net1 net2 net10
```

---

## Chuyển đổi danh sách và chuỗi

### Giải thích
`split` tách một chuỗi thành danh sách dựa trên ký tự phân cách. `join` nối các phần tử danh sách thành một chuỗi duy nhất bằng dấu phân cách chỉ định. `concat` gộp nhiều danh sách thành một danh sách phẳng.

### Cú pháp
```tcl
split string ?splitChars?
join list ?joinString?
concat ?arg arg ...?
```

### Ví dụ
```tcl
# String to list
set csv_line "clk_sys,1.5,100"
set fields [split $csv_line ","]
puts "Fields list: $fields"
puts "Period: [lindex $fields 1]"

# List to string
set new_csv [join $fields "|"]
puts "Pipe separated: $new_csv"

# Concat lists
set list1 {a b}
set list2 {c d}
puts "Concatenated: [concat $list1 $list2]"
```

### Kết quả
```
Fields list: clk_sys 1.5 100
Period: 1.5
Pipe separated: clk_sys|1.5|100
Concatenated: a b c d
```

---

## Các kiểu lặp

### Giải thích
`foreach` thường dùng để lặp qua các phần tử danh sách. Nó có thể lặp qua nhiều biến và nhiều danh sách cùng lúc. Danh sách lồng nhau có thể được truy cập bằng cách cung cấp nhiều chỉ số cho `lindex`.

### Ví dụ
```tcl
set ports {in_a in_b out_y}
foreach port $ports {
    puts "Processing port: $port"
}

# Multiple variables
set pairs {A 1 B 2 C 3}
foreach {name val} $pairs {
    puts "$name = $val"
}

# Nested list access
set nested_list {{clk1 10} {clk2 20}}
puts "clk2 period: [lindex $nested_list 1 1]"
```

### Kết quả
```
Processing port: in_a
Processing port: in_b
Processing port: out_y
A = 1
B = 2
C = 3
clk2 period: 20
```

---

## Bài tập thực hành
- `01_list_operations.tcl`: Bài tập chủ đề EDA thao tác với danh sách domain xung nhịp, tên chân, và đường dẫn timing bằng các lệnh danh sách khác nhau.

---

## Tóm tắt
- Danh sách là tập hợp chuỗi có thứ tự trong Tcl.
- Dùng `lindex` và `llength` để truy cập cơ bản.
- Dùng `lappend` và `lset` để sửa trực tiếp biến; `linsert` và `lreplace` trả về danh sách mới.
- `lsearch` và `lsort` cung cấp khả năng tìm kiếm và sắp xếp mạnh mẽ.
- Chuyển đổi giữa chuỗi và danh sách bằng `split` và `join`.
</Chương 07: Lists (Danh sách)>
