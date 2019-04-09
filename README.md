# Graphics compositing with wayland - glimagesink under Qml

## What?

Yet another demo project to show how to implement a wayland compositor using QtWayland.
It contains following components:

- A Qt-based wayland compositor that is capable of handling multiple displays on embedded linux
- Qt quick applications that render output of Gstreamer's glimagesink plugin under Qml
- A non Qt and non Gstreamer application which directly uses EGL and libwayland-client to help
  understanding how the wayland protocol works

## Why?

- It's hard to find code samples that help understanding how to use glimagesink under Qml
- Sometimes it may be necessary to just separate the main UI from the video part
- A more concrete Qt Wayland example that can be easily adapted to your needs

- A backup for myself that helps me remember how to do things:-)

## Note

This project has been implemented with glimagesink in mind but it should be applicable to other
wayland clients.
