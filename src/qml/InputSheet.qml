/*
 * Copyright (C) 2012 Arto Jalkanen <ajalkane@gmail.com>
 * Copyright (C) 2017-2025 Chupligin Sergey <neochapay@gmail.com>
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

import QtQuick
import Nemo
import Nemo.Controls

Page {
    id: sheet
    property alias title: header.title
    property alias subTitle: headerLabel.text
    property alias inputText: labelField.text

    signal accepted();

    headerTools:  HeaderToolsLayout {
        id: header
    }

    Label {
        id: headerLabel
    }

    TextField {
        id: labelField
        width: parent.width

        anchors.top: headerLabel.bottom

        Keys.onReturnPressed: {
            dummy.focus = true
        }
    }

    Button {
        id: cancel
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
        id: accept
        width: parent.width / 2
        height: Theme.itemHeightLarge
        text: qsTr("Ok")
        anchors {
            left: cancel.right
            bottom: parent.bottom
        }
        onClicked: {
            accepted()
        }
    }
}
