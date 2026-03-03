# Day 38 – YAML Basics Documentation

## Overview

This document contains my learnings and YAML files created while completing Day 38 tasks on YAML basics.

---

## Task 1: Key-Value Pairs

### person.yaml

```yaml
name: Preetham Pereira
role: DevOps Engineer
experience_years: 0.25
learning: true
```

---

## Task 2: Lists

### Updated person.yaml

```yaml
name: Preetham Pereira
role: DevOps Engineer
experience_years: 0.25
learning: true
tools:
  - Docker
  - Kubernetes
  - Jenkins
  - Terraform
  - Ansible
hobbies: [reading, coding, hiking]
```

**Two ways to write lists in YAML:**

1. Block style (multi-line with `-` prefix)
2. Inline/flow style (comma-separated within `[]`)

---

## Task 3: Nested Objects

### server.yaml

```yaml
server:
  name: prod-server-01
  ip: 192.168.1.100
  port: 8080

database:
  host: db.example.com
  name: production_db
  credentials:
    user: admin
    password: secure_password_123
```

**Validation Note:** Using tabs instead of spaces causes parsing errors. YAML strictly requires spaces for indentation.

---

## Task 4: Multi-line Strings

### Updated server.yaml with startup_script

```yaml
server:
  name: prod-server-01
  ip: 192.168.1.100
  port: 8080

database:
  host: db.example.com
  name: production_db
  credentials:
    user: admin
    password: secure_password_123

startup_script: |
  #!/bin/bash
  echo "Starting server..."
  systemctl start nginx
  systemctl start app

description: >
  This is a production server
  that handles web traffic and
  serves the main application.
```

**When to use `|` vs `>`:**

- Use `|` (literal block) when you need to preserve line breaks (e.g., scripts, code)
- Use `>` (folded block) when you want text to fold into a single line (e.g., descriptions, paragraphs)

---

## Task 5: Validation Results

**Validation Steps:**

1. **Installed yamllint:**
   ```bash
   sudo apt install yamllint
   ```

2. **Validated person.yml:**
   ```bash
   yamllint person.yml
   ```
   Result:
   ```
   person.yml
     3:1  warning  missing document start "---"  (document-start)
   ```

3. **Validated server.yml:**
   ```bash
   yamllint server.yml
   ```
   Result:
   ```
   server.yml
     1:1   warning  missing document start "---"  (document-start)
     23:81 error    line too long (355 > 80 characters)  (line-length)
   ```

4. **Intentionally broke indentation:**
   Created `server_broken.yml` with incorrect indentation:
   ```yaml
   server:
     name: prod-server-01
     ip: 192.168.1.100
       port: 8080  # Wrong indentation - 4 spaces instead of 2
   ```
   
   Validation result:
   ```
   server_broken.yml
     4:9  error  syntax error: mapping values are not allowed here (syntax)
   ```

5. **Fixed indentation and validation passed** ✓

---

## Task 6: Spot the Difference

**What's wrong with Block 2:**
The indentation is inconsistent. The first list item `- docker` has no indentation (0 spaces), while the second item `- kubernetes` has 2 spaces. All list items must have the same indentation level.

**Correct format:**

```yaml
tools:
  - docker
  - kubernetes
```

---

## Key Learnings

1. **Indentation is Critical**: YAML uses spaces (never tabs) for structure. Consistent 2-space indentation is the standard, and any inconsistency breaks the file.

2. **Multiple Data Structures**: YAML supports key-value pairs, lists (block and inline), nested objects, and multi-line strings with different behaviors (`|` vs `>`).

3. **Validation is Essential**: Always validate YAML files before using them in production. Small syntax errors can cause entire pipelines to fail.

---

## Conclusion

YAML is simple yet powerful. Understanding its syntax rules is fundamental for writing CI/CD pipelines and configuration files in DevOps.
