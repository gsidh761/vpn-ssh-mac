#!/bin/bash

# Gsidh761

sudo 

clear 
echo "Starting VPN Service..."

free_port

# Start VPN Service
osascript -e 'tell application "Tunnelblick"
    disconnect "macovpn-config"
    delay 2
    connect "macovpn-config"
end tell'
if [ $? -eq 0 ]; then
    echo "VPN Has Been Connected. Proceeding..."
else
    echo "VPN Has Not Been Connected. Quitting..."
    exit 1
fi

sleep 5

# Free Any Open Ports (:22)
free_port(){
    echo "Killing Any Pid's On Port 22 (SSH)"
    sudo lsof -ti :22 | xargs sudo kill -9 2>/dev/null
	sudo ps aux | grep '[o]penvpn' | awk '{print $2}' | xargs sudo kill -9
}

# Quit Tunnelblick
quit_vpn_app(){
    killall -9 "Tunnelblick" 2>/dev/null
}

# Cleanup After The Program Has Halted
cleanup() {
    echo
    echo "Stopping VPN Service..."
    osascript -e 'tell application "Tunnelblick" to disconnect all' 2>/dev/null
	sudo ps aux | grep '[o]penvpn' | awk '{print $2}' | xargs sudo kill -9
	
    if [ $? -eq 0 ]; then
        echo "VPN Has Been Disconnected. Quitting Program..."
        free_port
        quit_vpn_app
        exit 0
    else
        echo "VPN Is Still Connected. Quitting VPN Application..."
	quit_vpn_app
    fi
}

# Makes Sure The Cleanup Function Is Run After Pressing CTRL + Key & Any Other Exit Methods
trap cleanup SIGINT SIGTSTP EXIT

sleep 2
clear

# Starts SSH 

clear
echo "SSH Connecting..."

ssh $SSH_AUTH -o ConnectTimeout=25
