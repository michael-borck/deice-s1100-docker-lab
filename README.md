> [!NOTE]
> **This repository is archived and read-only.**
>
> It has been superseded by [**ethical-hacking-docker-labs**](https://github.com/michael-borck/ethical-hacking-docker-labs), where this lab is maintained as [`labs/week8`](https://github.com/michael-borck/ethical-hacking-docker-labs/tree/main/labs/week8). The maintained version pulls the prebuilt `ghcr.io/michael-borck/ethical-base` image rather than installing tools at container start. `STUDENT-WORKSHEET.md` now lives there as `LAB-GUIDE.md`, and `INSTRUCTOR-WALKTHROUGH.md` as `WALKTHROUGH.md`.
>
> Please use the lab series instead. This repository is preserved for reference only.

# De-ICE S1.100 Docker Simulation

<!-- BADGES:START -->
[![cybersecurity](https://img.shields.io/badge/-cybersecurity-f44336?style=flat-square)](https://github.com/topics/cybersecurity) [![docker](https://img.shields.io/badge/-docker-2496ed?style=flat-square)](https://github.com/topics/docker) [![edtech](https://img.shields.io/badge/-edtech-4caf50?style=flat-square)](https://github.com/topics/edtech) [![ethical-hacking](https://img.shields.io/badge/-ethical--hacking-blue?style=flat-square)](https://github.com/topics/ethical-hacking) [![html](https://img.shields.io/badge/-html-e34f26?style=flat-square)](https://github.com/topics/html) [![kali-linux](https://img.shields.io/badge/-kali--linux-blue?style=flat-square)](https://github.com/topics/kali-linux) [![penetration-testing](https://img.shields.io/badge/-penetration--testing-blue?style=flat-square)](https://github.com/topics/penetration-testing) [![security-lab](https://img.shields.io/badge/-security--lab-blue?style=flat-square)](https://github.com/topics/security-lab) [![vulnerability-assessment](https://img.shields.io/badge/-vulnerability--assessment-blue?style=flat-square)](https://github.com/topics/vulnerability-assessment) [![vulnhub](https://img.shields.io/badge/-vulnhub-blue?style=flat-square)](https://github.com/topics/vulnhub)
<!-- BADGES:END -->

This Docker project simulates the VulnHub De-ICE S1.100 vulnerable machine using **pull-only images** with a dedicated Kali Linux attacker container.

## Quick Start

**All Platforms (Linux/Mac/Windows):**
```bash
docker compose up -d
docker exec -it de-ice-attacker bash
```

## Architecture

**Pull-only approach** using mature Docker images:
- **Attacker**: Kali Linux with penetration testing tools
- **Web**: Apache HTTP server (httpd:2.4)
- **SSH**: LinuxServer OpenSSH with weak credentials
- **FTP**: Fauria VSFtpd with anonymous access
- **Mail**: MailHog SMTP + Dovecot POP3/IMAP

## Lab Network
All containers run in isolated network (172.20.0.0/24)

## Target Services

| Service | Container | Internal Access | External Access |
|---------|-----------|-----------------|-----------------|
| HTTP | target-web | http://target-web | http://localhost |
| SSH | target-ssh | ssh user@172.20.0.3 | ssh -p 2222 user@localhost |
| FTP | target-ftp | ftp target-ftp | ftp localhost |
| SMTP | target-smtp | telnet target-smtp 1025 | telnet localhost 1025 |
| POP3 | target-mail | telnet target-mail 110 | telnet localhost 110 |
| IMAP | target-mail | telnet target-mail 143 | telnet localhost 143 |
| MailHog UI | target-smtp | http://target-smtp:8025 | http://localhost:8025 |

## Vulnerable Credentials

- **SSH**: `aadams:smadaa`
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
4. **SSH brute force**: `hydra -L users.txt -P passwords.txt 172.20.0.3 ssh`
5. **Exploitation**: `/root/tools/exploit.sh`

## Documentation

- [INSTRUCTOR-WALKTHROUGH.md](INSTRUCTOR-WALKTHROUGH.md) - Complete answer key for instructors
- [STUDENT-WORKSHEET.md](STUDENT-WORKSHEET.md) - Student lab worksheet  
- [PENETRATION-TESTING-STRATEGY.md](PENETRATION-TESTING-STRATEGY.md) - Educational methodology guide
- [COMMAND-REFERENCE.md](COMMAND-REFERENCE.md) - Plain English explanation of all commands used
- [LINUX-BASICS.md](LINUX-BASICS.md) - Essential Linux crash course for beginners

## Benefits over Custom Build

✅ **Fast deployment** (pull vs build)  
✅ **Small footprint** (optimized images)  
✅ **Reliable** (maintained upstream images)  
✅ **Simple** (no complex Dockerfile)  

## Platform-Specific Setup

- **All platforms:** Standard Docker Compose commands work universally

## Cleanup

```bash
docker compose down
```

## Security Notice

**Educational use only in isolated lab environments.**