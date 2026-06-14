#!/bin/sh
# Force xcb (XWayland) on Wayland to allow mouse locking/warping to work correctly in the 3D viewport.
export QT_QPA_PLATFORM=xcb
exec /app/bin/Mine-imator "$@"
