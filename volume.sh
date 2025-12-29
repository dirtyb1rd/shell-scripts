#!/usr/bin/env sh

pactl get-sink-volume @DEFAULT_SINK@ | awk '/Volume/ {print $5}' | tr -d '%'
