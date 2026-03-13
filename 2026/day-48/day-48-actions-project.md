# Day 48 – GitHub Actions CI/CD Capstone

## Overview

This project implements a complete **DevSecOps CI/CD pipeline** using GitHub Actions.

The pipeline automates:

- Application testing
- Docker image creation
- Security scanning
- Deployment
- Monitoring

---

## Pipeline Architecture

![Pipeline Architecture](pipeline-architecture.png)

---

## Workflows Implemented

### 1️⃣ PR Pipeline

Trigger:

```
pull_request
```

Purpose:

- Validate code changes
- Run tests before merging

---

### 2️⃣ Build & Test Workflow

Reusable workflow that:

- Sets up Python
- Installs dependencies
- Executes test scripts

---

### 3️⃣ Docker Workflow

Reusable workflow responsible for:

- Building container images
- Using Docker Buildx
- Pushing images to Docker Hub

---

### 4️⃣ Security Scanning

Images are scanned using **Trivy** to detect vulnerabilities.

Pipeline fails if **CRITICAL vulnerabilities** are detected.

---

### 5️⃣ Deployment

Deployment stage simulates deploying the image to production.

Uses:

```
environment: production
```

---

### 6️⃣ Scheduled Health Check

Runs every:

```
12 hours
```

Checks:

```
curl /health
```

---

## Docker Image

Published to Docker Hub:

```
h4kops/github-actions-capestone
```

---

## Key DevOps Concepts Demonstrated

- CI/CD automation
- Reusable GitHub workflows
- Secret management
- Containerization
- Security scanning
- Monitoring automation

---

## Future Improvements

Possible enhancements:

- Slack notifications
- Multi-environment deployment
- Kubernetes deployment
- Infrastructure as Code
- Automated rollback

---

## Conclusion

This project demonstrates how GitHub Actions can be used to build a complete **DevSecOps CI/CD pipeline** using modern best practices.
