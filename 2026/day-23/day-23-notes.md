# Day 23 – Git Branching & Working with GitHub

## Task 1: Understanding Branches

### 1. What is a branch in Git?

A branch in Git is a lightweight movable pointer to a commit. It allows you to diverge from the main line of development and work independently without affecting the main codebase.

### 2. Why do we use branches instead of committing everything to `main`?

- Isolate feature development and bug fixes
- Enable parallel development by multiple team members
- Keep the main branch stable and production-ready
- Allow experimentation without breaking working code
- Facilitate code review through pull requests

### 3. What is `HEAD` in Git?

`HEAD` is a pointer that references the current branch or commit you're working on. It typically points to the tip of the current branch and moves forward with each new commit.

### 4. What happens to your files when you switch branches?

When you switch branches, Git updates your working directory to match the snapshot of the target branch. Files are added, removed, or modified to reflect the state of that branch.

---

## Task 2: Branching Commands — Hands-On

### Commands Executed:

1. **List all branches**: `git branch`
2. **Create new branch**: `git branch feature-1`
3. **Switch to branch**: `git checkout feature-1` or `git switch feature-1`
4. **Create and switch in one command**: `git checkout -b feature-2` or `git switch -c feature-2`
5. **Difference between git switch and git checkout**:
   - `git switch` is newer and specifically for switching branches
   - `git checkout` is older and has multiple purposes (switching branches, restoring files)
   - `git switch` is more intuitive and less error-prone
6. **Made commit on feature-1**: Created/modified files and committed
7. **Verified isolation**: Switched to main and confirmed feature-1 commits don't exist there
8. **Delete branch**: `git branch -d <branch-name>`

---

## Task 3: Push to GitHub

### Steps Completed:

1. Created new repository on GitHub
2. Connected local repo: `git remote add origin <repo-url>`
3. Pushed main branch: `git push -u origin main`
4. Pushed feature-1: `git push -u origin feature-1`
5. Verified both branches visible on GitHub

### What is the difference between `origin` and `upstream`?

- **origin**: The default name for your remote repository (typically your own repo or fork)
- **upstream**: Conventionally refers to the original repository you forked from
- origin is where you push your changes, upstream is where you pull updates from the original project

---

## Task 4: Pull from GitHub

### Steps Completed:

1. Made changes directly on GitHub using web editor
2. Pulled changes locally: `git pull origin main`

### What is the difference between `git fetch` and `git pull`?

- **git fetch**: Downloads changes from remote but doesn't merge them into your working branch
- **git pull**: Downloads changes AND automatically merges them into your current branch
- `git pull` = `git fetch` + `git merge`

---

## Task 5: Clone vs Fork

### What is the difference between clone and fork?

- **Clone**: Creates a local copy of a repository on your machine
- **Fork**: Creates a copy of a repository under your GitHub account (server-side)
- Clone is a Git operation, Fork is a GitHub feature

### When would you clone vs fork?

- **Clone**: When you have write access to the repo or just want to explore code locally
- **Fork**: When you want to contribute to a project you don't have write access to, or create your own version

### After forking, how do you keep your fork in sync with the original repo?

1. Add the original repo as upstream: `git remote add upstream <original-repo-url>`
2. Fetch changes from upstream: `git fetch upstream`
3. Merge upstream changes: `git merge upstream/main`
4. Push to your fork: `git push origin main`

---

## Learning Summary

- Branches enable isolated, parallel development
- Modern Git commands like `git switch` improve clarity
- Remote repositories (origin/upstream) facilitate collaboration
- Understanding fetch vs pull prevents merge conflicts
- Fork workflow is essential for open-source contribution
