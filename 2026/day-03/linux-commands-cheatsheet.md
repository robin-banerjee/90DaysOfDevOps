# Linux Commands Cheat Sheet

## Process Management Commands

| Command | Usage |
|---|---|
| `ps aux` | Display full snapshot of running processes on your system |
| `top` | Display real-time sorted information about system processes |
| `htop` | Interactive process viewer |
| `kill PID` | Kill a process specified by its process id (pid) |
| `kill -9 PID` | Force kill a process |
| `&` | Add this character to the end of command to run it in the background |
| `pgrep name` | Find processes by name |

---

## File System Commands

| Command | Usage |
|---|---|
| `pwd` | Present working directory |
| `ls -al` | List files with details |
| `cd` | Change directory |
| `mkdir` | Create new directory |
| `touch` | Create empty file |
| `cp` | Copy files/directories |
| `mv` | Move or rename files |
| `rm -rf` | Remove files/directories |
| `cat` | View file content |
| `wc X` | Display the word count of X |
| `find` | Find files/directories |
| `chmod` | Change file permissions |
| `df -h` | Show disk space usage |
| `du -sh` | Show file/directory size on disk |

---

## Networking Commands

| Command | Usage |
|---|---|
| `ping <website.com>` | send ICMP ECHO_REQUEST to network hosts |
| `ip addr` | Show IP address information |
| `curl <website.com>` | Tool for transferring data from or to a server using URLs |
| `dig <website.com> / host domain` | DNS lookup |
| `netstat -tulnp` | Show listening tcp and udp ports and corresponding programs |
| `ss -tulnp` | Socket statistics |
| `wget URL` | For non-interactive download of files from the Web |
| `whois domain` | Displays whois information for domain |
| `nslookup domain` | Display IP address of domain |

---

## Log & Service Commands

| Command | Usage |
|---|---|
| `journalctl -xe` | Print log entries from the systemd journal |
| `tail -f logfile` | Monitor logs in real time |
| `systemctl status process` | Check service status |
| `systemctl restart process` | Restart service |

---

## Why These Commands Matter in DevOps

These commands help DevOps engineers to:

- Debug production issues
- Monitor processes and services
- Troubleshoot network problems
- Analyze logs quickly
- Manage Linux systems efficiently