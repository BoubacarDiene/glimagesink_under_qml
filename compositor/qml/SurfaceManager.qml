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

pragma Singleton

import QtQuick 2.12
import QtWayland.Compositor 1.3

/**
 * This component provides functions to handle wayland shell surfaces and create Qml items
 * to display. Items are created only when requested depending on clientId. The compositor
 * relies on this latter to differentiate wayland clients so as to redirect their contents
 * to the right display screens.
 */
Item {
    id: root

    /**
     * Signal to notify Streamer.qml about the newly created shell surface.
     *
     * Creating Qml items is under Streamer.qml's responsibility. That depends on how its
     * users have configured it (E.g. Main.qml).
     */
    signal surfaceCreated(WaylandSurface surface, string clientId)

    /**
     * WaylandQuickItem is defined inside a Component so that an explicit request is required
     * to instantiate it by a newItem() function call.
     */
    Component {
        id: component
        WaylandQuickItem {
            onSurfaceDestroyed: destroy()
        }
    }

    /**
     * Create a new WaylandQuickItem that rendered to the provided surface.
     * It must be "attached" to the given parent.
     */
    function newItem(parent, surface, clientId) {
        console.log("New WaylandQuickItem requested by client: " + clientId)
        return component.createObject(parent, {"surface": surface});
    }

    /**
     * This function is called when a new shell surface has been created.
     * It has been tested with following shell extensions: WlShell, XdgShell
     *
     * In Wayland protocol, the set_title() and set_app_id() calls are performed after
     * the create_surface() request. As this compositor relies on the title (could be
     * the appId or any other unique id to identify the wayland clients), it's important
     * to always ensure that the given clientId is set and to bind to the titleChanged
     * event if not.
     */
    function newShellSurface(shell, surface, clientId, appEvent) {
        if (clientId() === "")
            appEvent().connect(function() {shellSurfaceCreated(surface, clientId())})
        else
            shellSurfaceCreated(surface, clientId())
    }

    /**
     * This function is in charge of notifying the modules that will then call the newItem()
     * function when necessary. It is called once a valid clientId is set.
     */
    function shellSurfaceCreated(surface, clientId) {
        console.log("Surface created: { "
                    + "clientId: " + clientId
                    + "; processId: " + surface.client.processId + " }")

        surfaceCreated(surface, clientId)
    }
}
