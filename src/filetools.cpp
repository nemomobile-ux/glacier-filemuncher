/*
 * Copyright (C) 2020 Chupligin Sergey <neochapay@gmail.com>
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

#include "filetools.h"
#include "txtfilereader.h"

#include <QDebug>
#include <QFile>

FileTools::FileTools(QObject* parent)
    : QObject(parent)
{
}

FileTools::~FileTools()
{
    m_workerThread.quit();
    m_workerThread.wait();
}

QString FileTools::path() const
{
    if (m_path.isEmpty()) {
        qDebug() << "Path is empty";
        return QString();
    }

    return m_path;
}

void FileTools::loadFileContent()
{
    if (m_path.isEmpty()) {
        return;
    }

    TxtFileReader* txtLoader = new TxtFileReader;
    txtLoader->moveToThread(&m_workerThread);
    connect(&m_workerThread, &QThread::finished, txtLoader, &QObject::deleteLater);
    connect(txtLoader, &TxtFileReader::resultReady, this, &FileTools::loadFileContentFinished);
    txtLoader->load(m_path);
}

void FileTools::loadFileContentFinished(QString content)
{
    if (m_fileContent != content) {
        m_fileContent = content;
        emit fileContentChanged(m_fileContent);
    }
}

void FileTools::setPath(QString path)
{
    if (path.isEmpty()) {
        qDebug() << "Path is empty";
    }

    QFile file(path);
    if (!file.exists()) {
        qDebug() << "File not exists";
        emit fileNotFound();
    } else {
        m_path = path;
        m_fileContent = "";

        emit pathChanged(path);
        if (m_fileContent.length() > 0) {
            emit fileContentChanged(m_fileContent);
        }
    }
}
