# Day 25 – Git Reset vs Revert & Branching Strategies

## Task 1: Git Reset — Hands-On

### Make 3 commits in your practice repo (commit A, B, C)

```bash
user@Machine:~/Downloads/devops-notes/Git$ git log --oneline 
daca16c (HEAD -> main) Added D Commit
cb0c4d3 Added C commit
965bf1b Added A commit
ca607fd (origin/main, origin/HEAD) Update git-commands.md for Day 24
0413e9d Updated the create page to fix an urgent bug
7c852ba (origin/feature-settings, feature-settings) Add theme preference support
e612858 Add settings validation
54fd03d Add settings save functionality
18241a6 Add settings page UI
63caa00 Added profile  feature
f6c27a0 Add basic logging utility
a1d8f3f Add application configuration file
74de71f Resolve merge conflict
44fa941 Update greeting in main branch
0b5cb9f (origin/feature-conflict, feature-conflict) Update greeting in feature branch
6958dae Add greet function
0c9143e Merge branch 'feature-signup'
2492ba9 Add application entry point
6e7aa5d Add utility function for user greeting
d2f8c09 Add signup form validation
2cf5e4f Add signup page UI
2ca4e61 Merge branch 'feature-login'
a3a4106 (origin/feature-login, feature-login) Add login form validation
ce3ee08 Add login page UI
62f84ef (origin/feature-1, feature-1) Fix typo in comment for clarity
afc18ed Updated git-commands.md with Day 23 commands and descriptions
67cfdcb Updated git-commands.md with Day 23 commands
581e274 Added test.py for Testing purpose
4b2bab6 Added more Git commands to git-commands.md and updated the cheat sheet.
1ef76a7 - Updated  with additional Git commands and details.
0f0a98c - Updated  with additional Git commands.
```
### Use git reset --soft to go back one commit — what happens to the changes?

```bach
user@Machine:~/Downloads/devops-notes/Git$ git reset --soft HEAD~1
user@Machine:~/Downloads/devops-notes/Git$ git log --oneline 
cb0c4d3 (HEAD -> main) Added C commit
965bf1b Added A commit
ca607fd (origin/main, origin/HEAD) Update git-commands.md for Day 24
0413e9d Updated the create page to fix an urgent bug
7c852ba (origin/feature-settings, feature-settings) Add theme preference support
e612858 Add settings validation
54fd03d Add settings save functionality
18241a6 Add settings page UI
63caa00 Added profile  feature
f6c27a0 Add basic logging utility
a1d8f3f Add application configuration file
74de71f Resolve merge conflict
44fa941 Update greeting in main branch
0b5cb9f (origin/feature-conflict, feature-conflict) Update greeting in feature branch
6958dae Add greet function
0c9143e Merge branch 'feature-signup'
2492ba9 Add application entry point
6e7aa5d Add utility function for user greeting
d2f8c09 Add signup form validation
2cf5e4f Add signup page UI
2ca4e61 Merge branch 'feature-login'
a3a4106 (origin/feature-login, feature-login) Add login form validation
ce3ee08 Add login page UI
62f84ef (origin/feature-1, feature-1) Fix typo in comment for clarity
afc18ed Updated git-commands.md with Day 23 commands and descriptions
67cfdcb Updated git-commands.md with Day 23 commands
581e274 Added test.py for Testing purpose
4b2bab6 Added more Git commands to git-commands.md and updated the cheat sheet.
1ef76a7 - Updated  with additional Git commands and details.
0f0a98c - Updated  with additional Git commands.
aa82211 Added git-commands.md
```
### Re-commit, then use git reset --mixed to go back one commit — what happens now?
```bash
user@Machine:~/Downloads/devops-notes/Git$ git status
On branch main
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	modified:   login.js

user@Machine:~/Downloads/devops-notes/Git$ git commit -m "Added Commit E"
[main 28e97b1] Added Commit E
 1 file changed, 1 insertion(+), 1 deletion(-)
user@Machine:~/Downloads/devops-notes/Git$ git log --oneline 
28e97b1 (HEAD -> main) Added Commit E
cb0c4d3 Added C commit
965bf1b Added A commit
ca607fd (origin/main, origin/HEAD) Update git-commands.md for Day 24
0413e9d Updated the create page to fix an urgent bug
7c852ba (origin/feature-settings, feature-settings) Add theme preference support
e612858 Add settings validation
54fd03d Add settings save functionality
18241a6 Add settings page UI
63caa00 Added profile  feature
f6c27a0 Add basic logging utility
a1d8f3f Add application configuration file
74de71f Resolve merge conflict
44fa941 Update greeting in main branch
0b5cb9f (origin/feature-conflict, feature-conflict) Update greeting in feature branch
6958dae Add greet function
0c9143e Merge branch 'feature-signup'
2492ba9 Add application entry point
6e7aa5d Add utility function for user greeting
d2f8c09 Add signup form validation
2cf5e4f Add signup page UI
2ca4e61 Merge branch 'feature-login'
a3a4106 (origin/feature-login, feature-login) Add login form validation
ce3ee08 Add login page UI
62f84ef (origin/feature-1, feature-1) Fix typo in comment for clarity
afc18ed Updated git-commands.md with Day 23 commands and descriptions
67cfdcb Updated git-commands.md with Day 23 commands
581e274 Added test.py for Testing purpose
4b2bab6 Added more Git commands to git-commands.md and updated the cheat sheet.
1ef76a7 - Updated  with additional Git commands and details.
0f0a98c - Updated  with additional Git commands.
aa82211 Added git-commands.md
user@Machine:~/Downloads/devops-notes/Git$ git reset --mixed HEAD~1
Unstaged changes after reset:
M	login.js
user@Machine:~/Downloads/devops-notes/Git$ git status
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   login.js

no changes added to commit (use "git add" and/or "git commit -a")
```

