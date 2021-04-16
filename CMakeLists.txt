cmake_minimum_required(VERSION 3.6.0)

project(glacier-filemuncher
	VERSION 0.2.0
	DESCRIPTION "The Glacier file manager")

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

include(FeatureSummary)
include(GNUInstallDirs)

set(INSTALL_QML_IMPORT_DIR "${CMAKE_INSTALL_FULL_LIBDIR}/qt/qml"
	CACHE PATH "Custom QML import installation directory")

set(QT_MIN_VERSION "5.6.0")
find_package(Qt5 ${QT_MIN_VERSION} COMPONENTS Gui Qml Quick REQUIRED)
find_package(Glacier COMPONENTS App REQUIRED)

add_subdirectory(src)

install(FILES glacier-filemuncher.desktop
	DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/applications)
install(FILES icon-app-filemanager.png
	DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/glacier-filemuncher/images)

feature_summary(WHAT ALL FATAL_ON_MISSING_REQUIRED_PACKAGES)
