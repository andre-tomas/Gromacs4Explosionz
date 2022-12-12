#!/bin/csh -f

cmake ../ -DCMAKE_INSTALL_PREFIX=/home/ibrahim/programs/gromacs-4.5.4-explosion
make -j8
make install
