# Day 80 – Helm Project: Multi-Environment Deployment & CI/CD

## Overview

On Day 80, I implemented a production-grade Helm workflow for the AI-BankApp. This included creating environment-specific configurations, adding Helm hooks for dependency management, packaging the chart, and simulating a GitOps-based CI/CD pipeline.

### Setup (Local Lab)

![Kind cluster created](screenshots/Task_0/1_created_cluster.png)

![Dev namespace created](screenshots/Task_0/2_namespace_dev.png)

---

## 1. Environment-Specific Values

### Dev vs Staging vs Prod

| Setting         | Dev                  | Staging   | Prod      |
| --------------- | -------------------- | --------- | --------- |
| Replicas        | 1                    | 2-3 (HPA) | 2-4 (HPA) |
| Image Tag       | latest               | v1.2.0    | v1.2.0    |
| MySQL Storage   | 2Gi                  | 5Gi       | 20Gi      |
| MySQL Resources | Low                  | Medium    | High      |
| Ollama          | Disabled (optimized) | Enabled   | Enabled   |
| Gateway         | Disabled             | Disabled  | Enabled   |

### Key Insight

- Same Helm chart, different environments using values files
- No duplication of Kubernetes manifests

#### Screenshots

![Chart structure](screenshots/Task_1/1_tree.png)

![values-dev.yaml](screenshots/Task_1/2_values_dev.png)

![values-prod.yaml](screenshots/Task_1/3_values_prod.png)

---

## 2. Helm Hooks (Database Readiness)

### Pre-install Hook

A Kubernetes Job was added using Helm hooks to ensure MySQL is ready before deploying the application.

### Hook Configuration

- `pre-install, pre-upgrade` → Runs before deployment
- `hook-delete-policy` → Cleans previous jobs

### Outcome

- Prevents race conditions
- Ensures reliable deployments

#### Screenshots

![Pre-install/pre-upgrade jobs](screenshots/Task_3/1_jobs.png)

![Job logs](screenshots/Task_3/2_logs.png)

---

## 3. Helm Test

A Helm test was added to verify application health:

- Hits `/actuator/health`
- Validates application availability post-deployment

---

## 4. Packaging & Versioning

### Commands Used

```bash
helm lint .
helm package .
```

![helm lint](screenshots/Task_1/4_helm_lint.png)

### Output

- bankapp-0.1.0.tgz
- bankapp-0.2.0.tgz

#### Screenshots

![helm package output](screenshots/Task_4/1_helm_package.png)

![Chart versions/packages](screenshots/Task_4/2_version_packages.png)

### Versioning Strategy

- `version` → Helm chart changes
- `appVersion` → Application version

---

## 5. CI/CD + GitOps Integration

### Simulated CI Step

```bash
TAG=dev-001
yq -y -i '.bankapp.image.tag = "'$TAG'"' values-dev.yaml
```

![Image tag update](screenshots/Task_5/1_tag.png)

### Git Commit

```bash
git commit -m "ci: update bankapp image tag"
```

![git log](screenshots/Task_5/2_git_log.png)

### Deployment

```bash
helm upgrade bankapp-dev . -f values-dev.yaml -n dev
```

#### Screenshots

![helm list](screenshots/Task_2/1_helm_list.png)

![Pods in dev namespace](screenshots/Task_2/2_pods_all_dev.png)

![Service details](screenshots/Task_2/3_svc.png)

![Application logs](screenshots/Task_2/4_logs.png)

### Flow

```text
Code → CI builds image → update values.yaml → push → Helm deploy
```

![CI/CD flow image](screenshots/Task_5/3_image.png)

---

## 6. Helm vs Raw Manifests vs Kustomize

| Approach  | Use Case                | Notes                                |
| --------- | ----------------------- | ------------------------------------ |
| Raw YAML  | Simple apps             | Hard to manage multiple environments |
| Helm      | Complex, multi-env apps | Best for reusable deployments        |
| Kustomize | Overlay configs         | No templating, simpler than Helm     |

---

## 7. Production Best Practices

- Use `helm upgrade --install`
- Enable `--atomic` for rollback safety
- Avoid storing secrets in values.yaml
- Use tools like External Secrets / Vault
- Use `helm diff` before upgrades

---

## 8. Key Learnings

- Debugged real-world issues (OOM, ImagePullBackOff, DB access)
- Implemented Helm hooks for dependency management
- Understood GitOps workflow using Helm
- Built reusable, environment-aware deployments

---

## Conclusion

This project demonstrates a production-ready Helm setup with CI/CD integration, environment management, and robust deployment practices. It reflects real DevOps workflows used in modern cloud-native applications.

---

#90DaysOfDevOps #Helm #Kubernetes #DevOps #GitOps
