# Day 52 — Kubernetes Namespaces and Deployments

## Overview

This exercise focused on two foundational Kubernetes concepts: **Namespaces** for logical isolation and organization, and **Deployments** for managing application lifecycle with reliability and scalability. The work demonstrates creation of isolated environments, running workloads within those environments, and managing applications using declarative configuration.

---

## Objectives Achieved

- Created and used multiple namespaces (dev, staging)
- Deployed an application using a Deployment with multiple replicas
- Verified self-healing behavior by deleting a Pod
- Scaled the Deployment up and down
- Performed a rolling update and rollback
- Captured outputs for verification

---

## Namespaces

Namespaces provide a mechanism to partition cluster resources between multiple users or environments. They are commonly used to separate development, staging, and production workloads.

### Create Namespaces

```bash
kubectl create namespace dev
kubectl create namespace staging
```

### Verify Namespaces

```bash
kubectl get namespaces
```

---

## Running Pods in Specific Namespaces

```bash
kubectl run nginx-dev --image=nginx:latest -n dev
kubectl run nginx-staging --image=nginx:latest -n staging
```

List pods across all namespaces:

```bash
kubectl get pods -A
```

---

## Deployments

A Deployment manages a set of identical Pods and ensures that a specified number of replicas are running at all times. It also supports rolling updates and rollbacks.

### Deployment Manifest

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: dev
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:1.24
          ports:
            - containerPort: 80
```

Apply the manifest:

```bash
kubectl apply -f nginx-deployment.yaml
```

Verify resources:

```bash
kubectl get deployments -n dev
kubectl get pods -n dev
```

---

## Self-Healing Behavior

Deleting a Pod managed by a Deployment triggers automatic recreation to maintain the desired replica count.

```bash
kubectl delete pod <pod-name> -n dev
kubectl get pods -n dev
```

Observation: The deleted Pod is replaced with a new Pod (different name), maintaining the configured number of replicas.

---

## Scaling

### Scale Up

```bash
kubectl scale deployment nginx-deployment --replicas=5 -n dev
kubectl get pods -n dev
```

### Scale Down

```bash
kubectl scale deployment nginx-deployment --replicas=2 -n dev
kubectl get pods -n dev
```

Observation: Kubernetes creates or terminates Pods to match the desired replica count.

---

## Rolling Update

Update the container image to trigger a rolling update:

```bash
kubectl set image deployment/nginx-deployment nginx=nginx:1.25 -n dev
kubectl rollout status deployment/nginx-deployment -n dev
```

Observation: Pods are updated incrementally to avoid downtime.

---

## Rollback

Revert to the previous version if needed:

```bash
kubectl rollout undo deployment/nginx-deployment -n dev
kubectl rollout status deployment/nginx-deployment -n dev
```

Verify the running image:

```bash
kubectl describe deployment nginx-deployment -n dev | grep Image
```

---

## Key Differences: Pod vs Deployment

| Feature         | Pod | Deployment |
| --------------- | --- | ---------- |
| Self-healing    | No  | Yes        |
| Scaling         | No  | Yes        |
| Rolling updates | No  | Yes        |

---

## Cleanup

```bash
kubectl delete deployment nginx-deployment -n dev
kubectl delete pod nginx-dev -n dev
kubectl delete pod nginx-staging -n staging
kubectl delete namespace dev staging
```

Verify cleanup:

```bash
kubectl get namespaces
kubectl get pods -A
```

---

## Verification Artifacts

- Output of `kubectl get namespaces`
- Output of `kubectl get pods -A`
- Output of `kubectl get deployments -n dev`
- Output of `kubectl get pods -n dev`

---

## Summary

This task demonstrated how Kubernetes maintains desired state using Deployments, provides isolation using Namespaces, and enables safe application updates through rolling deployments and rollbacks. These capabilities are essential for running reliable and scalable applications in production environments.
