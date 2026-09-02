# Day 02 – Linux Architecture, Processes, and systemd (Understanding how Linux works under the hood)

## Core components of Linux

### Kernel
The heart of Linux. The central core that directly controls hardware, processes, memory. Interface between hardware and software. Machine understands kernel language.

Responsibilities:
- Manages CPU and memory
- Handles hardware communication
- Manages processes
- Handles file systems and networking

The kernel acts as a bridge between hardware and software.

---

### Shell :
Interactive way to talk to kernel using commands.

---

### GUI :
Graphical user interface for visual interaction.

---

### System Libraries : 
Collections of pre-written functions that applications use to request services from the kernel.

---

### System Utilities : 
Programs and tools (like ls, cp, grep) that perform specific tasks, managing files, users, and system operations.

---

### User Space
User space is where users and applications run.

Examples:
- Bash
- VS Code
- Docker
- Chrome

Applications communicate with hardware through the kernel.

---

### Init / systemd (like system deamon running in background)
systemd is the init system used in modern Linux distributions.

Responsibilities:
- Starts services during system boot
- Restarts failed services
- Manages logs
- Controls background services

Example services:
- nginx
- docker
- ssh

---

# Process Management in Linux

Processes are instances of running programs. 
For ex: if we do `ping www.google.com` in the terminal then ping process is created.
We can list processes using ps(ps ax, ps ef) or top commands. 

Each process contains:
- PID (Process ID)
- Parent Process
- CPU usage
- Memory allocation

Linux uses a scheduler to manage processes efficiently.

---

# Process States

| State | Meaning |
|------|------|
| Running (R) | Process actively using CPU |
| Sleeping (S) | Waiting for resources/input |
| Stopped (T) | Process execution paused by signal SIGSTOP (Ctrl+Z, Ctrl+C), It can be resumed by a SIGCONT signal|
| Zombie (Z) | Process completed but not cleaned as its entry in the process table still exists because its parent process has not yet read its exit status|
| Idle | Special kernel task that runs only when the CPU has no real work to do |

---

# Useful systemd Commands

```bash
systemctl status nginx
systemctl start nginx
systemctl stop nginx
systemctl restart nginx
systemctl enable nginx
```

---

# 5 Linux Commands Used Daily

```bash

- "ps or top" : Provides process ID, memory usage, CPU time and command name which is crucial for monitoring system performance and troubleshooting.

- "systemctl status <unit_name>" : To check the current operational state.

- "ssh ubuntu@aws-server-ip" : To log into a remote computer and use their tools as if you were sitting right in front of it

- "chmod" : Changing permission of files.

- "while true; do curl -s http://<SERVICE_IP_OR_URL>/ > /dev/null; done" : Curl to continuously hit application endpoint to check scaling.


```

---

# Why This Matters in DevOps

Understanding Linux internals helps DevOps engineers to:

- Debug crashed services faster
- Fix CPU and memory issues
- Monitor production systems
- Understand logs and service restarts confidently