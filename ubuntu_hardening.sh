#!/bin/bash

# 1. Update all installed packages to the latest versions
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# 2. Enable and start the firewall (UFW - Uncomplicated Firewall)
echo "Enabling and configuring UFW..."
sudo apt install ufw -y
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw enable

# 3. Enable AppArmor for additional access control
echo "Ensuring AppArmor is enabled..."
sudo apt install apparmor apparmor-utils -y
sudo systemctl enable --now apparmor

# 4. Enable automatic security updates
echo "Enabling automatic security updates..."
sudo apt install unattended-upgrades -y
sudo dpkg-reconfigure --priority=low unattended-upgrades

# 5. Install and enable auditd for monitoring
echo "Installing and enabling auditd..."
sudo apt install auditd -y
sudo systemctl enable --now auditd

# 6. Disable unused services (e.g., bluetooth, cups, etc.)
echo "Disabling unused services..."
sudo systemctl disable --now bluetooth
sudo systemctl disable --now cups

# 7. Set up a strong password policy using libpam-pwquality
echo "Configuring strong password policy..."
sudo apt install libpam-pwquality -y
sudo sed -i '/pam_pwquality.so/ s/$/ minlen=14 difok=4 retry=3/' /etc/pam.d/common-password

# 8. Disable root login via SSH
echo "Disabling root login via SSH..."
sudo sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# 9. Configure system to use a secure kernel (enable randomization)
echo "Configuring kernel randomization..."
echo "kernel.randomize_va_space = 2" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# 10. Install fail2ban to prevent brute force attacks
echo "Installing fail2ban..."
sudo apt install fail2ban -y
sudo systemctl enable --now fail2ban

# 11. Enable automatic logout for idle users
echo "Enabling automatic logout for idle users..."
echo "TMOUT=600" | sudo tee -a /etc/profile

# 12. Secure the GRUB bootloader
echo "Securing GRUB bootloader..."
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo grub-set-password

# 13. Enforce file permissions and set proper umask
echo "Enforcing proper file permissions and umask..."
echo "umask 027" | sudo tee -a /etc/profile

# 14. Limit the number of login attempts via SSH
echo "Limiting login attempts via SSH..."
echo "MaxAuthTries 3" | sudo tee -a /etc/ssh/sshd_config
sudo systemctl restart sshd

echo "Ubuntu system hardening completed!"