Re-commit, then use git reset --hard to go back one commit — what happens this time?

```bash
user@Machine:~/Downloads/devops-notes/Git$ git status 
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   login.js
no changes added to commit (use "git add" and/or "git commit -a")

user@Machine:~/Downloads/devops-notes/Git$ git add .
user@Machine:~/Downloads/devops-notes/Git$ git commit -m "Added F commit"
[main f957a3e] Added F commit
 1 file changed, 1 insertion(+), 1 deletion(-)

user@Machine:~/Downloads/devops-notes/Git$ git log --oneline
f957a3e (HEAD -> main) Added F commit
cb0c4d3 Added C commit
965bf1b Added A commit
ca607fd (origin/main, origin/HEAD) Update git-commands.md for Day 24
0413e9d Updated the create page to fix an urgent bug
7c852ba (origin/feature-settings, feature-settings) Add theme preference support
e612858 Add settings validation
54fd03d Add settings save functionality
18241a6 Add settings page UI
63caa00 Added profile  feature
f6c27a0 Add basic logging utility
a1d8f3f Add application configuration file
74de71f Resolve merge conflict
44fa941 Update greeting in main branch
0b5cb9f (origin/feature-conflict, feature-conflict) Update greeting in feature branch
6958dae Add greet function
0c9143e Merge branch 'feature-signup'
2492ba9 Add application entry point
6e7aa5d Add utility function for user greeting
d2f8c09 Add signup form validation
2cf5e4f Add signup page UI
2ca4e61 Merge branch 'feature-login'
a3a4106 (origin/feature-login, feature-login) Add login form validation
ce3ee08 Add login page UI
62f84ef (origin/feature-1, feature-1) Fix typo in comment for clarity
afc18ed Updated git-commands.md with Day 23 commands and descriptions
67cfdcb Updated git-commands.md with Day 23 commands
581e274 Added test.py for Testing purpose
4b2bab6 Added more Git commands to git-commands.md and updated the cheat sheet.
1ef76a7 - Updated  with additional Git commands and details.
0f0a98c - Updated  with additional Git commands.
aa82211 Added git-commands.md

user@Machine:~/Downloads/devops-notes/Git$ git reset --hard HEAD~1
HEAD is now at cb0c4d3 Added C commit
user@Machine:~/Downloads/devops-notes/Git$ git status
On branch main
nothing to commit, working tree clean 
```

## Answer in your notes

### What is the difference between --soft, --mixed, and --hard?

--soft keeps changes staged, --mixed keeps changes only in the working directory (unstaged), and --hard removes the changes completely.

### Which one is destructive and why?

git reset --hard is destructive because it permanently deletes changes from both the staging area and the working directory, making them difficult or impossible to recover.

### When would you use each one?

Use --soft when you want to undo a commit but keep the changes staged, --mixed when you want to undo a commit and keep the changes in the working directory (unstaged), and --hard when you want to discard the commit and all its changes completely.

### Should you ever use git reset on commits that are already pushed?

Avoid using git reset on commits that have already been pushed because it rewrites commit history and can cause problems for other people who have pulled those commits.

## Task 2: Git Revert — Hands-On

### Make 3 commits (commit X, Y, Z)

