# Day 13 – Linux Volume Management (LVM)

# Commands Used

## Switch to Root User

```bash
ubuntu@ip:~$ sudo -i
```

---

# Task 1: Check Current Storage

```bash
root@ip:~# lsblk
NAME         MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
loop0          7:0    0 28.2M  1 loop /snap/amazon-ssm-agent/13009
loop1          7:1    0   74M  1 loop /snap/core22/2411
loop2          7:2    0 49.3M  1 loop /snap/snapd/26865
nvme0n1      259:0    0    8G  0 disk
├─nvme0n1p1  259:1    0  6.9G  0 part /
├─nvme0n1p13 259:2    0 1023M  0 part /boot
├─nvme0n1p14 259:3    0    4M  0 part
└─nvme0n1p15 259:4    0  106M  0 part /boot/efi
```

```bash
root@ip:~# pvs

root@ip:~# vgs

root@ip:~# lvs
```
```bash
root@ip:~# df -h
Filesystem       Size  Used Avail Use% Mounted on
/dev/root        6.7G  2.1G  4.6G  31% /
tmpfs            455M     0  455M   0% /dev/shm
tmpfs            182M  888K  181M   1% /run
efivarfs         128K  3.3K  120K   3% /sys/firmware/efi/efivars
tmpfs            455M     0  455M   0% /tmp
none             1.0M     0  1.0M   0% /run/credentials/systemd-journald.service
none             1.0M     0  1.0M   0% /run/credentials/systemd-resolved.service
/dev/nvme0n1p13  989M   96M  827M  11% /boot
/dev/nvme0n1p15  105M  6.3M   99M   7% /boot/efi
none             1.0M     0  1.0M   0% /run/credentials/systemd-networkd.service
none             1.0M     0  1.0M   0% /run/credentials/getty@tty1.service
none             1.0M     0  1.0M   0% /run/credentials/serial-getty@ttyS0.service
tmpfs             91M  8.0K   91M   1% /run/user/1000
```

Observed:
- Checked available disks and mounted file systems
- No existing physical volumes or logical volumes found initially

---

# Create Virtual Disk

```bash
ubuntu@ip:~$ dd if=/dev/zero of=/tmp/disk1.img bs=1M count=1024
dd: IO error: Disk quota exceeded
```
Observed:
- The /tmp directory is mounted as a limited tmpfs RAM-backed space that only has about 455MB available (and 80% is already used), so trying to create a 1GB file there triggered a disk quota error.

- Instead, creating the virtual disk file in your main root home directory (/home/ubuntu/ or /root/), which has the full 4.6GB of free space.
```bash
ubuntu@ip:~$ sudo dd if=/dev/zero of=/home/ubuntu/disk1.img bs=1M count=1024
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 6.82603 s, 157 MB/s
```
Command Breakdown
- `dd`: The core program name, historically standing for `Dataset Definition` (often humorously referred to as `Disk Destroyer` because a typo can overwrite real data). It copies data bit-by-bit from an input to an output.
- `if=/dev/zero`: The `Input File`. /dev/zero is a special system file (a pseudo-device) that provides an endless stream of null bytes (binary zeros, or 0x00).
- `of=/home/ubuntu/disk1.img`: The `Output File`. This specifies where the copied data goes—creating a new file named disk1.img inside the /tmp/ directory.
- `bs=1M`: The `Block Size`. This tells dd to read and write data in chunks of 1 Megabyte at a time, making the operation much faster than moving single bytes.
- `count=1024`: The `Multiplier`. This tells the program to repeat the block size operation 1,024 times (1MB X 1024 = 1024MB, or exactly 1 Gigabyte).

