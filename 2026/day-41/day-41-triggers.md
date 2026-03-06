# Day 41 – Triggers & Matrix Builds

## Task 1: Trigger on Pull Request

### Workflow File: `.github/workflows/pr-check.yml`

```yaml
name: PR Check

on:
  pull_request:
    branches: [main]

jobs:
  pr-check:
    runs-on: ubuntu-latest
    steps:
      - name: Print branch name
        run: echo "PR check running for branch: ${{ github.head_ref }}"
```

### Screenshot

![PR Check](./screenshots/Task%201/1_PR_check.png)

---

## Task 2: Scheduled Trigger

### Workflow File: `.github/workflows/schedule.yml`

```yaml
name: Scheduled Workflow

on:
  schedule:
    - cron: "0 0 * * *"

jobs:
  scheduled-job:
    runs-on: ubuntu-latest
    steps:
      - name: Run scheduled task
        run: echo "Scheduled workflow running at midnight UTC"
```

### Cron Expression

- **Every day at midnight UTC:** `0 0 * * *`
- **Every Monday at 9 AM UTC:** `0 9 * * 1`

### Screenshot

![Scheduled Trigger](./screenshots/Task%202/schedule.png)

---

## Task 3: Manual Trigger

### Workflow File: `.github/workflows/manual.yml`

```yaml
name: Manual Workflow

on:
  workflow_dispatch:
    inputs:
      environment:
        description: 'Environment to deploy'
        required: true
        type: choice
        options:
          - staging
          - production

jobs:
  manual-job:
    runs-on: ubuntu-latest
    steps:
      - name: Print environment
        run: echo "Deploying to: ${{ inputs.environment }}"
```

### Screenshots

![Manual Workflow](./screenshots/Task%203/workflow.png)
![Manual Trigger Output](./screenshots/Task%203/3_task3.png)

---

## Task 4: Matrix Builds

### Workflow File: `.github/workflows/matrix.yml`

```yaml
name: Matrix Build

on: [push]

jobs:
  matrix-job:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        python-version: ["3.10", "3.11", "3.12"]
        os: [ubuntu-latest, windows-latest]
    steps:
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: ${{ matrix.python-version }}

      - name: Print Python version
        run: python --version
```

**Total jobs:** 6 (3 Python versions × 2 OS = 6 combinations)

### Screenshots

![Matrix Workflow](./screenshots/Task%204/workflow.png)
![Matrix Build Output](./screenshots/Task%204/matrix_build.png)

---

## Task 5: Exclude & Fail-Fast

### Updated Matrix with Exclude

```yaml
name: Matrix with Exclude

on: [push]

jobs:
  matrix-job:
    runs-on: ${{ matrix.os }}
    strategy:
      fail-fast: false
      matrix:
        python-version: ["3.10", "3.11", "3.12"]
        os: [ubuntu-latest, windows-latest]
        exclude:
          - os: windows-latest
            python-version: "3.10"
    steps:
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: ${{ matrix.python-version }}

      - name: Print Python version
        run: python --version
```

### Fail-Fast Behavior

- **`fail-fast: true` (default):** If one job fails, all other running jobs are cancelled immediately
- **`fail-fast: false`:** All jobs continue running even if one fails

### Screenshots

![Matrix Exclude Workflow](./screenshots/Task%205/workflow.png)
![Matrix Exclude Output](./screenshots/Task%205/matrix_exclude.png)

---

## Key Learnings

- Pull request triggers automatically run on PR events
- Cron schedules enable automated periodic workflows
- Manual triggers provide on-demand workflow execution
- Matrix builds run jobs in parallel across multiple configurations
- Exclude reduces unnecessary job combinations
- Fail-fast controls whether failures stop other jobs

---

## Submission

✅ Completed all tasks
✅ Created workflow files
✅ Documented learnings
