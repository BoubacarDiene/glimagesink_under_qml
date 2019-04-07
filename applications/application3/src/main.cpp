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
* \file main.cpp
* \brief Main entry point of the application
* \author Boubacar DIENE
*
* In this example, the application's window is expected to be used instead of the one created
* by gstreamer's glimagesink plugin if no window is provided.
* TODO: This is a work in progress to correctly retrieve the window and display handles and
*       also make the set_window_handle() work.
*
* However, the exampe remains useful as it shows more possibilities of gstreamer compared
* to "application1".
*
* Notes:
* - To simplify the example, there's no error checking
* - To see more logs, please use GST_DEBUG and/or WAYLAND_DEBUG environment variables
*/

/* -------------------------------------------------------------------------------------------- */
/* ////////////////////////////////////////// HEADERS ///////////////////////////////////////// */
/* -------------------------------------------------------------------------------------------- */

#include <QGuiApplication>
#include <QObject>
#include <QQmlApplicationEngine>
#include <QtGlobal>
#include <QUrl>
#include <QWindow>
#include <qpa/qplatformnativeinterface.h> //qtbase5-private is required

#include <gst/gst.h>
#include <gst/video/videooverlay.h>
#include <gst/wayland/wayland.h>

/* -------------------------------------------------------------------------------------------- */
/* //////////////////////////////////////// VARIABLES ///////////////////////////////////////// */
/* -------------------------------------------------------------------------------------------- */

namespace {
    const int videoWidth       = 540;
    const int videoHeight      = 380;
    const gchar *videoPipeline = "videotestsrc"\
                                 " ! video/x-raw, width=540, height=380"\
                                 " ! glimagesink name=sinkName";
#if 0
    struct wl_surface *windowHandle  = nullptr;
    struct wl_display *displayHandle = nullptr;
#endif
}

/* -------------------------------------------------------------------------------------------- */
/* ///////////////////////////////////// PRIVATE METHODS ////////////////////////////////////// */
/* -------------------------------------------------------------------------------------------- */

static GstBusSyncReply
busSyncHandler(GstBus *bus, GstMessage *message, gpointer user_data)
{
#if 0
    if (gst_is_wayland_display_handle_need_context_message(message)) {
        if (displayHandle) {
            GstContext *context = gst_wayland_display_handle_context_new(displayHandle);
            gst_element_set_context(GST_ELEMENT(GST_MESSAGE_SRC(message)), context);
        } else {
            g_warning("Should have obtained display_handle by now!\n");
        }
        gst_message_unref (message);
        return GST_BUS_DROP;
    }
#endif

    if (gst_is_video_overlay_prepare_window_handle_message(message)) {
        //if (windowHandle) {//TODO: Uncomment once set_window_handle() works well!
            GstVideoOverlay *overlay = GST_VIDEO_OVERLAY(GST_MESSAGE_SRC(message));

#if 0
            // FIXME: gst_video_overlay_set_window_handle() is used to provide a custom
            //        window to glimagesink. It is not really needed fr this demo application.
            gst_video_overlay_set_window_handle (overlay, (guintptr) windowHandle);
#endif
            gst_video_overlay_set_render_rectangle(overlay, 0, 0, videoWidth, videoHeight);
        //}

        gst_message_unref (message);
        return GST_BUS_DROP;
    }

    return GST_BUS_PASS;
}

/* -------------------------------------------------------------------------------------------- */
/* /////////////////////////////////////////// MAIN /////////////////////////////////////////// */
/* -------------------------------------------------------------------------------------------- */

int main(int argc, char *argv[])
{
    /* Environment variables */
    qputenv("QT_QPA_PLATFORM", "wayland");
    qputenv("QT_WAYLAND_SHELL_INTEGRATION", "xdg-shell"/*"wl-shell"*/);

    qputenv("GST_GL_WINDOW", "wayland");
    qputenv("GST_GL_PLATFORM", "egl");
    qputenv("GST_GL_API", "gles2");

    qputenv("GST_DEBUG", "*:2");
    qputenv("WAYLAND_DEBUG", "0"/*"1"*/);

    /* Qt main UI */
    QGuiApplication app(argc, argv);
    app.setOrganizationName("Demo");
    app.setOrganizationDomain("demo.com");
    app.setApplicationName("application3");

    QQmlApplicationEngine engine(QUrl("qrc:///Main.qml"));

#if 0
    // Get window and display handles. They will be used to tell the glimagesink to use our
    // custom window instead of the default one.
    // FIXME: This does not work yet
    QObject *rootObject              = engine.rootObjects().first();
    QWindow *window                  = qobject_cast<QWindow*>(rootObject);
    QPlatformNativeInterface *native = QGuiApplication::platformNativeInterface();

    displayHandle = (struct wl_display *)native->nativeResourceForIntegration("nativedisplay");//TODO: display?
    windowHandle  = static_cast<struct wl_surface *>(native->nativeResourceForWindow("eglsurface", window));//TODO: surface?
    qDebug("windowHandle = %p / displayHandle = %p", windowHandle, displayHandle);
#endif

    /* Video pipeline */
    gst_init (&argc, &argv);

    GstElement *pipeline = gst_parse_launch(videoPipeline, NULL);

    GstBus *bus = gst_pipeline_get_bus (GST_PIPELINE (pipeline));
    gst_bus_set_sync_handler (bus, (GstBusSyncHandler) busSyncHandler, NULL, NULL);
    gst_object_unref (bus);

    gst_element_set_state(pipeline, GST_STATE_PLAYING);

    return app.exec();
}
