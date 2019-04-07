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

/*!
* \file Main.c
* \brief Main entry point of the application
* \author Boubacar DIENE
*
* In this example, the main UI and the streaming parts are completely independent. They could
* have been separated into two different processes and the result would be the same.
*
* Notes:
* - To simplify the example, there's no error checking
* - To see more logs, please use GST_DEBUG and/or WAYLAND_DEBUG environment variables
*/

/* -------------------------------------------------------------------------------------------- */
/* ////////////////////////////////////////// HEADERS ///////////////////////////////////////// */
/* -------------------------------------------------------------------------------------------- */

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QUrl>

#include <gst/gst.h>

/* -------------------------------------------------------------------------------------------- */
/* //////////////////////////////////////// VARIABLES ///////////////////////////////////////// */
/* -------------------------------------------------------------------------------------------- */

namespace {
const gchar *videoPipeline = "videotestsrc"\
                             " ! video/x-raw, width=540, height=380"\
                             " ! glimagesink name=sinkName";
}

/* -------------------------------------------------------------------------------------------- */
/* /////////////////////////////////////////// MAIN /////////////////////////////////////////// */
/* -------------------------------------------------------------------------------------------- */

int main(int argc, char *argv[])
{
    // Environment variables
    qputenv("QT_QPA_PLATFORM", "wayland");
    qputenv("QT_WAYLAND_SHELL_INTEGRATION", "wl-shell"/*"xdg-shell"*/);

    qputenv("GST_GL_WINDOW", "wayland");
    qputenv("GST_GL_PLATFORM", "egl");
    qputenv("GST_GL_API", "gles2");

    qputenv("GST_DEBUG", "*:2");
    qputenv("WAYLAND_DEBUG", "0"/*"1"*/);

    // Qt main UI
    QGuiApplication app(argc, argv);
    app.setOrganizationName("Demo");
    app.setOrganizationDomain("demo.com");
    app.setApplicationName("application1");

    QQmlApplicationEngine engine(QUrl("qrc:///Main.qml"));

    // Video pipeline
    gst_init (&argc, &argv);

    GstElement *pipeline = gst_parse_launch(videoPipeline, NULL);
    gst_element_set_state(pipeline, GST_STATE_PLAYING);

    return app.exec();
}
