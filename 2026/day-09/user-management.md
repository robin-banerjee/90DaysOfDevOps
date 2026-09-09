# Day 09 – Linux User & Group Management

# Users & Groups Created

## Users
- tokyo
- berlin
- professor
- nairobi

## Groups
- developers
- admins
- project-team

---

# Group Assignments

| User | Groups |
|---|---|
| tokyo | developers, project-team |
| berlin | developers, admins |
| professor | admins |
| nairobi | project-team |

---

# Directories Created

| Directory | Group Owner | Permissions |
|---|---|---|
| /opt/dev-project | developers | 775 |
| /opt/team-workspace | project-team | 775 |

---

# Commands Used

## Create Users & Set Passwords

```bash
ubuntu@ip-of-EC2:~$ useradd -m tokyo
useradd: Permission denied. # error as this should done with root power

ubuntu@ip-of-EC2:~$ sudo useradd -m tokyo       # creating tokyo 
[sudo] password for user:
ubuntu@ip-of-EC2:~$ sudo passwd tokyo           # setting password for tokyo
New password:
Retype new password:
passwd: password updated successfully
```
```bash
ubuntu@ip-of-EC2:~$ sudo adduser berlin         # creating berlin
info: Adding user `berlin' ...
info: Selecting UID/GID from range 1000 to 59999 ...
info: Adding new group `berlin' (1007) ...
info: Adding new user `berlin' (1007) with group `berlin (1007)' ...
info: Creating home directory `/home/berlin' ...
info: Copying files from `/etc/skel' ...
New password:                               
Retype new password:
passwd: password updated successfully       # password for berlin
Changing the user information for berlin
Enter the new value, or press ENTER for the default
	Full Name []: berlin
	Room Number []:
	Work Phone []:
	Home Phone []:
	Other []:
Is the information correct? [Y/n] y
info: Adding new user `berlin' to supplemental / extra groups `users' ...
info: Adding user `berlin' to group `users' ...     # WARNING: added to 'users' group by default
```
```bash
ubuntu@ip-of-EC2:~$ sudo adduser professor      # creating professor
info: Adding user `professor' ...
info: Selecting UID/GID from range 1000 to 59999 ...
info: Adding new group `professor' (1008) ...
info: Adding new user `professor' (1008) with group `professor (1008)' ...
info: Creating home directory `/home/professor' ...
info: Copying files from `/etc/skel' ...
New password:                       
Retype new password:
Sorry, passwords do not match.
passwd: Authentication token manipulation error
passwd: password unchanged
Try again? [y/N] y
New password:
Retype new password:
passwd: password updated successfully       # password for professor
Changing the user information for professor
Enter the new value, or press ENTER for the default
	Full Name []: professor
	Room Number []:
	Work Phone []:
	Home Phone []:
	Other []:
Is the information correct? [Y/n] y
info: Adding new user `professor' to supplemental / extra groups `users' ...
info: Adding user `professor' to group `users' ...      # WARNING: added to 'users' group by default
```
```bash
ubuntu@ip-of-EC2:/opt/dev-project$ sudo useradd -m nairobi
[sudo] password for user:
# For nairobi, no password
```

---

## Verify Users

```bash
professor@ip-of-EC2:/$ cat /etc/passwd | tail -4
tokyo:x:1005:1006::/home/tokyo:/bin/sh
berlin:x:1007:1007:berlin,,,:/home/berlin:/bin/bash
professor:x:1008:1008:professor,,,:/home/professor:/bin/bash
nairobi:x:1009:1011::/home/nairobi:/bin/sh

professor@ip-of-EC2:/$ ls /home
berlin  nairobi  professor  tokyo  ubuntu
```

---

## Create Groups

```bash
ubuntu@ip-of-EC2:~$ groupadd developers
groupadd: Permission denied.

groupadd: cannot lock /etc/group; try again later.
ubuntu@ip-of-EC2:~$ sudo groupadd developers
ubuntu@ip-of-EC2:~$ sudo groupadd admins
ubuntu@ip-of-EC2:/opt/dev-project$ sudo groupadd project-team
```

---

## Verify Groups

```bash
ubuntu@ip-of-EC2:/opt/dev-project$ cat /etc/group | tail -7
tokyo:x:1006:
berlin:x:1007:
professor:x:1008:
developers:x:1009:tokyo,berlin
admins:x:1010:berlin,professor
nairobi:x:1011:
project-team:x:1012:
```

---

## Assign Users to Groups

```bash
ubuntu@ip-of-EC2:~$ sudo gpasswd -a tokyo developer     # non-existant group "developer" instead of  "developers" mentioned
gpasswd: group 'developer' does not exist in /etc/group

