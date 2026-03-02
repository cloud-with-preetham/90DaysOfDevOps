# Day 36 – Docker Project Documentation

## Project Overview

This document outlines the complete Dockerization of a full-stack application as part of the #90DaysOfDevOps challenge.

---

## Application Selection

**Application Type:** Node.js Express REST API with MongoDB

**Why this app:**

- Simple CRUD operations demonstrate real-world use case
- MongoDB is commonly used with Node.js in production
- Minimal dependencies keep image size small

---

## Dockerfile Implementation

```dockerfile
FROM node:18-alpine
# Use alpine for smaller image size

RUN addgroup -g 1001 appgroup && adduser -u 1001 -S appuser -G appgroup
# Create non-root user for security

WORKDIR /app
# Set working directory

COPY app/package*.json ./
# Copy dependency files first for better caching

RUN npm install --production
# Install production dependencies only

COPY --chown=appuser:appgroup app/ .
# Copy application code and set ownership

USER appuser
# Switch to non-root user

EXPOSE 3000
# Expose application port

CMD ["node", "server.js"]
# Start application
```

---

## Docker Compose Configuration

```yaml
services:
  app:
    build: .
    container_name: task-api
    ports:
      - "3000:3000"
    environment:
      - MONGO_URI=mongodb://${MONGO_USER}:${MONGO_PASSWORD}@mongodb:27017/${MONGO_DB}?authSource=admin
    depends_on:
      mongodb:
        condition: service_healthy
    networks:
      - app-network
    restart: unless-stopped

  mongodb:
    image: mongo:7-jammy
    container_name: task-mongodb
    environment:
      - MONGO_INITDB_ROOT_USERNAME=${MONGO_USER}
      - MONGO_INITDB_ROOT_PASSWORD=${MONGO_PASSWORD}
      - MONGO_INITDB_DATABASE=${MONGO_DB}
    volumes:
      - mongo-data:/data/db
    networks:
      - app-network
    healthcheck:
      test: echo 'db.runCommand("ping").ok' | mongosh localhost:27017/test --quiet
      interval: 10s
      timeout: 5s
      retries: 5
    restart: unless-stopped

volumes:
  mongo-data:

networks:
  app-network:
    driver: bridge
```

---

## .dockerignore File

```
node_modules
npm-debug.log
.git
.gitignore
.env
.DS_Store
*.md
Dockerfile
docker-compose.yml
```

---

## Environment Variables (.env)

```
MONGO_USER=admin
MONGO_PASSWORD=secret123
MONGO_DB=taskdb
```

---

## Challenges Faced & Solutions

### Challenge 1: MongoDB Connection Timing

**Problem:** App started before MongoDB was ready
**Solution:** Added healthcheck to MongoDB and used depends_on with condition

### Challenge 2: Image Size Optimization

**Problem:** Initial image was over 200MB
**Solution:** Used alpine base image and production dependencies only, reduced to ~120MB

### Challenge 3: Non-root User Permissions

**Problem:** Permission denied errors when running as non-root
**Solution:** Used --chown flag in COPY commands to set proper ownership

---

## Image Details

- **Final Image Size:** ~120 MB
- **Base Image:** node:18-alpine
- **Layers:** 6 layers
- **Security:** Non-root user implemented

---

## Docker Hub

**Repository:** YOUR_USERNAME/task-api
**Tag:** latest
**Pull Command:**

```bash
docker pull YOUR_USERNAME/task-api:latest
```

**Docker Hub Link:** https://hub.docker.com/r/YOUR_USERNAME/task-api

**Note:** Replace YOUR_USERNAME with your actual Docker Hub username

---

## How to Run

### Prerequisites

- Docker installed
- Docker Compose installed

### Steps

1. Clone the repository:

```bash
git clone [your-repo-url]
cd [project-directory]
```

2. Create `.env` file with required variables:

```bash
cp .env.example .env
# Edit .env with your values
```

3. Build and run with Docker Compose:

```bash
docker compose up -d
```

4. Verify services are running:

```bash
docker compose ps
```

5. Access the application:

```
http://localhost:3000
```

### Using Pre-built Image from Docker Hub

```bash
docker compose pull
docker compose up -d
```

---

## Testing the Complete Flow

1. **Clean local environment:**

```bash
docker compose down -v
docker rmi [image-name]
```

2. **Pull and run from Docker Hub:**

```bash
docker compose pull
docker compose up -d
```

3. **Verify functionality:**

- Application accessible
- Database connected
- Data persists after restart

---

## Application Code

### server.js

```javascript
const express = require("express");
const mongoose = require("mongoose");

const app = express();
app.use(express.json());

mongoose
  .connect(process.env.MONGO_URI)
  .then(() => console.log("MongoDB connected"))
  .catch((err) => console.error("MongoDB connection error:", err));

const TaskSchema = new mongoose.Schema({
  title: String,
  completed: { type: Boolean, default: false },
});

const Task = mongoose.model("Task", TaskSchema);

app.get("/", (req, res) => res.json({ message: "Task API Running" }));

app.get("/tasks", async (req, res) => {
  const tasks = await Task.find();
  res.json(tasks);
});

app.post("/tasks", async (req, res) => {
  const task = await Task.create(req.body);
  res.status(201).json(task);
});

app.listen(3000, () => console.log("Server running on port 3000"));
```

### package.json

```json
{
  "name": "task-api",
  "version": "1.0.0",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "mongoose": "^8.0.0"
  }
}
```

---

## API Testing

### Health Check

```bash
curl http://localhost:3000
# Response: {"message":"Task API Running"}
```

### Create Task

```bash
curl -X POST http://localhost:3000/tasks \
  -H "Content-Type: application/json" \
  -d '{"title":"Learn Docker","completed":false}'
# Response: {"_id":"...","title":"Learn Docker","completed":false}
```

### Get All Tasks

```bash
curl http://localhost:3000/tasks
# Response: [{"_id":"...","title":"Learn Docker","completed":false}]
```

---

## Key Learnings

- Docker Compose simplifies multi-container orchestration
- Healthchecks ensure proper startup order and reliability
- Alpine images significantly reduce container size
- Non-root users are essential for production security
- Environment variables keep sensitive data out of images

---

## Future Improvements

- [x] Add CI/CD pipeline
- [ ] Implement container orchestration (Kubernetes)
- [x] Add monitoring and logging
- [x] Implement automated backups

---

## Screenshots

Project includes 7 screenshots documenting:

1. Project structure
2. Docker build process
3. Container status
4. API testing
5. MongoDB connection
6. Docker Hub push
7. Complete workflow

---

## Project Structure

```
day-36/
├── app/
│   ├── server.js          # Express API
│   └── package.json       # Dependencies
├── screenshots/           # Project screenshots
├── Dockerfile            # Container image definition
├── docker-compose.yml    # Multi-container setup
├── .dockerignore         # Build optimization
├── .env                  # Environment variables
└── day-36-docker-project.md  # This file
```

---

**Challenge Completed:** Day 36 of #90DaysOfDevOps
**Date:** March 2, 2026
**Project:** Task API - Node.js + Express + MongoDB
