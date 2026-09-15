# Networking Fundamentals & Hands-on Checks

# Quick Concepts

## OSI Model vs TCP/IP Model

### OSI Model
OSI is a conceptual model that defines network communication. It consists of 7 layers where each layer performs a specific function.
* **Application L7** - User interaction (e.g., browser).
* **Presentation L6** - Data encryption/decryption, format conversion.
* **Session L5** - Establish/manage/terminate sessions.
* **Transport L4** - Reliable delivery (TCP/UDP).
* **Netwrok L3** - IP addressing, routing.
* **Data Link L2** - Error‑free node‑to‑node delivery.
* **Physical L1** - Hardware, cables, signals.

### TCP/IP Model
TCP/IP is practically used for providing communication between computers over the internet.
* **Application L4** - Combines OSI’s Application + Presentation + Session. 
* **Transport L3** - Same as OSI Transport.
* **Internet L2** - Same as OSI Network.
* **Netwrok access L1** - Physical + Data Link combined.

---

## Protocols in the Stack
* **HTTP, HTTPS, FTP, SMTP, DNS, DHCP, SSH** - Application layer
* **TCP, UDP** - Transport Layer
* **IP, ICMP, ARP** - Internet Layer
* **Ethernet, Wi-Fi** - Network Access layer

Example:

```bash
ubuntu@ip:~$ curl -L https://askubuntu.com/

<!DOCTYPE html><html lang="en-US"><head><title>Just a moment...</title><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge"><meta name="robots" content="noindex,nofollow"><meta name="viewport" content="width=device-width,initial-scale=1">...
```
Application Layer (HTTP/HTTPS) -> Transport Layer (TCP)  -> Internet Layer (IP)

---

# Hands-on Checklist

## Identity Check
```bash
ubuntu@ip:~$ hostname -I
172.31.7.202
```
Observed:
- Local private IP address is 172.31.7.202

---

## Reachability Check
```bash
ubuntu@ip:~$ ping google.com
PING google.com (142.251.126.138) 56(84) bytes of data.
64 bytes from cn-in-f138.1e100.net (142.251.126.138): icmp_seq=1 ttl=113 time=1.36 ms
64 bytes from cn-in-f138.1e100.net (142.251.126.138): icmp_seq=2 ttl=113 time=1.32 ms
64 bytes from cn-in-f138.1e100.net (142.251.126.138): icmp_seq=3 ttl=113 time=1.36 ms
64 bytes from cn-in-f138.1e100.net (142.251.126.138): icmp_seq=4 ttl=113 time=1.28 ms
^C
--- google.com ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3004ms
rtt min/avg/max/mdev = 1.277/1.329/1.360/0.033 ms
```
Observed:
- Successful replies received.
- 0% packet loss with 3004ms average latency confirms good network connectivity.

---

## Path Check
```bash
ubuntu@ip:~$ traceroute www.google.com
traceroute to www.google.com (142.251.154.119), 30 hops max, 60 byte packets
 1  242.6.252.7 (242.6.252.7)  1.689 ms  1.666 ms 242.6.252.3 (242.6.252.3)  1.405 ms
 2  240.2.196.0 (240.2.196.0)  1.783 ms  2.292 ms  1.241 ms
 3  142.251.154.119 (142.251.154.119)  1.110 ms  0.982 ms  0.967 ms
```
Observed:
- Multiple network hops identified.
- No major delays detected.

---

## Open Ports Check
```bash
ubuntu@ip:~$ ss -tulpn
Netid      State        Recv-Q       Send-Q                 Local Address:Port             Peer Address:Port      Process
udp        UNCONN       0            0                          127.0.0.1:323                   0.0.0.0:*
udp        UNCONN       0            0                         127.0.0.54:53                    0.0.0.0:*
udp        UNCONN       0            0                      127.0.0.53%lo:53                    0.0.0.0:*
udp        UNCONN       0            0                  172.31.7.202%ens5:68                    0.0.0.0:*
udp        UNCONN       0            0                              [::1]:323                      [::]:*
tcp        LISTEN       0            4096                   127.0.0.53%lo:53                    0.0.0.0:*
tcp        LISTEN       0            4096                         0.0.0.0:22                    0.0.0.0:*
tcp        LISTEN       0            4096                      127.0.0.54:53                    0.0.0.0:*
tcp        LISTEN       0            4096                            [::]:22                 [::]:*
```
Observed:
- SSH service listening on port 22.
- 0.0.0.0 means it is listening on all available IPv4 interfaces, allowing incoming SSH connections from the outside world (subject to the cloud security groups/firewall).

