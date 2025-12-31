#!/bin/bash

# Check if Redshift is already running
if pgrep -x "redshift" > /dev/null
then
    fyi "Redshift is already running."
else
    fyi "Redshift is not running. Starting Redshift..."
    redshift & # Start Redshift in the background
fi
