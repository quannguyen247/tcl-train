# Vivado Tcl Lesson: 01_project_management
# -------------------------------------------------------------------------
# Description: Essential commands for project creation, loading, and management.
# -------------------------------------------------------------------------

# 1. create_project
# Creates a new Vivado project.
# -force overwrites the project if it already exists.
# -part specifies the FPGA part number.
puts "Creating project..."
# create_project -force my_project ./my_project_dir -part xc7a35tcpg236-1

# 2. current_project
# Returns the currently active project.
# set proj [current_project]
# puts "Active project: $proj"

# 3. set_property / get_property
# Used to set and get properties on the project or any other Vivado object.
# set_property target_language VHDL [current_project]
# set lang [get_property target_language [current_project]]
# puts "Target language is set to: $lang"

# 4. add_files / import_files / remove_files
# Adding source files to the project.
# add_files links the files, while import_files copies them into the project directory.
# add_files ./src/top.v
# import_files ./src/top.v
# remove_files ./src/top.v

# 5. set_part / get_parts
# Used to query available parts or change the current project's part.
# get_parts *xc7a35t* 
# set_part xc7z020clg400-1

# 6. archive_project
# Packages the entire project into a zip file for sharing or version control backup.
# archive_project ./my_project_archive.zip -force

# 7. close_project / open_project
# Closes the current project in memory, and opens an existing one.
# close_project
# open_project ./my_project_dir/my_project.xpr
