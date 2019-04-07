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

import QtQuick 2.6
import QtQuick.Window 2.3
import QtWayland.Compositor 1.3

import com.demo.SurfaceManager 1.0

WaylandCompositor {
    id: wlcompositor

    WaylandOutput {
        compositor: wlcompositor
        sizeFollowsWindow: true

        window: Window {
            width: 740
            height: 530
            visible: true
            color: "#bbb2ba"

            Streamer {
                control {
                    objectName: "app-control-ui"
                    width: parent.width
                    height: parent.height
                }
                stream {objectName: "OpenGL Renderer"; width: 540; height: 380}
                anchors.centerIn: parent
            }

            // Enable the following to make the output target an actual screen,
            // for example when running on eglfs in a multi-display embedded system.

            // screen: Qt.application.screens[0]
        }
    }

    WaylandOutput {
        compositor: wlcompositor
        sizeFollowsWindow: true

        window: Window {
            width: 540
            height: 380
            visible: true
			
            Streamer {
                stream {
                    objectName: "OpenGL Renderer"
                    width: parent.width
                    height: parent.height
                    color: "red"
                }
                anchors.centerIn: parent
            }

            // Enable the following to make the output target an actual screen,
            // for example when running on eglfs in a multi-display embedded system.

            // screen: Qt.application.screens[1]
        }
    }

    XdgShell {
        onToplevelCreated: {
            SurfaceManager.newShellSurface(
                toplevel,
                xdgSurface.surface,
                function(){return toplevel.title},
                function(){return toplevel.titleChanged}
            )
        }
    }
    
    WlShell {
        onWlShellSurfaceCreated: {
            SurfaceManager.newShellSurface(
                shellSurface,
                shellSurface.surface,
                function(){return shellSurface.title},
                function(){return shellSurface.titleChanged}
            )
        }
    }
}
