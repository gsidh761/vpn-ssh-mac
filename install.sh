#!/bin/bash

# VPN SSH Mac Automated Installer
# This script installs the VPN SSH connect script, makes it executable,
# optionally moves it to /usr/local/bin, and sets up the SSH user.

# Function to check if Tunnelblick is installed
check_tunnelblick() {
    if [ ! -d "/Applications/Tunnelblick.app" ]; then
        echo "Tunnelblick is not installed. Please install it first from https://tunnelblick.net/"
        exit 1
    fi
}

# Ask for SSH username
read -p "Enter your Mount Royal SSH username and server (e.g., user@server): " SSH_USER

# Check Tunnelblick
check_tunnelblick

# Download connect.sh
echo "Downloading connect.sh..."
curl https://raw.githubusercontent.com/gsidh761/vpn-ssh-mac/refs/heads/main/connect.sh --output connect.sh

# Replace placeholder with SSH user
echo "Setting SSH_USER in script..."
sed -i '' "s|\$SSH_AUTH|$SSH_USER|g" connect.sh

# Make executable
chmod +x connect.sh

# Ask if user wants to move it to /usr/local/bin
read -p "Move script to /usr/local/bin/connect for global access? (y/n): " MOVE_CHOICE
if [[ "$MOVE_CHOICE" == "y" || "$MOVE_CHOICE" == "Y" ]]; then
    sudo mv connect.sh /usr/local/bin/connect
    echo "Script moved to /usr/local/bin/connect. You can now run it from anywhere with 'connect'."
else
    echo "Keep script in current directory. Run it using './connect.sh'."
fi

echo "Installation complete. Quick start:"
if [[ "$MOVE_CHOICE" == "y" || "$MOVE_CHOICE" == "Y" ]]; then
    echo "connect"
else
    echo "./connect.sh"
fi

# Asks if the user would like to delete the script installer
read -p "Delete installation script (y/n): " DELETE_CHOICE
if [[ "$DELETE_CHOICE" == "y" || "$DELETE_CHOICE" == "Y" ]]; then
    echo "Installer script deleted."
    rm install.sh
fi

