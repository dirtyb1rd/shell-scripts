#!/bin/bash

MUTE=$(pactl get-sink-mute "$(pactl get-default-sink)")
# == *"xyz"* checks str1 for substring str2 (regex)
if [[ "$MUTE" == *"yes"* ]]; then
    MUTE="  |  🤫🤫🤫"
else
    MUTE=""
fi

VOLUME=$(
    pactl get-sink-volume "$(pactl get-default-sink)" | 
    grep 'Volume:' |
    # sed extracts percentage
    sed -E 's/.*([0-9]{2}%).*/\1/'
)

echo $VOLUME
