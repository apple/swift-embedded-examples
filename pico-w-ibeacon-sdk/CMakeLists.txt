cmake_minimum_required(VERSION 3.13)
include($ENV{PICO_SDK_PATH}/external/pico_sdk_import.cmake)

project(swift-ibeacon)
pico_sdk_init()

if(APPLE)
execute_process(COMMAND xcrun -f swiftc OUTPUT_VARIABLE SWIFTC OUTPUT_STRIP_TRAILING_WHITESPACE)
else()
execute_process(COMMAND which swiftc OUTPUT_VARIABLE SWIFTC OUTPUT_STRIP_TRAILING_WHITESPACE)
endif()

add_executable(swift-ibeacon)
target_link_libraries(swift-ibeacon
    pico_stdlib 
    hardware_uart
    hardware_gpio
    pico_lwip_arch
    pico_cyw43_arch_none
    pico_btstack_ble
    pico_btstack_cyw43
)

target_include_directories(swift-ibeacon PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/include # For btstack config
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

gather_compile_definitions_recursive(swift-ibeacon)
get_property(COMPILE_DEFINITIONS GLOBAL PROPERTY compilerdefs_list)

# Parse compiler definitions into a format that swiftc can understand
list(REMOVE_DUPLICATES COMPILE_DEFINITIONS)
list(PREPEND COMPILE_DEFINITIONS "") # adds a semicolon at the beginning
string(REPLACE "$<TARGET_PROPERTY:PICO_TARGET_BINARY_TYPE>" "$<TARGET_PROPERTY:swift-ibeacon,PICO_TARGET_BINARY_TYPE>" COMPILE_DEFINITIONS "${COMPILE_DEFINITIONS}")
string(REPLACE ";" ";-Xcc;-D" COMPILE_DEFINITIONS "${COMPILE_DEFINITIONS}")

add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/_swiftcode.o
    COMMAND
        ${SWIFTC}
        -target armv6m-none-none-eabi -Xcc -mfloat-abi=soft -Xcc -fshort-enums
        ${COMPILE_DEFINITIONS}
        -Xcc -DCYW43_LWIP
        -Xcc -DPICO_CYW43_ARCH_THREADSAFE_BACKGROUND
        -Xcc -I$ENV{PICO_SDK_PATH}/lib/lwip/src/include
        -Xcc -I${CMAKE_CURRENT_LIST_DIR}/include
        -Xfrontend -function-sections -enable-experimental-feature Embedded -wmo -parse-as-library
        $$\( echo '$<TARGET_PROPERTY:swift-ibeacon,INCLUDE_DIRECTORIES>' | tr '\;' '\\n' | sed -e 's/\\\(.*\\\)/-Xcc -I\\1/g' \)
        $$\( echo '${CMAKE_C_IMPLICIT_INCLUDE_DIRECTORIES}'             | tr ' '  '\\n' | sed -e 's/\\\(.*\\\)/-Xcc -I\\1/g' \)
        -import-bridging-header ${CMAKE_CURRENT_LIST_DIR}/BridgingHeader.h
        ${CMAKE_CURRENT_LIST_DIR}/Main.swift
        ${CMAKE_CURRENT_LIST_DIR}/Error.swift
        ${CMAKE_CURRENT_LIST_DIR}/CYW43.swift
        ${CMAKE_CURRENT_LIST_DIR}/GPIO.swift
        ${CMAKE_CURRENT_LIST_DIR}/Bluetooth.swift
        ${CMAKE_CURRENT_LIST_DIR}/BluetoothAddress.swift
        ${CMAKE_CURRENT_LIST_DIR}/ByteSwap.swift
        ${CMAKE_CURRENT_LIST_DIR}/CompanyIdentifier.swift
        ${CMAKE_CURRENT_LIST_DIR}/LowEnergyAdvertisingData.swift
        ${CMAKE_CURRENT_LIST_DIR}/Data.swift
        ${CMAKE_CURRENT_LIST_DIR}/String.swift
        ${CMAKE_CURRENT_LIST_DIR}/Hexadecimal.swift
        ${CMAKE_CURRENT_LIST_DIR}/Encoder.swift
        ${CMAKE_CURRENT_LIST_DIR}/GAPData.swift
        ${CMAKE_CURRENT_LIST_DIR}/GAPDataType.swift
        ${CMAKE_CURRENT_LIST_DIR}/GAPFlags.swift
        ${CMAKE_CURRENT_LIST_DIR}/GAPShortLocalName.swift
        ${CMAKE_CURRENT_LIST_DIR}/GAPManufacturerSpecificData.swift
        ${CMAKE_CURRENT_LIST_DIR}/UInt128.swift
        ${CMAKE_CURRENT_LIST_DIR}/UUID.swift
        ${CMAKE_CURRENT_LIST_DIR}/iBeacon.swift
        ${CMAKE_CURRENT_LIST_DIR}/Integer.swift
        -c -o ${CMAKE_CURRENT_BINARY_DIR}/_swiftcode.o
    DEPENDS
        ${CMAKE_CURRENT_LIST_DIR}/BridgingHeader.h
        ${CMAKE_CURRENT_LIST_DIR}/Main.swift
        ${CMAKE_CURRENT_LIST_DIR}/Error.swift
        ${CMAKE_CURRENT_LIST_DIR}/CYW43.swift
        ${CMAKE_CURRENT_LIST_DIR}/GPIO.swift
        ${CMAKE_CURRENT_LIST_DIR}/Bluetooth.swift
        ${CMAKE_CURRENT_LIST_DIR}/BluetoothAddress.swift
        ${CMAKE_CURRENT_LIST_DIR}/ByteSwap.swift
        ${CMAKE_CURRENT_LIST_DIR}/CompanyIdentifier.swift
        ${CMAKE_CURRENT_LIST_DIR}/LowEnergyAdvertisingData.swift
        ${CMAKE_CURRENT_LIST_DIR}/Data.swift
        ${CMAKE_CURRENT_LIST_DIR}/String.swift
        ${CMAKE_CURRENT_LIST_DIR}/Hexadecimal.swift
        ${CMAKE_CURRENT_LIST_DIR}/Encoder.swift
        ${CMAKE_CURRENT_LIST_DIR}/GAPData.swift
        ${CMAKE_CURRENT_LIST_DIR}/GAPDataType.swift
        ${CMAKE_CURRENT_LIST_DIR}/GAPFlags.swift
        ${CMAKE_CURRENT_LIST_DIR}/GAPShortLocalName.swift
        ${CMAKE_CURRENT_LIST_DIR}/GAPManufacturerSpecificData.swift
        ${CMAKE_CURRENT_LIST_DIR}/UInt128.swift
        ${CMAKE_CURRENT_LIST_DIR}/UUID.swift
        ${CMAKE_CURRENT_LIST_DIR}/iBeacon.swift
        ${CMAKE_CURRENT_LIST_DIR}/Integer.swift
)
add_custom_target(swift-ibeacon-swiftcode DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/_swiftcode.o)

target_link_libraries(swift-ibeacon
    ${CMAKE_CURRENT_BINARY_DIR}/_swiftcode.o
)
add_dependencies(swift-ibeacon swift-ibeacon-swiftcode)
pico_add_extra_outputs(swift-ibeacon)