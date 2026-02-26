# Git Commands Reference

## Setup & Config

### `git --version`

- Checks the installed Git version
- Example: `git --version`

### `git config --global user.name "Your Name"`

- Sets your Git username globally
- Example: `git config --global user.name "John Doe"`

### `git config --global user.email "your.email@example.com"`

- Sets your Git email globally
- Example: `git config --global user.email "john@example.com"`

### `git config --list`

- Displays all Git configuration settings
- Example: `git config --list`

---

## Basic Workflow

### `git init`

- Initializes a new Git repository in the current directory
- Example: `git init`

### `git status`

- Shows the current state of the working directory and staging area
- Example: `git status`

### `git add <file>`

- Stages a file for commit
- Example: `git add git-commands.md`

### `git add .`

- Stages all changes in the current directory
- Example: `git add .`

### `git commit -m "message"`

- Commits staged changes with a descriptive message
- Example: `git commit -m "Add initial Git commands reference"`

### `git rm <file>`

- Removes a file from the working directory and stages the deletion
- Example: `git rm old-file.txt`

### `git restore <file>`

- Discards changes in the working directory and restores file to last committed state
- Example: `git restore git-commands.md`

---

## Branching

### `git branch`

- Lists all local branches
- Example: `git branch`

### `git branch <branch name>`

- Creates a new branch
- Example: `git branch feature-login`

### `git checkout <branch>`

- Switches to an existing branch
- Example: `git checkout main`

### `git checkout -b <branch name>`

- Creates a new branch and switches to it immediately
- Example: `git checkout -b feature-signup`

### `git switch <branch>`

- Switches to an existing branch (modern alternative to checkout)
- Example: `git switch main`

### `git switch -c <branch name>`

- Creates a new branch and switches to it (modern alternative to checkout -b)
- Example: `git switch -c feature-new`

### `git branch -d <branch name>`

- Deletes a branch (only if merged)
- Example: `git branch -d feature-old`

### `git branch -D <branch name>`

- Force deletes a branch (even if not merged)
- Example: `git branch -D feature-experimental`

---

## Remote Repository

### `git remote -v`

- Lists all remote repositories with their URLs
- Example: `git remote -v`

### `git remote add origin <url>`

- Connects local repository to a remote repository
- Example: `git remote add origin https://github.com/user/repo.git`

### `git remote add upstream <url>`

- Adds the original repository as upstream (for forks)
- Example: `git remote add upstream https://github.com/original/repo.git`

### `git remote set-url origin <url_link>`

- Changes the URL of an existing remote repository
- Example: `git remote set-url origin https://github.com/user/repo.git`

### `git push origin <branch>`

- Pushes local commits to a remote repository branch
- Example: `git push origin main`

### `git push -u origin <branch>`

- Pushes branch and sets upstream tracking
- Example: `git push -u origin feature-1`

### `git pull origin <branch>`

- Fetches and merges changes from a remote repository branch
- Example: `git pull origin main`

### `git fetch`

- Downloads changes from remote repository without merging
- Example: `git fetch`

### `git fetch upstream`

- Fetches changes from upstream repository
- Example: `git fetch upstream`

### `git clone <url>`

- Creates a local copy of a remote repository
- Example: `git clone https://github.com/user/repo.git`

---

## Viewing Changes

### `git log`

- Shows the commit history
- Example: `git log`

### `git log --oneline`

- Displays commit history in a compact, one-line format
- Example: `git log --oneline`
