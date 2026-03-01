# Day 29 – Docker Basics

## Task 1: What is Docker?

### What is a Container and Why Do We Need Them?

A **container** is a lightweight, standalone, executable package that includes everything needed to run an application: code, runtime, system tools, libraries, and settings.

**Why we need containers:**

- **Consistency**: "Works on my machine" problem solved — runs the same everywhere
- **Isolation**: Applications run independently without conflicts
- **Efficiency**: Lightweight compared to VMs, faster startup times
- **Portability**: Easy to move between development, testing, and production
- **Scalability**: Quick to spin up multiple instances

### Containers vs Virtual Machines

| Aspect             | Containers           | Virtual Machines     |
| ------------------ | -------------------- | -------------------- |
| **Size**           | Lightweight (MBs)    | Heavy (GBs)          |
| **Startup**        | Seconds              | Minutes              |
| **OS**             | Share host OS kernel | Each has full OS     |
| **Isolation**      | Process-level        | Hardware-level       |
| **Resource Usage** | Minimal overhead     | Significant overhead |
| **Portability**    | Highly portable      | Less portable        |

**Key Difference**: Containers virtualize the OS, while VMs virtualize the hardware.

### Docker Architecture

```
┌─────────────────────────────────────────────────────────┐
│                     Docker Client                       │
│              (docker CLI commands)                      │
└────────────────────┬────────────────────────────────────┘
                     │ REST API
┌────────────────────▼────────────────────────────────────┐
│                  Docker Daemon                          │
│                  (dockerd)                              │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐               │
│  │Container │  │Container │  │Container │               │
│  │    1     │  │    2     │  │    3     │               │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘               │
│       │             │             │                     │
│  ┌────▼─────────────▼─────────────▼─────┐               │
│  │           Docker Images              │               │
│  └──────────────────────────────────────┘               │
└────────────────────┬────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────┐
│                Docker Registry                          │
│              (Docker Hub / Private)                     │
└─────────────────────────────────────────────────────────┘
```

**Components:**

- **Docker Client**: CLI tool where you run commands
- **Docker Daemon**: Background service that manages containers, images, networks
- **Images**: Read-only templates used to create containers
- **Containers**: Running instances of images
- **Registry**: Storage for Docker images (Docker Hub is the default public registry)

---

## Task 2: Install Docker

### Installation Steps

```bash
# Update package index
sudo apt-get update

# Install prerequisites
sudo apt-get install ca-certificates curl gnupg lsb-release

# Add Docker's official GPG key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

### Verify Installation

```bash
docker --version
docker run hello-world
```

### Hello World Output

The `hello-world` container output explains:

1. Docker client contacted the Docker daemon
2. Daemon pulled the "hello-world" image from Docker Hub
3. Daemon created a new container from that image
4. Container ran the executable that produced the output
5. Daemon streamed the output to the Docker client

---

## Task 3: Run Real Containers

### 1. Run Nginx Container

```bash
# Run Nginx on port 80
docker run -d -p 80:80 --name my-nginx nginx

# Access in browser: http://localhost:80
```

### 2. Run Ubuntu Container (Interactive Mode)

```bash
# Run Ubuntu interactively
docker run -it ubuntu bash

# Inside container, explore:
ls
pwd
cat /etc/os-release
exit
```

### 3. List Running Containers

```bash
docker ps
```

### 4. List All Containers (Including Stopped)

```bash
docker ps -a
```

### 5. Stop and Remove Container

```bash
# Stop container
docker stop container-id

# Remove container
docker rm container-id
```

---

## Task 4: Explore

### 1. Detached Mode

```bash
# Run in detached mode (background)
docker run -d --name nginx-detached nginx

# Container runs in background, returns container ID
```

**Difference**: Detached mode runs container in background; you get your terminal back immediately.

### 2. Custom Name

```bash
docker run -d --name my-custom-nginx nginx
```

### 3. Port Mapping

```bash
# Map host port 9090 to container port 80
docker run -d -p 9090:80 --name nginx-9090 nginx
```

### 4. Check Logs

```bash
docker logs nginx-9090

# Follow logs in real-time
docker logs -f nginx-9090
```

### 5. Execute Command Inside Running Container

```bash
# Execute bash inside running container
docker exec -it nginx-9090 bash

# Run single command
docker exec nginx-9090 ls /usr/share/nginx/html
```

---

## Key Commands Summary

| Command                         | Description                  |
| ------------------------------- | ---------------------------- |
| `docker run`                    | Create and start a container |
| `docker ps`                     | List running containers      |
| `docker ps -a`                  | List all containers          |
| `docker stop <container>`       | Stop a running container     |
| `docker start <container>`      | Start a stopped container    |
| `docker rm <container>`         | Remove a container           |
| `docker images`                 | List downloaded images       |
| `docker pull <image>`           | Download an image            |
| `docker logs <container>`       | View container logs          |
| `docker exec <container> <cmd>` | Execute command in container |

---

## Screenshots

### Task 2: Install Docker
![Docker Installation 1](screenshots/Task%202/1_task2.png)
![Docker Installation 2](screenshots/Task%202/2_task2.png)
![Docker Installation 3](screenshots/Task%202/3_task2.png)
![Docker Installation 4](screenshots/Task%202/4_task2.png)
![Docker Installation 5](screenshots/Task%202/5_task2.png)
![Docker Installation 6](screenshots/Task%202/6_task2.png)

### Task 3: Run Real Containers
![Running Containers 1](screenshots/Task%203/1_task3.png)
![Running Containers 2](screenshots/Task%203/2_task3.png)
![Nginx in Browser](screenshots/Task%203/webpage_nginx.png)

### Task 4: Explore
![Docker Explore 1](screenshots/Task%204/1_task4.png)
![Docker Explore 2](screenshots/Task%204/2_task4.png)

---

## Key Learnings

1. **Containers are lightweight**: They share the host OS kernel, making them faster and more efficient than VMs
2. **Docker architecture**: Client-daemon model with images stored in registries
3. **Port mapping is essential**: Containers are isolated; you need to explicitly expose ports
4. **Detached vs Interactive**: `-d` for background services, `-it` for interactive shells
5. **Container lifecycle**: run → stop → start → rm

---

## Why This Matters for DevOps

Docker revolutionized software deployment by solving the "it works on my machine" problem. Understanding containers is fundamental because:

- **CI/CD pipelines** use containers for consistent build environments
- **Kubernetes** orchestrates containers at scale
- **Microservices** are typically deployed as containers
- **Cloud-native applications** are built with containers first

Today's learning is the foundation for modern DevOps practices.
