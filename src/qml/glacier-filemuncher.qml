/*
 * Copyright (C) 2012 Robin Burchell <robin+nemo@viroteck.net>
 * Copyright (C) 2018 Chupligin Sergey <neochapay@gmail.com>
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

import Nemo.Thumbnailer 1.0

ApplicationWindow {
    id: window

    initialPage: DirectoryPage{
        path: homeDirectory
        isRootDirectory: true
    }

    // TODO: immediate should not be a bool, should take a hash of params.
    // root should be set by a param, not by knowledge of /. that is not x-platform!
    function cdInto(path, immediate)
    {
        var component = Qt.createComponent("DirectoryPage.qml");
        if (component.status == Component.Ready) {
            // TODO: error handling
            var dirPage = component.createObject(window, {"path": path, "isRootDirectory": path == "/" ? true : false});
            pageStack.push(dirPage, {}, immediate)
        } else {
            console.log("cdInto: error: " + component.errorString());
        }
    }

    /*format icons for some file types*/
    function formatIcon(object)
    {
        if(object.isDir) {
            return "image://theme/folder-o"
        }

        if(object.mimeType) {
            if(object.mimeType.slice(0, 6) === "image/") {
                return object.iconSource
            }

            if(object.mimeType === "application/x-rpm") {
                return "image://theme/box"
            }
        }

        console.log("mimetype is "+object.mimeType)

        return "image://theme/file-o"
    }
}
