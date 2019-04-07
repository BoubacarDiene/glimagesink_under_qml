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

import QtQuick 2.12

import com.demo.SurfaceManager 1.0

/**
 * This component provides two areas to display remote wayland clients' contents. Each area can
 * be used or not depending on "objectName" attribute (empty means not displayed):
 * - control: dedicated to the main UI
 * - stream: dedicated to the video stream
 *
 * It has been implemented with Gstreamer's glimagesink plugin in mind but should work the same
 * way with any other wayland clients. The component allows to split a wayland client into two
 * separated processes even if a single process can be used to handle both UI and streaming.
 *
 * Note:
 *   glimagesink plugin creates a default window with "OpenGL Renderer" as title when it is not
 *   explicitly told to use a custom window instead. That means the application can be implemented
 *   so that it
 *   - either sends one content (everything "composited" in the same Qml item)
 *   - or sends two distinct contents as if there were two applications
 */
Rectangle {
    id: root

    property Rectangle control
    property Rectangle stream

    // The UI part of the application (buttns, lines, ...)
    control: Rectangle {
        id: control
        objectName: ""
        parent: root

        width: 640
        height: 480
        z: 1
        anchors.centerIn: parent
        color: "transparent"
        visible: objectName != ""

        Connections {
            target: SurfaceManager
            onSurfaceCreated: {
                if (control.objectName != "" && clientId.endsWith(control.objectName))
                    SurfaceManager.newItem(control, surface, clientId)
            }
        }
    }

    // The video stream rendering occurs here
    stream: Rectangle {
        id: stream
        objectName: ""
        parent: root

        width: 320
        height: 240
        anchors.centerIn: parent
        color: "transparent"
        visible: objectName != ""

        Connections {
            target: SurfaceManager
            onSurfaceCreated: {
                if (stream.objectName != "" && clientId.endsWith(stream.objectName))
                    SurfaceManager.newItem(stream, surface, clientId)
            }
        }
    }
}
