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
include src/tools/CMakeFiles/g_tcaf.dir/depend.make

# Include the progress variables for this target.
include src/tools/CMakeFiles/g_tcaf.dir/progress.make

# Include the compile flags for this target's objects.
include src/tools/CMakeFiles/g_tcaf.dir/flags.make

src/tools/CMakeFiles/g_tcaf.dir/g_tcaf.c.o: src/tools/CMakeFiles/g_tcaf.dir/flags.make
src/tools/CMakeFiles/g_tcaf.dir/g_tcaf.c.o: ../src/tools/g_tcaf.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object src/tools/CMakeFiles/g_tcaf.dir/g_tcaf.c.o"
	cd /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/tools && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/g_tcaf.dir/g_tcaf.c.o   -c /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/src/tools/g_tcaf.c

src/tools/CMakeFiles/g_tcaf.dir/g_tcaf.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/g_tcaf.dir/g_tcaf.c.i"
	cd /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/tools && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/src/tools/g_tcaf.c > CMakeFiles/g_tcaf.dir/g_tcaf.c.i

src/tools/CMakeFiles/g_tcaf.dir/g_tcaf.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/g_tcaf.dir/g_tcaf.c.s"
	cd /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/tools && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/src/tools/g_tcaf.c -o CMakeFiles/g_tcaf.dir/g_tcaf.c.s

src/tools/CMakeFiles/g_tcaf.dir/g_tcaf.c.o.requires:

.PHONY : src/tools/CMakeFiles/g_tcaf.dir/g_tcaf.c.o.requires

src/tools/CMakeFiles/g_tcaf.dir/g_tcaf.c.o.provides: src/tools/CMakeFiles/g_tcaf.dir/g_tcaf.c.o.requires
	$(MAKE) -f src/tools/CMakeFiles/g_tcaf.dir/build.make src/tools/CMakeFiles/g_tcaf.dir/g_tcaf.c.o.provides.build
.PHONY : src/tools/CMakeFiles/g_tcaf.dir/g_tcaf.c.o.provides

src/tools/CMakeFiles/g_tcaf.dir/g_tcaf.c.o.provides.build: src/tools/CMakeFiles/g_tcaf.dir/g_tcaf.c.o


# Object files for target g_tcaf
g_tcaf_OBJECTS = \
"CMakeFiles/g_tcaf.dir/g_tcaf.c.o"

# External object files for target g_tcaf
g_tcaf_EXTERNAL_OBJECTS =

src/tools/g_tcaf: src/tools/CMakeFiles/g_tcaf.dir/g_tcaf.c.o
src/tools/g_tcaf: src/tools/CMakeFiles/g_tcaf.dir/build.make
src/tools/g_tcaf: src/tools/libgmxana.so.6
src/tools/g_tcaf: src/mdlib/libmd.so.6
src/tools/g_tcaf: /usr/lib64/libfftw3f.so
src/tools/g_tcaf: src/gmxlib/libgmx.so.6
src/tools/g_tcaf: src/tools/CMakeFiles/g_tcaf.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable g_tcaf"
	cd /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/tools && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/g_tcaf.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/tools/CMakeFiles/g_tcaf.dir/build: src/tools/g_tcaf

.PHONY : src/tools/CMakeFiles/g_tcaf.dir/build

src/tools/CMakeFiles/g_tcaf.dir/requires: src/tools/CMakeFiles/g_tcaf.dir/g_tcaf.c.o.requires

.PHONY : src/tools/CMakeFiles/g_tcaf.dir/requires

src/tools/CMakeFiles/g_tcaf.dir/clean:
	cd /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/tools && $(CMAKE_COMMAND) -P CMakeFiles/g_tcaf.dir/cmake_clean.cmake
.PHONY : src/tools/CMakeFiles/g_tcaf.dir/clean

src/tools/CMakeFiles/g_tcaf.dir/depend:
	cd /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/src/tools /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/tools /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build/src/tools/CMakeFiles/g_tcaf.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/tools/CMakeFiles/g_tcaf.dir/depend

