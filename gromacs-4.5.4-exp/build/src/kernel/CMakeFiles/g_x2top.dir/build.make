# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/build

# Include any dependencies generated for this target.
include src/kernel/CMakeFiles/g_x2top.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include src/kernel/CMakeFiles/g_x2top.dir/compiler_depend.make

# Include the progress variables for this target.
include src/kernel/CMakeFiles/g_x2top.dir/progress.make

# Include the compile flags for this target's objects.
include src/kernel/CMakeFiles/g_x2top.dir/flags.make

src/kernel/CMakeFiles/g_x2top.dir/g_x2top.c.o: src/kernel/CMakeFiles/g_x2top.dir/flags.make
src/kernel/CMakeFiles/g_x2top.dir/g_x2top.c.o: ../src/kernel/g_x2top.c
src/kernel/CMakeFiles/g_x2top.dir/g_x2top.c.o: src/kernel/CMakeFiles/g_x2top.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object src/kernel/CMakeFiles/g_x2top.dir/g_x2top.c.o"
	cd /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/build/src/kernel && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT src/kernel/CMakeFiles/g_x2top.dir/g_x2top.c.o -MF CMakeFiles/g_x2top.dir/g_x2top.c.o.d -o CMakeFiles/g_x2top.dir/g_x2top.c.o -c /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/src/kernel/g_x2top.c

src/kernel/CMakeFiles/g_x2top.dir/g_x2top.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/g_x2top.dir/g_x2top.c.i"
	cd /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/build/src/kernel && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/src/kernel/g_x2top.c > CMakeFiles/g_x2top.dir/g_x2top.c.i

src/kernel/CMakeFiles/g_x2top.dir/g_x2top.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/g_x2top.dir/g_x2top.c.s"
	cd /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/build/src/kernel && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/src/kernel/g_x2top.c -o CMakeFiles/g_x2top.dir/g_x2top.c.s

# Object files for target g_x2top
g_x2top_OBJECTS = \
"CMakeFiles/g_x2top.dir/g_x2top.c.o"

# External object files for target g_x2top
g_x2top_EXTERNAL_OBJECTS =

src/kernel/g_x2top: src/kernel/CMakeFiles/g_x2top.dir/g_x2top.c.o
src/kernel/g_x2top: src/kernel/CMakeFiles/g_x2top.dir/build.make
src/kernel/g_x2top: src/kernel/libgmxpreprocess.so.6
src/kernel/g_x2top: src/mdlib/libmd.so.6
src/kernel/g_x2top: src/gmxlib/libgmx.so.6
src/kernel/g_x2top: /usr/lib/x86_64-linux-gnu/libfftw3f.so
src/kernel/g_x2top: src/kernel/CMakeFiles/g_x2top.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable g_x2top"
	cd /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/build/src/kernel && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/g_x2top.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/kernel/CMakeFiles/g_x2top.dir/build: src/kernel/g_x2top
.PHONY : src/kernel/CMakeFiles/g_x2top.dir/build

src/kernel/CMakeFiles/g_x2top.dir/clean:
	cd /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/build/src/kernel && $(CMAKE_COMMAND) -P CMakeFiles/g_x2top.dir/cmake_clean.cmake
.PHONY : src/kernel/CMakeFiles/g_x2top.dir/clean

src/kernel/CMakeFiles/g_x2top.dir/depend:
	cd /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/src/kernel /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/build /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/build/src/kernel /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/build/src/kernel/CMakeFiles/g_x2top.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/kernel/CMakeFiles/g_x2top.dir/depend

