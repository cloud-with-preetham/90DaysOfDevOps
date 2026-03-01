# Day 30 – Docker Images & Container Lifecycle

## Task 1: Docker Images

### Pull Images
```bash
docker pull nginx
docker pull ubuntu
docker pull alpine
```

### List All Images
```bash
docker images
```

### Ubuntu vs Alpine Comparison
Alpine is much smaller because it uses musl libc and busybox instead of glibc and GNU utilities, making it a minimal base image optimized for containers.

### Inspect Image
```bash
docker inspect nginx
```

### Remove Image
```bash
docker rmi <image-id>
```

---

## Task 2: Image Layers

### View Image History
```bash
docker image history nginx
```

### What are Layers?
Layers are read-only filesystem changes stacked on top of each other. Docker uses layers for:
- Efficient storage (shared layers between images)
- Faster builds (cached layers)
- Reduced bandwidth (only pull new layers)

---

## Task 3: Container Lifecycle

```bash
# Create container
docker create --name test-container nginx

# Start container
docker start test-container

# Pause container
docker pause test-container
docker ps -a

# Unpause container
docker unpause test-container

# Stop container
docker stop test-container

# Restart container
docker restart test-container

# Kill container
docker kill test-container

# Remove container
docker rm test-container
```

---

## Task 4: Working with Running Containers

```bash
# Run Nginx in detached mode
docker run -d --name my-nginx -p 8080:80 nginx

# View logs
docker logs my-nginx

# Real-time logs
docker logs -f my-nginx

# Exec into container
docker exec -it my-nginx /bin/bash

# Run single command
docker exec my-nginx ls /usr/share/nginx/html

# Inspect container
docker inspect my-nginx
```

---

## Task 5: Cleanup

```bash
# Stop all running containers
docker stop $(docker ps -q)

# Remove all stopped containers
docker container prune

# Remove unused images
docker image prune

# Check disk space
docker system df
```

---

## Key Learnings
- Images are templates, containers are running instances
- Layers enable efficient storage and caching
- Container lifecycle: create → start → pause/unpause → stop → restart → kill → remove
- Docker provides powerful inspection and cleanup tools
