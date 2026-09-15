# Day 15 – Networking Concepts: DNS, IP, Subnets & Ports

# Task 1: DNS – How Names Become IPs

**When we type `google.com` in a browser**:

1. Browser checks local DNS cache for the corresponding IP address.
2. If not present browser will send request to DNS(Domain Name Service) requesting IP address. Request goes to DNS resolver.
3. DNS server returns the IP address of google.com.
4. Browser sets up a secure connection (HTTPS) with Google’s servers using TCP/IP.
5. The request is routed through Google’s load balancers to the right web server.
6. The web server processes the request, may talk to application servers and databases and then sends back the webpage we see.

---

**What are these record types?** A, AAAA, CNAME, MX, NS

| Record | Purpose |
|----------|----------|
| A | Maps domain name to IPv4 address |
| AAAA | Maps domain name to IPv6 address |
| CNAME | Creates an alias from one domain name to another |
| MX | Specifies mail servers responsible for handling email for the domain |
| NS | Defines the authoritative name servers for the domain |

---

## `dig` Command

```
ubuntu@ip-172-31-7-202:~$ dig google.com

; <<>> DiG 9.20.18-1ubuntu2.1-Ubuntu <<>> google.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 56026
;; flags: qr rd ra; QUERY: 1, ANSWER: 6, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;google.com.			IN	A

;; ANSWER SECTION:
google.com.		176	IN	A	192.178.173.100
google.com.		176	IN	A	192.178.173.138
google.com.		176	IN	A	192.178.173.102
google.com.		176	IN	A	192.178.173.139
google.com.		176	IN	A	192.178.173.101
google.com.		176	IN	A	192.178.173.113

;; Query time: 3 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Tue Sep 15 14:53:19 UTC 2026
;; MSG SIZE  rcvd: 135
```

Observed:
- `A` record gives IPv4 address - 192.178.173.xxx
- `TTL` - Time To Live - 176secs

---

# Task 2: IP Addressing

## What is IPv4? How is it structured?

IPv4 is a 32-bit address used to identify devices on a network.

Example: `192.168.1.10`
* IP address is divided into -
    - Network Portion : Identifies the network
    - Host Portion : Identifies the individual device
    - In example : IP 192.168.1.10 
        - Network Portion - 192.168.1.0
        - Host Portion - 10

---

## Public vs Private IP


**Public IP**                                           |   **Private IP**
--------------------------------------------------------|--------------------------------------------------------------------
It is assigned by ISP to every device on the internet.  |   Assigned within private networks to identify devices  locally. 
It is unique across the entire internet.                |   Not routable on the internet.
Example: `103.176.157.29`, `8.8.8.8 (Google DNS)`       |   Example: `192.168.x.x`, `10.x.x.x`,`172.16.x.x`


---

## Private IP Ranges

- `10.x.x.x` [10.0.0.0 – 10.255.255.255] - Large enterprise networks
- `172.16.x.x – 172.31.x.x` [172.16.0.0 – 172.31.255.255] - Medium-sized organizations
- `192.168.x.x` [192.168.0.0 – 192.168.255.255] - Home & small office networks

---

## `ip addr show` Command

```bash
ubuntu@ip-172-31-7-202:~$ ip addr show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute
       valid_lft forever preferred_lft forever
2: ens5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc mq state UP group default qlen 1000
    link/ether 0a:ff:cf:f8:3e:c5 brd ff:ff:ff:ff:ff:ff
    altname enp0s5
    altname enx0affcff83ec5
    inet 172.31.7.202/20 metric 100 brd 172.31.15.255 scope global dynamic ens5
       valid_lft 2235sec preferred_lft 2235sec
    inet6 fe80::8ff:cfff:fef8:3ec5/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever
```

Observed:
- 127.0.0.1/8 - Reserved for local host communication
- 172.31.7.202/20 - This is a private IP address and CIDR block.
- My IP belongs to a mid-size class B private IP range.

---

# Task 3: CIDR & Subnetting

## What does /24 meanin `192.168.1.0/24`?
- /24 is CIDR notation. It tells us how many bits of the IP address are used for network portion.
    * Here first `24` bits (out of 32) are reserved for network. That leaves 8 bits for the host address.
    * IP range : (192.168.1.0 - 192.168.1.255) Total :256 IP's 

