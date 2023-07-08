cmake_minimum_required(VERSION 3.6.0)

project(glacier-filemuncher
	VERSION 0.2.0
	DESCRIPTION "The Glacier file manager")

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_INSTALL_PREFIX /usr)

include(FeatureSummary)
include(GNUInstallDirs)

function(FindQtInstallQml)
    find_program(QMAKE NAMES qmake6 qmake)
    if(NOT QMAKE)
        message(FATAL_ERROR "qmake not found")
    endif()
    execute_process(
        COMMAND ${QMAKE} -query QT_INSTALL_QML
        OUTPUT_VARIABLE PROC_RESULT
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    set(QT_INSTALL_QML ${PROC_RESULT} PARENT_SCOPE)
endfunction()

FindQtInstallQml()

set(QT_MIN_VERSION "6.0.0")
find_package(Qt6 ${QT_MIN_VERSION} COMPONENTS Gui Qml Quick LinguistTools REQUIRED)
find_package(Glacier COMPONENTS App REQUIRED)

add_subdirectory(src)

# Translations
file(GLOB TS_FILES translations/*.ts)
qt_add_translation(QM_FILES ${TS_FILES})
add_custom_target(translations DEPENDS ${QM_FILES})
add_dependencies(glacier-filemuncher translations)

install(FILES ${QM_FILES}
        DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/glacier-filemuncher/translations)


install(FILES glacier-filemuncher.desktop
	DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/applications)
install(FILES icon-app-filemanager.png
	DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/glacier-filemuncher/images)

feature_summary(WHAT ALL FATAL_ON_MISSING_REQUIRED_PACKAGES)
