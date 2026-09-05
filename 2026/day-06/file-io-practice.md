# Read and Write text files in Linux

- Created empty file named notes.txt and updated modified time with -m
```
guy@localhost:~/90DaysOfDevOps/2026/day-06$ touch notes.txt
guy@localhost:~/90DaysOfDevOps/2026/day-06$ stat notes.txt 
  File: notes.txt
  Size: 0               Blocks: 0          IO Block: 4096   regular empty file
Device: 252,1   Inode: 37886218    Links: 1
Access: (0664/-rw-rw-r--)  Uid: ( 1000/    user)   Gid: ( 1000/    user)
Access: 2026-09-05 20:28:00.745381679 +0530
Modify: 2026-09-05 20:28:00.745381679 +0530
Change: 2026-09-05 20:28:00.745381679 +0530
 Birth: 2026-09-05 20:28:00.745381679 +0530
```
Notice here initially `Access` time and `Modify` time were same, later `Modify` time was explicitly updated for the file notes.txt as per stat
```
guy@localhost:~/90DaysOfDevOps/2026/day-06$ touch -m notes.txt
guy@localhost:~/90DaysOfDevOps/2026/day-06$ stat notes.txt 
  File: notes.txt
  Size: 0               Blocks: 0          IO Block: 4096   regular empty file
Device: 252,1   Inode: 37886218    Links: 1
Access: (0664/-rw-rw-r--)  Uid: ( 1000/    user)   Gid: ( 1000/    user)
Access: 2026-09-05 20:28:00.745381679 +0530
Modify: 2026-09-05 20:28:39.713119061 +0530
Change: 2026-09-05 20:28:39.713119061 +0530
 Birth: 2026-09-05 20:28:00.745381679 +0530
```

---

- Writing lines into the file notes.txt
```
guy@localhost:~/90DaysOfDevOps/2026/day-06$ echo "line 1" > notes.txt 
guy@localhost:~/90DaysOfDevOps/2026/day-06$ echo "line 2" >> notes.txt 
guy@localhost:~/90DaysOfDevOps/2026/day-06$ echo "line 3" | tee -a notes.txt 
line 3
```
Added 3 lines into the file using `>` (to write), `>>` (to append), and `tee` (to write using tee command that also prints the output to terminal -a appends).

---

- Read full file notes.txt
```
guy@localhost:~/90DaysOfDevOps/2026/day-06$ cat notes.txt 
line 1
line 2
line 3
```

---

- Read first 2 Lines of file notes.txt
```
guy@localhost:~/90DaysOfDevOps/2026/day-06$ head -n 2 notes.txt
line 1
line 2
```

---

- Read last 2 Lines of file notes.txt
```
guy@localhost:~/90DaysOfDevOps/2026/day-06$ tail -n 2 notes.txt
line 2
line 3
```
