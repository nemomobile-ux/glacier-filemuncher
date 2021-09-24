/*
 * Copyright (C) 2012 Robin Burchell <robin+nemo@viroteck.net>
 * Copyright (C) 2017-2020 Chupligin Sergey <neochapay@gmail.com>
 *
 * You may use this file under the terms of the BSD license as follows:
 *
 * "Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *   * Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   * Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in
 *     the documentation and/or other materials provided with the
 *     distribution.
 *   * Neither the name of Nemo Mobile nor the names of its contributors
 *     may be used to endorse or promote products derived from this
 *     software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
 */

import QtQuick 2.6

import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

import Nemo.Dialogs 1.0

import org.nemomobile.folderlistmodel 1.0
import org.nemomobile.filemuncher 1.0

Page {
    id: page
    property alias path: dirModel.path
    property bool isRootDirectory: false
    property string selectedFile
    property string selectedFilePath
    property int selectedRow

    headerTools:  HeaderToolsLayout {
        id: header
        title: qsTr("File manager")
        showBackButton: !page.isRootDirectory;

        tools: [
            ToolButton {
                iconSource: "image://theme/refresh"
                onClicked: dirModel.refresh()
            }/*,
            ToolButton {
                iconSource: "image://theme/bars"
                onClicked: (pageMenu.status == DialogStatus.Closed) ? pageMenu.open() : pageMenu.close()
            }*/
        ]
        drawerLevels: [
            Button {
                text: qsTr("Create directory")
                onClicked: {
                    var component = Qt.createComponent("InputSheet.qml");
                    if (component.status == Component.Ready) {
                        // TODO: error handling
                        var newFolder = component.createObject(page, {"title": qsTr("Enter new folder name")});
                        pageStack.push(newFolder)
                        newFolder.accepted.connect(function() {
                            var folderName = newFolder.inputText
                            dirModel.mkdir(folderName)
                            pageStack.pop();
                            cdInto(path+"/"+folderName)
                        });
                    }
                }
            },
            Button {
                text:  dirModel.showHiddenFiles ? qsTr("Hide hidden files") : qsTr("Show hidden files")
                onClicked: {
                    dirModel.showHiddenFiles = !dirModel.showHiddenFiles
                }
            }
        ]
    }


    Rectangle {
        id: dirName
        height: Theme.itemHeightLarge
        color: Theme.accentColor
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        Item {
            id: othercontent
            width: childrenRect.width
            height: childrenRect.height
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            id: label
            anchors.left: othercontent.right
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            smooth: true
            color: Theme.textColor
            text: dirModel.path
            elide: Text.ElideLeft
        }
    }

    ListView {
        id: fileList
        width: parent.width
        height: parent.height - dirName.height - Theme.itemSpacingMedium

        anchors{
            top: dirName.bottom
            left: parent.left
            topMargin: Theme.itemSpacingMedium
        }

        clip: true

        model: FolderListModel {
            id: dirModel
            showHiddenFiles: false
        }
        delegate: FileListDelegate {
            icon: formatIcon(model)
            iconColorized: icon.startsWith("image://theme/")
            onClicked: {
                if (model.isDir)
                    window.cdInto(model.filePath)

                else if (mimeType.slice(0, 5) === "text/") {
                  // Open text file
                    pageStack.push(Qt.resolvedUrl("TextViewPage.qml"), {"viewFile": filePath})
                } else {
                    page.selectedFilePath = model.filePath
                    openFileDialog.visible = true
                }
            }
            onWhantRemove: {
                removeFileDialog.subLabelText = file
                removeFileDialog.visible = true
            }

            onWhantInfo: {
                var component = Qt.createComponent("DetailViewSheet.qml");
                if (component.status == Component.Ready) {
                    // TODO: error handling
                    var detailsSheet = component.createObject(page, {"model": model});
                    pageStack.push(detailsSheet)
                }

                console.log(component.errorString())
            }
        }
    }

    Label {
        text: qsTr("No files here")
        anchors.centerIn: parent
        visible: !dirModel.awaitingResults && fileList.count == 0 ? true : false
    }

    Spinner {
        anchors.centerIn: parent
        visible: dirModel.awaitingResults && fileList.count == 0 ? true : false
    }

    // TODO: create menus only when needed, and share between pages
    /*Menu {
        id: pageMenu
        MenuLayout {
                MenuItem { text: "Delete items"; onClicked: {
                    var component = Qt.createComponent("FilePickerSheet.qml");
                    if (component.status == Component.Ready) {
                        // TODO: error handling
                        var deletePicker = component.createObject(page, {"model": dirModel, "pickText": "Delete"});
                        deletePicker.picked.connect(function(files) {
                            console.log("deleting " + files)
                            dirModel.rm(files)
                        });
                        deletePicker.open()
                    } else {
                        console.log("Delete Items: " + component.errorString())
                    }
                }
            }
        }
    }*/

    /*Menu {
        id: tapMenu
        MenuLayout {
            MenuItem {
                text: "Details"
                onClicked: {
                    var component = Qt.createComponent("DetailViewSheet.qml");
                    console.log(component.errorString())
                    if (component.status == Component.Ready) {
                        // TODO: error handling
                        var detailsSheet = component.createObject(page, {"model": dirModel, "selectedRow": page.selectedRow});
                        detailsSheet.open()
                    }
                }
            }
        }
    }*/

    QueryDialog {
        id: openFileDialog
        headingText: qsTr("Open file")
        subLabelText: page.selectedFilePath
        acceptText: qsTr("Yes")
        cancelText: qsTr("No")
        onAccepted: {
            Qt.openUrlExternally("file://" + page.selectedFilePath )
        }
        visible: false
    }


    QueryDialog {
        id: removeFileDialog
        headingText: qsTr("Remove")
        acceptText: qsTr("Yes")
        cancelText: qsTr("No")
        onAccepted: {
            dirModel.rm(subLabelText);
        }
        visible: false
    }

    QueryDialog {
        id: errorDialog
        acceptText: qsTr("Ok")
        visible: false
    }

    Connections {
        target: dirModel
        function onError(errorTitle, errorMessage) {
            errorDialog.headingText = errorTitle
            errorDialog.subLabelText = errorMessage
            errorDialog.open()
        }
    }
}

