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

ListViewItemWithActions {
    id: delegate
    property bool navigationMode: true
    property bool selected: false

    signal whantRemove(string file)
    signal whantInfo(var model)

    label: model.fileName
    showNext: isDir

    width: parent.width
    height: Theme.itemHeightLarge

    actions: Rectangle{
        id: itemActions
        height: Theme.itemHeightLarge
        width: height*2

        color: "transparent"

        Image{
            id: removeButton
            width: parent.height*0.6
            height: width

            source: "image://theme/trash"

            anchors{
                top: parent.top
                topMargin: parent.height*0.2
                left: parent.left
                leftMargin: parent.height*0.2
            }

            MouseArea{
                anchors.fill: parent
                onClicked: whantRemove(model.filePath)
            }
        }

        Image{
            id: infoButton
            width: parent.height*0.6
            height: width

            source: "image://theme/info"

            anchors{
                top: parent.top
                topMargin: parent.height*0.2
                left: removeButton.right
                leftMargin: parent.height*0.4
            }

            MouseArea{
                anchors.fill: parent
                onClicked: whantInfo(model)
            }
        }
    }

    Text {
        id: fileSize
        color: Theme.textColor
        visible: model.isFile
        font: Theme.fontFamily
        text: model.fileSize
        anchors{
            right: parent.right
            rightMargin: Theme.itemSpacingMedium
            verticalCenter: parent.verticalCenter
        }
    }
}

