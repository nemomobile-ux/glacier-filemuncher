PROJECT_NAME = glacier-filemuncher
QT += qml quick
TEMPLATE = app
DEPENDPATH += .
INCLUDEPATH += .
CONFIG -= app_bundle
TARGET = $$PROJECT_NAME


qml.files = src/qml/*.qml
qml.files += src/qml/*.js
qml.path = /usr/share/$${PROJECT_NAME}/qml/
INSTALLS += qml

images.files = src/*.png
images.path = /usr/share/$${PROJECT_NAME}/images
INSTALLS += images

# qml API we provide
api.files = src/qml/api/*
api.path = $$[QT_INSTALL_QML]/org/nemomobile/filemuncher
INSTALLS += api

target.path = /usr/bin
INSTALLS += target

desktop.files = $${PROJECT_NAME}.desktop
desktop.path = /usr/share/applications
INSTALLS += desktop

# Input
SOURCES += src/main.cpp \
    src/utils.cpp

HEADERS += \
    src/utils.h

CONFIG += link_pkgconfig

DISTFILES += \
    src/qml/api/qmldir \
    src/qml/api/FileListDelegate.qml \
    src/qml/api/FilePermissionIndicator.qml \
    src/qml/prohibitionsign.svg \
    src/qml/main.qml \
    src/qml/InputSheet.qml \
    src/qml/DirectoryPage.qml \
    src/qml/DetailViewSheet.qml \
    src/qml/FilePickerSheet.qml \
    rpm/glacier-filemuncher.spec
