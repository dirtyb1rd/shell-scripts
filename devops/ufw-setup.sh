#!/bin/bash
# template: ufw rules for incus bridge

if [[ $(id -u) -ne 0 ]]; then
    echo "need root for ufw"
    exit 1
fi

# allow dhcp and dns on bridge
ufw allow in on labnet to any port 67 proto udp
ufw allow in on labnet to any port 53

# allow network traffic
ufw allow in on labnet from 10.10.10.0/24
ufw route allow in on labnet from 10.10.10.0/24
ufw route allow out on labnet to 10.10.10.0/24

echo "ufw configured for labnet"