```bash
ubuntu@ip:~$ lsblk
NAME         MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
loop0          7:0    0 28.2M  1 loop /snap/amazon-ssm-agent/13009
loop1          7:1    0   74M  1 loop /snap/core22/2411
loop2          7:2    0 49.3M  1 loop /snap/snapd/26865
loop3          7:3    0 28.4M  1 loop /snap/amazon-ssm-agent/13349
nvme0n1      259:0    0    8G  0 disk
├─nvme0n1p1  259:1    0  6.9G  0 part /
├─nvme0n1p13 259:2    0 1023M  0 part /boot
├─nvme0n1p14 259:3    0    4M  0 part
└─nvme0n1p15 259:4    0  106M  0 part /boot/efi

ubuntu@ip:~$ df -h
Filesystem       Size  Used Avail Use% Mounted on
/dev/root        6.7G  3.1G  3.6G  47% /
tmpfs            455M     0  455M   0% /dev/shm
tmpfs            182M  892K  181M   1% /run
efivarfs         128K  3.3K  120K   3% /sys/firmware/efi/efivars
tmpfs            455M  364M   91M  80% /tmp
none             1.0M     0  1.0M   0% /run/credentials/systemd-journald.service
none             1.0M     0  1.0M   0% /run/credentials/systemd-resolved.service
/dev/nvme0n1p13  989M   96M  827M  11% /boot
/dev/nvme0n1p15  105M  6.3M   99M   7% /boot/efi
none             1.0M     0  1.0M   0% /run/credentials/systemd-networkd.service
none             1.0M     0  1.0M   0% /run/credentials/getty@tty1.service
none             1.0M     0  1.0M   0% /run/credentials/serial-getty@ttyS0.service
tmpfs             91M  8.0K   91M   1% /run/user/1000
```
Observed:
- The 1GB file was successfully created in your home directory (/home/ubuntu/disk1.img), and your available space dropped from 4.6G to 3.6G as expected.
- The next step is to attach this file to a loop device so the kernel treats it like a real block storage drive, allowing LVM to recognize it.

```bash
ubuntu@ip:~$ losetup -fP /home/ubuntu/disk1.img
losetup: /home/ubuntu/disk1.img: failed to set up loop device: Permission denied

ubuntu@ip:~$ sudo losetup -fP /home/ubuntu/disk1.img
```
Command Breakdown
* losetup: The core management utility used to set up, modify, and query loop devices in Linux.
* -f (or --find): Automatically searches for the first available, unused loop device on your system (e.g., /dev/loop4) so you don't have to look it up manually.
* -P (or --partscan): Forces the Linux kernel to scan the loop device for any internal partition tables right after attaching it. (This is especially useful if your image file contains multiple partitions, allowing the system to automatically generate sub-nodes like /dev/loop4p1).
* /home/ubuntu/disk1.img: The target image file you want to mount as a block device.

```bash
ubuntu@ip:~$ lsblk
NAME         MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
loop0          7:0    0 28.2M  1 loop /snap/amazon-ssm-agent/13009
loop1          7:1    0   74M  1 loop /snap/core22/2411
loop2          7:2    0 49.3M  1 loop /snap/snapd/26865
loop3          7:3    0 28.4M  1 loop /snap/amazon-ssm-agent/13349
loop4          7:4    0    1G  0 loop
nvme0n1      259:0    0    8G  0 disk
├─nvme0n1p1  259:1    0  6.9G  0 part /
├─nvme0n1p13 259:2    0 1023M  0 part /boot
├─nvme0n1p14 259:3    0    4M  0 part
└─nvme0n1p15 259:4    0  106M  0 part /boot/efi
```
Observation:
- The loop device /dev/loop4 with a size of 1G has been successfully created and attached.

```bash
ubuntu@ip:~$ losetup -a
...
/dev/loop4: []: (/home/ubuntu/disk1.img)
...
```
Command Breakdown
* losetup: The core management command for loop devices.
* -a (or --all): Tells the utility to query the system and list all currently active loop devices and show which files they are mapped to.

Observed:
- Created a 1GB virtual disk image
- Attached loop device successfully
- Running sudo losetup -a will display a clean summary showing that /dev/loop4 is actively bound to your /home/ubuntu/disk1.img file, allowing you to double-check your mappings before creating your LVM Physical Volume.

---

# Task 2: Create Physical Volume

```bash
root@ip:~# pvcreate /dev/loop4
  Physical volume "/dev/loop4" successfully created.

root@ip:~# pvs
  PV         VG Fmt  Attr PSize PFree
  /dev/loop4    lvm2 ---  1.00g 1.00g
```

Observed:
- Physical volume created successfully

---

# Task 3: Create Volume Group

```bash
root@ip:~# vgcreate devops-vg /dev/loop4
  Volume group "devops-vg" successfully created

root@ip:~# vgs
  VG        #PV #LV #SN Attr   VSize    VFree
  devops-vg   1   0   0 wz--n- 1020.00m 1020.00m
```

Observed:
- Volume group `devops-vg` created successfully

---

# Task 4: Create Logical Volume

```bash
root@ip:~# lvcreate -L 500M -n app-data devops-vg
  Logical volume "app-data" created.

root@ip:~# lvs
  LV       VG        Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  app-data devops-vg -wi-a----- 500.00m
```

Observed:
- Logical volume `app-data` created successfully

---

# Task 5: Format and Mount

