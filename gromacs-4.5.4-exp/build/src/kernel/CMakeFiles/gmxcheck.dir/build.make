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
include src/kernel/CMakeFiles/gmxcheck.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include src/kernel/CMakeFiles/gmxcheck.dir/compiler_depend.make

# Include the progress variables for this target.
include src/kernel/CMakeFiles/gmxcheck.dir/progress.make

# Include the compile flags for this target's objects.
include src/kernel/CMakeFiles/gmxcheck.dir/flags.make

src/kernel/CMakeFiles/gmxcheck.dir/gmxcheck.c.o: src/kernel/CMakeFiles/gmxcheck.dir/flags.make
src/kernel/CMakeFiles/gmxcheck.dir/gmxcheck.c.o: ../src/kernel/gmxcheck.c
src/kernel/CMakeFiles/gmxcheck.dir/gmxcheck.c.o: src/kernel/CMakeFiles/gmxcheck.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object src/kernel/CMakeFiles/gmxcheck.dir/gmxcheck.c.o"
	cd /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/build/src/kernel && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT src/kernel/CMakeFiles/gmxcheck.dir/gmxcheck.c.o -MF CMakeFiles/gmxcheck.dir/gmxcheck.c.o.d -o CMakeFiles/gmxcheck.dir/gmxcheck.c.o -c /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/src/kernel/gmxcheck.c

src/kernel/CMakeFiles/gmxcheck.dir/gmxcheck.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/gmxcheck.dir/gmxcheck.c.i"
	cd /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/build/src/kernel && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/src/kernel/gmxcheck.c > CMakeFiles/gmxcheck.dir/gmxcheck.c.i

src/kernel/CMakeFiles/gmxcheck.dir/gmxcheck.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/gmxcheck.dir/gmxcheck.c.s"
	cd /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/build/src/kernel && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/src/kernel/gmxcheck.c -o CMakeFiles/gmxcheck.dir/gmxcheck.c.s

# Object files for target gmxcheck
gmxcheck_OBJECTS = \
"CMakeFiles/gmxcheck.dir/gmxcheck.c.o"

# External object files for target gmxcheck
gmxcheck_EXTERNAL_OBJECTS =

src/kernel/gmxcheck: src/kernel/CMakeFiles/gmxcheck.dir/gmxcheck.c.o
src/kernel/gmxcheck: src/kernel/CMakeFiles/gmxcheck.dir/build.make
src/kernel/gmxcheck: src/kernel/libgmxpreprocess.so.6
src/kernel/gmxcheck: src/mdlib/libmd.so.6
src/kernel/gmxcheck: src/gmxlib/libgmx.so.6
src/kernel/gmxcheck: /usr/lib/x86_64-linux-gnu/libfftw3f.so
src/kernel/gmxcheck: src/kernel/CMakeFiles/gmxcheck.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable gmxcheck"
	cd /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/build/src/kernel && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/gmxcheck.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/kernel/CMakeFiles/gmxcheck.dir/build: src/kernel/gmxcheck
.PHONY : src/kernel/CMakeFiles/gmxcheck.dir/build

src/kernel/CMakeFiles/gmxcheck.dir/clean:
	cd /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/build/src/kernel && $(CMAKE_COMMAND) -P CMakeFiles/gmxcheck.dir/cmake_clean.cmake
.PHONY : src/kernel/CMakeFiles/gmxcheck.dir/clean

src/kernel/CMakeFiles/gmxcheck.dir/depend:
	cd /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/src/kernel /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/build /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/build/src/kernel /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/build/src/kernel/CMakeFiles/gmxcheck.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/kernel/CMakeFiles/gmxcheck.dir/depend

