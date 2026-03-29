# Kubernetes Capstone Project – WordPress + MySQL Deployment

## Project Overview

Designed and deployed a production-like WordPress + MySQL application on Kubernetes using core Kubernetes components such as Deployments, StatefulSets, Services, ConfigMaps, Secrets, Persistent Volumes, Probes, Resource Limits, and Horizontal Pod Autoscaler (HPA). This project demonstrates container orchestration, self-healing, autoscaling, and persistent storage in a Kubernetes environment.

---

## S.T.A.R Explanation

### Situation

Modern applications require scalable, highly available, and fault-tolerant infrastructure. Traditional deployments lack self-healing, autoscaling, and persistent storage management.

### Task

Deploy a real-world multi-tier application (WordPress + MySQL) on Kubernetes with persistent storage, autoscaling, health checks, and secure configuration management.

### Action

Built a Kubernetes architecture using StatefulSet for MySQL, Deployment for WordPress, ConfigMaps and Secrets for configuration management, Persistent Volume Claims for storage, NodePort Service for external access, and Horizontal Pod Autoscaler for scaling based on CPU usage. Implemented liveness and readiness probes to ensure application health and availability.

### Result

Successfully deployed a scalable and self-healing WordPress application on Kubernetes with persistent storage. Verified high availability, automatic pod recovery, and autoscaling under load, simulating a production-grade deployment.

---

## Technical Implementation

### Features / Modules

- WordPress Frontend (Deployment)
- MySQL Database (StatefulSet)
- Persistent Storage (PVC)
- Config Management (ConfigMap)
- Secret Management (Kubernetes Secret)
- Internal Communication (Headless Service)
- External Access (NodePort Service)
- Health Monitoring (Liveness & Readiness Probes)
- Autoscaling (Horizontal Pod Autoscaler)

### API Endpoints

- WordPress Web UI: `http://<NodeIP>:30080`

### Tech Stack

- Kubernetes
- Docker
- WordPress
- MySQL
- YAML
- Linux
- Helm

---

## DevOps Concepts Used

- Container Orchestration (Kubernetes)
- Deployments & StatefulSets
- Services (ClusterIP, NodePort, Headless)
- ConfigMaps & Secrets
- Persistent Volume Claims (PVC)
- Resource Requests & Limits
- Liveness & Readiness Probes
- Horizontal Pod Autoscaling (HPA)
- Helm Package Management
- Self-Healing & High Availability

---

## What I Learned

- How StatefulSets manage persistent data in Kubernetes
- How Deployments ensure high availability and self-healing
- How Kubernetes Services enable internal and external communication
- How ConfigMaps and Secrets separate configuration from code
- How resource limits and autoscaling improve performance and reliability
- How multiple Kubernetes components work together in a real-world application

---

## Future Improvements

- Implement Ingress Controller for domain-based routing
- Enable HTTPS using TLS certificates
- Use Managed Database (AWS RDS)
- Implement Monitoring using Prometheus & Grafana
- Add CI/CD pipeline for automated deployment
- Implement automated backups for MySQL
