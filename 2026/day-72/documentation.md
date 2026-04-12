# Ansible-Based Docker & Nginx Deployment – DevOps Automation Project

## Project Overview

An end-to-end infrastructure automation project using Ansible to provision a server, deploy a containerized application using Docker, and configure Nginx as a reverse proxy.

The entire setup is automated using role-based Ansible architecture, enabling one-command deployment from a fresh server to a production-style environment.

---

## S.T.A.R Explanation

### S – Situation

- Manual server setup for applications is repetitive and error-prone
- Installing Docker, running containers, and configuring Nginx requires multiple manual steps
- No standardized way to ensure consistent deployments across environments

### T – Task

- Automate full server provisioning using Ansible
- Deploy a containerized application using Docker
- Configure Nginx as a reverse proxy to expose the application
- Ensure idempotent and repeatable infrastructure setup

### A – Action

- Designed a modular Ansible project using roles: **common**, **docker**, and **nginx**
- Implemented system setup automation (packages, timezone, user creation)
- Installed and configured Docker using Ansible modules
- Deployed containerized application with port mapping (8080 → 80)
- Configured Nginx using Jinja2 templates to act as a reverse proxy
- Implemented handlers for efficient service reloads
- Structured variables using `group_vars` and role defaults
- Debugged real-world issues including inventory setup, permissions, missing templates, and variable resolution

### R – Result

- Achieved one-command deployment of a complete application stack
- Eliminated manual configuration errors through automation
- Ensured idempotency — repeated runs produce consistent results
- Built a scalable and reusable deployment structure
- Successfully deployed application accessible via Nginx on port 80

---

## Technical Implementation

### Architecture

```id="m3a8qe"
Client → Nginx (Port 80) → Docker Container (Port 8080)
```

---

### Components Built

1. **Common Role**
   - Package installation
   - Timezone configuration
   - User provisioning

2. **Docker Role**
   - Docker installation and setup
   - Image pull from Docker Hub
   - Container deployment with restart policy

3. **Nginx Role**
   - Nginx installation
   - Reverse proxy configuration using templates
   - Service management with handlers

---

### Tech Stack

- **Ansible** – Configuration management & automation
- **Docker** – Containerization platform
- **Nginx** – Reverse proxy server
- **Linux (Ubuntu)** – Target environment

---

### Key Features

- Role-based Ansible architecture
- Idempotent infrastructure automation
- Dynamic configuration using variables and templates
- Service orchestration using handlers
- Reverse proxy setup for production-style routing

---

## DevOps Thinking Applied

This project demonstrates:

- **Automation** – Entire deployment done via a single playbook
- **Idempotency** – Safe re-execution without unintended changes
- **Modularity** – Roles for reusable and maintainable code
- **Debugging** – Solved real-world issues (permissions, missing configs, variable scope)
- **Production mindset** – Reverse proxy architecture and service management

---

## What I Learned

- How to structure real-world Ansible projects using roles
- Docker automation using Ansible modules
- Nginx configuration using Jinja2 templates
- Importance of inventory and variable management
- Debugging infrastructure issues systematically
- DevOps mindset: automate, validate, and iterate

---

## Next Steps

- Add SSL using Let's Encrypt (Certbot)
- Deploy multi-container applications using Docker Compose
- Integrate CI/CD pipeline (GitHub Actions / Jenkins)
- Add monitoring (Prometheus + Grafana)
- Extend to cloud provisioning using Terraform

---

## Repository

GitHub: (Add your repo link here)

---

**Built as part of 90 Days of DevOps – TrainWithShubham**

#DevOps #Ansible #Docker #Nginx #Automation #90DaysOfDevOps
