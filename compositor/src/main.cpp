//////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                              //
//         Copyright © 2019 Boubacar DIENE <boubacar.diene@gmail.com>                           //
//                                                                                              //
//         This file is part of glimagesink_under_qml project.                                  //
//                                                                                              //
//         glimagesink_under_qml is free software: you can redistribute it and/or               //
//         modify it under the terms of the GNU General Public License as published             //
//         by the Free Software Foundation, either version 2 of the License, or                 //
//         (at your option) any later version.                                                  //
//                                                                                              //
//         glimagesink_under_qml is distributed in the hope that it will be useful,             //
//         but WITHOUT ANY WARRANTY; without even the implied warranty of                       //
//         MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                        //
//         GNU General Public License for more details.                                         //
//                                                                                              //
//         You should have received a copy of the GNU General Public License                    //
//         along with glimagesink_under_qml. If not, see <http://www.gnu.org/licenses/>         //
//         or write to the Free Software Foundation, Inc., 51 Franklin Street,                  //
//         51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.                        //
//                                                                                              //
//////////////////////////////////////////////////////////////////////////////////////////////////

#include <QGuiApplication>
#include <QtQml>
#include <QQmlApplicationEngine>
#include <QUrl>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setOrganizationName("Demo");
    app.setOrganizationDomain("demo.com");
    app.setApplicationName("Wayland compositor - Multiple displays on embedded linux");

    qmlRegisterSingletonType(QUrl("qrc:///SurfaceManager.qml"),
                             "com.demo.SurfaceManager", 1, 0,
                             "SurfaceManager");

    QQmlApplicationEngine engine(QUrl("qrc:///Main.qml"));

    return app.exec();
}
