# CMake generated Testfile for 
# Source directory: /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp
# Build directory: /home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/build
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(TestBuildAll "make")
set_tests_properties(TestBuildAll PROPERTIES  _BACKTRACE_TRIPLES "/home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/CMakeLists.txt;830;add_test;/home/tomas/programs/gromacs-4.5.4/gromacs-4.5.4-exp/CMakeLists.txt;0;")
subdirs("share")
subdirs("include")
subdirs("man")
subdirs("src")
subdirs("scripts")
subdirs("tests")
