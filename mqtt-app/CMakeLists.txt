cmake_minimum_required(VERSION 3.10.0)

project(mqtt-app)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(Qt5 CONFIG REQUIRED COMPONENTS Widgets Core Quick Mqtt)

add_executable(mqtt-app
    main.cpp
    qml.qrc
    mqttclient.cpp)

target_link_libraries(mqtt-app
    Qt5::Widgets
    Qt5::Core
    Qt5::Quick
    Qt5::Mqtt)
