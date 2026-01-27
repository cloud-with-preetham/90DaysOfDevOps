# Day-2: Linux Architecture, Processes and systemd

---

## How Linux works under the woods?
- In the present world **90% of apps use linux**, and also built and running on linux.

---

## Explain the Core concepts of Linux?
- **Linux**: Is an **Operating System**.
- **Kernel**: **Kernel is the core of linux** or you can say it as the heart of linux.
- **User Space**: **User Space is noting but User Interaction**. It is basically using the terminal to interact with or using Graphical User Interface.
- **System Libraries**: **System Libraries** is providing functions for applications to **interact with the kernel**.
- **System Utilities**: It is basic commands for system operations.
- **init**: **init** is a tradition first process in the Linux kernel during boot. It initializes the system by staring the process and services in a specific order.
- **systemd**: **systemd** is a mordern replacement for init. It manages system, startup and services and daemons more efficently and supports parallel system startups.

---

## How processes are created and managed?
1. Process Creation:
- A new process is created using `fork()` system call that duplicates the parent process.
- `exec()` can then replace the new process memory with the new program.
- The new program then gets a unique PID (Process ID).

2. Process Management:
- The kernel manages processes, scheduling CPU time.
- Commands like `ps` show running processes.
- Processes can run in foreground & background using `&`.
- Signal control processes using `(start,stop and kill)`.

## Process States:
- Running(R): Process is running and ready to execute.
- Sleeping(S): Process is waiting for an event or resource.
- Stopped(T): Process is stopped, usually by a signal.
- Zombie(Z): Process has fininshed execution but still has an entry in the processes table.

---

## What systemd does and why it matters?
- `systemd` keeps Linux system oraginized and running smoothly from boot to shutdown.

--- 

## Listing 5 commands i would use daily.
- `ps` `ps aux`
- `start, stop, kill`
- `systemctl, journalctl`
- `cd, mkdir, rmdir, free, df`
- `cp, mv, rm`