```bash
user@Machine:~/Downloads/devops-notes/Git$ git log --oneline 
a5c1ef1 (HEAD -> main) Added Z Commit
8829095 Added Y Commit
db118aa Added X Commit
cb0c4d3 Added C commit
965bf1b Added A commit
ca607fd (origin/main, origin/HEAD) Update git-commands.md for Day 24
0413e9d Updated the create page to fix an urgent bug
7c852ba (origin/feature-settings, feature-settings) Add theme preference support
e612858 Add settings validation
54fd03d Add settings save functionality
18241a6 Add settings page UI
63caa00 Added profile  feature
f6c27a0 Add basic logging utility
a1d8f3f Add application configuration file
74de71f Resolve merge conflict
44fa941 Update greeting in main branch
0b5cb9f (origin/feature-conflict, feature-conflict) Update greeting in feature branch
6958dae Add greet function
0c9143e Merge branch 'feature-signup'
2492ba9 Add application entry point
6e7aa5d Add utility function for user greeting
d2f8c09 Add signup form validation
2cf5e4f Add signup page UI
2ca4e61 Merge branch 'feature-login'
a3a4106 (origin/feature-login, feature-login) Add login form validation
ce3ee08 Add login page UI
62f84ef (origin/feature-1, feature-1) Fix typo in comment for clarity
afc18ed Updated git-commands.md with Day 23 commands and descriptions
67cfdcb Updated git-commands.md with Day 23 commands
581e274 Added test.py for Testing purpose
4b2bab6 Added more Git commands to git-commands.md and updated the cheat sheet.
1ef76a7 - Updated  with additional Git commands and details.
0f0a98c - Updated  with additional Git commands.
aa82211 Added git-commands.md
```

### Revert commit Y (the middle one) — what happens?

```bash
user@Machine:~/Downloads/devops-notes/Git$ git revert 8829095
[main 13c4e1d] Revert "Added Y Commit"
 1 file changed, 1 deletion(-)

user@Machine:~/Downloads/devops-notes/Git$ git log --oneline 
13c4e1d (HEAD -> main) Revert "Added Y Commit"
a5c1ef1 Added Z Commit
8829095 Added Y Commit
db118aa Added X Commit
cb0c4d3 Added C commit
965bf1b Added A commit
ca607fd (origin/main, origin/HEAD) Update git-commands.md for Day 24
0413e9d Updated the create page to fix an urgent bug
7c852ba (origin/feature-settings, feature-settings) Add theme preference support
e612858 Add settings validation
54fd03d Add settings save functionality
18241a6 Add settings page UI
63caa00 Added profile  feature
f6c27a0 Add basic logging utility
a1d8f3f Add application configuration file
74de71f Resolve merge conflict
44fa941 Update greeting in main branch
0b5cb9f (origin/feature-conflict, feature-conflict) Update greeting in feature branch
6958dae Add greet function
0c9143e Merge branch 'feature-signup'
2492ba9 Add application entry point
6e7aa5d Add utility function for user greeting
d2f8c09 Add signup form validation
2cf5e4f Add signup page UI
2ca4e61 Merge branch 'feature-login'
a3a4106 (origin/feature-login, feature-login) Add login form validation
ce3ee08 Add login page UI
62f84ef (origin/feature-1, feature-1) Fix typo in comment for clarity
afc18ed Updated git-commands.md with Day 23 commands and descriptions
67cfdcb Updated git-commands.md with Day 23 commands
581e274 Added test.py for Testing purpose
4b2bab6 Added more Git commands to git-commands.md and updated the cheat sheet.
1ef76a7 - Updated  with additional Git commands and details.
0f0a98c - Updated  with additional Git commands.
aa82211 Added git-commands.md
```

### Check git log — is commit Y still in the history?

Yes, commit Y is still in the history after git revert; Git creates a new commit that undoes Y's changes instead of removing Y from the commit history.


## Answer in your notes

### How is git revert different from git reset?

git revert preserves history by creating an undo commit, while git reset rewrites history by moving the branch back and removing commits from the branch history.


### Why is revert considered safer than reset for shared branches?
git revert → Keeps all existing commits and adds a new "undo" commit.
git reset → Changes branch history by removing commits from the current branch.
On shared branches (like main), rewriting history with reset can cause conflicts and confusion for others who have already pulled those commits.

### When would you use revert vs reset?
git revert is best for shared branches because it preserves history, while git reset is best for local, unshared commits because it rewrites history.

## Task 3: Reset vs Revert — Summary

## Git Reset vs Git Revert

| Feature | `git reset` | `git revert` |
|----------|------------|-------------|
| **What it does** | Moves the branch pointer back and optionally removes commits | Creates a new commit that undoes the changes of a previous commit |
| **Removes commit from history?** | Yes | No |
| **Safe for shared/pushed branches?** | No | Yes |
| **When to use** | For local/unshared commits when you want to rewrite history | For shared/pushed commits when you want to undo changes safely |

### Summary