---

## DNS Resolution
```bash
ubuntu@ip:~$ nslookup google.com
Server:		127.0.0.53
Address:	127.0.0.53#53

Non-authoritative answer:
Name:	google.com
Address: 192.178.173.139
Name:	google.com
Address: 192.178.173.113
Name:	google.com
Address: 192.178.173.101
Name:	google.com
Address: 192.178.173.102
Name:	google.com
Address: 192.178.173.138
Name:	google.com
Address: 192.178.173.100
Name:	google.com
Address: 2404:6800:4009:81f::200e
```
```bash
ubuntu@ip:~$ dig google.com

; <<>> DiG 9.20.18-1ubuntu2.1-Ubuntu <<>> google.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 62708
;; flags: qr rd ra; QUERY: 1, ANSWER: 6, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;google.com.			IN	A

;; ANSWER SECTION:
google.com.		52	IN	A	192.178.173.138
google.com.		52	IN	A	192.178.173.101
google.com.		52	IN	A	192.178.173.113
google.com.		52	IN	A	192.178.173.139
google.com.		52	IN	A	192.178.173.100
google.com.		52	IN	A	192.178.173.102

;; Query time: 0 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Tue Sep 15 13:19:34 UTC 2026
;; MSG SIZE  rcvd: 135
```
Observed:
- Checked the SERVER IP (127.0.0.53) to see what resolver used, and looked for status: NOERROR (or error codes like NXDOMAIN) to instantly confirm if DNS name resolution is working.
- Domain resolves to: 192.178.173.138, 192.178.173.101, 192.178.173.113, etc.

---

## HTTP Check
```bash
ubuntu@ip:~$ curl -I www.google.com
HTTP/1.1 200 OK
Content-Type: text/html; charset=ISO-8859-1
Content-Security-Policy-Report-Only: object-src 'none';base-uri 'self';script-src 'nonce-j2GlWe66bjF7Z5eIdATQHQ' 'strict-dynamic' 'report-sample' 'unsafe-eval' 'unsafe-inline' https: http:;report-uri https://csp.withgoogle.com/csp/gws/other-hp
P3P: CP="This is not a P3P policy! See g.co/p3phelp for more info."
Date: Tue, 15 Sep 2026 13:32:19 GMT
Server: gws
X-XSS-Protection: 0
X-Frame-Options: SAMEORIGIN
Expires: Tue, 15 Sep 2026 13:32:19 GMT
Cache-Control: private
Set-Cookie: __Secure-STRP=ANmZwa1RpLWLQA5rCOskwPwD7YJwdn4oJ2TyFQKRaRH2UZgYS5lI5PW61T8NDAE3nE7mSSxRyZ4e8Beltji-HMZOKLeND61DpIFs; expires=Tue, 15-Sep-2026 13:37:19 GMT; path=/; domain=.google.com; Secure; SameSite=strict
Set-Cookie: AEC=AdJVEas2cB_nbEwd2oz5IENVLyUgi3riYfzKZXkLuJqqcd4HUrawPi0Xrg; expires=Sun, 14-Mar-2027 13:32:19 GMT; path=/; domain=.google.com; Secure; HttpOnly; SameSite=lax
Set-Cookie: NID=CvgBCAESqgEBp2sxrg6bCk8P0ka-YoNaN0SB2sQ_faB3aMal9w20bgVkCmx4wCwhEC0C8zILkIOQtsR-3mrsMsZKRdbiaSv5kB3eZeLnn8TxwEY3PPnoQYrs23TWby-l2BIYyvwMDabNHyOgZg6nNAVUIhRp-OSWnsUfsQF46CpWuNyAURap1crj1HRvk5ToU9QvQmdnfCNTp7yqvf2ggP8v9ppjCWEzRgoxvnS9v8-8xigBMkUBDiveEfcyz0qKH3pay9slDcL4tiZ_IEsWa99lu1cLRfqP0HnWvE4mgZ4tYZ3-uAHh0Mvp5qwJVTwKYi4ArmN7YpfTqAM; expires=Wed, 17-Mar-2027 13:32:19 GMT; path=/; domain=.google.com; HttpOnly
Transfer-Encoding: chunked
```
Observed:
- HTTP/1.1 200 OK: The request was completely successful.
- Server: gws: Identifies the web server type (Google Web Server).
- Set-Cookie: Shows that Google's server is dropping tracking and session tokens (like AEC) onto our client.

