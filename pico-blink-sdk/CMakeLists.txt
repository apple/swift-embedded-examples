cmake_minimum_required(VERSION 3.13)
include($ENV{PICO_SDK_PATH}/external/pico_sdk_import.cmake)
include(hacky_cmake_helper.cmake)

project(swift-blinky)
pico_sdk_init()

if(APPLE)
execute_process(COMMAND xcrun -f swiftc OUTPUT_VARIABLE SWIFTC OUTPUT_STRIP_TRAILING_WHITESPACE)
else()
execute_process(COMMAND which swiftc OUTPUT_VARIABLE SWIFTC OUTPUT_STRIP_TRAILING_WHITESPACE)
endif()


set(SWIFT_TARGET "armv6m-none-none-eabi") # default for rp2040
list(APPEND CLANG_ARCH_ABI_FLAGS "-Xcc") 

if(PICO_PLATFORM STREQUAL "rp2350-arm-s")
    message(STATUS "PICO_PLATFORM is set to rp2350-arm-s, using armv7em")
    set(SWIFT_TARGET "armv7em-none-none-eabi")
    list(APPEND CLANG_ARCH_ABI_FLAGS "-mfloat-abi=soft")
elseif(PICO_PLATFORM STREQUAL "rp2040")
    message(STATUS "PICO_PLATFORM is set to RP2040, using armv6m")
    list(APPEND CLANG_ARCH_ABI_FLAGS "-mfloat-abi=soft")
elseif(PICO_PLATFORM STREQUAL "rp2350-riscv")
    message(STATUS "PICO_PLATFORM is set to rp2350-riscv, using riscv32.")
    set(SWIFT_TARGET "riscv32-none-none-eabi")
    list(APPEND CLANG_ARCH_ABI_FLAGS "-march=rv32imac_zicsr_zifencei_zba_zbb_zbs_zbkb" "-Xcc" "-mabi=ilp32")
endif()

add_executable(swift-blinky)

target_link_libraries(swift-blinky
    pico_stdlib hardware_uart hardware_gpio
)

gather_vars(COMPILE_DEFINITIONS INTERFACE_COMPILE_DEFINITIONS _touched_cd swift-blinky)
list(REMOVE_DUPLICATES COMPILE_DEFINITIONS)
list(PREPEND COMPILE_DEFINITIONS "") # -Xcc -D
string(REPLACE "$<TARGET_PROPERTY:PICO_TARGET_BINARY_TYPE>" "$<TARGET_PROPERTY:swift-blinky,PICO_TARGET_BINARY_TYPE>" COMPILE_DEFINITIONS "${COMPILE_DEFINITIONS}")
string(REPLACE ";" " -Xcc -D" COMPILE_DEFINITIONS "${COMPILE_DEFINITIONS}")


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
