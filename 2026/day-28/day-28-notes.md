# Day 28 – Revision Notes

## Task 1: Self-Assessment Checklist

### Linux

- [x] Navigate the file system, create/move/delete files and directories
- [x] Manage processes — list, kill, background/foreground
- [x] Work with systemd — start, stop, enable, check status of services
- [x] Read and edit text files using vi/vim or nano
- [x] Troubleshoot CPU, memory, and disk issues using top, free, df, du
- [x] Explain the Linux file system hierarchy (/, /etc, /var, /home, /tmp, etc.)
- [x] Create users and groups, manage passwords
- [x] Set file permissions using chmod (numeric and symbolic)
- [x] Change file ownership with chown and chgrp
- [x] Create and manage LVM volumes
- [x] Check network connectivity — ping, curl, netstat, ss, dig, nslookup
- [x] Explain DNS resolution, IP addressing, subnets, and common ports

### Shell Scripting

- [x] Write a script with variables, arguments, and user input
- [x] Use if/elif/else and case statements
- [x] Write for, while, and until loops
- [x] Define and call functions with arguments and return values
- [x] Use grep, awk, sed, sort, uniq for text processing
- [x] Handle errors with set -e, set -u, set -o pipefail, trap
- [x] Schedule scripts with crontab

### Git & GitHub

- [x] Initialize a repo, stage, commit, and view history
- [x] Create and switch branches
- [x] Push to and pull from GitHub
- [x] Explain clone vs fork
- [x] Merge branches — understand fast-forward vs merge commit
- [x] Rebase a branch and explain when to use it vs merge
- [x] Use git stash and git stash pop
- [x] Cherry-pick a commit from another branch
- [x] Explain squash merge vs regular merge
- [x] Use git reset (soft, mixed, hard) and git revert
- [ ] Explain GitFlow, GitHub Flow, and Trunk-Based Development
- [ ] Use GitHub CLI to create repos, PRs, and issues

---

## Task 2: Revisit Your Weak Spots

### Topic 1:

**Work with systemd — start, stop, enable, check status of services:**
In the Phase 1 MCQ test a question was asked regarding this. If a particular service is restarted and you want to check whether its started or not, what command would you use?

**Clarification:** Actually, `status` is correct for checking if a service is running. `is-enabled` checks if a service will start on boot, not if it's currently running. Use `systemctl status <service>` to check current state and `systemctl is-active <service>` for a simple yes/no.

### Topic 2:

**Use grep, awk, sed, sort, uniq for text processing:**

- `grep` - Search for patterns in files
- `awk` - Process and analyze text, print specific columns
- `sed` - Stream editor for find/replace operations
- `sort` - Sort lines alphabetically or numerically
- `uniq` - Remove duplicate adjacent lines (use with sort)

### Topic 3:

**Explain clone vs fork:**

- `clone` - Creates a local copy of a repository on your machine
- `fork` - Creates your own copy of someone else's repository on GitHub, allowing you to make changes without affecting the original

---

## Task 3: Quick-Fire Questions

1. **What does `chmod 755 script.sh` do?**
   `chmod 755 script.sh` gives read, write, and execute (7) to owner, read and execute (5) to group, and read and execute (5) to others. Not read+write to group/others.

2. **What is the difference between a process and a service?**
   A process is any running program with a PID. A service is a background process managed by systemd (or init) that typically starts at boot and runs continuously (like nginx, ssh).

3. **How do you find which process is using port 8080?**
   `netstat -tulnp | grep 8080` or `ss -tulnp | grep 8080` or `lsof -i :8080`

4. **What does `set -euo pipefail` do in a shell script?**
   - `set -e` - Exit on any error
   - `set -u` - Exit on undefined variables
   - `set -o pipefail` - Exit if any command in a pipeline fails (not just the last one)

5. **What is the difference between `git reset --hard` and `git revert`?**
   `git reset --hard` moves HEAD back and deletes commits (rewrites history - dangerous for shared branches). `git revert` creates a NEW commit that undoes changes (safe for shared branches, preserves history).

6. **What branching strategy would you recommend for a team of 5 developers shipping weekly?**
   GitHub Flow or Trunk-Based Development would be better for weekly releases. GitFlow is too complex for fast releases - it's designed for scheduled releases with multiple versions in production.

7. **What does `git stash` do and when would you use it?**
   `git stash` temporarily saves uncommitted changes (not commit history) so you can switch branches with a clean working directory. Use it when you need to switch branches but aren't ready to commit your current work.

8. **How do you schedule a script to run every day at 3 AM?**
   Use `crontab -e` and add: `0 3 * * * /path/to/script.sh`

9. **What is the difference between `git fetch` and `git pull`?**
   `git fetch` downloads changes from remote but doesn't merge them (safe). `git pull` = `git fetch` + `git merge` (downloads and merges automatically).

10. **What is LVM and why would you use it instead of regular partitions?**
    LVM (Logical Volume Manager) allows flexible disk management - you can resize volumes on-the-fly, create snapshots, and span volumes across multiple disks without downtime.

---

## Task 5: Teach It Back

**Topic I'm explaining:** Git Branching

**Explanation (5-10 lines):**

Imagine you're writing a book with multiple authors. The main story is on the "main" branch. When you want to add a new chapter without messing up the main story, you create a "branch" - like making a copy to work on separately. You can write, edit, and experiment on your branch. Once you're happy with your chapter, you "merge" it back into the main story. If something goes wrong, the main story is still safe. This is exactly how developers work on features - they branch off, build their feature, test it, and merge it back when it's ready. Branches keep the main codebase stable while allowing parallel development.

---

## Additional Notes & Reflections

**Key Learnings:**

- Need to practice more with text processing tools (grep, awk, sed)
- Understand the difference between systemd commands better
- Git stash is for uncommitted work, not commit history
- Choose branching strategy based on release frequency, not organization size

**Areas to Improve:**

- File permission numeric notation (755 = rwxr-xr-x)
- Understanding when to use different git commands in real scenarios
- More hands-on practice with LVM operations

**Confidence Level:** 8/10 - Solid foundation, need more real-world practice