ubuntu@ip-of-EC2:~$ sudo gpasswd -a tokyo developers
Adding user tokyo to group developers

ubuntu@ip-of-EC2:~$ sudo usermod -aG developers,admins berlin
ubuntu@ip-of-EC2:~$ sudo usermod -aG admins professor

ubuntu@ip-of-EC2:/opt/dev-project$ sudo usermod -G project-team nairobi     # Accidentally omitting -a (append flag)
ubuntu@ip-of-EC2:/opt/dev-project$ groups nairobi   # NOTE: No problem for nairobi, as previously there was no "other secondary groups"  to overwrite
nairobi : nairobi project-team

ubuntu@ip-of-EC2:~$ groups tokyo
tokyo : tokyo developers        # NOTE: Initially tokyo was added to developers group
ubuntu@ip-of-EC2:/opt/dev-project$ sudo usermod -G project-team tokyo       # Accidentally omitting -a (append flag)
ubuntu@ip-of-EC2:/opt/dev-project$ groups tokyo
tokyo : tokyo project-team      # WARNING: For tokyo, previous "other secondary groups" got overwritten
ubuntu@ip-of-EC2:/opt/dev-project$ sudo gpasswd -a tokyo developers
Adding user tokyo to group developers       # NOTE: Explicitly had to add tokyo to developers group AGAIN!
ubuntu@ip-of-EC2:/opt/dev-project$ groups tokyo
tokyo : tokyo developers project-team
```

---

## Verify Group Membership

```
ubuntu@ip-of-EC2:/opt/dev-project$ groups tokyo
tokyo : tokyo developers project-team

ubuntu@ip-of-EC2:/opt/dev-project$ groups nairobi
nairobi : nairobi project-team

# WARNING: berlin and professor were added to default 'users' group due to use of adduser command
ubuntu@ip-of-EC2:~$ groups berlin
berlin : berlin users developers admins
ubuntu@ip-of-EC2:~$ groups professor
professor : professor users admins

# Correction: Deleting 'users' group 
ubuntu@ip-of-EC2:~$ sudo delgroup users
info: Removing group `users' ...

# NOTE: berlin and professor are free of users group
ubuntu@ip-of-EC2:~$ groups berlin
berlin : berlin developers admins
ubuntu@ip-of-EC2:~$ groups professor
professor : professor admins

# Final group memberships:
ubuntu@ip-of-EC2:/opt/dev-project$ cat /etc/group | tail -7
tokyo:x:1006:
berlin:x:1007:
professor:x:1008:
developers:x:1009:berlin,tokyo
admins:x:1010:berlin,professor
nairobi:x:1011:
project-team:x:1012:nairobi,tokyo
```

---

# Shared Directory Setup

## Create Directory

```bash
ubuntu@ip-of-EC2:~$ mkdir /opt/dev-project
mkdir: cannot create directory ‘/opt/dev-project’: Permission denied
ubuntu@ip-of-EC2:~$ sudo mkdir /opt/dev-project

ubuntu@ip-of-EC2:/opt$ ls -lt
total 16
drwxr-xr-x 2 root root 4096 Sep  9 17:22 dev-project
```

---

## Set Group Ownership

```bash
ubuntu@ip-of-EC2:/opt$ sudo chgrp developers dev-project/
ubuntu@ip-of-EC2:/opt$ ls -lt
total 16
drwxr-xr-x 2 root developers 4096 Sep  9 17:22 dev-project
```

---

## Set Permissions

```bash
ubuntu@ip-of-EC2:/opt$ sudo chmod 775 dev-project/
ubuntu@ip-of-EC2:/opt$ ls -lt
total 16
drwxrwxr-x 2 root developers 4096 Sep  9 17:22 dev-project
```

---

## Test File Creation

```bash
ubuntu@ip-of-EC2:/opt$ su tokyo
Password:
$ pwd
/opt
$ ls -lt
total 16
drwxrwxr-x 2 root developers 4096 Sep  9 17:22 dev-project
$ echo "this file was by tokyo" > /opt/dev-project/tokyo-file.txt
$ cd dev-project
$ ls
tokyo-file.txt
$ cat tokyo-file.txt
this file was by tokyo
$ exit
```
```bash
ubuntu@ip-of-EC2:/opt$ su berlin
Password:
berlin@ip-of-EC2:/opt$ pwd
/opt
berlin@ip-of-EC2:/opt$ cd dev-project/
berlin@ip-of-EC2:/opt/dev-project$ cat > berlin-file.txt
this is by berlin       # ctrl+d to write
berlin@ip-of-EC2:/opt/dev-project$ cat berlin-file.txt
this is by berlin
```

