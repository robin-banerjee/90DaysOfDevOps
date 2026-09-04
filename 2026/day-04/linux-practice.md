# Checking processes - Services - Logs - Troubleshooting

## Process Checks

- Check Running Processes : List running processes (top 10 lines)
```
user@Machine:~$ ps -aux | head -10
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.0  22768 13892 ?        Ss   14:03   0:01 /sbin/init
root           2  0.0  0.0      0     0 ?        S    14:03   0:00 some-process
root           3  0.0  0.0      0     0 ?        S    14:03   0:00 some-process
root           4  0.0  0.0      0     0 ?        I<   14:03   0:00 some-process
root           5  0.0  0.0      0     0 ?        I<   14:03   0:00 some-process
root           6  0.0  0.0      0     0 ?        I<   14:03   0:00 some-process
root           7  0.0  0.0      0     0 ?        I<   14:03   0:00 some-process
root           8  0.0  0.0      0     0 ?        I<   14:03   0:00 some-process
root           9  0.0  0.0      0     0 ?        I    14:03   0:00 some-process
```

- Monitor Live Processes : System load information about CPU & memory usage, Running & sleeping processes, etc
```
user@Machine:~$ top
top - 14:53:34 up 50 min,  1 user,  load average: 0.02, 0.12, 0.11
Tasks: 388 total,   2 running, 386 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.6 us,  0.4 sy,  0.0 ni, 98.9 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :  7.9 total,  5.9 free,   1.7 used,   43.5 buff/cache
MiB Swap:  2.5 total,  2.5 free,      0.0 used.  2.2 avail Mem

 PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
   2902 user      17  -3 2046028 219052 181224 S   7.0   0.7   1:11.06 some-process
  24893 user      17  -3 2326412 174744 132008 S   5.6   0.5   0:06.71 some-process
   2978 user      20   0 3274272 168672 132104 S   0.7   0.5   0:15.86 some-process
  10494 user      20   0 1449.9g 407428 104212 S   0.7   1.3   0:10.06 some-process
    895 root      20   0       0      0      0 S   0.3   0.0   0:04.32 some-process
   2997 user      20   0 2607920  58576  46876 S   0.3   0.2   0:01.07 some-process
   3382 user      20   0 1162124  29232  21572 S   0.3   0.1   0:00.47 some-process
   3666 user      29   9 2322888 172336 133000 S   0.3   0.5   0:13.44 some-process
  11540 user      17  -3 1448.3g 221884 100672 S   0.3   0.7   0:13.15 some-process
```

- pgrep: Looks for running processes based on a given name or pattern
```
user@Machine:~$ pgrep -a nginx
38617 nginx: master process /path/to/nginx -g daemon on; master_process on;
38618 nginx: worker process
38619 nginx: worker process
38621 nginx: worker process
```

---

## Service Checks

- Prints first 20 lines of system service status summary
```
user@Machine:~$ systemctl status | head -20
● Machine
    State: running
    Units: 494 loaded (incl. loaded aliases)
     Jobs: 0 queued
   Failed: 0 units
    Since: Fri 2026-09-04 14:03:34 IST; 1h 48min ago
  systemd: 255.4-debuntu8.0~176618~24.04~85b73
   CGroup: /
           ├─init.scope
           │ └─1 /sbin/init
           ├─system.slice
           │ ├─something.service
           │ │ └─1369 /usr/sbin/something
           │ ├─somethin.service
           │ │ └─1244 /usr/pathhh/somethin --no-daemon
           │ ├─somethingy-daemon.service
           │ │ └─1180 /path/to/somethingy-daemon
           │ ├─sdlkhn.service
           │ │ └─3197 /path/to/sdlkhn
           │ ├─sdlkhn-daemon.service
```

- Prints first 10 lines of running services status
```
user@Machine:~$ systemctl list-units --type=service --state=running | head
  UNIT                                             LOAD   ACTIVE SUB     DESCRIPTION
  something.service                          loaded active running something Service
  ....
  ....
  ....
```

---

# Log Checks

- View containerd Service Logs using journalctl (Linux uses systemd to manage services, and journalctl acts as the centralized tool to investigate everything happening on the system), observed containerd daemon startup logs and service initialization logs
```
user@Machine:~$ journalctl -u containerd
Sep 03 10:35:05 Machine systemd[1]: Starting containerd.service - containerd container runtime...
...
...
...
```


- Monitor Last 20 lines of the authentication log(ssh, sudo)

