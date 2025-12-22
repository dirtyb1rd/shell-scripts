#!/usr/bin/env dash

pactl get-sink-volume @DEFAULT_SINK@ | awk '/Volume/ {print $5}' | tr -d '%'
