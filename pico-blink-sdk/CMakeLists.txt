cmake_minimum_required(VERSION 3.13)
include($ENV{PICO_SDK_PATH}/external/pico_sdk_import.cmake)

project(swift-blinky)
pico_sdk_init()

if(APPLE)
execute_process(COMMAND xcrun -f swiftc OUTPUT_VARIABLE SWIFTC OUTPUT_STRIP_TRAILING_WHITESPACE)
else()
execute_process(COMMAND which swiftc OUTPUT_VARIABLE SWIFTC OUTPUT_STRIP_TRAILING_WHITESPACE)
endif()

set(SWIFT_TARGET "armv6m-none-none-eabi") # default for rp2040

if(PICO_PLATFORM STREQUAL "rp2350-arm-s")
    message(STATUS "PICO_PLATFORM is set to rp2350-arm-s, using armv7em")
    set(SWIFT_TARGET "armv7em-none-none-eabi")
    list(APPEND CLANG_ARCH_ABI_FLAGS "-Xcc" "-mfloat-abi=soft")
elseif(PICO_PLATFORM STREQUAL "rp2040")
    message(STATUS "PICO_PLATFORM is set to RP2040, using armv6m")
    list(APPEND CLANG_ARCH_ABI_FLAGS "-Xcc" "-mfloat-abi=soft")
elseif(PICO_PLATFORM STREQUAL "rp2350-riscv")
    message(STATUS "PICO_PLATFORM is set to rp2350-riscv, using riscv32.")
    set(SWIFT_TARGET "riscv32-none-none-eabi")
    list(APPEND CLANG_ARCH_ABI_FLAGS "-Xcc" "-march=rv32imac_zicsr_zifencei_zba_zbb_zbs_zbkb" "-Xcc" "-mabi=ilp32")
endif()

add_executable(swift-blinky)

target_link_libraries(swift-blinky
    pico_stdlib hardware_uart hardware_gpio
)

# Gather compile definitions from all dependencies

set_property(GLOBAL PROPERTY visited_targets "")
set_property(GLOBAL PROPERTY compilerdefs_list "")

function(gather_compile_definitions_recursive target)
    # Get the current value of visited_targets
    get_property(visited_targets GLOBAL PROPERTY visited_targets)
    
    # make sure we don't visit the same target twice
    # and that we don't visit the special generator expressions
    if (${target} MATCHES "\\$<" OR ${target} MATCHES "::@" OR ${target} IN_LIST visited_targets)
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

gather_compile_definitions_recursive(swift-blinky)
get_property(COMPILE_DEFINITIONS GLOBAL PROPERTY compilerdefs_list)

# Parse compiler definitions into a format that swiftc can understand
list(REMOVE_DUPLICATES COMPILE_DEFINITIONS)
list(PREPEND COMPILE_DEFINITIONS "") # -Xcc -D
string(REPLACE "$<TARGET_PROPERTY:PICO_TARGET_BINARY_TYPE>" "$<TARGET_PROPERTY:swift-blinky,PICO_TARGET_BINARY_TYPE>" COMPILE_DEFINITIONS "${COMPILE_DEFINITIONS}")
string(REPLACE ";" " -Xcc -D" COMPILE_DEFINITIONS "${COMPILE_DEFINITIONS}")

# Write the compiler definitions to a file (this way CMake will evaluate the compiler definitions)
file(GENERATE OUTPUT ${CMAKE_BINARY_DIR}/swiftc_flags.txt CONTENT "${COMPILE_DEFINITIONS}")


add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/_swiftcode.o
    COMMAND
        ${SWIFTC}
        -target ${SWIFT_TARGET} -Xcc -fshort-enums
        @${CMAKE_BINARY_DIR}/swiftc_flags.txt
        ${CLANG_ARCH_ABI_FLAGS}
        -Xfrontend -function-sections -enable-experimental-feature Embedded -wmo -parse-as-library
        $$\( echo '$<TARGET_PROPERTY:swift-blinky,INCLUDE_DIRECTORIES>' | tr '\;' '\\n' | sed -e 's/\\\(.*\\\)/-Xcc -I\\1/g' \)
        $$\( echo '${CMAKE_C_IMPLICIT_INCLUDE_DIRECTORIES}'             | tr ' '  '\\n' | sed -e 's/\\\(.*\\\)/-Xcc -I\\1/g' \)
        -import-bridging-header ${CMAKE_CURRENT_LIST_DIR}/BridgingHeader.h
        ${CMAKE_CURRENT_LIST_DIR}/Main.swift
        -c -o ${CMAKE_CURRENT_BINARY_DIR}/_swiftcode.o
    DEPENDS
        ${CMAKE_CURRENT_LIST_DIR}/BridgingHeader.h
        ${CMAKE_CURRENT_LIST_DIR}/Main.swift
)
add_custom_target(swift-blinky-swiftcode DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/_swiftcode.o)


target_link_libraries(swift-blinky
    ${CMAKE_CURRENT_BINARY_DIR}/_swiftcode.o
)
add_dependencies(swift-blinky swift-blinky-swiftcode)
pico_add_extra_outputs(swift-blinky)
