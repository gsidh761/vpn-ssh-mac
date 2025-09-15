# VPN SSH Mac  
### One-command VPN start + SSH connection  

**Setup Guide**
1. You need to have Tunnelblick installed and configured to use the macovpn-config
2. Run the following command in Terminal:
```
wget https://raw.githubusercontent.com/gsidh761/vpn-ssh-mac/refs/heads/main/connect.sh
```
3. Edit the connect.sh file and replace $SSH_AUTH with your Mount Royal SSH auth (username@server)
4. Make the script executable:
```
chmod +x connect.sh
```

**For Your Convenience (Optional)**
1. Move the script to /usr/local/bin/:
```
sudo mv connect.sh /usr/local/bin/connect
```

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
