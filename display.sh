#!/usr/bin/env dash

MAX_BRIGHTNESS=$(/usr/bin/cat /sys/class/backlight/intel_backlight/max_brightness)
ACTUAL_BRIGHTNESS=$(/usr/bin/cat /sys/class/backlight/intel_backlight/actual_brightness)

echo $(( (ACTUAL_BRIGHTNESS * 100) / MAX_BRIGHTNESS))
