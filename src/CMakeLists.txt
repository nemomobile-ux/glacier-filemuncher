set(PROJECT glacier-filemuncher)

set(SRC main.cpp
	filetools.cpp
	txtfilereader.cpp)

set(HEADERS filetools.h
	txtfilereader.h)

qt_add_resources(RESOURCES qml/${PROJECT}.qrc)

add_executable(${PROJECT} ${SRC} ${HEADERS} ${RESOURCES}
    qml/glacier-filemuncher.qrc)

target_link_libraries(${PROJECT}
	Qt6::Gui
	Qt6::Qml
	Qt6::Quick
	Glacier::App)

install(TARGETS ${PROJECT} RUNTIME
	DESTINATION ${CMAKE_INSTALL_BINDIR})
install(DIRECTORY qml/api/
	DESTINATION ${QT_INSTALL_QML}/org/nemomobile/filemuncher/)
