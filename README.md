# De-ICE S1.100 Docker Simulation

This Docker project simulates the VulnHub De-ICE S1.100 vulnerable machine using **pull-only images** with a dedicated Kali Linux attacker container.

## Quick Start

**All Platforms (Linux/Mac/Windows):**
```bash
docker compose -f de-ice-simple.yml up -d
docker exec -it de-ice-attacker bash
```

**Optional (Linux/Mac only):**
```bash
./setup.sh
```

## Architecture

**Pull-only approach** using mature Docker images:
- **Attacker**: Kali Linux with penetration testing tools
- **Web**: Apache HTTP server (httpd:2.4)
- **SSH**: LinuxServer OpenSSH with weak credentials
- **FTP**: Fauria VSFtpd with anonymous access
- **Mail**: MailHog SMTP + Dovecot POP3/IMAP

## Lab Network
All containers run in isolated network (192.168.100.0/24)

## Target Services

| Service | Container | Internal Access | External Access |
|---------|-----------|-----------------|-----------------|
| HTTP | target-web | http://target-web | http://localhost |
| SSH | target-ssh | ssh -p 2222 user@target-ssh | ssh -p 2222 user@localhost |
| FTP | target-ftp | ftp target-ftp | ftp localhost |
| SMTP | target-smtp | telnet target-smtp 1025 | telnet localhost 1025 |
| POP3 | target-mail | telnet target-mail 110 | telnet localhost 110 |
| IMAP | target-mail | telnet target-mail 143 | telnet localhost 143 |
| MailHog UI | target-smtp | http://target-smtp:8025 | http://localhost:8025 |

## Vulnerable Credentials

- **SSH**: `aadams:nostaw`
- **FTP**: Anonymous access enabled
- **Encrypted file password**: `HeadOfSecurity`

## Learning Path

**Attach to attacker container:**
```bash
docker exec -it de-ice-attacker bash
```

**Inside the Kali container:**

1. **Automated recon**: `/root/tools/recon.sh`
2. **Manual enumeration**: `nmap -sC -sV target-web`
3. **FTP exploration**: `ftp target-ftp` (anonymous/anonymous)
4. **SSH brute force**: `hydra -L users.txt -P passwords.txt target-ssh ssh -s 2222`
5. **Exploitation**: `/root/tools/exploit.sh`

See `pentest-guide.md` for detailed walkthrough.

## Benefits over Custom Build

✅ **Fast deployment** (pull vs build)  
✅ **Small footprint** (optimized images)  
✅ **Reliable** (maintained upstream images)  
✅ **Simple** (no complex Dockerfile)  

## Platform-Specific Setup

- **Windows users:** See [WINDOWS-SETUP.md](WINDOWS-SETUP.md) for detailed instructions
- **Linux/Mac users:** Can use `./setup.sh` for automated setup with helpful output

## Cleanup

```bash
docker compose -f de-ice-simple.yml down
```

## Security Notice

**Educational use only in isolated lab environments.**