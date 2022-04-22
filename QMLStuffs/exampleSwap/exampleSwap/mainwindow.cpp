#include <QQmlContext>
#include <QtQuick/QQuickView>
#include <QtQuick/QQuickItem>
#include <QUrl>
#include <QDebug>
#include <QTimer>
#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    m_latlon_kaluga.lat =1;
    m_latlon_kaluga.lon =1;
    m_lat =1;
    ui->setupUi(this);
    addMyGUI(ui->gridLayoutXY);



    m_timer_lat_lon_ref = new QTimer(this);
    m_timer_lat_lon_ref->setInterval(1000);
    connect(m_timer_lat_lon_ref, SIGNAL(timeout()), this, SLOT(sendLatLon()));
    m_timer_lat_lon_ref->start();
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::addMyGUI(QLayout *layout_)
{
    QQuickView *view = new QQuickView();
    /* NB: We load the QML from a .qrc file becuase the Qt build step
     * that packages the final .app on Mac forgets to add the QML
     * if you reference it directly
     */
    view->rootContext()->setContextProperty("mainWindow", this);
    view->setSource(QUrl("qrc:/main.qml"));
    obj = view->rootObject();

    childObj_kaluga = obj->findChild<QObject *>("the_joystick_kaluga");
    childObj_sead   = obj->findChild<QObject *>("the_joystick_sead");
    childObj_airfox = obj->findChild<QObject *>("the_joystick_airfox");

    childReferenceLatLonKaluga = obj->findChild<QObject *>("kaluga_controlContainer");
    childReferenceLatLonSead   = obj->findChild<QObject *>("sead_controlContainer");
    childReferenceLatLonAirfox = obj->findChild<QObject *>("airfox_controlContainer");

    connect(childObj_kaluga, SIGNAL(joystick_moved(double, double, double, QString)),this,SLOT(joystick_moved(double, double, double,QString) ) );
    connect(childObj_sead  , SIGNAL(joystick_moved(double, double, double,QString)),this,SLOT(joystick_moved(double, double, double,QString) ) );
    connect(childObj_airfox, SIGNAL(joystick_moved(double, double, double,QString)),this,SLOT(joystick_moved(double, double, double,QString) ) );

    connect(childReferenceLatLonKaluga, SIGNAL(sendReferenceLatLon(double, double,QString)),this,SLOT(latLonReference_moved(double, double,QString) ) );
    connect(childReferenceLatLonSead  , SIGNAL(sendReferenceLatLon(double, double,QString)),this,SLOT(latLonReference_moved(double, double,QString) ) );
    connect(childReferenceLatLonAirfox, SIGNAL(sendReferenceLatLon(double, double,QString)),this,SLOT(latLonReference_moved(double, double,QString) ) );

    /* Enable transparent background on the QQuickView
     * Note that this currently does not work on Windows
     */
#ifndef _WIN32
    view->setClearBeforeRendering(true);
    view->setColor(QColor(Qt::transparent));
#endif

    // Attach to the 'mouse moved' signal
//    auto *root = view->rootObject();

    // Create a container widget for the QQuickView
    QWidget *container = QWidget::createWindowContainer(view, this);
    container->setMinimumSize(640, 480);
    container->setMaximumSize(640, 480);
    container->setFocusPolicy(Qt::TabFocus);
    layout_->addWidget(container);
}

LatLon MainWindow::latlon_kaluga() const
{
    return m_latlon_kaluga;
}

LatLon MainWindow::latlon_sead() const
{
    return m_latlon_sead;
}

LatLon MainWindow::latlon_airfox() const
{
    return m_latlon_airfox;
}

double MainWindow::lat() const
{
    return m_lat;
}

void MainWindow::setLatlonKaluga(LatLon latlon)
{
    if (latlon.lat == m_latlon_kaluga.lat && latlon.lon == m_latlon_kaluga.lon)
        return;

    m_latlon_kaluga.lat = latlon.lat;
    m_latlon_kaluga.lon = latlon.lon;
    emit latlonChangedKaluga(m_latlon_kaluga.lat, m_latlon_kaluga.lon);
}

void MainWindow::setLatlonSead(LatLon latlon)
{
    if (latlon.lat == m_latlon_sead.lat && latlon.lon == m_latlon_sead.lon)
        return;

    m_latlon_sead.lat = latlon.lat;
    m_latlon_sead.lon = latlon.lon;
    emit latlonChangedSead(m_latlon_sead.lat, m_latlon_sead.lon);
}

void MainWindow::setLatlonAirfox(LatLon latlon)
{
    if (latlon.lat == m_latlon_airfox.lat && latlon.lon == m_latlon_airfox.lon)
        return;

    m_latlon_airfox.lat = latlon.lat;
    m_latlon_airfox.lon = latlon.lon;
    emit latlonChangedAirfox(m_latlon_airfox.lat, m_latlon_airfox.lon);
}

void MainWindow::setLat(double _lat)
{
    if (_lat == m_lat )
        return;

    m_lat = _lat;
    emit latChanged(m_lat);
}


void MainWindow::joystick_moved(double x, double y, double angle, QString vehicle) {

    qDebug() << "vehicle name: " << vehicle <<" " << x << ", " << y << " " << angle;
    //qDebug() << x << ", " << y;
}

void MainWindow::latLonReference_moved(double lat, double lon, QString vehicle)
{
    qDebug() << "vehicle name: " << vehicle <<" " << lat << ", " << lon ;
}

void MainWindow::sendLatLon()
{
    //qDebug() << "sending signal latChanged with m_lat = " << m_latlon_kaluga.lat ;

    if (m_latlon_kaluga.lat ==1)
    {
        m_latlon_kaluga.lat =0;
    }
    else
    {
        m_latlon_kaluga.lat =1;
    }
    emit latlonChangedKaluga(m_latlon_kaluga.lat, m_latlon_kaluga.lon);

    if (m_latlon_sead.lat ==1)
    {
        m_latlon_sead.lat =0;
    }
    else
    {
        m_latlon_sead.lat =1;
    }
    emit latlonChangedSead(m_latlon_sead.lat, m_latlon_sead.lon);


    if (m_latlon_airfox.lat ==1)
    {
        m_latlon_airfox.lat =0;
    }
    else
    {
        m_latlon_airfox.lat =1;
    }
    emit latlonChangedAirfox(m_latlon_airfox.lat, m_latlon_airfox.lon);
}


