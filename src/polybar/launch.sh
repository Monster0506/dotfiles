#!/usr/bin/env bash

# Terminate already running bar instances
polybar-msg cmd quit
killall -q polybar

# Launch bar1
echo "---" | tee -a /tmp/polybar1.log
polybar bar1 >>/tmp/polybar1.log 2>&1 &
disown
echo "Bar1 launched..."
