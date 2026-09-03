!/usr/bin/env bash

set -e

module load PrgEnv-gnu

mkdir build-gnu
cd build-gnu

cat >> initial.cmake << EOF
# GNU Compilers
set(CMAKE_Fortran_COMPILER ftn CACHE STRING "")
set(CMAKE_Fortran_FLAGS "-O2 -fallow-argument-mismatch -ffree-line-length-none" CACHE STRING "")
set(Fortran_MIN_FLAGS "-O0 -ffree-line-length-none" CACHE STRING "")
set(CMAKE_C_COMPILER cc CACHE STRING "")
set(CMAKE_C_FLAGS "-O2" CACHE STRING "")
set(CMAKE_CXX_COMPILER c++ CACHE STRING "")
set(CMAKE_CXX_FLAGS "-O2" CACHE STRING "")
set(USE_MPI ON CACHE BOOL "" FORCE)
set(USE_SCALAPACK ON CACHE BOOL "" FORCE)
set(USE_LIBXC ON CACHE BOOL "" FORCE)
set(USE_HDF5 OFF CACHE BOOL "" FORCE)
set(USE_RLSY ON CACHE BOOL "" FORCE)
EOF

cmake -C initial.cmake ..
make -j 8


