cmake_minimum_required(VERSION 3.20.0)
find_package(Zephyr REQUIRED HINTS $ENV{ZEPHYR_BASE})
project(blinky)

target_sources(app PRIVATE Stubs.c)

if(APPLE)
execute_process(COMMAND xcrun -f swiftc OUTPUT_VARIABLE SWIFTC OUTPUT_STRIP_TRAILING_WHITESPACE)
else()
execute_process(COMMAND which swiftc OUTPUT_VARIABLE SWIFTC OUTPUT_STRIP_TRAILING_WHITESPACE)
endif()

add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/_swiftcode.o
    COMMAND
        ${SWIFTC}
        -target armv7em-none-none-eabi -Xcc -mfloat-abi=soft -Xcc -fshort-enums
        -Xfrontend -function-sections -enable-experimental-feature Embedded -wmo -parse-as-library
        $$\( echo '$<TARGET_PROPERTY:app,INCLUDE_DIRECTORIES>' | sed 's/;$$//' | tr '\;' '\\n' | sed -e 's/\\\(.*\\\)/-Xcc -I\\1/g' \)
        $$\( echo '$<TARGET_PROPERTY:app,COMPILE_DEFINITIONS>' | sed 's/;$$/' | tr '\;' '\\n' | sed -e 's/\\\(.*\\\)/-Xcc \\1/g' \)
        -Xcc -DKERNEL -Xcc -DNRF52840_XXAA -Xcc -DPICOLIBC_INTEGER_PRINTF_SCANF -Xcc -D_FORTIFY_SOURCE=1 -Xcc -D_POSIX_C_SOURCE=200809 -Xcc -D__LINUX_ERRNO_EXTENSIONS__ -Xcc -D__PROGRAM_START -Xcc -D__ZEPHYR__=1
        -Xcc -I/opt/nordic/ncs/toolchains/20d68df7e5/opt/zephyr-sdk/arm-zephyr-eabi/picolibc/include
        -import-bridging-header ${CMAKE_CURRENT_LIST_DIR}/BridgingHeader.h
        ${CMAKE_CURRENT_LIST_DIR}/main.swift
        -c -o ${CMAKE_CURRENT_BINARY_DIR}/_swiftcode.o
    DEPENDS
        ${CMAKE_CURRENT_LIST_DIR}/BridgingHeader.h
        ${CMAKE_CURRENT_LIST_DIR}/Main.swift
)
add_custom_target(swift-blinky-swiftcode DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/_swiftcode.o)
target_link_libraries(app PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/_swiftcode.o)
add_dependencies(app swift-blinky-swiftcode)
