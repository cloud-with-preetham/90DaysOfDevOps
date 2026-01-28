# Day-4: Linux Practice: Processes and Services

## Running Processes
1. Active Processes

- What command i used?
I used `ps aux | head` command to see the processes.
- What did i learn from the command?
I learnt about the processes, my first point of note is init or systemd. The user who can operate this is **root**. It is in Process ID 1, so the system has been started before 1 minute ago and it is utilizing 0.2% of CPU and 1.4% of Memory.
- What i didn't understood in the command was?
It was about the VSZ, RSS and TTY. So i will try to research from google what it is actually about.


2. Live Processes
- What command i used?
I used `top` command to see the processes.
- What i learnt or observed?
I learnt that `top` command is used to see live processes. I observed about the total processes, running, sleeping, stoppedand zombie. Also how much memory has been utilized by the processes. In my case i recognised 2 processes one is my own user running the top command as a process and another is root user who is running systemd as a command in process from past several minutes.
- What i didn't understood in the commad pallet?
In the `top` command i recognized 2 column which is represented with PR and NI. 

3. Filtering a Process
- What command i used?
I used `ps aux | grep systemd` as a command.
- What i learnt for this?
I learnt what is grep and why it is useful in linux commands. It is beacause to ease the process of finding what necessary we want and also i recognised my process ID of my ubuntu user 1043. **grep** commands are always highlighted in color.
- What i didn't understood in this?
Mainly about what is **systemd+** now.


## Inspecting systemd
1. Checking service status
- What command i used?
I used `systemctl status ssh` as a command.
- What i learnt from this?
I mainly focused on ssh services and Active: active (running) and Main PID: 1037 (sshd) and also a log filed at the end of the session about my ssh login.
- What i didn't understood?
It is about in the loaded section ssh.service is disabled but still how is it running and why..! Another doubt is that why my ssh service is open to the internet its showing listening on 0.0.0.0 port 22. (this is open access to all through internet, so as per my knowledge this might be dangerous.

2. Service lifecycle
- What command i used?
I used `systemctl is-enabled ssh` commnd in my terminal.
- What did i learn?
Actually my ssh service is disabled.

## Troubleshooting Flow
1. Checking system load
- What command i used?
I used `uptime` command in terminal.
- What i learnt from this?
I saw the system information like time weather the system is up or not and at what time it started, how many users, load average of the system.(mine was 0.00) no load.

2. Checking recent logs
- What command i used?
I used `journalctl -u ssh -n 10` command in the terminal.
- What did i learn?
I saw that systemd is trying to commiunicate with ssh to connect and listen through port 22.
- What about the logs?
Logs were positive and no errors were shown in this process.
