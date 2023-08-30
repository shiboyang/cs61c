cmake_minimum_required(VERSION 3.10)

set(CMAKE_C_COMPILER gcc)
set(CMAKE_C_FLAGS "-g -Wall -std=c99 -fopenmp -mavx -mfma -pthread")


project(numc VERSION 1.0)


find_library(CUNIT_LIB cunit PATHS ~/CUnitHome/lib)
find_library(PYTHON_LIB python3.6m PATHS ~/miniconda3/envs/numcpy36/lib)


include_directories(
        ~/CUnitHome/include
        /usr/include/python3.10
)

link_directories(~/CUnitHome/lib)


add_executable(test
        mat_test.c
        matrix.c
        )

target_link_libraries(test PRIVATE
        ${CUNIT_LIB}
        ${PYTHON_LIB}
        -fopenmp
        )