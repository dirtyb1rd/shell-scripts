#!/bin/bash

# ==============================================================================
# DIRTYFETCH - A lightweight, pure bash system info fetcher
# Defaults: No Color, No ASCII.
# Usage: ./dirtyfetch.sh [--ascii] [--color]
# ==============================================================================

# --- 1. CONFIGURATION & DEFAULTS ---
SHOW_ASCII=false
SHOW_COLOR=false

# Custom "Dirty Bird" ASCII Art
# Note: We use an array for line-by-line printing
read -r -d '' DIRTY_BIRD_ART <<'EOF'

.______________
/____#ascii____
| ______art____
| | |____is____
| |/___cool____
|  \___________
|______________

EOF

# --- 2. ARGUMENT PARSING ---
for arg in "$@"; do
    case $arg in
        -a|--ascii)
            SHOW_ASCII=true
            ;;
        -c|--color)
            SHOW_COLOR=true
            ;;
        -h|--help)
            echo "Usage: $0 [--ascii] [--color]"
            exit 0
            ;;
    esac
done

# --- 3. COLOR DEFINITIONS ---
# If color is enabled, set ANSI codes. Otherwise, set them to empty strings.
if [ "$SHOW_COLOR" = true ]; then
    BOLD="\e[1m"
    RESET="\e[0m"
    c_user="\e[32m" # Green
    c_os="\e[34m"   # Blue
    c_host="\e[35m" # Magenta
    c_kern="\e[36m" # Cyan
    c_up="\e[33m"   # Yellow
    c_shell="\e[31m" # Red
    c_mem="\e[37m"  # White
else
    BOLD=""
    RESET=""
    c_user=""
    c_os=""
    c_host=""
    c_kern=""
    c_up=""
    c_shell=""
    c_mem=""
fi

# --- 4. DATA GATHERING ---

# User and Host
MY_USER=$USER
MY_HOST=$HOSTNAME

# OS Name
if [ -f /etc/os-release ]; then
    # Source the file to get the variables
    . /etc/os-release
    MY_OS=$PRETTY_NAME
else
    MY_OS=$(uname -o)
fi

# Kernel
MY_KERNEL=$(uname -r)

# Uptime
# Parse /proc/uptime (first field is seconds up)
if [ -f /proc/uptime ]; then
    upt_secs=$(awk '{print int($1)}' /proc/uptime)
    upt_hours=$((upt_secs / 3600))
    upt_mins=$(( (upt_secs % 3600) / 60 ))
    MY_UPTIME="${upt_hours}h ${upt_mins}m"
else
    MY_UPTIME="Unknown"
fi

# Shell (basename of the shell path)
MY_SHELL=$(basename "$SHELL")

# Memory Usage
# Parse /proc/meminfo for MemTotal and MemAvailable/MemFree
if [ -f /proc/meminfo ]; then
    mem_total=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
    # Try MemAvailable first (newer kernels), fallback to MemFree
    mem_avail=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)
    if [ -z "$mem_avail" ]; then
        mem_avail=$(awk '/MemFree/ {print $2}' /proc/meminfo)
    fi
    # Calculate in GiB with 1 decimal point
        MY_MEM=$(awk -v t="$mem_total" -v a="$mem_avail" 'BEGIN {
            printf "%.1f / %.1f GB", (t-a)/1048576, t/1048576
        }')    
else
    MY_MEM="Unknown"
fi

# --- 5. OUTPUT CONSTRUCTION ---

# Build the info lines array
INFO_LINES=(
    "${c_user}${MY_USER}${RESET}@${c_host}${MY_HOST}${RESET}"
    "-------------------"
    "${BOLD}OS${RESET}:     ${c_os}${MY_OS}${RESET}"
    "${BOLD}Kernel${RESET}: ${c_kern}${MY_KERNEL}${RESET}"
    "${BOLD}Uptime${RESET}: ${c_up}${MY_UPTIME}${RESET}"
    "${BOLD}Shell${RESET}:  ${c_shell}${MY_SHELL}${RESET}"
    "${BOLD}Memory${RESET}: ${c_mem}${MY_MEM}${RESET}"
)

# --- 6. DISPLAY LOGIC ---

if [ "$SHOW_ASCII" = true ]; then
    # Convert string block to array
    IFS=$'\n' read -rd '' -a ASCII_LINES <<< "$DIRTY_BIRD_ART"
    
    # Determine the wider of the two arrays (Info vs ASCII) to loop correctly
    MAX_LINES=${#ASCII_LINES[@]}
    if [ ${#INFO_LINES[@]} -gt $MAX_LINES ]; then
        MAX_LINES=${#INFO_LINES[@]}
    fi

    # Print Side-by-Side
    for ((i=0; i<MAX_LINES; i++)); do
        # Get ASCII line or empty padding if we ran out of ascii lines
        A_LINE="${ASCII_LINES[i]}"
        # Ensure consistent padding for ASCII column (approx 15 chars wide)
        printf "%-18s" "$A_LINE"
        
        # Print Info line
        echo -e "${INFO_LINES[i]}"
    done
else
    # Simple Mode: Just print the info
    for line in "${INFO_LINES[@]}"; do
        echo -e "$line"
    done
fi

echo ""
