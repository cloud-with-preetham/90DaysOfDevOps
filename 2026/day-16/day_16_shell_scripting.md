# Day 16 – Shell Scripting Basics

This directory contains my solutions for **Day 16** of the **90DaysOfDevOps** challenge. The focus of this day was to understand the fundamentals of shell scripting, including shebangs, variables, user input, and conditional logic.

---

## 📁 Directory Structure

```text
2026/day-16/
├── scripts/
│   ├── hello.sh
│   ├── variables.sh
│   ├── greet.sh
│   ├── check_number.sh
│   ├── file_check.sh
│   └── server_check.sh
└── day-16-shell-scripting.md
```

---

## ✅ Task 1: First Shell Script

### `hello.sh`

```bash
#!/bin/bash
echo "Hello, DevOps!"
```

**Output:**

```text
Hello, DevOps!
```

**Learning:**
- The shebang (`#!/bin/bash`) tells the OS which interpreter to use.
- Without it, running the script directly (`./hello.sh`) can fail.
- But in my case i was using bash so it didn't give any error with or without shebang.

---

## ✅ Task 2: Variables

### `variables.sh`

```bash
#!/bin/bash

NAME="Preetham"
ROLE="Student"

echo "Hello, I am $NAME and I am a $ROLE"
```

**Output:**

```text
Hello, I am Preetham and I am a Student
```

**Learning:**
- No spaces are allowed around `=` in variables.
- Double quotes expand variables, single quotes do not.

---

## ✅ Task 3: User Input with `read`

### `greet.sh`

```bash
#!/bin/bash

read -p "Enter your name: " NAME
read -p "Enter your favourite tool: " TOOL

echo "Hello $NAME, your favourite tool is $TOOL"
```

**Sample Output:**

```text
Enter your name: Preetham
Enter your favourite tool: GitHub Actions
Hello Preetham, your favourite tool is GitHub Actions
```

---

## ✅ Task 4: If-Else Conditions

### `check_number.sh`

```bash
#!/bin/bash

read -p "Enter the number: " NUM

if [ "$NUM" -gt 0 ]; then
  echo "The number is positive"
elif [ "$NUM" -lt 0 ]; then
  echo "The number is negative"
else
  echo "The number is zero"
fi
```

**Sample Output:**

```text
Enter the number: 50
The number is positive
```

---

### `file_check.sh`

```bash
#!/bin/bash

read -p "Enter filename: " FILE

if [ -f "$FILE" ]; then
  echo "File Exists"
else
  echo "File does not exist"
fi
```

**Sample Output:**

```text
Enter filename: file_check.sh
File Exists
```

---

## ✅ Task 5: Service Status Check

### `server_check.sh`

```bash
#!/bin/bash

SERVICE="nginx"

read -p "Do you want to check the status of $SERVICE (y/n): " ANSWER

if [ "$ANSWER" = "y" ]; then
  echo "Checking $SERVICE status"
  systemctl status $SERVICE
else
  echo "Skipped"
fi
```

**Sample Output:**

```text
Do you want to check the status of nginx (y/n): n
Skipped
```

---

## 📌 Key Learnings

1. Every shell script should start with a proper shebang.
2. Quoting (`' '` vs `" "`) directly affects variable expansion.
3. `read` and `if-else` are the foundation of interactive shell scripts.

---

## 🚀 Conclusion

Day 16 helped me understand the building blocks of shell scripting and how small syntax mistakes can lead to errors. Debugging these issues improved my confidence in writing and running shell scripts.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham

