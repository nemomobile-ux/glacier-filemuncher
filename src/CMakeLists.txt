set(SRC main.cpp
	filetools.cpp
	txtfilereader.cpp)

set(HEADERS filetools.h
	txtfilereader.h)

add_executable(glacier-filemuncher ${SRC} ${HEADERS})

target_link_libraries(glacier-filemuncher
	Qt5::Gui
	Qt5::Qml
	Qt5::Quick
	Glacier::App)

install(TARGETS glacier-filemuncher RUNTIME
	DESTINATION ${CMAKE_INSTALL_BINDIR})
install(DIRECTORY qml
	DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/glacier-filemuncher
	PATTERN "api" EXCLUDE)
install(DIRECTORY qml/api/
	DESTINATION
	${CMAKE_INSTALL_LIBDIR}/qt5/qml/org/nemomobile/filemuncher)
