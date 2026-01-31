# Day 02 – Linux Architecture, Processes and systemd

---

## How Linux Works Under the Hood
- In today’s world, **most applications run on Linux-based systems**.
- Linux provides a stable, secure, and efficient foundation for servers, cloud, and DevOps tools.

---

## Core Concepts of Linux

- **Linux**: An **operating system** that manages hardware and software resources.
  
- **Kernel**:  
  The **core of Linux**.  
  It manages:
  - CPU scheduling
  - Memory
  - Hardware devices
  - Process management

- **User Space**:  
  Where users and applications interact with the system.
  - Command line (terminal)
  - Graphical User Interface (GUI)
  - Applications like browsers, editors, servers

- **System Libraries**:  
  Provide standard functions that allow applications to **communicate with the kernel** without direct hardware access.

- **System Utilities**:  
  Basic commands and tools used for system operations (e.g., `ls`, `ps`, `df`).

- **init**:  
  The **first process started by the kernel** during boot (PID 1 in older systems).
  It starts system services in a fixed order.

- **systemd**:  
  A **modern replacement for init**.
  - Manages system startup, services, and daemons
  - Supports parallel service startup
  - Automatically restarts failed services

---

## How Processes Are Created and Managed

### Process Creation
- `fork()` creates a new child process by duplicating the parent.
- `exec()` replaces the child process with a new program.
- Each process gets a unique **PID (Process ID)**.

### Process Management
- The kernel schedules CPU time between processes.
- Processes can run in:
  - Foreground
  - Background (`&`)
- Signals are used to control processes (start, stop, terminate).

---

## Process States
- **Running (R):** Process is executing or ready to run
- **Sleeping (S):** Waiting for an event or resource
- **Stopped (T):** Paused by a signal
- **Zombie (Z):** Process finished execution but not yet cleaned up by parent

---

## What systemd Does and Why It Matters
- Controls system boot and shutdown
- Manages services and dependencies
- Restarts failed services automatically
- Centralizes logs for easier troubleshooting

---

## 5 Commands I Would Use Daily
- `ps`, `ps aux` – View running processes
- `top` – Monitor CPU and memory usage
- `systemctl` – Manage services
- `journalctl` – View system and service logs
- `cd`, `mkdir`, `df`, `free` – Navigation and system info

