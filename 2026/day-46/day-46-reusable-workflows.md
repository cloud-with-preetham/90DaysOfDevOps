# Day 46 – Reusable Workflows & Composite Actions

## Task 1 – Understanding Concepts

**1. What is a reusable workflow?**
A reusable workflow is a GitHub Actions workflow that can be called by another workflow using the `workflow_call` trigger. It allows teams to reuse CI/CD logic across multiple workflows or repositories instead of rewriting the same pipeline steps.

**2. What is the `workflow_call` trigger?**
`workflow_call` is a special GitHub Actions trigger that allows one workflow to be invoked by another workflow. It enables workflows to behave like reusable functions.

**3. How is calling a reusable workflow different from using a regular action (`uses:`)?**
Calling a reusable workflow runs an entire workflow with jobs, while a regular action runs only a single step inside a job.

**4. Where must a reusable workflow file live?**
Reusable workflows must be stored inside the `.github/workflows/` directory of a repository.

---

## Task 2 – Reusable Workflow

**File:** `.github/workflows/reusable-build.yml`

```yaml
name: Reusable Build Workflow

on:
  workflow_call:
    inputs:
      app_name:
        required: true
        type: string
      environment:
        required: true
        type: string
        default: staging
    secrets:
      docker_token:
        required: true

    outputs:
      build_version:
        description: "Generated build version"
        value: ${{ jobs.build.outputs.build_version }}

jobs:
  build:
    runs-on: ubuntu-latest

    outputs:
      build_version: ${{ steps.version.outputs.version }}

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Print build info
        run: |
          echo "Building ${{ inputs.app_name }} for ${{ inputs.environment }}"

      - name: Check docker token
        run: |
          echo "Docker token is set: ${{ secrets.docker_token != '' }}"

      - name: Generate build version
        id: version
        run: |
          SHORT_SHA=$(echo $GITHUB_SHA | cut -c1-7)
          VERSION="v1.0-$SHORT_SHA"
          echo "version=$VERSION" >> $GITHUB_OUTPUT
```

---

## Task 3 – Caller Workflow

**File:** `.github/workflows/call-build.yml`

```yaml
name: Call Reusable Workflow

on:
  push:
    branches:
      - main

jobs:
  build:
    uses: ./.github/workflows/reusable-build.yml

    with:
      app_name: "my-web-app"
      environment: "production"

    secrets:
      docker_token: ${{ secrets.DOCKER_TOKEN }}

  print-version:
    runs-on: ubuntu-latest
    needs: build

    steps:
      - name: Print build version
        run: |
          echo "Build version is ${{ needs.build.outputs.build_version }}"
```

---

## Task 5 – Composite Action

**File:** `.github/actions/setup-and-greet/action.yml`

```yaml
name: Setup and Greet

description: A custom composite action that greets the user

inputs:
  name:
    description: "Name of the person"
    required: true
  language:
    description: "Greeting language"
    required: false
    default: "en"

outputs:
  greeted:
    description: "Greeting status"
    value: ${{ steps.greet.outputs.status }}

runs:
  using: "composite"

  steps:
    - name: Greeting step
      id: greet
      shell: bash
      run: |
        if [ "${{ inputs.language }}" = "en" ]; then
          echo "Hello ${{ inputs.name }}"
        elif [ "${{ inputs.language }}" = "es" ]; then
          echo "Hola ${{ inputs.name }}"
        else
          echo "Hello ${{ inputs.name }}"
        fi
        echo "status=true" >> $GITHUB_OUTPUT

    - name: Print runner details
      shell: bash
      run: |
        echo "Date: $(date)"
        echo "Runner OS: $RUNNER_OS"
```

---

## Example Workflow Using Composite Action

```yaml
name: Use Composite Action

on:
  workflow_dispatch:

jobs:
  greet:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Run custom action
        uses: ./.github/actions/setup-and-greet

        with:
          name: "Preetham"
          language: "en"
```

---

## Task 6 – Comparison

|                              | Reusable Workflow    | Composite Action                             |
| ---------------------------- | -------------------- | -------------------------------------------- |
| Triggered by                 | workflow_call        | uses: in a step                              |
| Can contain jobs?            | Yes                  | No                                           |
| Can contain multiple steps?  | Yes                  | Yes                                          |
| Lives where?                 | .github/workflows/   | Anywhere in repo (commonly .github/actions/) |
| Can accept secrets directly? | Yes                  | No                                           |
| Best for                     | Full CI/CD pipelines | Reusable step logic                          |

---

## Summary

Today I learned how GitHub Actions can be modularized using reusable workflows and composite actions. Reusable workflows allow entire pipelines to be reused across repositories, while composite actions help package commonly used steps into a single reusable component. This reduces duplication and makes CI/CD pipelines easier to maintain in production environments.
