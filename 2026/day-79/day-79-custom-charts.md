# Day 79 – Custom Helm Chart for AI-BankApp

## Overview

Today I converted a multi-service Kubernetes application (AI-BankApp) from 12 raw YAML manifests into a reusable, configurable Helm chart. The application consists of:

- Spring Boot BankApp
- MySQL database
- Ollama AI chatbot

With Helm, the entire stack can now be deployed using a single command.

---

## Project Structure

```
helm-chart/
└── bankapp/
    ├── Chart.yaml
    ├── values.yaml
    ├── templates/
    │   ├── bankapp-deployment.yaml
    │   ├── mysql-deployment.yaml
    │   ├── ollama-deployment.yaml
    │   ├── services.yaml
    │   ├── configmap.yaml
    │   ├── secrets.yaml
    │   ├── storage.yaml
    │   ├── hpa.yaml
    │   └── _helpers.tpl
```

![Helm chart project structure](screenshots/1_project_structure/1_tree.png)

---

## values.yaml (Configuration)

The Helm chart is fully configurable via `values.yaml`.

### BankApp

- Replica count
- Image repository and tag
- Resource limits and requests
- Service configuration
- Autoscaling settings

![values.yaml - BankApp configuration](screenshots/2_values/1_bankapp.png)

### MySQL

- Enable/disable flag
- Image version
- Resource limits
- Persistent storage (5Gi)

![values.yaml - MySQL configuration](screenshots/2_values/2_mysql.png)

### Ollama

- Enable/disable flag
- Model selection (tinyllama)
- Resource configuration
- Persistent storage (10Gi)

![values.yaml - Ollama configuration](screenshots/2_values/3_ollama.png)

### Shared Config

- Database name
- Ollama service URL

### Secrets

- MySQL credentials managed securely via Helm templates

![values.yaml - Shared config and other settings](screenshots/2_values/4_other_config.png)

---

## Helm Validation

```
helm lint bankapp/
```

Result:

- Chart validated successfully
- No errors found

![helm lint output](screenshots/4_helm_lint/1_lint.png)

---

## Helm Template Rendering

```
helm template test bankapp/ -n bankapp
```

### Key Outputs

#### Deployment (BankApp)

- Init containers for dependency checks
- ConfigMap and Secret injection
- Health probes

![Rendered BankApp deployment template](screenshots/3_helm_templates/1_bankapp_deployment.png)

#### Services

- MySQL (ClusterIP)
- Ollama (ClusterIP)
- BankApp (ClusterIP)

![Rendered services template](screenshots/3_helm_templates/2_services.png)

#### HPA

- Min replicas: 2
- Max replicas: 4
- CPU-based scaling (70%)

![Rendered HPA template](screenshots/3_helm_templates/3_hpa.png)

---

## Deployment

```
helm install my-bankapp bankapp/ \
  -n bankapp --create-namespace \
  --set storageClass.create=false \
  --set mysql.persistence.storageClass=standard \
  --set ollama.persistence.storageClass=standard
```

![Helm install output](screenshots/5_helm/1_helm_deploy.png)

---

## Kubernetes Resources

```
kubectl get all -n bankapp
```

![Kubernetes resources after deployment](screenshots/6_running_resources/1_get_all.png)

Resources deployed:

- 3 Deployments (BankApp, MySQL, Ollama)
- 3 Services
- ReplicaSets
- Pods (all running)

---

## Persistent Storage

```
kubectl get pvc -n bankapp
```

![PersistentVolumeClaims for MySQL and Ollama](screenshots/6_pvc/1_pvc.png)

- MySQL PVC: 5Gi
- Ollama PVC: 10Gi

---

## Autoscaling (HPA)

```
kubectl get hpa -n bankapp
```

![HPA status](screenshots/8_hpa/1_hpa.png)

- Min pods: 2
- Max pods: 4
- CPU-based scaling

---

## Application Access

```
kubectl port-forward svc/my-bankapp-service -n bankapp 8080:8080
```

Access:

```
http://localhost:8080
```

![BankApp homepage running via port-forward](screenshots/9_application_running/1_homepage.png)

---

## AI Chatbot Integration

- Ollama service deployed via Helm
- Model pulled dynamically using lifecycle hook
- AI assistant integrated into BankApp UI
- Successfully responding to queries

![Ollama chatbot responding in the app](screenshots/9_application_running/2_ollama_working.png)

---

## Before vs After (Key Improvement)

| Raw Kubernetes   | Helm Chart          |
| ---------------- | ------------------- |
| 12 YAML files    | 1 Helm chart        |
| Hardcoded values | values.yaml driven  |
| Manual edits     | CLI overrides       |
| No reuse         | Reusable deployment |

---

## Key Learnings

- Helm templating (`{{ .Values }}`)
- Conditional deployments (`enabled` flags)
- Secret management using `b64enc`
- Init containers for dependency handling
- Persistent storage with PVCs
- Autoscaling using HPA
- Packaging applications with Helm

---

## Conclusion

This task demonstrated how to package a real-world Kubernetes application using Helm. The system is now:

- Configurable
- Reusable
- Scalable
- Production-ready

A single Helm command can deploy the complete stack including database and AI components.

---

#90DaysOfDevOps
