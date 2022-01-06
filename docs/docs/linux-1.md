# Linux

### Linux Commands List <a href="#ftoc-heading-2" id="ftoc-heading-2"></a>

The commands found in the downloadable cheat sheet are listed below.

#### Hardware Information <a href="#ftoc-heading-3" id="ftoc-heading-3"></a>

Show **bootup messages**:

```
dmesg
```

See **CPU information**:

```
cat /proc/cpuinfo
```

Display **free and used memory** with:

```
free -h
```

List **hardware configuration** information:

```
lshw
```

See information about **block devices**:

```
lsblk
```

Show **PCI devices** in a tree-like diagram:

```
lspci -tv
```

Display **USB devices** in a tree-like diagram:

```
lsusb -tv
```

Show **hardware information** from the BIOS:

```
dmidecode
```

Display **disk data** information:

```
hdparm -i /dev/disk
```

Conduct a **read-speed test** on device/disk:

```
hdparm -tT /dev/[device]
```

Test for **unreadable blocks** on device/disk:

```
badblocks -s /dev/[device]
```

#### Searching <a href="#ftoc-heading-4" id="ftoc-heading-4"></a>

[Search for a specific pattern](https://phoenixnap.com/kb/grep-multiple-strings) in a file with [grep](https://phoenixnap.com/kb/grep-command-linux-unix-examples):

```
grep [pattern] [file_name]
```

**Recursively search for a pattern** in a directory:

```
grep -r [pattern] [directory_name]
```

Find all **files and directories related to a particular name**:

```
locate [name]
```

List names that **begin with a specified character** **`[a]`** in a specified location **`[/folder/location]`** by using the [**`find`** command](https://phoenixnap.com/kb/guide-linux-find-command):

```
find [/folder/location] -name [a]
```

See **files larger than a specified size** **`[+100M]`** in a folder:

```
find [/folder/location] -size [+100M]
```

**Note:** Some commands are not recommended to use. Learn about them in our list of [dangerous Linux commands](https://phoenixnap.com/kb/dangerous-linux-terminal-commands).

#### File Commands <a href="#ftoc-heading-5" id="ftoc-heading-5"></a>

**List files** in the directory:

```
ls
```

**List all files** ([shows hidden files](https://phoenixnap.com/kb/show-hidden-files-linux)):

```
ls -a
```

**Show directory** you are currently working in:

```
pwd
```

[Create a new directory](https://phoenixnap.com/kb/create-directory-linux-mkdir-command):

```
mkdir [directory]
```

[Remove a file](https://phoenixnap.com/kb/how-to-remove-files-directories-linux-command-line):

```
rm [file_name] 
```

**Remove a directory** recursively:

```
rm -r [directory_name]
```

**Recursively remove a directory** without requiring confirmation:

```
rm -rf [directory_name]
```

[Copy the contents of one file](https://phoenixnap.com/kb/how-to-copy-files-directories-linux) to another file:

```
cp [file_name1] [file_name2]
```

**Recursively copy the contents of one file** to a second file:

```
cp -r [directory_name1] [directory_name2]
```

**Rename** **`[file_name1]`** to **`[file_name2]`** with the command:

```
mv [file_name1] [file_name2]
```

[Create a symbolic link](https://phoenixnap.com/kb/symbolic-link-linux) to a file:

```
ln -s /path/to/[file_name] [link_name]
```

Create a **new file** using [touch](https://phoenixnap.com/kb/touch-command-in-linux):

```
touch [file_name]
```

**Show the contents** of a file:

```
more [file_name]
```

or use the [**`cat`** command](https://phoenixnap.com/kb/linux-cat-command):

```
cat [file_name]
```

Append file contents to another file:

```
cat [file_name1] >> [file_name2]
```

Display the **first 10 lines** of a file with:

```
head [file_name]
```

Show the **last 10 lines** of a file:

```
tail [file_name]
```

**Encrypt** a file:

```
gpg -c [file_name]
```

**Decrypt** a file:

```
gpg [file_name.gpg]
```

Show the **number of words, lines, and bytes** in a file:

```
wc
```

**Note:** Want to read more about file creation? Check out an article about [how to create a file in Linux using the command line](https://phoenixnap.com/kb/how-to-create-a-file-in-linux).

#### Directory Navigation <a href="#ftoc-heading-6" id="ftoc-heading-6"></a>

Move **up one level** in the directory tree structure:

```
cd ..
```

Change **directory to** **`$HOME`**:

```
cd
```

**Change location** to a specified directory:

```
cd /chosen/directory
```

#### File Compression <a href="#ftoc-heading-7" id="ftoc-heading-7"></a>

**Archive an existing file**:

```
tar cf [compressed_file.tar] [file_name]
```

[Extract an archived file](https://phoenixnap.com/kb/extract-tar-gz-files-linux-command-line#htoc-using-tar-utility):

```
tar xf [compressed_file.tar]
```

Create a **gzip compressed tar file** by running:

```
tar czf [compressed_file.tar.gz]
```

**Compress** a file with the **`.gz`** extension:

```
gzip [file_name]
```

**Note:** For a more comprehensive overview of how to use **`tar`** refer to our guide [tar Command in Linux With Examples](https://phoenixnap.com/kb/tar-command-in-linux).

#### File Transfer <a href="#ftoc-heading-8" id="ftoc-heading-8"></a>

[Copy a file to a server](https://phoenixnap.com/kb/how-to-use-linux-scp-command-examples) directory securely:

```
scp [file_name.txt] [server/tmp]
```

**Synchronize** the contents of a directory **with a backup directory** using the [rsync command](https://phoenixnap.com/kb/rsync-command-linux-examples):

```
rsync -a [/your/directory] [/backup/] 
```

#### Users <a href="#ftoc-heading-9" id="ftoc-heading-9"></a>

See details about the **active users**:

```
id
```

Show **last system logins**:

```
last
```

Display who is **currently logged into the system** with the [who command](https://phoenixnap.com/kb/linux-who-command):

```
who
```

Show which users are **logged in** and **their activity**:

```
w
```

**Add a new group** by typing:

```
groupadd [group_name]
```

Add a **new user**:

```
adduser [user_name]
```

Add a **user to a group**:

```
usermod -aG [group_name] [user_name]
```

Temporarily **elevate user privileges** to superuser or root using the [sudo command](https://phoenixnap.com/kb/linux-sudo-command):

```
sudo [command_to_be_executed_as_superuser]
```

**Delete** a user:

```
userdel [user_name] 
```

**Modify** user information with:

```
usermod
```

**Note:** If you want to learn more about users and groups, take a look at our article on [how to add a user to a group in Linux](https://phoenixnap.com/kb/how-to-add-user-to-group-linux).

#### Package Installation <a href="#ftoc-heading-10" id="ftoc-heading-10"></a>

[List all installed package](https://phoenixnap.com/kb/how-to-list-installed-packages-on-centos)s with **`yum`**:

```
yum list installed
```

Find a package by a **related keyword**:

```
yum search [keyword]
```

Show **package information and summary**:

```
yum info [package_name]
```

Install a package using the **YUM package manager**:

```
yum install [package_name.rpm]
```

Install a package using the **DNF package manager**:

```
dnf install [package_name.rpm]
```

Install a package[ using the **APT package manager**](https://phoenixnap.com/kb/how-to-use-apt-get-commands):

```
apt-get install [package_name]
```

**Install** an **`.rpm`** package from a local file:

```
rpm -i  [package_name.rpm]
```

**Remove** an **`.rpm`** package:

```
rpm -e [package_name.rpm]
```

Install software from **source code**:

```
tar zxvf [source_code.tar.gz]
cd [source_code]
./configure
make
make install
```

#### Process Related <a href="#ftoc-heading-11" id="ftoc-heading-11"></a>

See a **snapshot of active processes**:

```
ps
```

Show **processes in a tree-like diagram**:

```
pstree
```

Display a **memory usage map** of processes:

```
pmap
```

See **all running processes**:

```
top
```

[Terminate a Linux process](https://phoenixnap.com/kb/how-to-kill-a-process-in-linux) under a **given ID**:

```
kill [process_id]
```

Terminate a process under a **specific name**:

```
pkill [proc_name]
```

Terminate all processes **labelled** **“proc”**:

```
killall [proc_name]
```

**List and resume stopped jobs** in the background:

```
bg
```

Bring the most **recently suspended job to the** **foreground**:

```
fg
```

Bring a **particular job to the** **foreground**:

```
fg [job]
```

List **files opened by running processes**:

```
lsof
```

**Note:** If you want to learn more about shell jobs, how to terminate jobs or keep them running after you log off, check out our article on [how to use disown command](https://phoenixnap.com/kb/disown-command-linux).

#### System Information <a href="#ftoc-heading-12" id="ftoc-heading-12"></a>

Show **system information**:

```
uname -r 
```

See [kernel release information](https://phoenixnap.com/kb/check-linux-kernel-version):

```
uname -a  
```

Display **how long the system has been running**, including load average:

```
uptime 
```

See system **hostname**:

```
hostname
```

Show the **IP address** of the system:

```
hostname -i 
```

List system **reboot history**:

```
last reboot 
```

See current **time and date**:

```
date
```

Query and **change the system clock** with:

```
timedatectl 
```

Show current **calendar** (month and day):

```
cal
```

List **logged in users**:

```
w
```

See which **user you are using**:

```
whoami
```

Show **information about a particular user**:

```
finger [username]
```

#### Disk Usage <a href="#ftoc-heading-13" id="ftoc-heading-13"></a>

You can use the df and du commands to [check disk space in Linux](https://phoenixnap.com/kb/linux-check-disk-space).

See **free and used space** on mounted systems:

```
df -h
```

Show **free inodes** on mounted filesystems:

```
df -i
```

Display **disk partitions, sizes, and types** with the command:

```
fdisk -l
```

See [**disk usage** for all files and directory](https://phoenixnap.com/kb/show-linux-directory-size):

```
du -ah
```

Show **disk usage of the directory** you are currently in:

```
du -sh
```

Display **target mount point** for all filesystem:

```
findmnt
```

**Mount a device**:

```
mount [device_path] [mount_point]
```

#### SSH Login <a href="#ftoc-heading-14" id="ftoc-heading-14"></a>

**Connect to host** as user:

```
ssh user@host
```

Securely **connect to host via SSH** default port 22:

```
ssh host
```

Connect to host **using a particular port**:

```
ssh -p [port] user@host
```

Connect to host **via telnet default port 23**:

```
telnet host
```

**Note**: For a detailed explanation of SSH Linux Commands, refer to our [19 Common SSH Commands in Linux](https://phoenixnap.com/kb/linux-ssh-commands) tutorial.

#### File Permission <a href="#ftoc-heading-15" id="ftoc-heading-15"></a>

[Chown command in Linux](https://phoenixnap.com/kb/linux-chown-command-with-examples) changes file and directory ownership.

Assign **read, write, and execute permission** to everyone:

```
chmod 777 [file_name]
```

Give **read, write, and execute permission to owner**, and r**ead and execute permission to group and others**:

```
chmod 755 [file_name]
```

Assign **full permission to owner**, and **read and write permission to group and others**:

```
chmod 766 [file_name]
```

Change the **ownership of a file**:

```
chown [user] [file_name]
```

Change the **owner and group ownership of a file**:

```
chown [user]:[group] [file_name]
```

**Note**: To learn more about how to check and change permissions, refer to our [Linux File Permission Tutorial](https://phoenixnap.com/kb/linux-file-permissions).

#### Network <a href="#ftoc-heading-16" id="ftoc-heading-16"></a>

[List IP addresses ](https://phoenixnap.com/kb/linux-ip-command-examples)and **network interfaces**:

```
ip addr show
```

Assign an **IP address to interface eth0**:

```
ip address add [IP_address]
```

Display **IP addresses of all network interfaces** with:

```
ifconfig
```

See **active (listening) ports** with the [netstat command](https://phoenixnap.com/kb/netstat-command):

```
netstat -pnltu
```

Show **tcp** and **udp** **ports** and their programs:

```
netstat -nutlp
```

Display more **information about a domain**:

```
whois [domain]
```

Show **DNS information** about a domain using the [dig command](https://phoenixnap.com/kb/linux-dig-command-examples):

```
dig [domain] 
```

Do a **reverse lookup** **on domain**:

```
dig -x host
```

Do **reverse lookup of an IP address**:

```
dig -x [ip_address]
```

Perform an **IP lookup for a domain**:

```
host [domain]
```

Show the **local IP address**:

```
hostname -I
```

**Download a file** from a domain using the [**`wget`** command](https://phoenixnap.com/kb/wget-command-with-examples):

```
wget [file_name]
```

#### Linux Keyboard Shortcuts <a href="#ftoc-heading-17" id="ftoc-heading-17"></a>

**Kill process** running in the terminal:

```
Ctrl + C
```

Stop **current process**:

```
Ctrl + Z
```

The process can be **resumed** in the **foreground** with **`fg`** or in the **background** with **`bg`**.

Cut **one word before the cursor** and add it to clipboard:

```
Ctrl + W
```

Cut **part of the line before the cursor** and add it to clipboard:

```
Ctrl + U
```

Cut **part of the line after the cursor** and add it to clipboard:

```
Ctrl + K
```

**Paste** from clipboard:

```
Ctrl + Y
```

**Recall last command** that matches the provided characters:

```
Ctrl + R
```

**Run** the previously recalled command:

```
Ctrl + O
```

**Exit command history** without running a command:

```
Ctrl + G
```

**Run the last command** again:

```
!!
```

**Log out** of current session:

```
exit
```
