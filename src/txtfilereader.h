#ifndef TXTFILEREADER_H
#define TXTFILEREADER_H

#include <QObject>

class TxtFileReader : public QObject {
    Q_OBJECT
public:
    explicit TxtFileReader(QObject* parent = nullptr);

signals:
    void resultReady(QString result);

public slots:
    void load(QString path);
};

#endif // TXTFILEREADER_H
