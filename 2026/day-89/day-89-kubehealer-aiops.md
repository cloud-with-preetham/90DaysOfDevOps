# Day 89 – AIOps with KubeHealer (AI-Powered Kubernetes Incident Diagnosis)

## Overview

On Day 89 of my #90DaysOfDevOps journey, I explored **AIOps (Artificial Intelligence for IT Operations)** by building and debugging **KubeHealer**—an AI-assisted Kubernetes incident diagnosis platform.

This project combined:

- Kubernetes failure simulation
- Temporal workflow orchestration
- AI-based root cause analysis
- Production guardrails for safe remediation
- Local LLM integration using Ollama

![AIOps notes and KubeHealer planning](screenshots/1-aiops-notes.png)

---

## Objectives

The goal was to simulate real production incidents and validate whether an AI-powered workflow could:

- Detect unhealthy pods
- Diagnose root causes
- Recommend safe remediation actions
- Escalate unsafe fixes for human approval
- Operate with workflow durability and retries

---

## Tech Stack

- Kubernetes (Kind Cluster)
- Temporal
- Python
- Ollama
- Gemma4 local LLM
- kubectl
- Linux

---

## Production Guardrails Implemented

1. Human approval for risky actions
2. Scope limitation for remediation
3. Full auditability via workflows
4. Retry + timeout handling
5. Rollback mindset
6. Escalation for unsafe configuration fixes

---

## Lab Setup

### 1) Local Kubernetes Cluster

Created a local Kind cluster for isolated testing.

![KubeHealer project setup](screenshots/2-kubehealer-setup.png)

### 2) Temporal Server

Started Temporal locally to orchestrate workflows and activity retries.

![Kind cluster and Temporal running locally](screenshots/3-kind-temporal-running.png)

### 3) Broken Pod Scenarios

Deployed intentionally broken pods:

| Pod        | Failure                    | Cause                        |
| ---------- | -------------------------- | ---------------------------- |
| web-app    | ImagePullBackOff           | Typo in image name (`ngnix`) |
| memory-app | CrashLoopBackOff           | Memory limit too low         |
| config-app | CreateContainerConfigError | Missing ConfigMap            |

![Broken Kubernetes pods created for diagnosis](screenshots/4-broken-pods.png)

---

## Challenge Faced

The original project used Anthropic API, but billing credits blocked execution.

![Anthropic API key configured before the billing blocker appeared](screenshots/5-api-key-configured.png)

### Solution

I refactored the codebase to use local inference:

**Anthropic → Ollama → Gemma4**

Changes included:

- Replacing SDK imports
- Replacing API client calls
- Updating response parsing
- Fixing JSON extraction logic
- Switching model from qwen3.5 to gemma4 due to runtime issues

![Original Anthropic client dependency before local LLM refactor](screenshots/8-anthropic-client.png)

![Chat activities originally wired to Anthropic](screenshots/14-chat-activities-anthropic.png)

![Ollama import added for local inference](screenshots/9-import-ollama.png)

![Ollama request wired into the diagnosis flow](screenshots/10-ollama-request.png)

![Ollama response parser updated for structured diagnosis output](screenshots/11-ollama-response-parser.png)

![Local LLM patch replacing external API dependency](screenshots/7-local-llm-patch.png)

![Patched chat parser for model response extraction](screenshots/15-chat-parser-patched.png)

---

## AI Diagnosis Results

### config-app

Diagnosis:

- Missing ConfigMap dependency
  Action:
- Skip auto-remediation
- Escalate for human intervention

### web-app

Diagnosis:

- Typo in image name
  Action:
- Suggest image correction (`nginx:latest`)

This validated safe AIOps behavior.

![Worker running the KubeHealer diagnosis workflow](screenshots/6-worker-running.png)

![AI diagnosis successfully generated from Kubernetes failure context](screenshots/12-ai-diagnosis-success.png)

![Worker log showing diagnosis output](screenshots/13-worker-diagnosis-log.png)

![AI diagnosis success after local LLM integration](screenshots/16-ai-diagnosis-success.png)

![Pod states after diagnosis workflow execution](screenshots/17-pods-state-after-diagnosis.png)

---

## Temporal Workflow Validation

Observed:

- Workflow scheduling
- Activity execution
- Retry behavior
- Timeout handling
- Multiple workflow runs during debugging

This demonstrated durable orchestration patterns used in production systems.

![Temporal workflow runs visible in the dashboard](screenshots/18-temporal-workflows-dashboard.png)

---

## Key Learnings

- AI should diagnose before acting
- Production systems need guardrails
- Local LLMs are viable for DevOps workflows
- Workflow engines like Temporal are powerful for automation durability
- Debugging distributed systems is iterative engineering

---

## Outcome

Successfully built a **local AI-powered Kubernetes diagnostic workflow** that:

- Detects failures
- Understands root causes
- Suggests remediation
- Escalates unsafe actions
- Runs without paid external APIs

A strong step toward practical AIOps engineering.
