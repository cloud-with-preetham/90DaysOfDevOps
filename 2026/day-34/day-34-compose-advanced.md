# Day 34 – Docker Compose: Advanced Multi-Container Apps

## Overview

Implemented a production-ready multi-container application using Docker Compose with healthchecks, restart policies, named networks, and volumes.

## Architecture

- **Web App**: Python Flask application
- **Database**: PostgreSQL with persistent storage
- **Cache**: Redis for in-memory caching

## Task 1: App Stack ✅

Created 3-service stack with Flask, PostgreSQL, and Redis.

**Files:**

- `app/app.py` - Flask app with 3 routes
- `app/Dockerfile` - Container build instructions
- `docker-compose.yml` - Service orchestration

**Screenshots:**

![Web Application](screenshots/Task%201/webpage_docker.png)
_Flask web application running_

![Database Connection](screenshots/Task%201/database.png)
_PostgreSQL database connection test_

![Redis Cache](screenshots/Task%201/cache-test.png)
_Redis cache functionality_

## Task 2: Dependencies & Healthchecks ✅

**Implemented:**

- Healthcheck on PostgreSQL using `pg_isready`
- `depends_on` with `condition: service_healthy`
- Web service waits for database to be ready

**Result:** No connection errors during startup

**Screenshots:**

![Healthcheck Configuration](screenshots/Task%202/1_task2.png)
_Docker Compose healthcheck setup_

![Service Dependencies](screenshots/Task%202/2_task2.png)
_depends_on configuration_

![Healthcheck Status](screenshots/Task%202/3_task2.png)
_Service health status_

![Startup Sequence](screenshots/Task%202/4_task2.png)
_Services starting in correct order_

## Task 3: Restart Policies ✅

**Tested:**

- `restart: always` - Container restarts after kill
- `restart: on-failure` - Only restarts on error exit

**Use Cases:**

- **always**: Production databases, critical services
- **on-failure**: Development, services that should stop cleanly
- **unless-stopped**: Persist across reboots but respect manual stops
- **no**: Default, no automatic restart

**Screenshots:**

![Restart Policy Configuration](screenshots/Task%203/1_task3.png)
_Restart policies in docker-compose.yml_

![Container Auto-Restart](screenshots/Task%203/2_task3.png)
_Container automatically restarting after kill_

## Task 4: Custom Dockerfiles ✅

**Workflow:**

1. Modified `app.py` code
2. Ran `docker compose up --build`
3. Changes reflected immediately

**Benefit:** Single command to rebuild and deploy

**Screenshots:**

![Code Modification](screenshots/Task%204/1_task4.png)
_Modified application code_

![Rebuild and Deploy](screenshots/Task%204/2_task4.png)
_docker compose up --build in action_

## Task 5: Named Networks & Volumes ✅

**Added:**

- Network: `app-network` (bridge driver)
- Volume: `postgres-data` (persistent database storage)
- Labels: project, environment, service metadata

**Result:** Data persists across container restarts

**Screenshots:**

![Networks and Volumes](screenshots/Task%205/1_task5.png)
_Named networks and volumes configuration_

## Task 6: Scaling ✅

**Command:** `docker compose up --scale web=3`

**Issue:** Port conflict - multiple containers can't bind to same port

**Why it breaks:**

- Each replica tries to bind to `5000:5000`
- Host can only have one service per port

**Solutions:**

- Remove explicit port mapping
- Use reverse proxy (nginx)
- Use orchestration (Kubernetes, Docker Swarm)

## Key Learnings

1. Healthchecks prevent race conditions during startup
2. Restart policies ensure service availability
3. Named volumes provide data persistence
4. Scaling requires load balancer for production
5. Labels improve service organization

## Commands Used

```bash
# Start services
docker compose up -d

# Rebuild
docker compose up --build

# Scale
docker compose up --scale web=3

# View status
docker compose ps

# View logs
docker compose logs -f

# Stop services
docker compose down

# Stop and remove volumes
docker compose down -v
```

## Testing Results

✅ All services running
✅ Database connection successful
✅ Redis cache working
✅ Data persists after restart
✅ Healthchecks functioning
✅ Auto-restart working

**Verification Screenshots:**

![Service Status](screenshots/Verification/1_verify.png)
_All services running successfully_

![Container Logs](screenshots/Verification/2_verify.png)
_Service logs verification_

![Volume Persistence](screenshots/Verification/3_verify.png)
_Data persistence verification_

![Final Status](screenshots/Verification/4_verify.png)
_Complete stack health check_
