# Exercise 03: Quoting Rules ("", {}, []) and Special Characters in EDA
# 1. Declare variable 'module_name' with value "core_dft" and 'net_name' with value "scan_enable".
# 2. Create a variable 'path_double_quotes' using double quotes "" to store: "Path for core_dft is /top/core_dft/scan_enable" (substituting variables automatically).
# 3. Create a variable 'path_braces' using braces {} to store: "Path for $module_name is /top/$module_name/$net_name" (keeping literal $ characters, no substitution).
# 4. In EDA designs, bus names contain index brackets: `data_in[7]`. Suppose we want to access pin `core_dft/data_in[7]`.
#    Assign the string `core_dft/data_in[7]` to variables 'bus_pin_1' and 'bus_pin_2' in 2 ways:
#      a. Method 1: Using curly braces `{}` (Safe & recommended).
#      b. Method 2: Using double quotes `""` but with backslash escapes `\` so Tcl doesn't evaluate `[7]` as command substitution.
# 5. Print all variables to verify the differences.
# Bonus: Add a brief comment explaining why using backslash escape `\` or braces `{}` is critical when working with bus index brackets (e.g., `reg[15]`) in an EDA Tcl environment.
# Write your code here:

# 1. Declare variable 'module_name' with value "core_dft" and 'net_name' with value "scan_enable".
set module_name "core_dft"
set net_name "scan_enable"

# 2. Create a variable 'path_double_quotes' using double quotes "" to store: "Path for core_dft is /top/core_dft/scan_enable".
set path_double_quotes "Path for $module_name is /top/$module_name/$net_name"

# 3. Create a variable 'path_braces' using braces {} to store: "Path for $module_name is /top/$module_name/$net_name".
set path_braces {Path for $module_name is /top/$module_name/$net_name}

# 4. Assign the string `core_dft/data_in[7]` to variables 'bus_pin_1' and 'bus_pin_2' in 2 ways:
# Method 1: Using curly braces {}
set bus_pin_1 {core_dft/data_in[7]}

# Method 2: Using double quotes "" but escape the brackets using the \ character.
set bus_pin_2 "core_dft/data_in\[7\]"

# 5. Print all variables to verify the differences.
puts "Double quotes: $path_double_quotes"
puts "Braces       : $path_braces"
puts "Bus pin (1)  : $bus_pin_1"
puts "Bus pin (2)  : $bus_pin_2"

# Bonus: Add a brief comment explaining why using backslash escape \ or braces {} is critical when working with bus index brackets (e.g., reg[15]) in an EDA Tcl environment.
# Square brackets [] in Tcl trigger Command Substitution.
# If we wrote "core_dft/data_in[7]" without backslash escapes or braces,
# Tcl would try to execute a command named "7" and insert its return value.
# Since no command named "7" exists, the interpreter would throw an "invalid command name '7'" error.
# Therefore, wrapping bus indices in braces or using escape sequences is critical in EDA Tcl.
