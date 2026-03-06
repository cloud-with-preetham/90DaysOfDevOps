# Day 42 – Runners: GitHub-Hosted & Self-Hosted

## Task 1: GitHub-Hosted Runners

### Workflow File: `.github/workflows/multi-os.yml`

```yaml
name: Multi-OS Runners

on: [push]

jobs:
  ubuntu-job:
    runs-on: ubuntu-latest
    steps:
      - name: Print Ubuntu info
        run: |
          echo "OS: $(uname -s)"
          echo "Hostname: $(hostname)"
          echo "User: $(whoami)"

  windows-job:
    runs-on: windows-latest
    steps:
      - name: Print Windows info
        run: |
          echo "OS: Windows"
          echo "Hostname: $env:COMPUTERNAME"
          echo "User: $env:USERNAME"

  macos-job:
    runs-on: macos-latest
    steps:
      - name: Print macOS info
        run: |
          echo "OS: $(uname -s)"
          echo "Hostname: $(hostname)"
          echo "User: $(whoami)"
```

### What is a GitHub-Hosted Runner?

A GitHub-hosted runner is a virtual machine managed by GitHub that executes your workflow jobs. GitHub maintains, updates, and manages all infrastructure.

### Screenshots

![Multi-OS Workflow](./screenshots/Task%201/multi-os-workflow.png)
![Task 1 Output](./screenshots/Task%201/1_task1.png)

---

## Task 2: Pre-installed Tools

### Workflow File: `.github/workflows/pre-installed.yml`

```yaml
name: Check Pre-installed Tools

on: [push]

jobs:
  check-tools:
    runs-on: ubuntu-latest
    steps:
      - name: Check Docker version
        run: docker --version

      - name: Check Python version
        run: python --version

      - name: Check Node version
        run: node --version

      - name: Check Git version
        run: git --version
```

### Why Pre-installed Tools Matter

Pre-installed tools save time and reduce setup overhead. Workflows start faster without waiting for tool installations, making CI/CD pipelines more efficient.

### Screenshots

![Pre-installed Workflow](./screenshots/Task%202/pre-installed-workflow.png)
![Task 2 Output](./screenshots/Task%202/1_task2.png)

---

## Task 3: Self-Hosted Runner Setup

### Steps to Register

1. Go to GitHub repo → Settings → Actions → Runners
2. Click "New self-hosted runner"
3. Select Linux
4. Download and run the configuration script
5. Start the runner: `./run.sh`

### Screenshots

![Terminal Setup 1](./screenshots/Task%203/1-terminal-setup.png)
![Terminal Setup 2](./screenshots/Task%203/2-terminal-setup.png)
![Self-Hosted Runners](./screenshots/Task%203/self-hosted-runners.png)

---

## Task 4: Use Self-Hosted Runner

### Workflow File: `.github/workflows/self-hosted.yml`

```yaml
name: Self-Hosted Runner

on: [push]

jobs:
  self-hosted-job:
    runs-on: self-hosted
    steps:
      - name: Print hostname
        run: echo "Hostname: $(hostname)"

      - name: Print working directory
        run: pwd

      - name: Create test file
        run: echo "Test file created" > /tmp/test-file.txt

      - name: Verify file exists
        run: cat /tmp/test-file.txt
```

### Screenshots

![GitHub Workflow](./screenshots/Task%204/github-workflow.png)
![Task 4 Output](./screenshots/Task%204/task4.png)
![Terminal Self-Hosted](./screenshots/Task%204/terminal-self-hosted.png)

---

## Task 5: Labels

### Add Label to Runner

```bash
./config.sh --labels my-linux-runner
```

### Updated Workflow

```yaml
jobs:
  self-hosted-job:
    runs-on: [self-hosted, my-linux-runner]
    steps:
      - name: Run on labeled runner
        run: echo "Running on labeled self-hosted runner"
```

### Screenshots

![Configured Runner](./screenshots/Task%205/configured-runner.png)
![Updated List](./screenshots/Task%205/updated-list.png)
![GitHub Workflow](./screenshots/Task%205/github-workflow.png)
![Terminal Workflow](./screenshots/Task%205/terminal-workflow.png)

---

## Task 6: GitHub-Hosted vs Self-Hosted Comparison

| Aspect                  | GitHub-Hosted             | Self-Hosted                           |
| ----------------------- | ------------------------- | ------------------------------------- |
| **Who manages it?**     | GitHub                    | You                                   |
| **Cost**                | Included (with limits)    | Your infrastructure cost              |
| **Pre-installed tools** | Yes, extensive            | You install what you need             |
| **Good for**            | Most CI/CD tasks, testing | Custom environments, private networks |
| **Security concern**    | Limited (GitHub manages)  | You manage security & updates         |
| **Scalability**         | Limited by GitHub         | Unlimited (your infrastructure)       |
| **Maintenance**         | GitHub handles            | You handle                            |

---

## Key Learnings

- GitHub-hosted runners are managed by GitHub and come with pre-installed tools
- Self-hosted runners run on your own infrastructure and give you full control
- Labels help organize and target specific self-hosted runners
- Pre-installed tools on GitHub runners save setup time
- Self-hosted runners are ideal for custom environments and private networks

---

## Submission

✅ Completed all tasks
✅ Created workflow files
✅ Registered self-hosted runner
✅ Documented learnings