- **`git reset`** rewrites history by removing commits from the branch.
- **`git revert`** preserves history by creating a new commit that reverses earlier changes.
- Use **`git reset`** for local commits that have not been pushed.
- Use **`git revert`** for commits that have already been pushed or shared with others.

## Task 4: Branching Strategies

## Branching Strategies

### 1. Git Flow

**How it works:**

* Uses separate branches for development and production.
* Main branches: `main` and `develop`.
* Feature, release, and hotfix branches are created as needed.
* Suitable for projects with scheduled releases.

### 2. GitHub Flow

**How it works:**

* Uses a single `main` branch as the production branch.
* Create a feature branch for each change.
* Open a Pull Request (PR), review, and merge into `main`.
* Simple and ideal for continuous deployment.

### 3. GitLab Flow

**How it works:**

* Similar to GitHub Flow but includes environment branches such as `staging` and `production`.
* Changes are merged through environments before reaching production.
* Useful for teams with deployment stages.

### 4. Trunk-Based Development

**How it works:**

* Developers work on short-lived feature branches or directly on the main branch (trunk).
* Changes are merged frequently into the trunk.
* Encourages continuous integration and rapid delivery.
* Common in DevOps and Agile teams.

## A simple diagram or flow (text-based is fine)

## Branching Strategies

### 1. Git Flow

**How it works:**
- Uses `main` and `develop` as long-lived branches.
- Features are developed in feature branches.
- Releases and hotfixes use dedicated branches.

**Diagram:**
```text
main ────────────────●──────────────●
                      \            /
develop ──●────●──────●────●──────●
            \        /
feature ─────●──────●
```

---

### 2. GitHub Flow

**How it works:**
- Create a branch from `main`.
- Make changes and open a Pull Request.
- Review and merge back into `main`.

**Diagram:**
```text
main ──●──────────────●──────────────●
         \            /
feature ──●────●────●
```

---

### 3. GitLab Flow

**How it works:**
- Uses feature branches and environment branches.
- Changes move through staging before production.

**Diagram:**
```text
feature ──●────●
            \
main ────────●─────────●
                      \
staging ───────────────●
                        \
production ─────────────●
```

---

### 4. Trunk-Based Development

**How it works:**
- Developers frequently merge small changes into the main branch (trunk).
- Feature branches are short-lived.

**Diagram:**
```text
main ──●──●──●──●──●──●──●
         \ /    \ /
          ●      ●
      short-lived
    feature branches
```

## When/where it's used

### Git Flow

**When/Where it's used:**  
Used in large projects with planned releases and multiple development stages. Common in enterprise software development.

### GitHub Flow

**When/Where it's used:**  
Used for continuous deployment and rapid development. Common in web applications and small-to-medium development teams.

### GitLab Flow

**When/Where it's used:**  
Used when code moves through environments such as staging and production before release. Common in DevOps workflows.

### Trunk-Based Development

**When/Where it's used:**  
Used in Agile and CI/CD environments where developers merge small changes frequently. Common in modern DevOps teams.


## Pros and cons

### Git Flow

**Pros:**
- Well-structured and easy to manage releases.
- Supports parallel development with feature, release, and hotfix branches.

**Cons:**
- Complex for small projects.
- Requires more branch management and coordination.

---

### GitHub Flow

**Pros:**
- Simple and easy to understand.
- Supports continuous deployment and rapid releases.

**Cons:**
- Less suitable for projects with scheduled releases.
- Requires strong testing before merging to `main`.

---

### GitLab Flow

**Pros:**
- Integrates well with deployment environments.
- Provides a clear path from development to production.

**Cons:**
- More complex than GitHub Flow.
- Requires managing additional environment branches.

---

### Trunk-Based Development

**Pros:**
- Encourages frequent integration and faster feedback.
- Works well with CI/CD pipelines.

**Cons:**
- Requires good automated testing.
- Frequent merges can be challenging without team discipline.

## Answer

### Which strategy would you use for a startup shipping fast?

For a startup shipping fast, I would use GitHub Flow or Trunk-Based Development. Both encourage small, frequent changes and quick deployments, making them ideal for rapid development and continuous delivery.

### Which strategy would you use for a large team with scheduled releases?

For a large team with scheduled releases, I would use Git Flow. It provides separate branches for development, releases, and hotfixes, making it easier to manage complex projects and planned release cycles.

### Which one does your favorite open-source project use? (check any repo on GitHub)

My favorite open-source project is Kubernetes. It uses a GitHub-style workflow with feature branches and Pull Requests before merging into the main branch. This approach works well for large open-source communities.

## Task 5: Git Commands Reference Update

- Updated `git-commands.md` -> [Git Commands Cheat Sheet](https://github.com/robin-banerjee/devops-notes/blob/main/Git/git-commands.md)

