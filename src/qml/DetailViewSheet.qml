/*
 * Copyright (C) 2012 Robin Burchell <robin+nemo@viroteck.net>
 * Copyright (C) 2017 Chupligin Sergey <neochapay@gmail.com>
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

Page {
    id: sheet
    property QtObject model
    property int selectedRow
    property string originalFileName: model.fileName

    Component.onCompleted: {
        // we should only enable this if there is something to save, and if
        deactivateSave();
    }

    function activateSave() {
        console.log("activating save")
        acceptButton.enabled = true
        rejectButton.text = qsTr("Cancel")
    }

    function deactivateSave() {
        console.log("deactivating save");
        acceptButton.enabled = false
        rejectButton.text = qsTr("Close")
    }

    Flickable {
        width: parent.width-Theme.itemSpacingSmall*2
        height: parent.height-Theme.itemSpacingSmall*2-Theme.itemHeightLarge

        anchors {
            top: parent.top
            topMargin: Theme.itemSpacingSmall
            left: parent.left
            leftMargin: Theme.itemSpacingSmall
        }

        Column {
            anchors.fill: parent

            Item {
                id: nameContainer
                height: Theme.itemHeightMedium
                anchors.left: parent.left
                anchors.right: parent.right

                Label {
                    id: nameLabel
                    text: qsTr("Name:")
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: Theme.itemSpacingSmall
                }

                TextField {
                    id: nameField
                    text: model.fileName
                    placeholderText: qsTr("Enter a new name")
                    anchors.right: parent.right
                    anchors.left: nameLabel.right
                    anchors.leftMargin: Theme.itemSpacingSmall
                    anchors.verticalCenter: parent.verticalCenter
                    // workaround for onTextChange only emitting when preedit is committed
                    inputMethodHints: Qt.ImhNoPredictiveText

                    onTextChanged: {
                        if (text != originalFileName) {
                            activateSave();
                        } else {
                            deactivateSave();
                        }
                    }
                }
            }

            Item {
                id: pathContainer
                height: Theme.itemHeightMedium
                anchors.left: parent.left
                anchors.right: parent.right

                Label {
                    id: pathLabel
                    text: qsTr("Path:")
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: Theme.itemSpacingSmall
                }

                Label {
                    id: pathField
                    text: model.filePath
                    anchors.right: parent.right
                    anchors.left: pathLabel.right
                    horizontalAlignment: Text.AlignRight
                    wrapMode: Text.NoWrap
                    elide: Text.ElideLeft
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Item {
                id: sizeContainer
                height: Theme.itemHeightMedium
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.topMargin: Theme.itemSpacingSmall
                visible: model.isFile

                Label {
                    id: sizeLabel
                    text: qsTr("Size:")
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: Theme.itemSpacingSmall
                }

                Label {
                    id: sizeField
                    text: model.fileSize
                    anchors.right: parent.right
                    anchors.left: sizeLabel.right
                    horizontalAlignment: Text.AlignRight
                    wrapMode: Text.NoWrap
                    elide: Text.ElideRight
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Item {
                id: createdContainer
                height: Theme.itemHeightMedium
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.topMargin: Theme.itemSpacingSmall

                Label {
                    id: createdLabel
                    text: qsTr("Created:")
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin:Theme.itemSpacingSmall
                }

                Label {
                    id: createdField
                    text: model.creationDate
                    anchors.right: parent.right
                    anchors.left: createdLabel.right
                    horizontalAlignment: Text.AlignRight
                    wrapMode: Text.NoWrap
                    elide: Text.ElideRight
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Item {
                id: modifiedContainer
                height: Theme.itemHeightMedium
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.topMargin: Theme.itemSpacingSmall

                Label {
                    id: modifiedLabel
                    text: qsTr("Last Modified:")
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: Theme.itemSpacingSmall
                }

                Label {
                    id: modifiedField
                    text: model.modifiedDate
                    anchors.right: parent.right
                    anchors.left: modifiedLabel.right
                    horizontalAlignment: Text.AlignRight
                    wrapMode: Text.NoWrap
                    elide: Text.ElideRight
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }

    Button {
        id: rejectButton
        width: parent.width / 2
        height: Theme.itemHeightLarge
        text: qsTr("Cancel")
        anchors {
            left: parent.left
            bottom: parent.bottom
        }
        onClicked: {
            pageStack.pop()
        }
    }

    Button {
        id: acceptButton
        width: parent.width / 2
        height: Theme.itemHeightLarge
        text: qsTr("Ok")
        anchors {
            left: rejectButton.right
            bottom: parent.bottom
        }
        onClicked: {
            if (nameField.text != originalFileName) {
                var ret = false
                //TODO: rework rename function
                if (!ret) {
                    // TODO: show a dialog here
                    nameField.text = originalFileName
                    console.log("rename failed; but we can't block the sheet closing. TODO! error handling.")
                }
            }
        }
    }
}

