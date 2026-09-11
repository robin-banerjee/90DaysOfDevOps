# File Ownership Challenge (chown & chgrp)

## Users Created
- tokyo
- berlin
- nairobi
- professor

## Groups Created
- heist-team
- planners
- vault-team
- tech-team

# Files & Directories Created

## Files
- devops-file.txt
- team-notes.txt
- project-config.yaml
- heist-project/vault/gold.txt
- heist-project/plans/strategy.conf
- bank-heist/access-codes.txt
- bank-heist/blueprints.pdf
- bank-heist/escape-plan.txt

## Directories
- app-logs/
- heist-project/
- heist-project/vault/
- heist-project/plans/
- bank-heist/

---

# Understanding Ownership

```
user@host-IP:~/day-11$ ls -lt
total 12
-rw-rw-r-- 1 user user 3152 Sep 11 12:31 file-ownership.md
-rw-rw-r-- 1 user user 4448 Sep  5 21:28 README.md
```

Observed format:

```text
-rw-rw-r-- 1 owner group size date filename
```

* Owner : The owner is usually the user who created the file or directory. Owner can change permission of file.
* Group : The group is a collection of users who share access to the file.

---

# Commands Used

## Created Users

```
sudo useradd -m tokyo
sudo useradd -m berlin
sudo useradd -m professor
sudo useradd -m nairobi
```

---

## Create Groups

```bash
sudo groupadd heist-team
sudo groupadd planners
sudo groupadd vault-team
sudo groupadd tech-team
```

---

# Basic chown Operations

- Create file devops-file.txt
- Check current owner: ls -l devops-file.txt
- Change owner to tokyo and later change to berlin
- Verify the changes

```
user@host-IP:~/day-11$ touch devops-file.txt
user@host-IP:~/day-11$ ls -l devops-file.txt
-rw-rw-r-- 1 user user 0 Sep 11 12:46 devops-file.txt

user@host-IP:~/day-11$ sudo chown tokyo devops-file.txt
user@host-IP:~/day-11$ ls -l devops-file.txt
-rw-rw-r-- 1 tokyo user 0 Sep 11 12:46 devops-file.txt

user@host-IP:~/day-11$ sudo chown berlin devops-file.txt
user@host-IP:~/day-11$ ls -l devops-file.txt
-rw-rw-r-- 1 berlin user 0 Sep 11 12:46 devops-file.txt
```

---

# Basic chgrp Operations
- Create file team-notes.txt
- Check current group: ls -l team-notes.txt
- Create group: sudo groupadd heist-team
- Change file group to heist-team
- Verify the change
```
user@host-IP:~/day-11$ touch team-notes.txt
user@host-IP:~/day-11$ ls -l team-notes.txt
-rw-rw-r-- 1 user user 0 Sep 11 12:56 team-notes.txt

user@host-IP:~/day-11$ sudo chgrp heist-team team-notes.txt
chgrp: invalid group: ‘heist-team’
user@host-IP:~/day-11$ sudo groupadd heist-team

user@host-IP:~/day-11$ sudo chgrp heist-team team-notes.txt
user@host-IP:~/day-11$ ls -l team-notes.txt
-rw-rw-r-- 1 user heist-team 0 Sep 11 12:56 team-notes.txt
```

---

# Combined Owner & Group Change

**Using chown you can change both owner and group together**
- Create file project-config.yaml
- Change owner to professor AND group to heist-team (one command)
- Create directory app-logs/
- Change its owner to berlin and group to heist-team
```
user@host-IP:~/day-11$ touch project-config.yaml
user@host-IP:~/day-11$ ls -l project-config.yaml
-rw-rw-r-- 1 user user 0 Sep 11 13:16 project-config.yaml

user@host-IP:~/day-11$ sudo chown professor:heist-team project-config.yaml
user@host-IP:~/day-11$ ls -l project-config.yaml
-rw-rw-r-- 1 professor heist-team 0 Sep 11 13:16 project-config.yaml

user@host-IP:~/day-11$ mkdir -p app-logs
user@host-IP:~/day-11$ ls -lt
total 20
drwxrwxr-x 2 user      user       4096 Sep 11 13:18 app-logs
-rw-rw-r-- 1 professor heist-team    0 Sep 11 13:16 project-config.yaml
-rw-rw-r-- 1 user      user       4778 Sep 11 13:04 file-ownership.md
-rw-rw-r-- 1 user      heist-team    0 Sep 11 12:56 team-notes.txt
-rw-rw-r-- 1 berlin    user          0 Sep 11 12:46 devops-file.txt
-rw-rw-r-- 1 user      user       4448 Sep  5 21:28 README.md

user@host-IP:~/day-11$ sudo chown berlin:heist-team app-logs
user@host-IP:~/day-11$ ls -lt
total 20
drwxrwxr-x 2 berlin    heist-team 4096 Sep 11 13:18 app-logs
-rw-rw-r-- 1 professor heist-team    0 Sep 11 13:16 project-config.yaml
-rw-rw-r-- 1 user      user       4778 Sep 11 13:04 file-ownership.md
-rw-rw-r-- 1 user      heist-team    0 Sep 11 12:56 team-notes.txt
-rw-rw-r-- 1 berlin    user          0 Sep 11 12:46 devops-file.txt
-rw-rw-r-- 1 user      user       4448 Sep  5 21:28 README.md
```

---

# Recursive Ownership Change

1. Create directory structure:
   ```
   mkdir -p heist-project/vault
   mkdir -p heist-project/plans
   touch heist-project/vault/gold.txt
   touch heist-project/plans/strategy.conf
   ```

