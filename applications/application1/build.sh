#!/bin/bash

set -e

export QTVER=qt5.12
export QTDIR=/opt/qt/$QTVER
export PATH=$QTDIR/bin/:$PATH
export LD_LIBRARY_PATH=$QTDIR/lib/:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=$QTDIR/lib/pkgconfig/:$PKG_CONFIG_PATH
export QT_PLUGIN_PATH=$QTDIR/lib/plugins/

if [ ! -f application1.pro ]; then
	qmake -project
fi
qmake application1.pro
make
