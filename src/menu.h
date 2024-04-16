#pragma once

#include <memory>
#include <deque>

#include <QWidget>
#include <QTimer>
#include <QFrame>
#include <QGraphicsScene>
#include <QGraphicsView>
#include <QGraphicsProxyWidget>

QT_BEGIN_NAMESPACE
namespace Ui { class Menu; }
QT_END_NAMESPACE

class Menu : public QWidget
{
    Q_OBJECT

public:
    Menu(QWidget *parent = nullptr);
    ~Menu();

private:
    void _updateUi();
    void _updateInfo();

private:
    Ui::Menu*               _ui;
    QGraphicsProxyWidget*   _item;

    std::unique_ptr<QGraphicsView>  _view;
    std::unique_ptr<QGraphicsScene> _scene;

    std::string _pathToImg;
};