2. Create group `planners`: `sudo groupadd planners`

3. Change ownership of entire `heist-project/` directory:
   - Owner: `professor`
   - Group: `planners`
   - Use recursive flag (`-R`)

4. Verify all files and subdirectories changed: `ls -lR heist-project/`

```
user@host-IP:~/day-11$ mkdir -p heist-project/vault
mkdir -p heist-project/plans
touch heist-project/vault/gold.txt
touch heist-project/plans/strategy.conf

user@host-IP:~/day-11$ sudo groupadd planners

user@host-IP:~/day-11$ sudo chown -R professor:planners heist-project

user@host-IP:~/day-11$ ls -lR heist-project/
heist-project/:
total 8
drwxrwxr-x 2 professor planners 4096 Sep 11 13:28 plans
drwxrwxr-x 2 professor planners 4096 Sep 11 13:28 vault

heist-project/plans:
total 0
-rw-rw-r-- 1 professor planners 0 Sep 11 13:28 strategy.conf

heist-project/vault:
total 0
-rw-rw-r-- 1 professor planners 0 Sep 11 13:28 gold.txt
```

---

# Practice Challenge

1. Create users: `tokyo`, `berlin`, `nairobi` (if not already created)
2. Create groups: `vault-team`, `tech-team`
3. Create directory: `bank-heist/`
4. Create 3 files inside:
   ```
   touch bank-heist/access-codes.txt
   touch bank-heist/blueprints.pdf
   touch bank-heist/escape-plan.txt
   ```

5. Set different ownership:
   - `access-codes.txt` → owner: `tokyo`, group: `vault-team`
   - `blueprints.pdf` → owner: `berlin`, group: `tech-team`
   - `escape-plan.txt` → owner: `nairobi`, group: `vault-team`

**Verify:** `ls -l bank-heist/`

```
user@host-IP:~/day-11$ sudo groupadd vault-team
user@host-IP:~/day-11$ sudo groupadd tech-team
user@host-IP:~/day-11$ cat /etc/group | tail -4
heist-team:x:1013:
planners:x:1014:
vault-team:x:1015:
tech-team:x:1016:

user@host-IP:~/day-11$ mkdir -p bank-heist
user@host-IP:~/day-11$ ls -lt
total 28
drwxrwxr-x 2 user      user       4096 Sep 11 14:37 bank-heist
-rw-rw-r-- 1 user      user       7631 Sep 11 13:40 file-ownership.md
drwxrwxr-x 4 professor planners   4096 Sep 11 13:28 heist-project
drwxrwxr-x 2 berlin    heist-team 4096 Sep 11 13:18 app-logs
-rw-rw-r-- 1 professor heist-team    0 Sep 11 13:16 project-config.yaml
-rw-rw-r-- 1 user      heist-team    0 Sep 11 12:56 team-notes.txt
-rw-rw-r-- 1 berlin    user          0 Sep 11 12:46 devops-file.txt
-rw-rw-r-- 1 user      user       4448 Sep  5 21:28 README.md

user@host-IP:~/day-11$ touch bank-heist/access-codes.txt
touch bank-heist/blueprints.pdf
touch bank-heist/escape-plan.txt

user@host-IP:~/day-11$ ls -lR bank-heist/
bank-heist/:
total 0
-rw-rw-r-- 1 user user 0 Sep 11 14:38 access-codes.txt
-rw-rw-r-- 1 user user 0 Sep 11 14:38 blueprints.pdf
-rw-rw-r-- 1 user user 0 Sep 11 14:38 escape-plan.txt

user@host-IP:~/day-11$ sudo chown tokyo:vault-team bank-heist/access-codes.txt
user@host-IP:~/day-11$ sudo chown berlin:tech-team bank-heist/blueprints.pdf
user@host-IP:~/day-11$ sudo chown nairobi:vault-team bank-heist/escape-plan.txt

user@host-IP:~/day-11$ ls -lR bank-heist/
bank-heist/:
total 0
-rw-rw-r-- 1 tokyo   vault-team 0 Sep 11 14:38 access-codes.txt
-rw-rw-r-- 1 berlin  tech-team  0 Sep 11 14:38 blueprints.pdf
-rw-rw-r-- 1 nairobi vault-team 0 Sep 11 14:38 escape-plan.txt
```

---

# Ownership Changes

- devops-file.txt → user:user → berlin:user
- team-notes.txt → user:user → user:heist-team
- project-config.yaml → user:user → professor:heist-team
- app-logs/ → user:user → berlin:heist-team
- heist-project/ → user:user → professor:planners

---

## Commands Used

- View ownership : `ls -l filename`
- Change owner only : `sudo chown newowner filename`
- Change group only : `sudo chgrp newgroup filename`
- Change both owner and group : `sudo chown owner:group filename`
- Recursive change (directories) : `sudo chown -R owner:group directory/`
- Change only group with chown : `sudo chown :groupname filename` 
    ```
    user@host-IP:~/day-11$ ls -lt README.md
    -rw-rw-r-- 1 user      user       4448 Sep  5 21:28 README.md

    user@host-IP:~/day-11$ sudo chown :heist-team README.md

    user@host-IP:~/day-11$ ls -lt README.md
    -rw-rw-r-- 1 user heist-team 4448 Sep  5 21:28 README.md
    ```

---

# What I Learned

- Difference between file owner and group ownership and how to change them using `chown` and `chgrp` commands respectively.
- How recursive ownership works in directories with -R flag.
- Two ways to change only the group ownership:
    * using chgrp: `sudo chgrp groupname filename`
    * using chown: `sudo chown :groupname filename`
