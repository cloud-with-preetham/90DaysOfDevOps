# Linux Troubleshooting Runbook – Day 05

## Target Service / Process

**Service:** `sshd`  
**Reason:** Critical access service; easy to validate CPU, memory, network, and logs.

---

## Environment Basics

### 1. System Info

```bash
uname -a
```
**Observed:**
About Linux Kernel and **x86_64** Architecture

### 2. OS Info

```bash
cat /etc/os-release
```
**Observed:**
Ubuntu 22.04 LTS and services.

---

## Filesystem Sanity Check

### 3. Create Test Directory & File

```bash
mkdir /tmp/runbook-demo
cp /etc/hosts /tmp/runbook-demo/hosts-copy
ls -l /tmp/runbook-demo
```
**Observed:**
Host details copied to a different file form /etc/hosts to /tmp/runbook-demo/hosts-copy - It means filesystem readable.

### 4. Disk Usage Overview

```bash
df -h
```
**Observed:**
Root filesystem 29% usage: no immediate disk pressure.

---

## CPU & Memory

### 5. Identify `sshd` PID and Reource Usage.

```bash
ps -o pid,pcpu,pmem,comm -C sshd
```
**Observed:**
Multiple processes noticed: everything is <1% of CPU Usage and minimal memory.

### 6. Memory Overview

```bash
free -h
```
**Observed:**
63.24% of memory is available and no swap is used.

---

## Disk & Input/Output

### 7. Log Directory Size

```bash
du -sh /var/log
```
**Observed:**
Minimum size of log files are 300 MB: My total size of /var/log is 26MB.

### 8. Input/Output Activity
```bash
vmstat 1 5
```
**Observed:**
Low IO wait; system IO not-bound.

---

## Network

### 9. Listning Ports

```bash
ss -tulpn | grep ssh
```
**Obeserved:**
No Output

### 10. Local Connectivity Check

```bash
curl -I https://localhost
```
**Observed:**
Failed to connect to port 443: Connections refused.

---

## Logs Reviewed

### 11. System Logs for `sshd`

```bash
journalctl -u sshd -n 50
```
**Observed:**
Empty Logs

### 12. Auth.log

```bash
tail -n 50 /var/log/auth.log
```
**Observed**
One successful SSH Login 

---

**Quick Findings**
- `sshd` is healthy, low CPU/Memory usage.
- Disk space and IO in safe limits.
- Network ports showed no output.
- Logs showed no error but no entries found.

---

## If this Worsens

### **Step-1:** Increased Load/Hangs

```bash
top -Hp <PID>
```
**Observation:**
In my session i used `top -Hp 910` as the command in my case i was running sshd service. So ssh was running smoothly.

### **Step-2:** Authentication or Startup Failure
Increase verbosity level in `/etc/ssh/sshd_config`
```text
LogLevel DEBUG
```
Reload safely:
```bash
systemctl reload sshd
```

### **Step-3:** Suspected Bugs or Deadlocks
Diagnoistic:
```bash
strace -p <PID>
```
**My use case:** strace -p 910 -> No Output because my ssh was disabled.
