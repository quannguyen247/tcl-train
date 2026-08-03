# ==============================================================================
# CHAPTER 01: BASIC SYNTAX
# LESSON 04: ADVANCED STRING MANIPULATION
# ==============================================================================
# In Tcl, the core philosophy is "Everything Is A String".
# Mastering the 'string' command suite is mandatory for every Tcl developer.
# Run this script using: tclsh 04_string_manipulation.tcl
# ==============================================================================

puts "=== TCL STRING MANIPULATION TUTORIAL ==="

set text "  Hello, Tcl Programming World!  "

# 1. STRING LENGTH
# ------------------------------------------------------------------------------
set len [string length $text]
puts "\n1. Measuring String Length:"
puts "   String: '$text'"
puts "   Length: $len characters"

# 2. STRING INDEXING AND SLICING (STRING INDEX & STRING RANGE)
# ------------------------------------------------------------------------------
set str "Microchip"

# Extract character at specific index (0-indexed)
set first_char [string index $str 0]
set last_char  [string index $str end]

# Extract substring from Start to End index
set sub_str [string range $str 0 4]          ;# Extract index 0 to 4
set end_str [string range $str end-4 end]    ;# Extract last 5 characters

puts "\n2. String Indexing & Range Slicing:"
puts "   Original Word: $str"
puts "   First Char (index 0): $first_char"
puts "   Last Char (index end): $last_char"
puts "   Slice 0 to 4 (string range 0 4): $sub_str"
puts "   Last 5 chars (string range end-4 end): $end_str"

# 3. DICTIONARY MAPPING REPLACEMENT (STRING MAP) - EXTREMELY IMPORTANT
# ------------------------------------------------------------------------------
# 'string map' replaces substrings based on a {old new} key-value dictionary
set dna "ACGTACGT"
set rna [string map {G C C G T A A U} $dna]

puts "\n3. String Mapping Replacement via 'string map':"
puts "   Original DNA Strand: $dna"
puts "   Transcribed RNA Strand (G->C, C->G, T->A, A->U): $rna"

# 4. GLOB PATTERN MATCHING (STRING MATCH)
# ------------------------------------------------------------------------------
# Check if a string matches a glob pattern (Returns 1 if true, 0 if false)
set filename "top_module_v1.v"

if {[string match "*.v" $filename]} {
    puts "\n4. Glob Pattern Matching 'string match':"
    puts "   File '$filename' is a valid Verilog source file (*.v)!"
}

# 5. CASE CONVERSION (STRING TOUPPER / TOLOWER)
# ------------------------------------------------------------------------------
set raw_code "vhdl_design"
puts "\n5. Case Conversion:"
puts "   Uppercase: [string toupper $raw_code]"
puts "   Lowercase: [string tolower "VHDL_DESIGN"]"

# 6. TRIMMING WHITESPACE AND CHARACTERS (STRING TRIM)
# ------------------------------------------------------------------------------
set dirty_str "---Vivado 2026---"
set clean_str [string trim $dirty_str "-"]

puts "\n6. Trimming Whitespace and Delimiters 'string trim':"
puts "   Original String: '$text'"
puts "   Trimmed Whitespace: '[string trim $text]'"
puts "   Trimmed '-' characters: '$clean_str'"

# 7. SPLITTING STRINGS INTO LISTS (SPLIT COMMAND)
# ------------------------------------------------------------------------------
# 'split' parses a string into a list using a delimiter string:
set isbn_raw "3-598-21508-8"

set chars [split $isbn_raw ""]       ;# Split into individual characters (empty delimiter "")
set parts [split $isbn_raw "-"]      ;# Split by hyphen delimiter '-'

puts "\n7. Splitting Strings with 'split':"
puts "   Original ISBN: $isbn_raw"
puts "   Characters (split \"\"): $chars"
puts "   Hyphen Delimited (split \"-\"): $parts"

# 8. STRING CLEANING & PREPROCESSING (DATA CLEANING)
# ------------------------------------------------------------------------------
# In practice, 'clean' is commonly used to store sanitized strings:
set raw_isbn "3-598-21507-X"
set clean [string map {- ""} $raw_isbn]   ;# Strip all hyphens '-'

puts "\n8. String Cleaning & Preprocessing:"
puts "   Raw Input (raw_isbn): $raw_isbn"
puts "   Sanitized String (clean): $clean"

puts "\n=== COMPLETED STRING MANIPULATION LESSON ==="

