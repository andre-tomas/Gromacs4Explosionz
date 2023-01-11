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
CMAKE_SOURCE_DIR = /home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build

# Include any dependencies generated for this target.
include src/tools/CMakeFiles/g_anaeig.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include src/tools/CMakeFiles/g_anaeig.dir/compiler_depend.make

# Include the progress variables for this target.
include src/tools/CMakeFiles/g_anaeig.dir/progress.make

# Include the compile flags for this target's objects.
include src/tools/CMakeFiles/g_anaeig.dir/flags.make

src/tools/CMakeFiles/g_anaeig.dir/g_anaeig.c.o: src/tools/CMakeFiles/g_anaeig.dir/flags.make
src/tools/CMakeFiles/g_anaeig.dir/g_anaeig.c.o: ../src/tools/g_anaeig.c
src/tools/CMakeFiles/g_anaeig.dir/g_anaeig.c.o: src/tools/CMakeFiles/g_anaeig.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object src/tools/CMakeFiles/g_anaeig.dir/g_anaeig.c.o"
	cd /home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/tools && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT src/tools/CMakeFiles/g_anaeig.dir/g_anaeig.c.o -MF CMakeFiles/g_anaeig.dir/g_anaeig.c.o.d -o CMakeFiles/g_anaeig.dir/g_anaeig.c.o -c /home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/src/tools/g_anaeig.c

src/tools/CMakeFiles/g_anaeig.dir/g_anaeig.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/g_anaeig.dir/g_anaeig.c.i"
	cd /home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/tools && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/src/tools/g_anaeig.c > CMakeFiles/g_anaeig.dir/g_anaeig.c.i

src/tools/CMakeFiles/g_anaeig.dir/g_anaeig.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/g_anaeig.dir/g_anaeig.c.s"
	cd /home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/tools && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/src/tools/g_anaeig.c -o CMakeFiles/g_anaeig.dir/g_anaeig.c.s

# Object files for target g_anaeig
g_anaeig_OBJECTS = \
"CMakeFiles/g_anaeig.dir/g_anaeig.c.o"

# External object files for target g_anaeig
g_anaeig_EXTERNAL_OBJECTS =

src/tools/g_anaeig: src/tools/CMakeFiles/g_anaeig.dir/g_anaeig.c.o
src/tools/g_anaeig: src/tools/CMakeFiles/g_anaeig.dir/build.make
src/tools/g_anaeig: src/tools/libgmxana.so.6
src/tools/g_anaeig: src/mdlib/libmd.so.6
src/tools/g_anaeig: /usr/lib/x86_64-linux-gnu/libfftw3f.so
src/tools/g_anaeig: src/gmxlib/libgmx.so.6
src/tools/g_anaeig: src/tools/CMakeFiles/g_anaeig.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable g_anaeig"
	cd /home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/tools && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/g_anaeig.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/tools/CMakeFiles/g_anaeig.dir/build: src/tools/g_anaeig
.PHONY : src/tools/CMakeFiles/g_anaeig.dir/build

src/tools/CMakeFiles/g_anaeig.dir/clean:
	cd /home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/tools && $(CMAKE_COMMAND) -P CMakeFiles/g_anaeig.dir/cmake_clean.cmake
.PHONY : src/tools/CMakeFiles/g_anaeig.dir/clean

src/tools/CMakeFiles/g_anaeig.dir/depend:
	cd /home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp /home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/src/tools /home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build /home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/tools /home/tomas/programs/gromacs-4.5.4-installations/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/tools/CMakeFiles/g_anaeig.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/tools/CMakeFiles/g_anaeig.dir/depend

