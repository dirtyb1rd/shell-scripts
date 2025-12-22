#!/usr/bin/env dash

pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}'
