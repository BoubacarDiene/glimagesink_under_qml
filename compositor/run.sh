#!/bin/bash

set -e

export QTVER=qt5.12
export QTDIR=/opt/qt/$QTVER
export PATH=$QTDIR/bin/:$PATH
export LD_LIBRARY_PATH=$QTDIR/lib/:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=$QTDIR/lib/pkgconfig/:$PKG_CONFIG_PATH
export QT_PLUGIN_PATH=$QTDIR/lib/plugins/

#export QT_QPA_PLATFORM=xcb
#export QT_QPA_PLATFORM=eglfs
#export QT_QPA_EGLFS_INTEGRATION=eglfs_kms_vsp2
#export QT_QPA_EGLFS_INTEGRATION=eglfs_x11

#export QT_QPA_EGLFS_DEBUG=qt.qpa.*=true
#export QT_LOGGING_RULES=qt.qpa.*=true

./compositor -platform xcb
