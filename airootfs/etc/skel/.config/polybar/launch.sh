#!/usr/bin/env bash
# launch.sh — Polybar launcher for Xeno OS
# Called from bspwmrc on startup and on monitor hotplug

# Kill any running polybar instances
killall -q polybar 2>/dev/null

# Wait for processes to shut down
while pgrep -u "$UID" -x polybar > /dev/null; do
    sleep 0.1
done

# Launch bar on every connected monitor
if type "xrandr" > /dev/null 2>&1; then
    for monitor in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR="$monitor" polybar --reload xeno-bar \
            --config="$HOME/.config/polybar/config.ini" \
            2>&1 | tee -a /tmp/polybar-"$monitor".log &
        disown
    done
else
    polybar --reload xeno-bar \
        --config="$HOME/.config/polybar/config.ini" \
        2>&1 | tee -a /tmp/polybar.log &
    disown
fi

echo "Polybar launched."
