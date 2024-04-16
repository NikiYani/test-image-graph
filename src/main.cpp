#include <filesystem>

#include <QApplication>
#include <QtGui>
#include <qcursor.h>

#include "3rdparty/loguru/loguru.hpp"

#include "menu.h"

#define TRANSLATIONS_PATH "/testImageGraph/translations/"

void setupLogger(int argc, char** argv)
{
    loguru::g_preamble_uptime = false;

    loguru::Options logOptions;
    logOptions.verbosity_flag = "--log";

    loguru::init(argc, argv, logOptions);
}

int main(int argc, char* argv[])
{
    setupLogger(argc, argv);

    QApplication a(argc, argv);
    a.setOverrideCursor(QCursor(Qt::BlankCursor));

    LOG(INFO) << "Start testing utility for graph image";

    QTranslator translator(0);
    if(translator.load("testImageGraph_ru.qm", QString::fromStdString(TRANSLATIONS_PATH))) {
        a.installTranslator(&translator);
        LOG(INFO) << "Loaded translation";
    } else {
        LOG(ERROR) << "Not loaded translation";
    }

    Menu m;
    m.setGeometry(0, 0, 300, 300);
    m.setAutoFillBackground(true);

    QPalette pal = QPalette();
    pal.setColor(QPalette::Window, Qt::white);
    m.setPalette(pal);

    m.show();
    return a.exec();
}