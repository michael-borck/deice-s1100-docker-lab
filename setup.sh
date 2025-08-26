#!/bin/bash

echo "Setting up De-ICE S1.100 Docker Simulation with Kali Attacker..."

# Create directories
mkdir -p web-content ftp-data/incoming ssh-home attacker-tools lab-files

# Set permissions for FTP
chmod 755 ftp-data
chmod 755 ftp-data/incoming

echo "Starting De-ICE S1.100 simulation..."
docker compose up -d

echo ""
echo "De-ICE S1.100 Docker Simulation Ready!"
echo "====================================="
echo ""
echo "🎯 ATTACKER ACCESS:"
echo "docker exec -it de-ice-attacker bash"
echo ""
echo "🔧 AUTOMATED TOOLS (inside attacker):"
echo "/root/tools/recon.sh      - Automated reconnaissance"
echo "/root/tools/exploit.sh    - Automated exploitation"
echo ""
echo "🌐 TARGET SERVICES:"
echo "- HTTP:  http://target-web (or http://localhost)"
echo "- SSH:   ssh -p 2222 aadams@target-ssh (password: nostaw)"
echo "- FTP:   ftp target-ftp (anonymous access)"
echo "- SMTP:  telnet target-smtp 1025"
echo "- POP3:  telnet target-mail 110"
echo "- IMAP:  telnet target-mail 143"
echo "- Mail UI: http://target-smtp:8025 (or http://localhost:8025)"
echo ""
echo "📚 LEARNING OBJECTIVES:"
echo "1. Network discovery (nmap)"
echo "2. Web enumeration (curl, browser)"
echo "3. Service enumeration (nmap -sC -sV)"
echo "4. SSH brute force (hydra)"
echo "5. FTP exploration (anonymous login)"
echo "6. File decryption (openssl)"
echo ""
echo "🛑 Stop with: docker compose down"