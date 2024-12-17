cmake_minimum_required(VERSION 3.29)
include($ENV{PICO_SDK_PATH}/external/pico_sdk_import.cmake)

project(app)
pico_sdk_init()

add_executable(app)

# Which Pico SDK libraries are we using. This also automatically sets up header
# search paths (via target_include_directories / INTERFACE_INCLUDE_DIRECTORIES).
target_link_libraries(app
    pico_stdlib
    pico_btstack_ble
    pico_btstack_classic
    pico_btstack_cyw43
    pico_cyw43_arch_lwip_threadsafe_background
    hardware_adc
)

# Make our "config headers" (e.g. lwipopts.h) discoverable by libraries themselves.
target_include_directories(app PRIVATE "${CMAKE_CURRENT_LIST_DIR}/include")

# Uncomment to debug lwIP.
target_compile_definitions(pico_standard_link INTERFACE "LWIP_DEBUG=1")
target_compile_definitions(pico_standard_link INTERFACE "WANT_HCI_DUMP=1")

# Gather compile definitions from all dependencies
set_property(GLOBAL PROPERTY visited_targets "")
set_property(GLOBAL PROPERTY compilerdefs_list "")

function(gather_compile_definitions_recursive target)
    # Get the current value of visited_targets
    get_property(visited_targets GLOBAL PROPERTY visited_targets)
    
    # make sure we don't visit the same target twice
    # and that we don't visit the special generator expressions
    if (${target} MATCHES "\\\$<" OR ${target} MATCHES "::@" OR ${target} IN_LIST visited_targets)
        return()
    endif()

    # Append the target to visited_targets
    list(APPEND visited_targets ${target})
    set_property(GLOBAL PROPERTY visited_targets "${visited_targets}")

    # Get the current value of compilerdefs_list
    get_property(compilerdefs_list GLOBAL PROPERTY compilerdefs_list)

    get_target_property(target_definitions ${target} INTERFACE_COMPILE_DEFINITIONS)
    if (target_definitions)
        # Append the target definitions to compilerdefs_list
        list(APPEND compilerdefs_list ${target_definitions})
        set_property(GLOBAL PROPERTY compilerdefs_list "${compilerdefs_list}")
    endif()

    get_target_property(target_linked_libs ${target} INTERFACE_LINK_LIBRARIES)
    if (target_linked_libs)
        foreach(linked_target ${target_linked_libs})
            # Recursively gather compile definitions from dependencies
            gather_compile_definitions_recursive(${linked_target})
        endforeach()
    endif()
endfunction()

gather_compile_definitions_recursive(app)
get_property(COMPILE_DEFINITIONS GLOBAL PROPERTY compilerdefs_list)

# Parse compiler definitions into a format that swiftc can understand
list(REMOVE_DUPLICATES COMPILE_DEFINITIONS)
list(PREPEND COMPILE_DEFINITIONS "") # adds a semicolon at the beginning
string(REPLACE "$<TARGET_PROPERTY:PICO_TARGET_BINARY_TYPE>" "$<TARGET_PROPERTY:app,PICO_TARGET_BINARY_TYPE>" COMPILE_DEFINITIONS "${COMPILE_DEFINITIONS}")
string(REPLACE ";" " -Xcc -D" COMPILE_DEFINITIONS "${COMPILE_DEFINITIONS} ")
message("COMPILE_DEFINITIONS: ${COMPILE_DEFINITIONS}")

get_target_property(var pico_standard_link INTERFACE_COMPILE_OPTIONS)
set_target_properties(pico_standard_link PROPERTIES INTERFACE_COMPILE_OPTIONS "")

# Compute -Xcc flags to set up the C and C++ header search paths for Swift (for bridging header).
set(SWIFT_INCLUDES)
foreach(dir ${CMAKE_C_IMPLICIT_INCLUDE_DIRECTORIES})
    string(CONCAT SWIFT_INCLUDES ${SWIFT_INCLUDES} "-Xcc ")
    string(CONCAT SWIFT_INCLUDES ${SWIFT_INCLUDES} "-I${dir} ")
endforeach()
foreach(dir ${CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES})
    string(CONCAT SWIFT_INCLUDES ${SWIFT_INCLUDES} "-Xcc ")
    string(CONCAT SWIFT_INCLUDES ${SWIFT_INCLUDES} "-I${dir} ")
endforeach()

# Swift compiler flags to build in Embedded Swift mode, optimize for size, choose the right ISA, ABI, etc.
target_compile_options(app PUBLIC "$<$<COMPILE_LANGUAGE:Swift>:SHELL:
        -target armv6m-none-none-eabi
        -Xfrontend -function-sections -wmo -parse-as-library -Osize
        -enable-experimental-feature Embedded
        -enable-experimental-feature Extern
        -Xcc -mfloat-abi=soft -Xcc -fshort-enums

        -Xcc -I${CMAKE_CURRENT_LIST_DIR}/include

        -pch-output-dir /tmp
        -Xfrontend -enable-single-module-llvm-emission
        
        ${SWIFT_INCLUDES}
        ${COMPILE_DEFINITIONS}

        -import-bridging-header ${CMAKE_CURRENT_LIST_DIR}/BridgingHeader.h
    >")

# Enable Swift support in CMake, force Whole Module builds (required by Embedded Swift), and use "CMAKE_Swift_COMPILER_WORKS" to
# skip the trial compilations which don't (yet) correctly work when cross-compiling.
set(CMAKE_Swift_COMPILER_WORKS YES)
set(CMAKE_Swift_COMPILATION_MODE_DEFAULT wholemodule)
set(CMAKE_Swift_COMPILATION_MODE wholemodule)
enable_language(Swift)

# Don't link via the Swift driver, it doesn't understand some GNU linker arguments, and it's not necessary for Embedded Swift.
set_property(TARGET app PROPERTY LINKER_LANGUAGE C)

# List of Swift and C source files to build.
target_sources(app
    PRIVATE
    Main.swift
    Stubs.c
    CDemoImpl.c
)

pico_add_extra_outputs(app)
