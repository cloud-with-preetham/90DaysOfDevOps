# Docker Cheat Sheet

## Container Commands

- `docker run <image>` — Create and start a container
- `docker run -it <image>` — Run container in interactive mode
- `docker run -d <image>` — Run container in detached mode
- `docker ps` — List running containers
- `docker ps -a` — List all containers
- `docker stop <container>` — Stop a running container
- `docker start <container>` — Start a stopped container
- `docker rm <container>` — Remove a container
- `docker exec -it <container> <command>` — Execute command in running container
- `docker logs <container>` — View container logs
- `docker logs -f <container>` — Follow container logs

## Image Commands

- `docker build -t <name:tag> .` — Build image from Dockerfile
- `docker pull <image>` — Download image from registry
- `docker push <image>` — Upload image to registry
- `docker tag <source> <target>` — Tag an image
- `docker images` — List all images
- `docker rmi <image>` — Remove an image
- `docker image ls` — List images
- `docker image inspect <image>` — View image details

## Volume Commands

- `docker volume create <name>` — Create a named volume
- `docker volume ls` — List all volumes
- `docker volume inspect <name>` — View volume details
- `docker volume rm <name>` — Remove a volume
- `docker run -v <volume>:<path>` — Mount named volume
- `docker run -v <host-path>:<container-path>` — Bind mount

## Network Commands

- `docker network create <name>` — Create a custom network
- `docker network ls` — List all networks
- `docker network inspect <name>` — View network details
- `docker network connect <network> <container>` — Connect container to network
- `docker network disconnect <network> <container>` — Disconnect container from network

## Compose Commands

- `docker compose up` — Start services
- `docker compose up -d` — Start services in detached mode
- `docker compose down` — Stop and remove services
- `docker compose down -v` — Stop services and remove volumes
- `docker compose ps` — List running services
- `docker compose logs` — View service logs
- `docker compose build` — Build or rebuild services
- `docker compose restart` — Restart services

## Cleanup Commands

- `docker system prune` — Remove unused data
- `docker system prune -a` — Remove all unused images
- `docker container prune` — Remove stopped containers
- `docker image prune` — Remove dangling images
- `docker volume prune` — Remove unused volumes
- `docker network prune` — Remove unused networks
- `docker system df` — Show disk usage

## Dockerfile Instructions

- `FROM <image>` — Set base image
- `RUN <command>` — Execute command during build
- `COPY <src> <dest>` — Copy files from host to image
- `ADD <src> <dest>` — Copy files (supports URLs and tar extraction)
- `WORKDIR <path>` — Set working directory
- `EXPOSE <port>` — Document port usage
- `ENV <key>=<value>` — Set environment variable
- `CMD ["executable", "param"]` — Default command (can be overridden)
- `ENTRYPOINT ["executable"]` — Main executable (not easily overridden)
- `VOLUME <path>` — Create mount point
- `USER <user>` — Set user for RUN, CMD, ENTRYPOINT
- `ARG <name>` — Define build-time variable
- `HEALTHCHECK` — Define container health check

## Common Flags

- `-d` — Detached mode
- `-it` — Interactive terminal
- `-p <host>:<container>` — Port mapping
- `-v <volume>:<path>` — Volume mount
- `--name <name>` — Assign container name
- `--network <network>` — Connect to network
- `-e <KEY>=<value>` — Set environment variable
- `--rm` — Remove container after exit
- `--restart <policy>` — Restart policy (no, always, on-failure, unless-stopped)
