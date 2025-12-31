#!/usr/bin/env bash

STATUS=$(cat /sys/class/power_supply/BAT0/status)
CHARGE=$(cat /sys/class/power_supply/BAT0/capacity)

if [ "$CHARGE" -lt "20" ] && [ "$STATUS" = "Discharging" ]; then
  fyi "🪫 Battery Low"
else
  :
fi
