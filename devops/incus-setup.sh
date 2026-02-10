#!/bin/bash
# template: incus setup helper

# check if we have root
if [[ $(id -u) -ne 0 ]]; then
    echo "need root for incus socket"
    exit 1
fi

# install if missing
if ! command -v incus &> /dev/null; then
    echo "incus not found, installing..."
    apt update && apt install -y incus
fi

# init with defaults
incus admin init --auto

# create storage if needed
if ! incus storage list | grep -q "default"; then
    incus storage create default dir
fi

echo "incus ready"
