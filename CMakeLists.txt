cmake_minimum_required(VERSION 3.3)
project(jiebaR)

SET( CMAKE_VERBOSE_MAKEFILE on )

set(LIBS_LIBRARY_SOURCES

    src/detect.cpp
    src/get_idf.cpp
    src/get_tuple.cpp
    src/init.c
    src/segtype-v4.cpp
    src/word_freq.cpp
    )

add_library(rlibs SHARED ${LIBS_LIBRARY_SOURCES})

set(CMAKE_SHARED_LINKER_FLAGS "-s -static-libgcc -LC:/PROGRA~1/R/R-EXPE~1/bin/x64")

include_directories(C:/PROGRA~1/R/R-EXPE~1/include)
include_directories(./inst/include)
include_directories(C:/Users/outwen/Documents/R/win-library/3.3/Rcpp/include)

link_directories(C:/Rbuild/R-devel-win64/extsoft/lib)
link_directories(C:/PROGRA~1/R/R-EXPE~1/bin/x64)
link_directories(C:/Rbuild/R-devel-win64/extsoft/lib/x64)

target_link_libraries(rlibs R)
set_property(TARGET rlibs PROPERTY CXX_STANDARD 11)


