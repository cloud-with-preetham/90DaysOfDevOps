# Day 22 Notes - Understanding Git Workflow

## Question 1: What is the difference between `git add` and `git commit`?

`git add` stages changes, preparing files to be included in the next commit. It moves changes from the working directory to the staging area. `git commit` takes all staged changes and saves them as a snapshot in the repository's history with a descriptive message. In short: `git add` selects what to save, `git commit` actually saves it.

---

## Question 2: What does the staging area do? Why doesn't Git just commit directly?

The staging area acts as a middle layer where you can review and organize changes before committing them. It allows you to selectively choose which changes to include in a commit, even if you've modified multiple files. This gives you control to create logical, focused commits rather than committing everything at once, making your project history cleaner and more meaningful.

---

## Question 3: What information does `git log` show you?

`git log` displays the commit history, showing:

- Commit hash (unique identifier)
- Author name and email
- Date and time of the commit
- Commit message

This helps to track what changes were made, when, and by whom.

---

## Question 4: What is the `.git/` folder and what happens if you delete it?

The `.git/` folder is a hidden directory that contains all the metadata and history of your Git repository. It stores commits, branches, configuration, and tracking information. If you delete it, your directory becomes a regular folder with no version control — all commit history, branches, and Git functionality are permanently lost. The files remain, but all Git tracking is gone.

---

## Question 5: What is the difference between a working directory, staging area, and repository?

- **Working Directory**: The actual files and folders you see and edit on your computer. This is where you make changes.

- **Staging Area**: A temporary holding area where you prepare changes before committing. It contains the snapshot of what will go into the next commit.

- **Repository**: The `.git/` folder that stores the complete history of all commits, branches, and project metadata. It's the permanent record of your project's evolution.

**Flow**: Working Directory → (git add) → Staging Area → (git commit) → Repository
