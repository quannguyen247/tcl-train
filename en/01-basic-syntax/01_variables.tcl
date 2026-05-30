# Exercise 01: Variables and Basic I/O
# 1. Declare variable 'design_name' with value "dft_top".
# 2. Declare variable 'flop_count' with value 12500 (number of flip-flops).
# 3. Declare variable 'scan_chains' with value 4 (number of scan chains).
# 4. Use 'puts' command to print design metadata in this exact format:
#   "Design: dft_top | FF Count: 12500 | Scan Chains: 4"
# 5. Delete the 'flop_count' variable from memory using the appropriate command.
# 6. Verify if the 'flop_count' variable still exists using the 'info exists' command and print the result.
# Bonus: Print the username of the current logged-in user by querying the global platform array.
# Write your code here:

# 1. Declare variable 'design_name' with value "dft_top".
set design_name "dft_top"

# 2. Declare variable 'flop_count' with value 12500 (number of flip-flops).
set flop_count 12500

# 3. Declare variable 'scan_chains' with value 4 (number of scan chains).
set scan_chains 4

# 4. Use 'puts' command to print design metadata in this exact format:
# "Design: dft_top | FF Count: 12500 | Scan Chains: 4"
puts "Design: $design_name | FF Count: $flop_count | Scan Chains: $scan_chains"

# 5. Release (delete) the 'flop_count' variable from memory using the appropriate command.
unset flop_count

# 6. Verify if the 'flop_count' variable still exists using the 'info exists' command and print the result.
puts "flop_count exists: [info exists flop_count]"

# Bonus: Print the username of the current logged-in user by querying the global platform array.
puts "Current user: $tcl_platform(user)"
