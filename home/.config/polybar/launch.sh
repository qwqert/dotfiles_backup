#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch i3bar
polybar i3bar 2>&1 & disown

echo "Bars launched..."
