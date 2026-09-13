# Day 12 – Revision (Days 01–11)

# Mindset & Learning Plan Review

- Revisited my Day 01 DevOps learning plan
- Goals still align with "Given my background in quality assurance and understanding throughout the software development lifecycle, I like automation in workflows. Hence would like to learn how to deliver and deploy quality applications faster, smarter and better. By the end of my preparation I want to become a trustworthy DevOps/cloud engineer who is skilled enough to deliver and deploy applications at scale. Also building my own brand called **infraRanger** over next one year."
- Need to improve consistency with hands-on Linux practice and start writing medium blogs about it
- Will focus more on troubleshooting and permissions in upcoming days

---

# Processes & Services Review

## Process Check

```bash
ps aux | head
```

Observed:
- Multiple background services running normally
- System processes managed by systemd


```bash
htop
```

Observed:
- Display sorted information about processes and CPU/RAM usage.

---

## Service Check

```bash
systemctl status <service>
```

Observed:
- Displays the status of a specific service (whether it’s active, failed, or inactive).

---

## Log Review

```bash
journalctl -u <service> -20
```

Observed:
- Displays logs for a specific service, useful for debugging issues.

---

# File Skills Practice

## Append Content to File

```bash
ubuntu@Server:~/90DaysOfDevOps/2026/day-12$ echo "Revision practice" >> notes.txt
ubuntu@Server:~/90DaysOfDevOps/2026/day-12$ cat notes.txt 
Revision practice
```

---

## Change File Permission

```bash
ubuntu@Server:~/90DaysOfDevOps/2026/day-12$ chmod 764 notes.txt
ubuntu@Server:~/90DaysOfDevOps/2026/day-12$ ls -l notes.txt 
-rwxrw-r-- 1 ubuntu ubuntu 18 Sep 13 09:32 notes.txt
```

---

## Change Ownership

```bash
ubuntu@Server:~/90DaysOfDevOps/2026/day-12$ sudo chown professor:heist-team notes.txt 
ubuntu@Server:~/90DaysOfDevOps/2026/day-12$ ls -l notes.txt 
-rwxrw-r-- 1 professor heist-team 18 Sep 13 09:32 notes.txt
```

---

# 5 Commands I Would Use First During an Incident

| Command | Purpose |
|---|---|
| `htop` | Monitor CPU and memory usage |
| `ps aux` | Check running processes |
| `systemctl status <service>` | Verify service health |
| `journalctl -u` | Review service logs |
| `cat /var/log/nginx/error.log` | Reads raw logs for web server errors (replace with relevant service log path) |

---

# User & Group Sanity Check

## Verify User Information

```bash
ubuntu@Server:~/90DaysOfDevOps/2026/day-12$ id professor 
uid=1008(professor) gid=1008(professor) groups=1008(professor),1010(admins)
```

---

## Verify File Ownership

```bash
ubuntu@Server:~/90DaysOfDevOps/2026/day-12$ sudo chown professor:admins notes.txt 
ubuntu@Server:~/90DaysOfDevOps/2026/day-12$ ls -l notes.txt 
-rwxrw-r-- 1 professor admins 18 Sep 13 09:32 notes.txt
```

Observed:
- Ownership and group changes applied successfully

---

# Mini Self-Check

## 1. Which 3 commands save you the most time right now?

- `systemctl status` → quickly checks service health
- `journalctl -u` → helps identify service errors
- `ls -l` → verifies permissions and ownership

---

## 2. How do you check if a service is healthy?

Commands:

```bash
ubuntu@Server:~/90DaysOfDevOps/2026/day-12$ systemctl status nginx
● nginx.service - A high performance web server and a reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; preset: enabled)
     Active: active (running) since Sun 2026-09-13 05:16:36 IST; 4h 32min ago ...
```
```bash
ubuntu@Server:~/90DaysOfDevOps/2026/day-12$ journalctl -u nginx -n 5
Sep 12 20:22:55 Server systemd[1]: Stopping nginx.service - A high performance web server and a reverse proxy server...
Sep 12 20:22:55 Server systemd[1]: nginx.service: Deactivated successfully.
Sep 12 20:22:55 Server systemd[1]: Stopped nginx.service - A high performance web server and a reverse proxy server.
-- Boot 5373708401ad4315b9a8b87e62c17970 --
Sep 13 05:16:36 Server systemd[1]: Starting nginx.service - A high performance web server and a reverse proxy server...
Sep 13 05:16:36 Server systemd[1]: Started nginx.service - A high performance web server and a reverse proxy server.
```
```bash
ubuntu@Server:~/90DaysOfDevOps/2026/day-12$ ps aux | grep nginx
root        1997  0.0  0.0  11168  1804 ?        SNs  05:16   0:00 nginx: master process /usr/sbin/nginx -g daemon on; master_process on;
www-data    1998  0.0  0.0  12892  4568 ?        SN   05:16   0:00 nginx: worker process
www-data    1999  0.0  0.0  12892  4568 ?        SN   05:16   0:00 nginx: worker process
```

---

## 3. How do you safely change ownership and permissions?

Example:

```bash
ubuntu@Server:~/90DaysOfDevOps/2026/day-12$ sudo chown professor:admins notes.txt 
ubuntu@Server:~/90DaysOfDevOps/2026/day-12$ ls -l notes.txt 
-rwxrw-r-- 1 professor admins 18 Sep 13 09:32 notes.txt

ubuntu@Server:~/90DaysOfDevOps/2026/day-12$ sudo chmod 640 notes.txt

```

Always verify changes using `ls -l`:

```bash
ubuntu@Server:~/90DaysOfDevOps/2026/day-12$ ls -l notes.txt 
-rw-r----- 1 professor admins 18 Sep 13 09:32 notes.txt
```

---

## 4. What will I improve in the next 3 days?

- I want to focus on networking now and complete Linux Volume Management.
- Also I will practice users & group management.
- And if time allows I will also practice AWS solutions architect fundamentals.

---

# Key Takeaways

- Revision helped reinforce Linux fundamentals
- Repeating commands improves confidence
- Logs and permissions are critical in DevOps troubleshooting