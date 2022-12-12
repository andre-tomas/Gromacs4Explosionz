# CMake generated Testfile for 
# Source directory: /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp
# Build directory: /home/ibrahim/projects/hybrid-plasma-md-code/Gromacs4Explosionz/gromacs-4.5.4-exp/build
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(TestBuildAll "make")
subdirs("share")
subdirs("include")
subdirs("man")
subdirs("src")
subdirs("scripts")
subdirs("tests")
