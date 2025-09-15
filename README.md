# VPN SSH Mac  
### One-command VPN start + SSH connection  

**Setup Guide**
1. You need to have Tunnelblick installed and configured to use the macovpn-config
2. Run ```
wget https://raw.githubusercontent.com/gsidh761/vpn-ssh-mac/refs/heads/main/connect.sh
``` in Terminal (/Applications/Utilities/Terminal.app)
4. Edit the connect.sh file and replace $SSH_AUTH with your Mount Royal SSH auth (username@server)
5. Run chmod +x (drag the connect.sh file here) in Terminal (/Applications/Utilities/Terminal.app)

**For Your Convenience (Optional)**
1. Run mv (drag the connect.sh file here) /usr/local/bin/connect in Terminal (/Applications/Utilities/Terminal.app)

**Quick Start:**  
```
./connect.sh or connect
```
