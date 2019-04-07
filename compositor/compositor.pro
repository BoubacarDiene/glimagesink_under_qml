#////////////////////////////////////////////////////////////////////////////////////////////////#
#//                                                                                            //#
#//         Copyright © 2019 Boubacar DIENE <boubacar.diene@gmail.com>                         //#
#//                                                                                            //#
#//         This file is part of glimagesink_under_qml project.                                //#
#//                                                                                            //#
#//         glimagesink_under_qml is free software: you can redistribute it and/or             //#
#//         modify it under the terms of the GNU General Public License as published           //#
#//         by the Free Software Foundation, either version 2 of the License, or               //#
#//         (at your option) any later version.                                                //#
#//                                                                                            //#
#//         glimagesink_under_qml is distributed in the hope that it will be useful,           //#
#//         but WITHOUT ANY WARRANTY; without even the implied warranty of                     //#
#//         MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                      //#
#//         GNU General Public License for more details.                                       //#
#//                                                                                            //#
#//         You should have received a copy of the GNU General Public License                  //#
#//         along with glimagesink_under_qml. If not, see <http://www.gnu.org/licenses/>       //#
#//         or write to the Free Software Foundation, Inc., 51 Franklin Street,                //#
#//         51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.                      //#
#//                                                                                            //#
#////////////////////////////////////////////////////////////////////////////////////////////////#

TEMPLATE = app
TARGET = compositor
INCLUDEPATH += .

QT += quick
CONFIG += c++11 exceptions

# The following define makes your compiler warn you if you use any
# feature of Qt which has been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# .qml files as well as accompanying .js files can be translated into
# intermediate C++ source code.
# After compilation with a traditional compiler, the code is linked into
# the application binary. This entirely eliminates the need of deploying
# QML source code, it reduces the application startup time and allows for
# a much faster execution on platforms that do not permit Just-in-time
# compilation (See https://doc.qt.io/QtQuickCompiler/)
CONFIG += qtquickcompiler

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version
# of Qt.
DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000 # disables all the APIs
                                                 # deprecated before Qt 6.0.0

# Files
SOURCES += src/main.cpp

RESOURCES += qml/compositor.qrc
