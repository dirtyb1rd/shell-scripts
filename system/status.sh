#!/usr/bin/env sh

# I use this with swaybar to generate a simple status line.
# I hide my status bar by default (I do not need it to look ).

DISPLAY=$(/home/bp/gh/shell-scripts/display.sh)
BATTERY=$(/home/bp/gh/shell-scripts/battery.sh)
BATTERY_STATUS=$(/home/bp/gh/shell-scripts/battery_status.sh)
MUTE=$(/home/bp/gh/shell-scripts/mute.sh)
VOLUME=$(/home/bp/gh/shell-scripts/volume.sh)
DATE=$(/home/bp/gh/shell-scripts/date_simple.sh)
CLOCK=$(/home/bp/gh/shell-scripts/clock.sh)

if [ "$MUTE" = "yes" ]; then
  AUDIO_EMOJI="🤫"
elif [ "$VOLUME" -lt "35" ]; then
  AUDIO_EMOJI="🔉"
else
  AUDIO_EMOJI="🔊"
fi

if [ "$BATTERY_STATUS" = "Charging" ]; then
  BATTERY_EMOJI="🔌"
elif [ "$BATTERY" -gt "20" ]; then
  BATTERY_EMOJI="🔋"
else
  BATTERY_EMOJI="🪫"
fi

DISPLAY_EMOJI="🔆"
DATE_EMOJI="📆"
CLOCK_EMOJI="⏰"

OUTPUT="$DISPLAY_EMOJI $DISPLAY | $AUDIO_EMOJI $VOLUME | $BATTERY_EMOJI $BATTERY | $DATE_EMOJI $DATE | $CLOCK_EMOJI $CLOCK"

echo $OUTPUT
