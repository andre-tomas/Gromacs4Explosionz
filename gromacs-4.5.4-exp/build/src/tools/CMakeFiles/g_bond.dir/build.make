# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.9

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /davinci/Cellar/cmake/3.9.4/cmake-3.9.4-Linux-x86_64/bin/cmake

# The command to remove a file.
RM = /davinci/Cellar/cmake/3.9.4/cmake-3.9.4-Linux-x86_64/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build

# Include any dependencies generated for this target.
include src/tools/CMakeFiles/g_bond.dir/depend.make

# Include the progress variables for this target.
include src/tools/CMakeFiles/g_bond.dir/progress.make

# Include the compile flags for this target's objects.
include src/tools/CMakeFiles/g_bond.dir/flags.make

src/tools/CMakeFiles/g_bond.dir/g_bond.c.o: src/tools/CMakeFiles/g_bond.dir/flags.make
src/tools/CMakeFiles/g_bond.dir/g_bond.c.o: ../src/tools/g_bond.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object src/tools/CMakeFiles/g_bond.dir/g_bond.c.o"
	cd /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/tools && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/g_bond.dir/g_bond.c.o   -c /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/src/tools/g_bond.c

src/tools/CMakeFiles/g_bond.dir/g_bond.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/g_bond.dir/g_bond.c.i"
	cd /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/tools && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/src/tools/g_bond.c > CMakeFiles/g_bond.dir/g_bond.c.i

src/tools/CMakeFiles/g_bond.dir/g_bond.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/g_bond.dir/g_bond.c.s"
	cd /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/tools && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/src/tools/g_bond.c -o CMakeFiles/g_bond.dir/g_bond.c.s

src/tools/CMakeFiles/g_bond.dir/g_bond.c.o.requires:

.PHONY : src/tools/CMakeFiles/g_bond.dir/g_bond.c.o.requires

src/tools/CMakeFiles/g_bond.dir/g_bond.c.o.provides: src/tools/CMakeFiles/g_bond.dir/g_bond.c.o.requires
	$(MAKE) -f src/tools/CMakeFiles/g_bond.dir/build.make src/tools/CMakeFiles/g_bond.dir/g_bond.c.o.provides.build
.PHONY : src/tools/CMakeFiles/g_bond.dir/g_bond.c.o.provides

src/tools/CMakeFiles/g_bond.dir/g_bond.c.o.provides.build: src/tools/CMakeFiles/g_bond.dir/g_bond.c.o


# Object files for target g_bond
g_bond_OBJECTS = \
"CMakeFiles/g_bond.dir/g_bond.c.o"

# External object files for target g_bond
g_bond_EXTERNAL_OBJECTS =

src/tools/g_bond: src/tools/CMakeFiles/g_bond.dir/g_bond.c.o
src/tools/g_bond: src/tools/CMakeFiles/g_bond.dir/build.make
src/tools/g_bond: src/tools/libgmxana.so.6
src/tools/g_bond: src/mdlib/libmd.so.6
src/tools/g_bond: /usr/lib64/libfftw3f.so
src/tools/g_bond: src/gmxlib/libgmx.so.6
src/tools/g_bond: src/tools/CMakeFiles/g_bond.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable g_bond"
	cd /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/tools && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/g_bond.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/tools/CMakeFiles/g_bond.dir/build: src/tools/g_bond

.PHONY : src/tools/CMakeFiles/g_bond.dir/build

src/tools/CMakeFiles/g_bond.dir/requires: src/tools/CMakeFiles/g_bond.dir/g_bond.c.o.requires

.PHONY : src/tools/CMakeFiles/g_bond.dir/requires

src/tools/CMakeFiles/g_bond.dir/clean:
	cd /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/tools && $(CMAKE_COMMAND) -P CMakeFiles/g_bond.dir/cmake_clean.cmake
.PHONY : src/tools/CMakeFiles/g_bond.dir/clean

src/tools/CMakeFiles/g_bond.dir/depend:
	cd /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/src/tools /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/tools /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/tools/CMakeFiles/g_bond.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/tools/CMakeFiles/g_bond.dir/depend

