# Day 17 – Shell Scripting (Loops, Arguments & Error Handling)

Welcome to **Day 17** of my **#90DaysOfDevOps** journey  
Today was all about moving from basic commands to **real automation with Bash**.

This repository contains hands-on shell scripts demonstrating loops, command-line arguments, package automation, and error handling — along with real debugging lessons learned along the way.

---

## What I Practiced Today

- `for` loops & `while` loops
- Command-line arguments (`$0`, `$1`, `$#`, `$@`)
- Automating package installation
- Root user validation in scripts
- Error handling using `set -e` and logical operators
- Debugging common Bash mistakes (arrays, quotes, syntax)

---

## Project Structure

```
day-17/
├── scripts/
│   ├── for_loop.sh
│   ├── count.sh
│   ├── countdown.sh
│   ├── greet.sh
│   ├── args_demo.sh
│   ├── install_packages.sh
│   └── safe_script.sh
└── day-17-scripting.md
```

---

## Scripts Explained

### for_loop.sh
Loops through a list of fruits and prints each one.

**Sample Output**
```
apple
banana
mango
pineapple
watermelon
```

---

### count.sh
Uses a `for` loop to print numbers from **1 to 10**.

---

### countdown.sh
- Takes user input
- Counts down to zero using a `while` loop
- Prints **Done!** when finished

---

### greet.sh
- Accepts a name as an argument
- Prints a greeting
- Shows usage message if no argument is provided

```
./greet.sh Preetham
Hello, Preetham
```

---

### args_demo.sh
Demonstrates command-line arguments:
- Script name (`$0`)
- Total number of arguments (`$#`)
- All arguments (`$@`)

---

### install_packages.sh
A real-world automation script that:
- Ensures the script is run as **root**
- Checks if packages are already installed
- Installs missing packages:
  - `nginx`
  - `curl`
  - `wget`

> Run with:
```
sudo ./install_packages.sh
```

---

### safe_script.sh
Demonstrates error handling:
- Uses `set -e` to exit on failure
- Safely creates directories and files
- Prevents script crashes

---

## Key Learnings

1. Bash scripting is powerful but unforgiving — syntax matters  
2. Arrays, quotes, and conditionals are common sources of errors  
3. Writing, breaking, fixing, and understanding scripts is **real DevOps work**  

