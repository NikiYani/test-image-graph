cmake_minimum_required(VERSION 3.5)

if(DEFINED VERSION)
    set(version ${VERSION})
endif()

project(testImageGraph VERSION ${version} LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread")

find_package(QT NAMES Qt6 Qt5 COMPONENTS Widgets Multimedia REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Widgets Multimedia REQUIRED)
find_package(Boost COMPONENTS system filesystem date_time thread chrono REQUIRED)

message("\n----Qt Linguist start----")

set(TS_DIR "${CMAKE_CURRENT_SOURCE_DIR}/translations")

set(TS_FILES
    "${TS_DIR}/${PROJECT_NAME}_ru.ts"
)

find_program(LUPDATE_EXECUTABLE lupdate)
find_program(LRELEASE_EXECUTABLE lrelease)

foreach(_ts_file ${TS_FILES})
    execute_process(
        COMMAND ${LUPDATE_EXECUTABLE} -recursive ${CMAKE_SOURCE_DIR}/src -ts ${_ts_file})
    execute_process(
        COMMAND ${LRELEASE_EXECUTABLE} ${_ts_file})
endforeach()

message("----Qt Linguist end----\n")

file(GLOB ALL_SRCS
    "${PROJECT_SOURCE_DIR}/src/*.h"
    "${PROJECT_SOURCE_DIR}/src/*.cpp"
)

add_subdirectory(3rdparty/loguru)

add_executable(${PROJECT_NAME} ${ALL_SRCS})

target_link_libraries(${PROJECT_NAME} 
    PUBLIC 
        Qt${QT_VERSION_MAJOR}::Widgets
        Qt${QT_VERSION_MAJOR}::Multimedia
        loguru
        Boost::system
        Boost::filesystem
        Boost::date_time
        Boost::thread
        Boost::chrono
)

install(TARGETS ${PROJECT_NAME})

install(DIRECTORY
    resources
    DESTINATION .
)

install(DIRECTORY
    translations
    DESTINATION .
)