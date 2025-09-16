#!/bin/bash

# Gsidh761

clear 
echo "Restarting Network Service..."
networksetup -setairportpower en0 off && networksetup -setairportpower en0 on
echo ""

# Wait for Wi-Fi to come online
echo "Checking Wi-Fi status..."
TRIES=0
MAX_TRIES=15 
while true; do
    WIFI_STATUS=$(networksetup -getairportpower en0 | awk '{print $4}')
    if [ "$WIFI_STATUS" = "On" ]; then
        echo "Wi-Fi is ON. Proceeding..."
        break
    fi

    TRIES=$((TRIES+1))
    if [ $TRIES -ge $MAX_TRIES ]; then
        echo "Wi-Fi did not come online in time. Quitting..."
        exit 1
    fi

    echo "Wi-Fi is OFF. Retrying in 2s..."
    sleep 2
done
echo ""

echo "Starting VPN Service..."
osascript -e 'tell application "Tunnelblick" to connect "macovpn-config"' 2>/dev/null

# Wait until VPN is actually connected
TRIES=0
MAX_TRIES=20  
while true; do
    VPN_STATUS=$(scutil --nc status "macovpn-config" 2>/dev/null | head -n1)
    if [ "$VPN_STATUS" = "Connected" ]; then
        echo "VPN is CONNECTED. Proceeding..."
        break
    fi

    TRIES=$((TRIES+1))
    if [ $TRIES -ge $MAX_TRIES ]; then
        echo "VPN did not connect in time. Quitting..."
        exit 1
    fi

    echo "Waiting for VPN to connect... (status: $VPN_STATUS)"
    sleep 2
done

# Free Any Open Ports (:22)
free_port(){
    echo "Killing Any Pid's On Port 22 (SSH)"
    sudo lsof -ti :22 | xargs sudo kill -9 2>/dev/null
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

free_port

# Starts SSH 
clear
echo "SSH Connecting..."

ssh $SSH_AUTH -o ConnectTimeout=25 -o BatchMode=yes -o StrictHostKeyChecking=no
