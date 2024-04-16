#include <fcntl.h>
#include <linux/input.h>
#include <thread>
#include <unistd.h>

#include <QImageReader>
#include <QString>
#include <QTranslator>
#include <QVBoxLayout>

#include "3rdparty/loguru/loguru.hpp"

#include "menu.h"
#include "./ui_menu.h"

using namespace std::chrono_literals;

Menu::Menu(QWidget *parent)
    : QWidget(parent)
    , _ui(new Ui::Menu)
    , _scene(new QGraphicsScene)
    , _view(new QGraphicsView)
    , _pathToImg("/testImageGraph/resources/aircraft.jpg")
{
    _ui->setupUi(this);

    LOG(INFO) << "Supported Formats:";

    for(auto& format : QImageReader::supportedImageFormats())
        LOG(INFO) << QString(format).toStdString();
    
    QPixmap logoPic(_pathToImg.c_str());
    _ui->logo->setPixmap(logoPic);

    _updateInfo();
    _updateUi();
}

Menu::~Menu()
{
    delete _ui;
}

void Menu::_updateUi()
{
    QCoreApplication::processEvents();
    QCoreApplication::processEvents();
}

void Menu::_updateInfo()
{
    LOG(INFO) << "-----------------";
    LOG(INFO) << "---Update info---";
    LOG(INFO) << "-----------------";
    
    LOG(INFO) << "Path to image: " << _pathToImg;

    LOG(INFO) << "-----------------";
}