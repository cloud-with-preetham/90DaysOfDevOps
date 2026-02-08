# Day 15 – Networking Concepts: DNS, IP, Subnets & Ports

## Task 1: DNS – How Names Become IPs

### 1. What happens when you type `google.com` in a browser?
When I type `google.com`, the browser first checks its cache for the IP.  
If not found, it asks the OS, which queries a DNS resolver.  
The resolver contacts authoritative DNS servers and gets the IP address.  
The browser then connects to that IP using HTTP/HTTPS.

### 2. DNS Record Types
- **A** – Maps a domain name to an IPv4 address  
- **AAAA** – Maps a domain name to an IPv6 address  
- **CNAME** – Creates an alias from one domain to another  
- **MX** – Specifies mail servers for a domain  
- **NS** – Defines authoritative DNS servers for a domain  

### 3. `dig google.com` Output
Command:
```bash
dig google.com
```
```output
; <<>> DiG 9.18.39-0ubuntu0.24.04.2-Ubuntu <<>> google.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 37945
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;google.com.			IN	A

;; ANSWER SECTION:
google.com.		129	IN	A	142.250.69.174

;; Query time: 1 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Sun Feb 08 09:06:21 UTC 2026
;; MSG SIZE  rcvd: 55
```
- A Record IP: 142.250.69.174
- Time to Live: 129

---

## Task 2: IP Addressing

### 1. What is an IPv4 address?
An IPv4 address is a 32-bit numeric identifier assigned to a device on a network.
It is written as four numbers (0–255) separated by dots, e.g.,`192.168.1.10`.

### 2. Public vs Private IPs
Public IP – Reachable over the internet (e.g., `8.8.8.8`)
Private IP – Used inside internal networks (e.g., 192.168.1.10`)

### 3. Private IP Ranges

- `10.0.0.0 – 10.255.255.255`

- `172.16.0.0 – 172.31.255.255`

- `192.168.0.0 – 192.168.255.255`

### 4. ip addr show Output

Command:
```bash
ip addr show
```
```text
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute 
       valid_lft forever preferred_lft forever
2: ens5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc mq state UP group default qlen 1000
    link/ether 02:96:e7:a7:4d:93 brd ff:ff:ff:ff:ff:ff
    inet 172.31.28.77/20 metric 100 brd 172.31.31.255 scope global dynamic ens5
       valid_lft 2577sec preferred_lft 2577sec
    inet6 fe80::96:e7ff:fea7:4d93/64 scope link 
       valid_lft forever preferred_lft forever
```
- Private IP Identified: `172.31.28.77`

---

Task 3: CIDR & Subnetting
1. **What does `/24` mean?**
`/24` means the first 24 bits are used for the network, leaving 8 bits for hosts.

2. **Usable Hosts**
- `/24` → 254 usable hosts
- `/16` → 65,534 usable hosts
- `/28` → 14 usable hosts

3. **Why do we subnet?**
Subnetting helps organize networks, improve security, reduce broadcast traffic,
and efficiently manage IP address usage.

4. **CIDR Table**
|   **CIDR**    |   **Subnet Mask** |   **Total IPs**   |   **Usable Hosts**    |
|---------------|-------------------|-------------------|-----------------------|
|   /24	        |   255.255.255.0	|   256	            |   254                 |
|   /16	        |   255.255.0.0	    |   65,536	        |   65,534              |
|   /28	        |   255.255.255.240	|   16	            |   14                  |

---

### Task 4: Ports – The Doors to Services
1. **What is a port?**
A port is a logical endpoint that identifies a specific service running on a machine. Ports allow multiple services to run on the same IP address.

2. **Common Ports**
|   **Port**    |   **Service** |
|---------------|---------------|
|   22	        |   SSH         |
|   80	        |   HTTP        |
|   443	        |   HTTPS       |
|   53	        |   DNS         |
|   3306	    |   MySQL       |
|   6379	    |   Redis       |
|   27017	    |   MongoDB     |

3. `ss -tulpn`
```bash
ss -tulpn
```
**My Matches:**
Port `22` → SSH
Port `80` → HTTP

### Task 5: Putting It Together
1. `curl http://myapp.com:8080`
DNS resolves myapp.com to an IP address, the request uses HTTP on port 8080, and routing + firewall rules determine connectivity.

2. App can’t reach `10.0.1.50:3306`
I would first check network connectivity, security group/firewall rules, and ensure MySQL is listening on port 3306.

### What I Learned
- DNS translates human-readable names into IP addresses.
- CIDR and subnetting help efficiently manage large networks.
- Ports allow multiple services to run on a single IP safely.