```bash
root@ip:~# mkfs.ext4 /dev/devops-vg/app-data
mke2fs 1.47.2 (1-Jan-2025)
Discarding device blocks: done
Creating filesystem with 128000 4k blocks and 128000 inodes
Filesystem UUID: da59f9d6-553d-401e-b0a6-0748884ace92
Superblock backups stored on blocks:
	32768, 98304
Allocating group tables: done
Writing inode tables: done
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information: done
```
Observed:
- Applied an ext4 filesystem to new logical volume, with successful formatting message confirming block groups and inode tables were written.

```bash
root@ip:~# mkdir -p /mnt/app-data
```
- Created a directory as mount point.
```bash
root@ip:~# mount /dev/devops-vg/app-data /mnt/app-data/
```

```bash
root@ip:~# df -h /mnt/app-data/
Filesystem                        Size  Used Avail Use% Mounted on
/dev/mapper/devops--vg-app--data  452M  152K  417M   1% /mnt/app-data
```
Observed:
- Logical volume formatted with ext4
- Mounted successfully on `/mnt/app-data`
```bash
root@ip:~# lsblk
NAME                   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
...
loop4                    7:4    0    1G  0 loop
└─devops--vg-app--data 252:0    0  500M  0 lvm  /mnt/app-data
...
```

---

# Task 6: Extend the Volume

```bash
root@ip:~# lvextend -L +200M /dev/devops-vg/app-data
  Size of logical volume devops-vg/app-data changed from 500.00 MiB (125 extents) to 700.00 MiB (175 extents).
  Logical volume devops-vg/app-data successfully resized.
```
* Because you extended the LVM container without the automatic -r flag, the filesystem inside still thinks it is 500MB. Expand the ext4 filesystem to fill the new 700MB space:
```bash
root@ip:~# resize2fs /dev/devops-vg/app-data
resize2fs 1.47.2 (1-Jan-2025)
Filesystem at /dev/devops-vg/app-data is mounted on /mnt/app-data; on-line resizing required
old_desc_blocks = 1, new_desc_blocks = 1
The filesystem on /dev/devops-vg/app-data is now 179200 (4k) blocks long.
```
Command Breakdown
* resize2fs: The standard utility used to resize ext2, ext3, or ext4 file systems on Linux. It safely expands or shrinks the filesystem boundaries to match its underlying block device.
* /dev/devops-vg/app-data: The target logical volume path containing the ext4 filesystem you want to expand.

```bash
root@ip:~# lsblk
NAME                   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
...
loop4                    7:4    0    1G  0 loop
└─devops--vg-app--data 252:0    0  700M  0 lvm  /mnt/app-data
...

root@ip:~# df -h /mnt/app-data/
Filesystem                        Size  Used Avail Use% Mounted on
/dev/mapper/devops--vg-app--data  637M  152K  594M   1% /mnt/app-data
```

Observed:
- Extended logical volume size successfully
- Filesystem resized correctly

**Pro Tip Note for expanding volumes**:
- Adding the -r (or --resizefs) flag to lvextend automatically resizes the underlying filesystem, making a separate resize2fs command completely unnecessary.
- When you execute:
```Bash
sudo lvextend -L +200M -r /dev/devops-vg/app-data
```
- LVM performs two actions sequentially in a single step:
    * It expands the logical volume container to the new size.
    * It automatically detects the filesystem type (like ext4) and invokes the proper resizing tool (like resize2fs) to expand the filesystem into the newly added space.

---

# What I Learned

- Storage hierarchy in LVM: Physical Volumes (PV) → Volume Groups (VG) → Logical Volumes (LV).

- Flexibility of LVM: Unlike traditional partitions, LVM allows resizing volumes dynamically without downtime.

- Creating and managing PVs: Learned how to initialize raw disks/loop partitions into physical volumes using pvcreate.

- Grouping storage with VGs: Multiple PVs can be combined into a single Volume Group, making storage management easier.

- Filesystem resizing: After extending an LV, the filesystem (resize2fs) must also be resized to use the new space.
    * The order of operations is completely reversed when shrinking, and getting it wrong will destroy your data.
    * When **Expanding** (Safe to do live): You grow the container first (lvextend), then expand the filesystem to fill the new space (resize2fs).
    * When **Shrinking** (High risk): You must shrink the filesystem first (resize2fs), and then shrink the LVM container (lvreduce).

- Mounting volumes: Learned how to format (mkfs.ext4) and mount LVs to directories for actual usage.

- Direct PV mounting: Although possible to mount a PV directly, it’s not recommended — LVM provides abstraction and flexibility.
