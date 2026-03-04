# Day 39 – CI/CD Concepts

## Task 1: The Problem

### What can go wrong?

1. **Merge conflicts** – Multiple developers working on same files causing integration issues
2. **Inconsistent environments** – Different versions of dependencies on different machines
3. **Human error** – Manual deployment steps missed or executed in wrong order
4. **No rollback plan** – Failed deployments with no easy way to revert
5. **Testing gaps** – Code deployed without proper testing, breaking production

### "It works on my machine"

This means code runs fine on a developer's local setup but fails elsewhere due to:

- Different OS, library versions, or environment variables
- Missing dependencies not documented
- Hardcoded paths or configurations specific to one machine

### Manual deployment frequency

Realistically, 1-3 times per day maximum. Each deployment requires coordination, testing, and monitoring, making frequent manual deployments risky and time-consuming.

---

## Task 2: CI vs CD

### Continuous Integration (CI)

Automatically merges and tests code changes multiple times daily. Catches integration bugs, syntax errors, and test failures early before they reach production.

**Example:** Every push to GitHub triggers automated tests. If tests fail, the merge is blocked.

### Continuous Delivery (CD)

Extends CI by automatically preparing code for release. "Delivery" means code is always deployment-ready but requires manual approval to go live.

**Example:** After passing tests, code is packaged and deployed to staging automatically, awaiting manual production release.

### Continuous Deployment

Fully automated – every change that passes tests goes directly to production without human intervention. Used by teams with high confidence in automated testing.

**Example:** Netflix deploys hundreds of times daily – successful builds automatically reach production servers.

---

## Task 3: Pipeline Anatomy

- **Trigger** – Event that starts the pipeline (push, pull request, schedule, manual button)
- **Stage** – Logical phase grouping related jobs (build, test, deploy)
- **Job** – Unit of work inside a stage (run tests, build Docker image)
- **Step** – Single command or action inside a job (npm install, docker build)
- **Runner** – Machine/container that executes the job (GitHub-hosted or self-hosted)
- **Artifact** – Output produced by a job (compiled binary, Docker image, test reports)

---

## Task 4: Pipeline Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                     TRIGGER: Push to GitHub                 │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│  STAGE 1: TEST                                              │
│  ├─ Job: Run Unit Tests                                     │
│  │  ├─ Step: Checkout code                                  │
│  │  ├─ Step: Install dependencies                           │
│  │  └─ Step: Run test suite                                 │
│  └─ Job: Lint Code                                          │
│     └─ Step: Run linter                                     │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│  STAGE 2: BUILD                                             │
│  └─ Job: Build Docker Image                                 │
│     ├─ Step: Build image                                    │
│     ├─ Step: Tag image                                      │
│     └─ Step: Push to registry                               │
│     Artifact: Docker image (app:v1.2.3)                     │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│  STAGE 3: DEPLOY                                            │
│  └─ Job: Deploy to Staging                                  │
│     ├─ Step: Pull Docker image                              │
│     ├─ Step: Stop old container                             │
│     ├─ Step: Start new container                            │
│     └─ Step: Health check                                   │
└─────────────────────────────────────────────────────────────┘
                              ↓
                           SUCCESS
```

---

## Task 5: Explore in the Wild

### Repository Explored: **Kubernetes (kubernetes/kubernetes)**

**Workflow File:** `.github/workflows/ci.yml`

#### What triggers it?

- Push to main branch
- Pull requests
- Scheduled runs (nightly builds)

#### How many jobs?

Multiple jobs including:

- Unit tests
- Integration tests
- Build verification
- Linting and code quality checks

#### What does it do?

Validates all code changes by running comprehensive tests across different environments and configurations. Ensures no breaking changes are merged into the main branch. Builds and verifies Kubernetes components compile correctly across multiple platforms (Linux, Windows, different architectures).

---

## Key Takeaways

1. **CI/CD is a practice** – Tools like GitHub Actions, Jenkins, and GitLab CI implement it
2. **Failing pipelines are good** – They catch problems before production
3. **Automation reduces risk** – Consistent, repeatable processes eliminate human error
4. **Fast feedback loops** – Developers know within minutes if their code breaks something
