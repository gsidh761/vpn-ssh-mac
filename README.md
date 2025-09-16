# VPN SSH Mac  
### One-command VPN start + SSH connection  

**Setup/Update Guide**
1. You need to have Tunnelblick installed and configured to use the macovpn-config
2. Run the following command in Terminal:
```
curl https://raw.githubusercontent.com/gsidh761/vpn-ssh-mac/refs/heads/main/install.sh --output install.sh && chmod +x install.sh && ./install.sh
```
3. Follow the script's instructions

**Quick Start:**  
``` 
./connect.sh 
```
or if moved (from anywhere):
```
connect 
```

**Todo:**  
1. Better detection system to check if the VPN has been disconnected or not
2. Check for SSH timeout?
3. Delete the install.sh file after the installation has been completed
