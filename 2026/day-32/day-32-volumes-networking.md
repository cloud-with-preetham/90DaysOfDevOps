# Day 32 - Docker Volumes & Networking

## Task 1: The Problem - Data Loss Without Volumes

### Steps Performed

1. Ran a MySQL container without volume
2. Created a database and table with sample data
3. Stopped and removed the container
4. Started a new container

### Result

Data was lost after container removal.

### Why This Happened

Containers are ephemeral. All data stored inside a container's writable layer is deleted when the container is removed.

---

## Task 2: Named Volumes - Persistent Storage

### Commands Used

```bash
docker volume create my-db-volume
docker run -d --name mysql-db -v my-db-volume:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=password mysql
docker volume ls
docker volume inspect my-db-volume
```

### Result

Data persisted across container removals when using named volumes.

### Verification

Volume remained intact and data was accessible in the new container.

---

## Task 3: Bind Mounts - Host Directory Mapping

### Commands Used

```bash
mkdir -p ~/web-content
echo "<h1>Hello from Preetham</h1>" > ~/web-content/index.html
docker run -d --name nginx-web -p 8080:80 -v ~/web-content:/usr/share/nginx/html nginx
```

### Result

Changes to host files reflected immediately in the container.

### Difference: Named Volume vs Bind Mount

- **Named Volume**: Managed by Docker, stored in Docker's storage directory
- **Bind Mount**: Direct mapping to host filesystem path, full control over location

---

## Task 4: Docker Networking Basics

### Default Bridge Network

```bash
docker network ls
docker network inspect bridge
```

### Result

- Containers on default bridge can ping by IP
- Containers on default bridge cannot ping by name

---

## Task 5: Custom Networks

### Commands Used

```bash
docker network create my-app-net
docker run -d --name container1 --network my-app-net alpine sleep 3600
docker run -d --name container2 --network my-app-net alpine sleep 3600
docker exec container1 ping container2
```

### Result

Name-based communication works on custom networks.

### Why Custom Networks Enable Name Resolution

Custom bridge networks have built-in DNS resolution, allowing containers to discover each other by name.

---

## Task 6: Complete Application Setup

### Commands Used

```bash
docker network create app-network
docker volume create db-data
docker run -d --name postgres-db --network app-network -v db-data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=password postgres
docker run -d --name app-container --network app-network alpine sleep 3600
docker exec app-container ping postgres-db
```

### Result

Application container successfully connected to database using container name.

---

## Key Learnings

1. Volumes are essential for data persistence
2. Custom networks enable service discovery
3. Bind mounts are useful for development workflows
4. Container networking requires proper network configuration

---

## Screenshots

### Task 1: Data Loss Without Volumes

![Task 1 - Step 1](screenshots/Task%201/1_task1.png)
![Task 1 - Step 2](screenshots/Task%201/2_task1.png)
![Task 1 - Step 3](screenshots/Task%201/3_task1.png)
![Task 1 - Step 4](screenshots/Task%201/4_task1.png)

### Task 2: Named Volumes

![Task 2 - Step 1](screenshots/Task%202/1_task2.png)
![Task 2 - Step 2](screenshots/Task%202/2_task2.png)
![Task 2 - Step 3](screenshots/Task%202/3_task2.png)

### Task 3: Bind Mounts

![Task 3 - Setup](screenshots/Task%203/task3.png)
![Task 3 - Accessing Webpage](screenshots/Task%203/Accessing_webpage.png)
![Task 3 - Updated Content](screenshots/Task%203/Updated_content.png)

### Task 4: Docker Networking Basics

![Task 4 - Step 1](screenshots/Task%204/1_task4.png)
![Task 4 - Step 2](screenshots/Task%204/2_task4.png)

### Task 5: Custom Networks

![Task 5](screenshots/Task%205/task5.png)

### Task 6: Complete Application Setup

![Task 6 - Step 1](screenshots/Task%206/1_task6.png)
![Task 6 - Step 2](screenshots/Task%206/2_task6.png)
![Task 6 - Step 3](screenshots/Task%206/3_task6.png)
![Task 6 - Step 4](screenshots/Task%206/4_task6.png)
![Task 6 - Step 5](screenshots/Task%206/5_task6.png)
![Task 6 - Step 6](screenshots/Task%206/6_task6.png)
![Task 6 - Step 7](screenshots/Task%206/7_task6.png)
