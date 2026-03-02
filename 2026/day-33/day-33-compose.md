# Day 33 – Docker Compose: Multi-Container Basics

## Overview

Docker Compose allows you to run multi-container applications with a single command using a YAML configuration file.

---

## Task 1: Install & Verify

### Check Docker Compose Installation

```bash
docker compose version
```

**Expected Output:**

```
Docker Compose version v2.x.x
```

![Docker Compose Version](screenshots/Task%201/task-1.png)

---

## Task 2: Your First Compose File

### Create Project Directory

```bash
mkdir compose-basics
cd compose-basics
```

### Create docker-compose.yml

```yaml
version: "3.8"

services:
  nginx:
    image: nginx:latest
    ports:
      - "8080:80"
    container_name: my-nginx
```

### Start the Service

```bash
docker compose up
```

### Access in Browser

```
http://localhost:8080
```

![Docker Compose Up](screenshots/Task%202/task2.png)

![Nginx Welcome Page](screenshots/Task%202/webpage_nginx.png)

### Stop the Service

```bash
docker compose down
```

---

## Task 3: Two-Container Setup (WordPress + MySQL)

### Create docker-compose.yml

```yaml
version: "3.8"

services:
  db:
    image: mysql:8.0
    volumes:
      - db_data:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wpuser
      MYSQL_PASSWORD: wppassword
    networks:
      - wp-network

  wordpress:
    image: wordpress:latest
    ports:
      - "8000:80"
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wpuser
      WORDPRESS_DB_PASSWORD: wppassword
      WORDPRESS_DB_NAME: wordpress
    depends_on:
      - db
    networks:
      - wp-network

volumes:
  db_data:

networks:
  wp-network:
```

### Start Services

```bash
docker compose up -d
```

### Access WordPress

```
http://localhost:8000
```

![WordPress MySQL Setup](screenshots/Task%203/task3.png)

![WordPress Website](screenshots/Task%203/wordpress_website.png)

### Verify Data Persistence

```bash
docker compose down
docker compose up -d
```

---

## Task 4: Compose Commands

### Start in Detached Mode

```bash
docker compose up -d
```

### View Running Services

```bash
docker compose ps
```

![Docker Compose Commands 1](screenshots/Task%204/1_task4.png)

### View All Logs

```bash
docker compose logs -f
```

### View Specific Service Logs

```bash
docker compose logs -f wordpress
docker compose logs -f db
```

![Docker Compose Commands 2](screenshots/Task%204/2_task4.png)

### Stop Services (Without Removing)

```bash
docker compose stop
```

### Remove Everything

```bash
docker compose down
docker compose down -v  # Also removes volumes
```

![Docker Compose Commands 3](screenshots/Task%204/3_task4.png)

![Docker Compose Commands 4](screenshots/Task%204/4_task4.png)

### Rebuild Images

```bash
docker compose up --build
```

---

## Task 5: Environment Variables

### Method 1: Direct in docker-compose.yml

```yaml
services:
  app:
    image: nginx
    environment:
      - APP_ENV=production
      - DEBUG=false
```

### Method 2: Using .env File

**Create .env file:**

```env
MYSQL_ROOT_PASSWORD=rootpassword
MYSQL_DATABASE=wordpress
MYSQL_USER=wpuser
MYSQL_PASSWORD=wppassword
WP_PORT=8000
```

**Reference in docker-compose.yml:**

```yaml
version: "3.8"

services:
  db:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}

  wordpress:
    image: wordpress:latest
    ports:
      - "${WP_PORT}:80"
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: ${MYSQL_USER}
      WORDPRESS_DB_PASSWORD: ${MYSQL_PASSWORD}
      WORDPRESS_DB_NAME: ${MYSQL_DATABASE}
```

### Verify Variables

```bash
docker compose config
```

![Environment Variables 1](screenshots/Task%205/1_task5.png)

![Environment Variables 2](screenshots/Task%205/2_task5.png)

---

## Key Learnings

1. **Docker Compose** simplifies multi-container management
2. **Service names** act as DNS names for container communication
3. **Volumes** persist data across container restarts
4. **Networks** are created automatically by Compose
5. **Environment variables** can be managed via .env files

---

## Useful Commands Summary

| Command                                   | Description                |
| ----------------------------------------- | -------------------------- |
| `docker compose up`                       | Start services             |
| `docker compose up -d`                    | Start in detached mode     |
| `docker compose down`                     | Stop and remove containers |
| `docker compose ps`                       | List running services      |
| `docker compose logs`                     | View logs                  |
| `docker compose stop`                     | Stop services              |
| `docker compose start`                    | Start stopped services     |
| `docker compose restart`                  | Restart services           |
| `docker compose exec <service> <command>` | Execute command in service |

---

## Completed

- Installed and verified Docker Compose
- Created first Compose file with Nginx
- Set up WordPress + MySQL multi-container app
- Practiced essential Compose commands
- Implemented environment variables
