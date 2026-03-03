# Day 37 – Docker Revision

## Self-Assessment Checklist

- [x] Run a container from Docker Hub (interactive + detached)
- [x] List, stop, remove containers and images
- [x] Explain image layers and how caching works
- [x] Write a Dockerfile from scratch with FROM, RUN, COPY, WORKDIR, CMD
- [x] Explain CMD vs ENTRYPOINT
- [x] Build and tag a custom image
- [x] Create and use named volumes
- [x] Use bind mounts
- [x] Create custom networks and connect containers
- [x] Write a docker-compose.yml for a multi-container app
- [x] Use environment variables and .env files in Compose
- [x] Write a multi-stage Dockerfile
- [x] Push an image to Docker Hub
- [x] Use healthchecks and depends_on

---

## Quick-Fire Questions & Answers

### 1. What is the difference between an image and a container?

**Answer:** An image is a read-only template with instructions for creating a container. A container is a running instance of an image with its own writable layer.

### 2. What happens to data inside a container when you remove it?

**Answer:** All data stored in the container's writable layer is permanently lost unless it's stored in a volume or bind mount.

### 3. How do two containers on the same custom network communicate?

**Answer:** Containers on the same custom network can communicate using container names as DNS hostnames. Docker's built-in DNS resolves container names to IP addresses.

### 4. What does `docker compose down -v` do differently from `docker compose down`?

**Answer:** `docker compose down` stops and removes containers and networks. `docker compose down -v` additionally removes named volumes defined in the compose file.

### 5. Why are multi-stage builds useful?

**Answer:** Multi-stage builds reduce final image size by separating build dependencies from runtime dependencies. Only necessary artifacts are copied to the final stage.

### 6. What is the difference between `COPY` and `ADD`?

**Answer:** `COPY` simply copies files from host to image. `ADD` has additional features like extracting tar files and downloading from URLs, but `COPY` is preferred for transparency.

### 7. What does `-p 8080:80` mean?

**Answer:** It maps port 8080 on the host machine to port 80 inside the container. Traffic to host:8080 is forwarded to container:80.

### 8. How do you check how much disk space Docker is using?

**Answer:** Use `docker system df` to see disk usage breakdown by images, containers, volumes, and build cache.

---

## Key Concepts Reviewed

### Image Layers & Caching

- Each Dockerfile instruction creates a new layer
- Layers are cached and reused if unchanged
- Order instructions from least to most frequently changing
- Cached layers speed up builds significantly

### CMD vs ENTRYPOINT

- **CMD**: Provides default arguments, easily overridden
- **ENTRYPOINT**: Defines the main executable, harder to override
- Best practice: Use ENTRYPOINT for executable, CMD for default args

### Volumes vs Bind Mounts

- **Named Volumes**: Managed by Docker, portable, recommended for production
- **Bind Mounts**: Direct host path mapping, useful for development

### Docker Networking

- **Bridge** (default): Isolated network for containers
- **Host**: Container uses host network directly
- **Custom networks**: Enable DNS-based container communication

---

## Areas for Improvement

1. Multi-stage Dockerfile optimization
2. Advanced Docker Compose configurations with healthchecks

---

## Hands-On Practice Completed

- Rebuilt a multi-stage Dockerfile for a Node.js app
- Created a docker-compose.yml with healthchecks and depends_on

---

**Date Completed:** 03-03-2026
**Time Spent:** 60 minutes
