# Day 85 – ArgoCD Deep Dive with GitOps on Amazon EKS

## Objective

Implement a production-style GitOps workflow for the AI BankApp platform on Amazon EKS using ArgoCD, enabling declarative deployments, sync tracking, health monitoring, drift detection, and controlled reconciliation.

---

## What I Built

### 1) Installed ArgoCD on EKS

- Deployed ArgoCD controllers into a dedicated `argocd` namespace.
- Verified all control-plane components were healthy:
  - argocd-server
  - argocd-repo-server
  - argocd-application-controller
  - argocd-dex-server
  - argocd-redis
  - argocd-notifications-controller

**Validation Command**

```bash
kubectl get pods -n argocd
```

**Screenshots**

![ArgoCD pods running in the argocd namespace](screenshots/00-argo-cd-pods.png)

![ArgoCD control-plane pods healthy](screenshots/02a-argocd-pods-running.png)

---

### 2) Installed ArgoCD CLI & Authenticated

- Installed ArgoCD CLI on Ubuntu workstation.
- Connected securely to the ArgoCD server endpoint.
- Authenticated using admin credentials.

**Commands**

```bash
argocd version --client
argocd login <ARGOCD-ENDPOINT> --username admin --insecure --grpc-web
```

**Screenshots**

![ArgoCD CLI installed on workstation](screenshots/01-argocd-cli-installed.png)

![ArgoCD server exposed through port-forwarding](screenshots/02b-argocd-port-forward.png)

![ArgoCD CLI connected to the EKS cluster](screenshots/02-argocd-cli-connected-to-cluster.png)

---

### 3) Connected Git Repository

Repository Source:

```text
https://github.com/cloud-with-preetham/AI-BankApp-DevOps.git
```

Deployment Path:

```text
k8s/
```

Branch:

```text
feat/gitops
```

ArgoCD now continuously watches Git for desired state changes.

**Screenshot**

![GitOps branch selected for ArgoCD deployment](screenshots/07-gitops-branch-check.png)

---

### 4) Created GitOps Application

Configured ArgoCD Application for:

- Namespace creation
- Server-side apply
- Controlled sync
- Drift reconciliation

**Benefits achieved**

- Git = single source of truth
- Declarative deployments
- Repeatable releases
- Versioned infrastructure state
- Automated reconciliation

**Screenshots**

![BankApp configured with manual sync policy](screenshots/03-bankapp-manual-sync-policy.png)

![BankApp application status from ArgoCD CLI](screenshots/06-argocd-app-get-bankapp.png)

---

### 5) Tested Drift Detection

Modified live cluster state manually and validated ArgoCD drift detection.

Example drift:

```diff
- replicas: 2
+ replicas: 4
```

ArgoCD correctly reported:

```text
OutOfSync
```

This validated reconciliation visibility.

**Screenshots**

![ArgoCD diff preview showing desired and live state changes](screenshots/04-argocd-diff-preview.png)

![ArgoCD dry-run sync preview before applying changes](screenshots/05-argocd-sync-dry-run.png)

---

### 6) Implemented Sync Waves

To avoid ordering failures, introduced sync waves:

**Wave -2**

- Namespace
- StorageClass

**Wave -1**

- PVCs
- Secrets
- ConfigMap

**Wave 0**

- Services
- MySQL
- Ollama

**Wave 1**

- BankApp
- Certificate

**Wave 2**

- HPA
- Gateway
- HTTPRoute

Result:
Deterministic deployment ordering.

**Sync Wave Evidence**

![Namespace configured with sync wave](screenshots/08-sync-wave-namespace.png)

![StorageClass configured with sync wave](screenshots/09-sync-wave-storageclass.png)

![PVCs configured with sync wave](screenshots/10-sync-wave-pvc.png)

![First sync wave batch diff](screenshots/11-sync-wave-first-batch-diff.png)

![First sync wave batch clean after sync](screenshots/11a-sync-wave-first-batch-clean.png)

![ConfigMap configured with sync wave](screenshots/12-sync-wave-configmap.png)

![Secret configured with sync wave](screenshots/13-sync-wave-secret.png)

![MySQL deployment configured with sync wave](screenshots/14-sync-wave-mysql.png)

![Ollama deployment configured with sync wave](screenshots/15-sync-wave-ollama.png)

![Second sync wave batch summary](screenshots/16-sync-wave-second-batch-summary.png)

![Services configured with sync wave](screenshots/17-sync-wave-services.png)

![BankApp deployment configured with sync wave](screenshots/18-sync-wave-bankapp.png.png)

![HPA configured with sync wave](screenshots/19-sync-wave-hpa.png)

![Final sync wave summary](screenshots/20-sync-wave-final-summary.png)

![ArgoCD UI showing successful sync wave deployment](screenshots/24-argocd-sync-wave-success.png)

---

### 7) Integrated TLS with cert-manager

Implemented:

- ClusterIssuer
- Certificate resource
- TLS secret generation workflow

Integrated TLS secret into Gateway API.

This connected:

```text
cert-manager → Certificate → Secret → Gateway TLS listener
```

**Screenshots**

![Certificate resource created for TLS automation](screenshots/29-certificate-resource.png)

![cert-manager certificate request approved](screenshots/36-cert-manager-certificate-request-approved.png)

---

### 8) Validated Gateway API Health

Verified:

- Gateway Healthy
- HTTPRoute Healthy
- Backend routing Healthy
- Session affinity policy Healthy

Ingress routing fully declarative through GitOps.

**Screenshot**

![ArgoCD network and Gateway resources healthy](screenshots/0-networtks-argo.png)

---

### 9) HPA Drift Observation

Observed ArgoCD drift caused by HPA changing replica counts dynamically.

Example:

Desired:

```yaml
replicas: 2
```

Live:

```yaml
replicas: 3
```

This highlighted real-world GitOps reconciliation nuances with autoscaling systems.

---

## Key Learnings

- GitOps is desired-state management.
- Drift detection is operationally critical.
- Sync ordering matters.
- TLS resources must be dependency-aware.
- Gateway API + cert-manager integrate well with GitOps.
- Autoscalers can create intentional drift.
- ArgoCD gives excellent operational visibility.

---

## Architecture

```text
GitHub Repo
   ↓
ArgoCD watches repo
   ↓
Sync Waves
   ↓
Kubernetes Resources Apply
   ↓
cert-manager issues TLS
   ↓
Gateway API exposes app
   ↓
Continuous reconciliation
```

---

## Outcome

Successfully implemented a production-style GitOps deployment model for AI BankApp on Amazon EKS using ArgoCD with:

- Declarative delivery
- Drift detection
- Health monitoring
- Ordered sync
- TLS automation
- Gateway API routing
- Continuous reconciliation

Day 85 complete.
