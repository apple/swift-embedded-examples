idf_component_register(
    SRCS "Dummy.c"
    INCLUDE_DIRS "."
)

idf_build_get_property(target IDF_TARGET)
idf_build_get_property(arch IDF_TARGET_ARCH)

if("${arch}" STREQUAL "xtensa")
    message(FATAL_ERROR "Not supported target: ${target}")
endif()

if(${target} STREQUAL "esp32c2" OR ${target} STREQUAL "esp32c3")
    set(march_flag "rv32imc_zicsr_zifencei")
    set(mabi_flag "ilp32")
elseif(${target} STREQUAL "esp32p4")
    set(march_flag "rv32imafc_zicsr_zifencei")
    set(mabi_flag "ilp32f")
else()
    set(march_flag "rv32imac_zicsr_zifencei")
    set(mabi_flag "ilp32")
endif()

execute_process(COMMAND xcrun -f swiftc OUTPUT_VARIABLE SWIFTC OUTPUT_STRIP_TRAILING_WHITESPACE)

add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/_swiftcode.o
    COMMAND
        ${SWIFTC}
        -target riscv32-none-none-eabi
        -Xfrontend -function-sections -enable-experimental-feature Embedded -wmo -parse-as-library -Osize
        -Xcc -march=${march_flag} -Xcc -mabi=${mabi_flag}
        $$\( echo '$<TARGET_PROPERTY:__idf_main,INCLUDE_DIRECTORIES>' | tr '\;' '\\n' | sed -e 's/\\\(.*\\\)/-Xcc -I\\1/g' \)
        $$\( echo '${CMAKE_C_IMPLICIT_INCLUDE_DIRECTORIES}'           | tr ' '  '\\n' | sed -e 's/\\\(.*\\\)/-Xcc -I\\1/g' \)
        -import-bridging-header ${CMAKE_CURRENT_LIST_DIR}/BridgingHeader.h
        ${CMAKE_CURRENT_LIST_DIR}/Main.swift
        ${CMAKE_CURRENT_LIST_DIR}/Led.swift
        -c -o ${CMAKE_CURRENT_BINARY_DIR}/_swiftcode.o
    DEPENDS
        ${CMAKE_CURRENT_LIST_DIR}/BridgingHeader.h
        ${CMAKE_CURRENT_LIST_DIR}/Main.swift
        ${CMAKE_CURRENT_LIST_DIR}/Led.swift
)
add_custom_target(main-swiftcode DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/_swiftcode.o)

target_link_libraries(__idf_main
    ${CMAKE_CURRENT_BINARY_DIR}/_swiftcode.o
)
add_dependencies(__idf_main main-swiftcode)
