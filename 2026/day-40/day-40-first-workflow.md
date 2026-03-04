# Day 40 - My First GitHub Actions Workflow

## Workflow YAML

```yaml
name: Hello Workflow

on:
  push:
    branches:
      - main

jobs:
  greet:
    runs-on: ubuntu-latest
    
    steps:
      - name: Check out code
        uses: actions/checkout@v4
      
      - name: Print greeting
        run: echo "Hello from GitHub Actions!"
      
      - name: Print current date and time
        run: date
      
      - name: Print branch name
        run: echo "Branch: ${{ github.ref_name }}"
      
      - name: List files in repository
        run: ls -la
      
      - name: Print runner OS
        run: echo "Running on: $RUNNER_OS"
```

## Screenshot

![Green Pipeline Run](screenshot-placeholder.png)

## Understanding the Workflow Keys

- **on:** Defines the event that triggers the workflow (e.g., push, pull_request)
- **jobs:** Contains all the jobs that will run in this workflow
- **runs-on:** Specifies the type of runner/machine the job will execute on
- **steps:** Sequential list of tasks that make up a job
- **uses:** References an action from the marketplace or repository to use in a step
- **run:** Executes shell commands directly on the runner
- **name:** Provides a descriptive label for a step (shown in the Actions UI)

## What I Learned

- GitHub Actions workflows are defined in YAML files under `.github/workflows/`
- Each push triggers a new workflow run automatically
- Failed steps show red X marks and detailed error logs
- GitHub provides built-in variables like `github.ref_name` for context
- The Actions tab provides real-time feedback on pipeline execution

## Breaking and Fixing

When I intentionally broke the pipeline with `exit 1`, the workflow stopped at that step, marked it as failed with a red X, and didn't execute subsequent steps. The error was clearly visible in the logs, making debugging straightforward.

---

**Completed on:** Day 40 of #90DaysOfDevOps
