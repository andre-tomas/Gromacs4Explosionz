#!/bin/csh -f

### Can be removed if the path is unchanged
shopt -s extglob
rm -v !("install.sh")
###


cmake ../ -DCMAKE_INSTALL_PREFIX=/home/tomas/programs/gromacs-4.5.4-explosion
make -j8
make install