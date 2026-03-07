# Day 43 – Jobs, Steps, Env Vars & Conditionals

## Overview

GitHub Actions workflows are controlled through **jobs**, **steps**, **environment variables**, and **conditionals**. These features allow you to build complex, intelligent pipelines that respond to different conditions and pass data between stages.

---

## 1. Multi-Job Workflows with Dependencies

### What is `needs:`?

The `needs:` keyword creates a dependency chain. A job waits for all jobs listed in `needs:` to complete successfully before running.

### Example: Multi-Job Workflow

```yaml
name: Multi Job Pipeline

on:
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: echo "Building the application..."

  test:
    runs-on: ubuntu-latest
    needs: build
    steps:
      - run: echo "Running tests..."

  deploy:
    runs-on: ubuntu-latest
    needs: test
    steps:
      - run: echo "Deploying the application..."
```

**Key Points:**

- `test` waits for `build` to succeed
- `deploy` waits for `test` to succeed
- If any job fails, dependent jobs are skipped
- Check the workflow graph in the Actions tab to visualize the dependency chain

---

## 2. Environment Variables at Multiple Levels

### Three Levels of Env Vars

#### Workflow Level

```yaml
name: Environment Variables Demo

on: push

env:
  APP_NAME: myapp

jobs:
  env-var-job:
    runs-on: ubuntu-latest
    steps:
      - run: echo "App Name:${{ env.APP_NAME }}"
```

#### Job Level

```yaml
jobs:
  env-var-job-with-env:
    runs-on: ubuntu-latest
    env:
      ENVIRONMENT: staging
    steps:
      - run: echo "Environment:${{ env.ENVIRONMENT }}"
```

#### Step Level

```yaml
jobs:
  env-var-job-with-step-env:
    runs-on: ubuntu-latest
    steps:
      - run: echo "Version:${{ env.VERSION }}"
    env:
      VERSION: 1.0.0
```

### GitHub Context Variables

```yaml
jobs:
  env-var-job-with-github-context:
    runs-on: ubuntu-latest
    steps:
      - run: |
          echo "Commit SHA:${{ github.sha }}"
          echo "Actor:${{ github.actor }}"
          echo "Ref:${{ github.ref }}"
```

**Common GitHub Context Variables:**

- `github.sha` — commit SHA
- `github.actor` — user who triggered the workflow
- `github.ref` — branch or tag reference
- `github.event_name` — event that triggered the workflow

---

## 3. Job Outputs

### What are Job Outputs?

Job outputs allow you to pass data from one job to another. A job sets an output, and dependent jobs can read it using `needs.<job>.outputs.<name>`.

### Example: Setting and Reading Outputs

```yaml
name: Job Outputs

on: push

jobs:
  generate:
    runs-on: ubuntu-latest
    outputs:
      date: ${{ steps.date.outputs.date }}
    steps:
      - id: date
        run: |
          echo "date=$(date)" >> $GITHUB_OUTPUT

  consume:
    runs-on: ubuntu-latest
    needs: generate
    steps:
      - run: echo "The Generated date is ${{ needs.generate.outputs.date }}"
```

**Key Points:**

- Use `id:` to identify a step
- Use `echo "key=value" >> $GITHUB_OUTPUT` to set outputs
- Reference outputs with `${{ needs.job-name.outputs.key }}`
- Only jobs listed in `needs:` can access outputs

### Why Use Job Outputs?

- Pass build artifacts or metadata between jobs
- Share computed values (e.g., version numbers, commit info)
- Avoid re-computing values in dependent jobs
- Keep jobs loosely coupled and reusable

---

## 4. Conditionals

### Branch-Specific Steps

```yaml
jobs:
  when-branch:
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - run: echo "This step runs only on the main branch"
```

### Run on Previous Step Failure

```yaml
jobs:
  when-failed:
    runs-on: ubuntu-latest
    steps:
      - run: exit 1
      - run: echo "This step will not run because the previous step failed"
```

### Job-Level Conditionals

```yaml
jobs:
  when-event:
    if: github.event_name == 'push'
    runs-on: ubuntu-latest
    steps:
      - run: echo "This step runs only on push events"
```

### Continue on Error

```yaml
jobs:
  when-continue-on-error:
    runs-on: ubuntu-latest
    steps:
      - run: exit 1
        continue-on-error: true
      - run: echo "This step will run even if the previous step failed"
```

**What does `continue-on-error: true` do?**

- The step can fail without stopping the job
- The job continues to the next step
- The step outcome is marked as "failure" but doesn't fail the job
- Useful for non-critical steps like notifications or cleanup

### Common Conditional Functions

- `success()` — previous step succeeded
- `failure()` — previous step failed
- `always()` — always run (even if previous failed)
- `cancelled()` — workflow was cancelled

---

## 5. Smart Pipeline Example

```yaml
name: Smart Pipeline

on: push

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run linter
        run: echo "Running linter..."

  test:
    runs-on: ubuntu-latest
    needs: [lint]
    steps:
      - uses: actions/checkout@v4
      - name: Run tests
        run: echo "Running tests..."

  summary:
    runs-on: ubuntu-latest
    needs: [lint, test]
    steps:
      - run: |
          if [[ "${{ github.ref }}" == "refs/heads/main" ]]; then
            echo "This is a push to the main branch."
          else
            echo "This is a push to a feature branch."
          fi
      - run: echo "Commit message:${{ github.event.head_commit.message }}"
```

**Key Points:**

- `lint` and `test` run in parallel
- `summary` waits for both to complete
- Conditionals check the branch and print accordingly
- Commit message is accessed via `github.event.commits[0].message`

---

## Key Takeaways

| Concept              | Purpose                                                 |
| -------------------- | ------------------------------------------------------- |
| `needs:`             | Create job dependencies                                 |
| `env:`               | Define environment variables at workflow/job/step level |
| `outputs:`           | Pass data between jobs                                  |
| `if:`                | Run steps/jobs conditionally                            |
| `continue-on-error:` | Allow steps to fail without stopping the job            |
| GitHub Context       | Access workflow metadata (SHA, actor, ref, etc.)        |

---

## Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Workflow Syntax Reference](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
- [GitHub Context Variables](https://docs.github.com/en/actions/learn-github-actions/contexts)
