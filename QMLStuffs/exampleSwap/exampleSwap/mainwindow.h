#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QQuickView>
#include <QObject>
namespace Ui {
class MainWindow;
}

struct LatLon
{
    Q_GADGET
    Q_PROPERTY(double lat MEMBER lat)
    Q_PROPERTY(double lon MEMBER lon)
public:
    double lat;
    double lon;

};
Q_DECLARE_METATYPE(LatLon)

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    Q_PROPERTY(LatLon latlon_kaluga READ latlon_kaluga WRITE setLatlonKaluga NOTIFY latlonChangedKaluga)
    Q_PROPERTY(LatLon latlon_sead   READ latlon_sead   WRITE setLatlonSead   NOTIFY latlonChangedSead)
    Q_PROPERTY(LatLon latlon_airfox READ latlon_airfox WRITE setLatlonAirfox NOTIFY latlonChangedAirfox)
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();
    void addMyGUI(QLayout *layout_);

    LatLon latlon_kaluga() const;
    LatLon latlon_sead() const;
    LatLon latlon_airfox() const;
    double lat() const;

signals:
    void latlonChangedKaluga(double lat, double lon);
    void latlonChangedSead(double lat, double lon);
    void latlonChangedAirfox(double lat, double lon);
    void latChanged(double lat);

public slots:
    void setLatlonKaluga(LatLon latlon);
    void setLatlonSead(LatLon latlon);
    void setLatlonAirfox(LatLon latlon);
    void setLat(double lat);


private slots:
    void joystick_moved(double x, double y, double angle,QString vehicle);
    void latLonReference_moved(double lat, double lon,QString vehicle);
    void sendLatLon();

private:
    Ui::MainWindow *ui;
    QObject *obj ;
    QObject *childObj_kaluga;
    QObject *childObj_sead   ;
    QObject *childObj_airfox ;

    QObject *childReferenceLatLonKaluga ;
    QObject *childReferenceLatLonSead ;
    QObject *childReferenceLatLonAirfox ;

    LatLon m_latlon_kaluga ;
    LatLon m_latlon_sead;
    LatLon m_latlon_airfox;
    double m_lat =1.0;
    double m_lon = 1.2;

    QTimer *m_timer_lat_lon_ref;



};

#endif // MAINWINDOW_H
