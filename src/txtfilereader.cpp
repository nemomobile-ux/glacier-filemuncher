#include "txtfilereader.h"
#include <QDebug>
#include <QFile>
#include <QTextStream>

TxtFileReader::TxtFileReader(QObject* parent)
    : QObject(parent)
{
}

void TxtFileReader::load(QString path)
{
    QFile textFile(path);
    if (!textFile.open(QFile::ReadOnly | QFile::Text)) {
        qDebug() << "Can't open file";
    } else {
        QTextStream in(&textFile);
        QString tmp = in.readAll();
        emit resultReady(tmp);
    }
    textFile.close();
}