---

## Connection Snapshot
```bash
ubuntu@ip:~$ netstat -an | head
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN
tcp        0      0 127.0.0.54:53           0.0.0.0:*               LISTEN
tcp        0      0 172.31.7.202:36300      3.110.169.167:80        TIME_WAIT
tcp        0      0 172.31.7.202:22         49.32.9.84:32880        ESTABLISHED
tcp        0      0 172.31.7.202:22         49.32.9.84:51410        ESTABLISHED
tcp        0      0 172.31.7.202:22         49.32.9.84:43898        ESTABLISHED
tcp        0      0 172.31.7.202:22         49.32.9.84:58846        ESTABLISHED
```
Observed:
- Active LISTEN and ESTABLISHED connections visible.
    * ESTABLISHED on port 22: Multiple connections from 49.32.9.84 to EC2 server's port 22 (ESTABLISHED). That's me logged in via SSH right now!
    * TIME_WAIT on port 80: EC2 server recently finished talking to an HTTP server (3.110.169.167) and is safely winding down the connection.

---

# Mini Task: Port Probe & Interpret

## Identify Listening Port
```bash
ubuntu@ip:~$ sudo ss -tulpn | grep LISTEN
tcp   LISTEN 0      4096       127.0.0.53%lo:53        0.0.0.0:*    users:(("systemd-resolve",pid=181,fd=17))
tcp   LISTEN 0      4096             0.0.0.0:22        0.0.0.0:*    users:(("sshd",pid=671,fd=3),("systemd",pid=1,fd=231))
tcp   LISTEN 0      4096          127.0.0.54:53        0.0.0.0:*    users:(("systemd-resolve",pid=181,fd=19))
tcp   LISTEN 0      4096                [::]:22           [::]:*    users:(("sshd",pid=671,fd=4),("systemd",pid=1,fd=232))
```
Observed:
- Can see the exact three services currently listening for traffic on the clean Ubuntu EC2 instance:
    * Port 53 (systemd-resolve): The local DNS resolver handling lookups.
    * Port 22 (sshd): The secure shell service allowing remote logins.

---

## Test Port
```bash
ubuntu@ip:~$ nc -zv localhost 22
Connection to localhost (127.0.0.1) 22 port [tcp/ssh] succeeded!
```
Observed:
- Connection succeeded.

If not reachable:
- Check service status. `sudo systemctl status ssh` Checks if the background service daemon is actively running (active (running)) or dead/failed.
    *How to verify: Look for the green active (running) line. If it's stopped, start it with `sudo systemctl start ssh`.
- Check logs - `journalctl -u ssh -n 50`: Pulls the last 50 lines of system logs specifically generated by the SSH service.
    * How to verify: Look for explicit error strings like Bind to port 22 failed: Address already in use or configuration syntax errors.
- Verify firewall: `sudo ufw status` Ubuntu's local host-based firewall (Uncomplicated Firewall) rules.
    * How to verify: Look for Status: active and ensure port 22 is set to ALLOW. If it's blocked, run `sudo ufw allow 22`.

---

# Reflection

## Which command gives the fastest signal when something is broken?
```bash
ping
```
It quickly confirms basic network connectivity.

---

## What layer would you inspect if DNS fails?

It runs on application layer if DNS queries don’t resolve, the next logical layer to inspect is the Transport layer (L4) and Internet layer (L3)

Check:
- DNS server configuration
- DNS resolution commands
* `dig`, `nslookup`, `ping`, `ss -tulpn`

---

## What layer would you inspect if HTTP 500 appears?

HTTP 500 : It is application layer. Since you got response(500) it means internet and transport layers are fine. Check at Application layer.

Check:
- Application logs
- Web server logs
- Backend service health

* `systemctl status service`, `journalctl -u service`, `tail -f /var/log/service/error.log`
---

## Follow-Up Checks During an Incident
* Service health check: (`systemctl status <service>` , `journalctl -xe`) These help identify service failures and log errors.
* Check firewal: (`sudo ufw status` , `sudo iptables -L -n -v`)
* Connectivity test (`curl -I http://<server-ip>:<port>` , `nc -zv <server-ip> <port>`)