# Day 35 - Multi-Stage Builds & Docker Hub

## Task 1: The Problem with Large Images

### Single-Stage Dockerfile
```dockerfile
FROM node:18
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
CMD ["node", "index.js"]
```

**Image Size:** See screenshot below

![Task 1 - Single Stage Build](screenshots/Task%201/1_task1.png)
![Task 1 - Image Size](screenshots/Task%201/2_task1.png)

---

## Task 2: Multi-Stage Build

### Multi-Stage Dockerfile
```dockerfile
# Stage 1: Build
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# Stage 2: Production
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app .
CMD ["node", "index.js"]
```

**Image Size:** See screenshot below

![Task 2 - Multi-Stage Build](screenshots/Task%202/task2.png)

**Why is it smaller?**
Multi-stage builds exclude build tools, dependencies, and intermediate files from the final image, keeping only the runtime essentials.

---

## Task 3: Push to Docker Hub

### Commands Used
```bash
docker login
docker tag my-app:multi-stage h4kops/my-app:v1.0
docker push h4kops/my-app:v1.0
docker pull h4kops/my-app:v1.0
```

**Docker Hub Link:** https://hub.docker.com/repository/docker/h4kops/my-app/general

![Task 3 - Docker Login](screenshots/Task%203/1_task3.png)
![Task 3 - Docker Push](screenshots/Task%203/2_task3.png)
![Task 3 - Docker Hub](screenshots/Task%203/3_task3.png)

---

## Task 4: Docker Hub Repository

- Repository description added
- Tags explored: `latest`, `v1.0`
- Pulling specific tags works as expected

![Task 4 - Docker Hub Repository](screenshots/Task%204/task4.png)

---

## Task 5: Image Best Practices

### Optimized Dockerfile
```dockerfile
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install --production

FROM node:18-alpine
RUN adduser -D appuser
WORKDIR /app
COPY --from=builder /app .
USER appuser
CMD ["node", "index.js"]
```

**Before:** 1.11GB (single-stage)  
**After:** 179MB (optimized)

![Task 5 - Optimized Build](screenshots/Task%205/task5.png)

### Best Practices Applied
- ✅ Minimal base image (alpine)
- ✅ Non-root user
- ✅ Reduced layers
- ✅ Specific tags

---

## Results & Learnings

- Multi-stage builds reduced image size from 1.11GB to 179MB (84% reduction)
- Alpine base images are significantly smaller than full distributions
- Running as non-root user improves security
- Specific version tags ensure reproducible builds
- Docker Hub makes sharing and versioning images simple
