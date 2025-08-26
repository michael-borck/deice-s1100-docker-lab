# Windows Setup Guide

## Prerequisites

1. **Install Docker Desktop for Windows**
   - Download from: https://www.docker.com/products/docker-desktop/
   - Ensure WSL2 backend is enabled
   - Start Docker Desktop

2. **Install Git for Windows** (if not already installed)
   - Download from: https://git-scm.com/download/win
   - Use Git Bash for commands

## Setup Instructions

### Option 1: Using PowerShell
```powershell
# Clone the repository
git clone https://github.com/michael-borck/deice-s1100-docker-lab.git
cd deice-s1100-docker-lab

# Start the lab
docker compose up -d

# Access the attacker container
docker exec -it de-ice-attacker bash
```

### Option 2: Using Git Bash
```bash
# Clone the repository  
git clone https://github.com/michael-borck/deice-s1100-docker-lab.git
cd deice-s1100-docker-lab

# Start the lab
docker compose up -d

# Access the attacker container
docker exec -it de-ice-attacker bash
```

### Option 3: Using Command Prompt
```cmd
REM Clone the repository
git clone https://github.com/michael-borck/deice-s1100-docker-lab.git
cd deice-s1100-docker-lab

REM Start the lab
docker compose -f de-ice-simple.yml up -d

REM Access the attacker container
docker exec -it de-ice-attacker bash
```

## Verification

Check that all containers are running:
```bash
docker ps
```

You should see 6 containers:
- de-ice-attacker
- de-ice-web
- de-ice-ssh
- de-ice-ftp
- de-ice-smtp  
- de-ice-mail

## Lab Access

Once in the attacker container, run:
```bash
# Verify you're in Kali Linux
whoami
cat /etc/os-release

# Start reconnaissance
/root/tools/recon.sh
```

## Cleanup

To stop the lab:
```bash
docker compose down
```

## Troubleshooting

### Docker Desktop Not Running
- Start Docker Desktop application
- Wait for it to fully initialize

### Permission Errors
- Run PowerShell or Command Prompt as Administrator
- Ensure your user is in the "docker-users" group

### WSL2 Issues
- Ensure WSL2 is installed and set as default
- Update WSL2: `wsl --update`

### Port Conflicts
If ports are already in use:
```bash
# Stop any conflicting services
docker compose down
docker system prune -f

# Restart the lab
docker compose -f de-ice-simple.yml up -d
```