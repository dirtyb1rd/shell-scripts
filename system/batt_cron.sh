#!/usr/bin/env bash

STATUS=$(cat /sys/class/power_supply/BAT0/status)
CHARGE=$(cat /sys/class/power_supply/BAT0/capacity)

# Detect and export the necessary variables for GUI notifications
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"

# (Optional) Sometimes needed for specific notification daemons
export DISPLAY=:0

if [ "$CHARGE" -lt "20" ] && [ "$STATUS" = "Discharging" ]; then
  fyi "🪫 Battery Low"
  echo "🪫 Battery Low"
else
  echo "Battery Fine"
fi
