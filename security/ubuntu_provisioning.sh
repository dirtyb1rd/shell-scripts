#!/bin/bash

set -e  # Exit on error

# Update system
echo "Updating system..."
sudo apt update && sudo apt upgrade -y

# Install base packages
echo "Installing base packages..."
sudo apt install -y neovim git tmux python3 python3-pip markitdown nmap apt-transport-https curl flatpak

# Add Flatpak repository (Flathub)
echo "Adding Flatpak repository (Flathub)..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Setup Brave Browser repository
echo "Setting up Brave Browser repository..."
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
echo "Installing Brave Browser..."
sudo apt install -y brave-browser

# Install Tailscale
echo "Installing Tailscale..."
curl -fsSL https://tailscale.com/install.sh | sh
sudo systemctl enable --now tailscaled

# Install ProtonVPN
echo "Installing ProtonVPN..."
sudo apt install -y protonvpn-cli

# Install Todoist and Obsidian using Flatpak
echo "Installing Flatpak applications..."
sudo flatpak install -y flathub com.todoist.Todoist md.obsidian.Obsidian

# Install PyCharm using Flatpak
echo "Installing PyCharm..."
sudo flatpak install -y flathub com.jetbrains.PyCharm-Community

# Install SecLists
echo "Installing SecLists..."
sudo apt install -y seclists

echo "Setup complete!"
