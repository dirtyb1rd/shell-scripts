#!/bin/bash

#TryHackMe VPN Setup
echo 'Do you have a TryHackMe.com VPN profile to set up? Answer (y/n) (If so please make sure it is in your downloads folder.)'
read vpn
if [[ $vpn =~ ^[Yy]$ ]];
then
echo 'Hello, please provide THM username, this will be user to find your THM vpn profile in your downloads folder at ~/Downloads/^USERNAME^.ovpn'
read thm
mkdir ~/Documents/thmvpn
mv ~/Downloads/$thm.ovpn ~/Documents/thmvpn/$thm.ovpn
echo "alias thmvpn='sudo openvpn ~/Documents/"$thm".ovpn'" >> ~/.bashrc
echo "alias thmvpn='sudo openvpn ~/Documents/"$thm".ovpn'" >> ~/.zshrc
echo 'Your VPN alias is now setup, in order to connect, do the following: type thmvpn into the command line in a bash or zshell and enter password when prompted.'
else
echo 'Please run this script again when you have your THM VPN profile in your Downloads folder. Goodbye.'
fi
