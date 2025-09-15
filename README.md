# VPN SSH Mac

### One-command VPN start + SSH connection

**Setup Guide**

1. You need to have Tunnelblick installed and configured to use the macovpn-config

2. ```bash
wget https://raw.githubusercontent.com/gsidh761/vpn-ssh-mac/refs/heads/main/connect.sh
```

in Terminal (/Applications/Utilities/Terminal.app)
3\. Edit the connect.sh file and replace \$SSH\_AUTH with your Mount Royal SSH auth (username\@server)
4\. Run

```bash
chmod +x /path/to/connect.sh
```

in Terminal (/Applications/Utilities/Terminal.app)

**For Your Convenience (Optional)**

1. Run

```bash
mv /path/to/connect.sh /usr/local/bin/connect
```

in Terminal (/Applications/Utilities/Terminal.app)

**Quick Start:**

```bash
./connect.sh
```

or if moved to /usr/local/bin

```bash
connect
```