---

## How many usable hosts in /24, /16, /28?
- To find the number of usable hosts for any CIDR mask: `Usable Hosts = [2^(32) - CIDR] - 2` (We subtract 2 because the first IP is the network address and the last IP is the broadcast address).
    * /24: 2^(32-24) - 2 = 256 - 2 = 254
    * /16: 2^(32-16) - 2 = 65,536 - 2 = 65,534
    * /28: 2^(32-28) - 2 = 16 - 2 = 14

---

## Why Do We Subnet?

Subnet divides one large network into small, manageable and efficient sub-networks.
 * Improves performance - Local traffic stays within its subnet, reducing congestion.
 * Enhanced Security - Access to one subnet doesn’t automatically expose the entire network.
 * Troubleshooting & Management - Smaller networks are easier to monitor, isolate issues, and maintain.

---

## CIDR Table

| CIDR | Subnet Mask | Total IPs | Usable Hosts |
|--------|---------------|------------|-------------|
| /24 | 255.255.255.0 | 256 | 254 |
| /16 | 255.255.0.0 | 65,536 | 65,534 |
| /28 | 255.255.255.240 | 16 | 14 |

---

# Task 4: Ports – The Doors to Services

## What is a Port?
- Port is a logical endpoint in networking. 
- IP address identifies the device on a network and port number specifies which service the data goes to on that device. 
- Port is needed to differentiate between services, allowing multiple services to run on the same machine and still be uniquely identified using the same IP address.

---

## Common Ports

| Port | Service |
|--------|----------|
| 22 | SSH |
| 80 | HTTP |
| 443 | HTTPS |
| 53 | DNS |
| 3306 | MySQL |
| 6379 | Redis |
| 27017 | MongoDB |

---

## `ss -tulpn` Command output

```bash
ubuntu@ip-172-31-7-202:~$ ss -tulpn
Netid      State        Recv-Q       Send-Q                 Local Address:Port             Peer Address:Port      Process
udp        UNCONN       0            0                          127.0.0.1:323                   0.0.0.0:*
udp        UNCONN       0            0                         127.0.0.54:53                    0.0.0.0:*
udp        UNCONN       0            0                      127.0.0.53%lo:53                    0.0.0.0:*
udp        UNCONN       0            0                  172.31.7.202%ens5:68                    0.0.0.0:*
udp        UNCONN       0            0                              [::1]:323                      [::]:*
tcp        LISTEN       0            4096                   127.0.0.53%lo:53                    0.0.0.0:*
tcp        LISTEN       0            511                          0.0.0.0:80                    0.0.0.0:*
tcp        LISTEN       0            4096                         0.0.0.0:22                    0.0.0.0:*
tcp        LISTEN       0            4096                      127.0.0.54:53                    0.0.0.0:*
tcp        LISTEN       0            511                             [::]:80                       [::]:*
tcp        LISTEN       0            4096                            [::]:22                       [::]:*
```

Observed: 2 listening ports to their services
| Port | Service |
|--------|----------|
| 22 | SSH |
| 80 | Nginx |

---

# Task 5: Putting It Together

## when we run `curl http://localhost:80`
* Protocol HTTP
* Localhost : Resolve to loopback IP it resolves to 127.0.0.1
* Port 80 : Nginx service

---

## Your app can't reach a database at 10.0.1.50:3306, what would you check first?

First checks:
- Test the port: `nc -zv 10.0.1.50 3306` (Proves if packets can cross the network and hit the port).
- `Check Security Groups` / Firewalls: Ensure the database server allows **inbound traffic on port 3306** from your app server's IP.
- Check Remote Service: Log into the database server (if you have access) to check `systemctl status mysql`.
- Why?
    * Because 10.0.1.50 is a remote IP address (another server or database instance).
    * Running ss -tulpn or systemctl status mysql on your app server won't show anything useful because the database isn't running locally.
    * When an app fails to reach a remote database, the most common culprits are Cloud Security Groups, Network ACLs, or local firewalls blocking port 3306, followed by whether the database service itself is up on the remote end.

---

# What I Learned

- How DNS converts domain names into IP addresses
- How CIDR and subnetting help organize networks
- Why ports are important for service communication