#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar


# Launch bar1 and bar2
polybar -r -c ~/.config/polybar/config.ini main &
