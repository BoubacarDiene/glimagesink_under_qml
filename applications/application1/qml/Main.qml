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
import QtQuick.Controls 2.2

ApplicationWindow {
    id: mainWindow
    flags: Qt.FramelessWindowHint
    title: "app-control-ui"

    width: 740
    height: 530
    visible: true
    color: "transparent"
    
    Canvas {
        width: 500; height: 200
        contextType: "2d"
        anchors {horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter}

        Path {
            id: myPath
            startX: 0; startY: 100

            PathCurve { x: 75; y: 75 }
            PathCurve { x: 200; y: 150 }
            PathCurve { x: 325; y: 25 }
            PathCurve { x: 400; y: 100 }
        }

        onPaint: {
            context.strokeStyle = Qt.rgba(.4,.6,.8);
            context.path = myPath;
            context.lineWidth = 3;
            context.stroke();
        }
    }
    
    Text {
        text: "TEXT ON TOP"
        anchors.centerIn: parent
        color: "black"
        font.pixelSize: 15
    }
    
    Rectangle {
        id: rect
        width: 75
        height: 50
        color: "yellow"
        border.color: "black"
        border.width: 1
        radius: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 6
        anchors.left: parent.left
        anchors.leftMargin: 6
    }
	
    Button {
        text: "Click"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 6
        anchors.right: parent.right
        anchors.rightMargin: 6
        onClicked: rect.visible = false
    }
}
