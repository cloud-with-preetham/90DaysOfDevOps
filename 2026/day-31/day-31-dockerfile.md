# Day 31 - Dockerfile: Build Your Own Images

## Overview

Today I learned how to write Dockerfiles and build custom Docker images. This is a crucial skill for containerizing applications and creating reproducible environments.

---

## Task 1: Your First Dockerfile

### Steps:

1. Created folder `my-first-image`
2. Created Dockerfile with ubuntu base image
3. Installed curl and set default command
4. Built image with tag `my-ubuntu:v1`
5. Ran container to verify output

### Dockerfile:

```dockerfile
FROM ubuntu
RUN apt-get update && apt-get install -y curl
CMD ["echo", "Hello from my custom image!"]
```

### Commands:

```bash
docker build -t my-ubuntu:v1 .
docker run my-ubuntu:v1
```

---

## Task 2: Dockerfile Instructions

### Dockerfile with all instructions:

```dockerfile
FROM nginx:alpine
RUN apk add --no-cache curl
COPY index.html /usr/share/nginx/html/
WORKDIR /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

### What each instruction does:

- **FROM**: Specifies the base image to build upon
- **RUN**: Executes commands during the build process
- **COPY**: Copies files from host to the image
- **WORKDIR**: Sets the working directory for subsequent instructions
- **EXPOSE**: Documents which port the container listens on
- **CMD**: Defines the default command to run when container starts

---

## Task 3: CMD vs ENTRYPOINT

### CMD Behavior:

```dockerfile
FROM ubuntu
CMD ["echo", "hello"]
```

- Running `docker run image` → prints "hello"
- Running `docker run image pwd` → executes "pwd" (CMD is overridden)

### ENTRYPOINT Behavior:

```dockerfile
FROM ubuntu
ENTRYPOINT ["echo"]
```

- Running `docker run image` → prints nothing
- Running `docker run image hello` → prints "Welcome to DAY 31" (arguments are appended)

### When to use:

- **CMD**: When you want the command to be easily overridable
- **ENTRYPOINT**: When you want the container to always run a specific executable, with flexible arguments

---

## Task 4: Build a Simple Web App Image

### index.html:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>My Docker Website</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
      }
      .container {
        background: white;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        text-align: center;
      }
      h1 {
        color: #667eea;
        margin-bottom: 20px;
      }
      p {
        color: #555;
        line-height: 1.6;
      }
      .badge {
        display: inline-block;
        background: #667eea;
        color: white;
        padding: 5px 15px;
        border-radius: 20px;
        margin-top: 20px;
        font-size: 14px;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <h1>🐳 Hello from Docker!</h1>
      <p>This is my custom Nginx container running in Docker.</p>
      <p>Successfully built and deployed using Dockerfile!</p>
      <div class="badge">#90DaysOfDevOps</div>
    </div>
  </body>
</html>
```

### Dockerfile:

```dockerfile
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/
```

### Commands:

```bash
docker build -t my-website:v1 .
docker run -d -p 8080:80 my-website:v1
```

Access at: http://localhost:8080

---

## Task 5: .dockerignore

### .dockerignore file:

```
node_modules
.git
*.md
.env
```

### Purpose:

- Reduces build context size
- Prevents sensitive files from being copied
- Speeds up build process
- Keeps images clean and minimal

---

## Task 6: Build Optimization

### Key Learnings:

1. **Docker Layer Caching**: Docker caches each layer and reuses them if nothing changed
2. **Layer Order Matters**: Place frequently changing instructions at the end
3. **Best Practice**: Install dependencies first, copy code last

### Example - Optimized Dockerfile:

```dockerfile
FROM node:alpine
WORKDIR /app
# Dependencies change less frequently - copy first
COPY package*.json ./
RUN npm install
# Code changes frequently - copy last
COPY . .
CMD ["node", "app.js"]
```

### Why it matters:

- Faster rebuilds when only code changes
- Efficient use of cache
- Reduced build time in CI/CD pipelines

---

## Key Takeaways

1. Dockerfiles are recipes for building images
2. Each instruction creates a new layer
3. Layer order affects build performance
4. Use .dockerignore to exclude unnecessary files
5. CMD is overridable, ENTRYPOINT is fixed
6. Always optimize for caching

---

## Commands Reference

```bash
# Build image
docker build -t name:tag .

# Build with specific Dockerfile
docker build -t name:tag -f Dockerfile.custom .

# List images
docker images

# Remove image
docker rmi image-name

# View image history
docker history image-name
```

---

## Results & Screenshots

### Task 1: First Dockerfile

✅ Built my-ubuntu:v1 successfully
✅ Container printed "Hello from my custom image!"

![Task 1](screenshots/Task%201/task1.png)

### Task 2: All Dockerfile Instructions

✅ Created Dockerfile with FROM, RUN, COPY, WORKDIR, EXPOSE, CMD
✅ Successfully built and ran nginx container

![Task 2 - Build](screenshots/Task%202/1_task2.png)
![Task 2 - Run](screenshots/Task%202/2_test2.png)
![Task 2 - Webpage](screenshots/Task%202/nginx_webpage.png)

### Task 3: CMD vs ENTRYPOINT

✅ Tested both approaches
✅ Understood the difference in behavior

![Task 3 - CMD](screenshots/Task%203/1_task3.png)
![Task 3 - ENTRYPOINT](screenshots/Task%203/2_task3.png)

### Task 4: Web App

✅ Built my-website:v1 image
✅ Deployed on port 8080
✅ Accessed via EC2 public IP successfully

![Task 4 - Build](screenshots/Task%204/1_task4.png)
![Task 4 - Run](screenshots/Task%204/2_task4.png)
![Task 4 - Verify](screenshots/Task%204/3_task4.png)
![Task 4 - Webpage](screenshots/Task%204/webpage.png)

### Task 5: .dockerignore

✅ Created .dockerignore file
✅ Verified excluded files not copied to image

![Task 5](screenshots/Task%205/task5.png)

### Task 6: Build Optimization

✅ Demonstrated layer caching
✅ Optimized Dockerfile for faster rebuilds

![Task 6 - Unoptimized](screenshots/Task%206/1_task6.png)
![Task 6 - Optimized](screenshots/Task%206/2_task6.png)
![Task 6 - Cache Demo](screenshots/Task%206/3_task6.png)