```
user@Machine:~$ tail -20 /var/log/auth.log
2026-09-04T16:17:01.598118+05:30 Machine CRON[14086]: something(cron:session): session opened for user root(uid=0) by root(uid=0)
2026-09-04T16:17:01.599847+05:30 Machine CRON[14086]: something(cron:session): session closed for user root
...
...
...
```

---

# Mini troubleshooting steps

- Earlier:
```
user@Machine:~$ systemctl status docker
● docker.service - Docker Application Container Engine

     Loaded: loaded (/usr/path/to/docker.service; enabled; preset: enabled)

     Active: active (running) since Fri 2026-09-04 16:04:20 IST; 30min ago

TriggeredBy: ● docker.socket
...
...
...

user@Machine:~$ systemctl stop docker
Stopping 'docker.service', but its triggering units are still active:
docker.socket

user@Machine:~$ systemctl status docker
○ docker.service - Docker Application Container Engine

     Loaded: loaded (/usr/path/to/docker.service; enabled; preset: enabled)

     Active: inactive (dead) since Fri 2026-09-04 16:36:56 IST; 42s ago

   Duration: 32min 35.917s
TriggeredBy: ● docker.socket
...
...

user@Machine:~$ systemctl stop docker.socket
user@Machine:~$ docker stats
permission denied while trying to connect to the docker API at unix:///path/to/docker.sock

user@Machine:~$ sudo docker stats
[sudo] password for user:
Cannot connect to the Docker daemon at unix:///path/to/docker.sock. Is the docker daemon running?
```

- Issue:
Docker service was not responding properly.

- Steps Taken:
1. Checked active or inactive status using `systemctl status docker`
2. Verified ending logs of `journalctl -u docker -e`
3. Reviewed `ps aux`
4. Restarted service using: `systemctl restart docker`
5. Checked again using step 1 and step 2 commands
```
user@Machine:~$ systemctl status docker
○ docker.service - Docker Application Container Engine
     Loaded: loaded (/usr/path/to/docker.service; enabled; preset: enabled)
     Active: inactive (dead) since Fri 2026-09-04 16:36:56 IST; 30min ago
   Duration: 32min 35.917s
TriggeredBy: ○ docker.socket
...
...
...

user@Machine:~$ journalctl -u docker -e
...
...
...
Sep 04 16:04:20 Machine systemd[1]: Started docker.service - Docker Application Container Engine.
Sep 04 16:36:56 Machine systemd[1]: Stopping docker.service - Docker Application Container Engine...
Sep 04 16:36:56 Machine dockerd[1884]: time="2026-09-04T16:36:56.569410813+05:30" level=info msg="Processing signal 'terminated'"
Sep 04 16:36:56 Machine dockerd[1884]: time="2026-09-04T16:36:56.570716611+05:30" level=info msg="stopping event stream following g>
Sep 04 16:36:56 Machine dockerd[1884]: time="2026-09-04T16:36:56.570859216+05:30" level=info msg="Daemon shutdown complete"
Sep 04 16:36:56 Machine systemd[1]: docker.service: Deactivated successfully.
Sep 04 16:36:56 Machine systemd[1]: Stopped docker.service - Docker Application Container Engine.

user@Machine:~$ ps aux | grep docker
user       54667  0.0  0.0  18976  2488 pts/0    S<+  17:13   0:00 grep --color=auto docker

user@Machine:~$ systemctl restart docker

user@Machine:~$ systemctl status docker
● docker.service - Docker Application Container Engine
     Loaded: loaded (/usr/path/to/docker.service; enabled; preset: enabled)
     Active: active (running) since Fri 2026-09-04 17:17:02 IST; 10s ago
TriggeredBy: ● docker.socket
...
...
...

user@Machine:~$ journalctl -u docker -e
...
...
Sep 04 16:36:56 Machine dockerd[1884]: time="2026-09-04T16:36:56.570859216+05:30" level=info msg="Daemon shutdown complete"
Sep 04 16:36:56 Machine systemd[1]: docker.service: Deactivated successfully.
Sep 04 16:36:56 Machine systemd[1]: Stopped docker.service - Docker Application Container Engine.
Sep 04 17:17:01 Machine systemd[1]: Starting docker.service - Docker Application Container Engine...
Sep 04 17:17:01 Machine dockerd[56704]: time="2026-09-04T17:17:01.492930026+05:30" level=info msg="Starting up"
...
...
Sep 04 17:17:01 Machine dockerd[56704]: time="2026-09-04T17:17:01.500187681+05:30" level=info msg="Starting daemon with containerd >
Sep 04 17:17:01 Machine dockerd[56704]: time="2026-09-04T17:17:01.500764902+05:30" level=info msg="Restoring containers: start."
```

- Result: Docker service restarted successfully.
