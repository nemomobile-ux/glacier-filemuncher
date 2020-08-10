#ifndef FILETOOLS_H
#define FILETOOLS_H

#include <QObject>
#include <QThread>

class FileTools: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString path READ path WRITE setPath NOTIFY pathChanged)

public:
    explicit FileTools(QObject *parent = 0);
    ~FileTools();

    QString path() const;
    Q_INVOKABLE void loadFileContent();

public slots:
    void setPath(QString path);

private slots:
    void loadFileContentFinished(QString content);

signals:
    void pathChanged(QString path);
    void fileNotFound();

    void fileLoading();
    void fileLoad();

    void fileContentChanged(QString content);

private:
    QThread m_workerThread;

    QString m_path;
    QString m_fileContent;
    bool m_fLoad;
};

#endif // FILETOOLS_H