---

# Team Workspace Setup

## Create Workspace Directory

```bash
ubuntu@ip-of-EC2:/opt/dev-project$ sudo mkdir /opt/team-workspace
ubuntu@ip-of-EC2:/opt/dev-project$ cd ..
ubuntu@ip-of-EC2:/opt$ ls -lt
total 20
drwxr-xr-x 2 root root       4096 Sep  9 18:14 team-workspace
drwxrwxr-x 2 root developers 4096 Sep  9 17:48 dev-project
```

---

## Set Group & Permissions

```bash
ubuntu@ip-of-EC2:/opt$ sudo chgrp project-team team-workspace/
ubuntu@ip-of-EC2:/opt$ ls -lt
total 20
drwxr-xr-x 2 root project-team 4096 Sep  9 18:14 team-workspace
drwxrwxr-x 2 root developers   4096 Sep  9 17:48 dev-project

ubuntu@ip-of-EC2:/opt$ sudo chmod 775 team-workspace/
ubuntu@ip-of-EC2:/opt$ ls -lt
total 20
drwxrwxr-x 2 root project-team 4096 Sep  9 18:14 team-workspace
drwxrwxr-x 2 root developers   4096 Sep  9 17:48 dev-project
```

---

## Test Workspace Access

```bash
ubuntu@ip-of-EC2:/opt$ sudo -u nairobi touch /opt/team-workspace/nairobi-file.txt
ubuntu@ip-of-EC2:/opt$ ls -l /opt/team-workspace/
total 0
-rw-rw-r-- 1 nairobi nairobi 0 Sep  9 18:18 nairobi-file.txt
```

---

# How to login using created users

## Example : Login as Berlin User

* Create .ssh directory for user "berlin" - `sudo mkdir -p /home/berlin/.ssh`
    
* Copied Authorized keys from user ubuntu to berlin - `sudo cp /home/ubuntu/.ssh/authorized_keys /home/berlin/.ssh`
    
* Change the ownership of .ssh and authorized keys - `sudo chown -R berlin:berlin /home/berlin/.ssh`

* Changed permissions for .ssh and authorized keys - 
    `sudo chmod 700 /home/berlin/.ssh` &&  `sudo chmod 600 /home/berlin/.ssh/authorized_keys`

* Login - `ssh -i "EC2-private-key.pem" berlin@Public-DNS`

---

# What I Learned

* Gained a clear understanding of how users and groups work in Linux.

* Practiced managing permissions and observed their impact on collaboration.

* Even if two users belong to the same group and share access to a directory, they cannot automatically write to or modify each other’s files. By default, when a user creates a file inside a directory:
  -The file is owned by the user and their primary group (not necessarily the directory’s group).
  -The default file permissions usually give write access only to the owner, while the group gets read access.
  -As a result, other group members can view the file but cannot edit or delete it.
  Example : Shared directory scenario.

* Group Membership Management (`usermod -aG` vs `gpasswd`)

| Feature | `usermod -aG` | `gpasswd` |
| :--- | :--- | :--- |
| **Scope & Focus** | User-centric (modifies user account profile) | Group-centric (administers group membership) |
| **Syntax Order** | `-aG <group> <user>` | `-a <user> <group>` |
| **Multiple Groups** | Supported via comma separation (`-aG group1,group2`) | Requires command chaining (`gpasswd -a user g1 && gpasswd -a user g2`) |
| **Mistakes to Avoid** | **Omitting `-a`**: Running `usermod -G` without `-a` completely overwrites and wipes out all other secondary groups the user belongs to. | **Wrong Argument Order**: Passing the group name before the username, or assuming `-a` accepts multiple groups at once. |

* User Creation (`useradd` vs `adduser`)

| Feature | `useradd` | `adduser` |
| :--- | :--- | :--- |
| **Backend & Type** | Low-level C binary (`shadow-utils`) | High-level interactive Perl script wrapper |
| **Interactivity** | Non-interactive (relies entirely on explicit command flags) | Interactive step-by-step terminal prompt |
| **Home Directory** | Skipped by default (requires explicit `-m` flag) | Created automatically along with skeleton files |
| **Password Setup** | Leaves account locked (requires a separate `passwd` command) | Prompts to set and confirm the password immediately |
| **Best Use Case** | Shell scripts, automation pipelines, and Dockerfiles | Manual administration on Debian/Ubuntu-based systems |

* Set up direct login access for newly created users using SSH keys and proper permissions.