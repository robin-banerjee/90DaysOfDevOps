# Day 28 – Revision Day: Everything from Day 1 to Day 27

## Task 1: Self-Assessment Checklist

Go through the checklist below and mark yourself honestly.

- ✅ Can do confidently
- 🟡 Need more practice
- ❌ Haven't done yet

### Linux

- ✅ Navigate Linux file system
- ✅ Manage files and directories
- ✅ Work with processes and services
- ✅ Edit files using Vim/Nano
- ✅ Troubleshoot CPU, memory, and disk usage
- ✅ Explain Linux directory structure
- 🟡 Create users and groups
- ✅ Manage file permissions and ownership
- 🟡 Configure LVM
- 🟡 Perform basic network troubleshooting

### Shell Scripting

- ✅ Write scripts using variables, command-line arguments, and user input
- ✅ Use `if`, `elif`, `else`, and `case` statements
- ✅ Write `for`, `while`, and `until` loops
- ✅ Define and call functions with arguments and return values
- 🟡 Use `grep`, `awk`, `sed`, `sort`, and `uniq` for text processing
- ✅ Handle errors using `set -e`, `set -u`, `set -o pipefail`, and `trap`
- 🟡 Schedule scripts using `crontab`

### Git & GitHub

- ✅ Initialize a Git repository, stage changes, commit, and view commit history
- ✅ Create, switch, and manage branches
- ✅ Push to and pull from GitHub
- ✅ Explain the difference between `git clone` and `git fork`
- ✅ Merge branches and understand fast-forward vs. merge commits
- ✅ Rebase a branch and explain when to use rebase vs. merge
- ✅ Use `git stash` and `git stash pop`
- ✅ Cherry-pick commits from another branch
- ✅ Explain squash merge vs. regular merge
- ✅ Use `git reset` (`--soft`, `--mixed`, `--hard`) and `git revert`
- ✅ Explain GitFlow, GitHub Flow, and Trunk-Based Development
- ✅ Use GitHub CLI (`gh`) to create repositories, pull requests, and issues

## Task 2: Revisit Your Weak Spots

### Pick 3 topics from the checklist where you marked "Need to revisit"
- DNS resolution, IP addressing, subnets, and common ports
-  Handle errors with set -e, set -u, set -o pipefail, trap
-  Rebase a branch and explain when to use it vs merge

## Task 3: Quick-Fire Questions

### Q : What does chmod 755 script.sh do?
**A:** chmod 755 script.sh gives the owner read, write, and execute (rwx) permissions, while the group and others get read and execute (r-x) permissions.

### Q : What is the difference between a process and a service?
**A:** A process is a running instance of a program, whereas a service is a program that runs in the background to provide functionality to the system or other applications

### Q : How do you find which process is using port 8080?

**A:** Use the following command to identify the process using port `8080`:

```bash
lsof -i :8080
```

Or, if elevated privileges are required:

```bash
sudo lsof -i :8080
```

### Q : What does `set -euo pipefail` do in a shell script?

**A:** It makes a shell script safer by:
- `-e` → Exits the script if any command fails.
- `-u` → Exits if an undefined variable is used.
- `-o pipefail` → Fails the pipeline if any command in the pipeline fails.

### Q : What is the difference between git reset --hard and git revert?
**A:** git reset --hard moves the branch pointer to a previous commit and discards all staged, unstaged, and committed changes after that point, whereas git revert creates a new commit that undoes the changes from a previous commit without rewriting history.

### What branching strategy would you recommend for a team of 5 developers shipping weekly?
**A:** I would recommend Trunk-Based Development because it supports frequent integration, reduces merge conflicts, and is well-suited for teams shipping weekly.

### What does git stash do and when would you use it?
**A:**  git stash temporarily stores uncommitted changes so you can switch branches or work on another feature without committing your work.

### Q : How do you schedule a script to run every day at 3 AM?

**A:** Use a cron job. Edit the crontab with:

```bash
crontab -e
```

Then add the following entry:

```bash
0 3 * * * /path/to/script.sh
```

### Q : What is the difference between git fetch and git pull?
**A:** git fetch retrieves changes from the remote repository without merging, while git pull retrieves and merges the changes into the current branch.

### Q : What is LVM and why would you use it instead of regular partitions?

**A:** LVM (Logical Volume Manager) combines one or more physical volumes into logical volumes, making storage easier to manage, resize, and extend than regular partitions.

## Task 5: Teach It Back

### Q: Explain file permissions to a new Linux user.

**A:** File permissions are a security feature in Linux that control who can read, write, or execute a file. Permissions are assigned to three categories: **Owner**, **Group**, and **Others**. Use `ls -l` to view permissions and `chmod` to change them. Numeric values are:
- `4` = Read (`r`)
- `2` = Write (`w`)
- `1` = Execute (`x`)

Examples:
- `7` = `rwx` (Read, Write, Execute)
- `6` = `rw-` (Read, Write)
- `5` = `r-x` (Read, Execute)
- `4` = `r--` (Read only)

Example:
```bash
chmod 744 file.txt
```

This gives the **owner** `rwx` permissions and the **group** and **others** `r--` permissions.
