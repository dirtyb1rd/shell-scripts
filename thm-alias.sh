#!/bin/bash

#By Ben Paris

#TryHackMe VPN Setup

#Check for download
echo 'Do you have a TryHackMe.com VPN profile to set up? Answer (y/n) (If so please make sure it is in your downloads folder.)'
read vpn
if [[ $vpn =~ ^[Yy]$ ]];
then

#Get name in order to find file
echo 'Hello, please provide THM username, this will be user to find your THM vpn profile in your downloads folder at ~/Downloads/^USERNAME^.ovpn'
read thm

#Make dir. and move vpn file into it
mkdir ~/Documents/thmvpn
mv ~/Downloads/$thm.ovpn ~/Documents/thmvpn/$thm.ovpn

#Add connection command to bash adn zsh rc file
echo "alias thmvpn='sudo openvpn ~/Documents/"$thm".ovpn'" >> ~/.bashrc
echo "alias thmvpn='sudo openvpn ~/Documents/"$thm".ovpn'" >> ~/.zshrc
echo 'Your VPN alias is now setup, in order to connect, do the following: type thmvpn into the command line in a bash or zshell and enter password when prompted.'

#If not
else
echo 'Please run this script again when you have your THM VPN profile in your Downloads folder. Goodbye.'
fi
