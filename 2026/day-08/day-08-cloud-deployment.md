# Day 08 – Cloud Server Setup: Docker, Nginx & Web Deployment

## Goal
Deploy a real web server on the cloud and practice **production-level DevOps tasks** such as server provisioning, secure access, service deployment, security configuration, and log extraction.

---

## Part 1: Launch Cloud Instance & SSH Access

### Step 1: Create a Cloud Instance
- Created a Linux virtual machine using **AWS EC2 (Ubuntu 22.04)**
- Selected a free-tier eligible instance
- Generated and downloaded an SSH key pair
- Configured security rules to allow:
  - **SSH (Port 22)**
  - **HTTP (Port 80)**

---

### Step 2: Connect to Server via SSH

```bash
ssh -i devops-secret-key.pem ubuntu@ec2-44-250-180-68.us-west-2.compute.amazonaws.com
```

### SSH Connection to Cloud Server
![SSH Connection](images/ssh-connection.png)

<p align="center">
  <b>Figure:</b> Successful SSH connection to cloud instance
</p>

---

## Part 2: Install Docker & Nginx

### Step 1: Update System Packages
```bash
sudo apt update && sudo apt upgrade -y
```

---

## Step 2: Install Docker
```bash
sudo apt install docker.io -y
sudo systemctl status docker 
```
**If Docker is not running:**
```bash
sudo systemctl start docker
sudo systemctl enable docker
```
**And:**
Verify Docker installation:
```bash
docker --version
```

---

### Step 3: Install Nginx
```bash
sudo apt install nginx -y
```

---

### Step 4: Verify Nginx Service
```bash
systemctl status nginx
```
**If Nginx is not running:**
```bash
sudo systemctl start nginx
sudo systemctl enable nginx
```

---

## Part 3: Security Group Configuration

- Opened Port 80 (HTTP) in the cloud firewall / security group
- Allowed inbound traffic from 0.0.0.0/0

**Test Web Access**
Opened a browser and visited:
```cpp
http://44.250.180.68
```

### Nginx Welcome Page
![Nginx Webpage](images/nginx-webpage.png)

<p align="center">
  <b>Figure:</b> Nginx default welcome page accessible from the internet
</p>

---

## Part 4: Extract Nginx Logs

### Step 1: View Nginx Access Logs
```bash
sudo cat /var/log/nginx/access.log
```

---

### Step 2: Save Logs to a File
```bash
sudo cat /var/log/nginx/access.log > ~/nginx-logs.txt
```
**Verify:**
```bash
ls -l nginx-logs.txt
```

### Nginx Logs File
![Nginx Logs](images/nginx-log.png)

<p align="center">
  <b>Figure:</b> Nginx access logs extracted and saved to file
</p>

---

**Step 3: Download Logs to Local Machine**
```local
scp -i my-key.pem ubuntu@<instance-ip>:~/nginx-logs.txt .
```

---

## Challenges Faced:
- Nginx page not loading initially
- Issue was due to Port 80 not opened in security group
- Fixed by updating inbound rules and reloading the page

---

## What I Learned:
- How to launch and access a cloud server using SSH
- Installing and managing services using systemctl
- Importance of security groups and firewall rules
- How to locate and extract Nginx logs
- Real-world cloud deployment workflow

---

## My Learnings:
Deployed my first cloud-based web server using Nginx, verified public access, and extracted logs for analysis.
This felt like real production work, not just theory.
