---
layout: page
title: COMP141 - Vocab and Commands from TLCL Chapters 5,9, & 17
permalink: /teaching/COMP141/LectureNotes/tlcl_bandit02/
mathjax: true
---
# TLCL Chapters 5, 9, and 17: Vocabulary and Commands Covered

## Chapter 5

### Vocabulary

| Term | Definition |
| :--- | :--- |
| **Executable Program** | A program stored as an executable file on the filesystem (such as binaries or scripts located in `/usr/bin`), which can be executed directly by the operating system. |
| **Compiled Binary** | An executable program compiled from source code written in a programming language (such as C or C++) into native machine code instructions that the processor executes directly. |
| **Scripting Language** | A high-level programming language (such as Bash shell script, Python, Perl, or Ruby) where instructions are interpreted line-by-line at runtime by an interpreter program rather than compiled beforehand into binary machine code. |
| **Shell Builtins** | Commands implemented and executed directly inside the shell program itself (e.g., `cd`, `type`, `help`), rather than executed as external program files stored on the filesystem. |
| **Environment** | The configuration context and state maintained by the shell session, consisting of shell variables, environment variables (e.g., `PATH`, `HOME`, `USER`), and functions available to the shell and processes spawned from it. |
| **Shell Functions** | Modular miniature shell scripts or procedures incorporated directly into the shell environment that behave like built-in commands when called. |
| **Alias** | A custom command name defined by the user (using the `alias` command) that represents a string containing one or more commands and options, allowing convenient shortcuts or modified default command behaviors. |
| **Man Page** | The standard, formal reference manual page provided for command-line programs, utilities, system calls, and configuration file formats, viewed using the `man` paging program. |

### Commands Covered

| Command | Option | Purpose | Example Usage |
| :--- | :--- | :--- | :--- |
| `type` | | Indicate how a command name is interpreted | `type ls` |
| `which` | | Display which executable program will be executed | `which ls` |
| `help` | | Get help for shell builtins | `help cd` |
| | `-m` | Display help output in a format resembling a man page | `help -m cd` |
| `man` | | Display a command's manual page | `man ls` |
| | `-k` | Search manual page descriptions for keywords (same as apropos) | `man -k partition` |
| `apropos` | | Display a list of appropriate commands matching a keyword | `apropos partition` |
| `whatis` | | Display one-line manual page descriptions | `whatis ls` |
| `info` | | Display a command's info entry | `info coreutils` |
| `alias` | | Create an alias for a command, or display defined aliases | `alias foo='cd /usr; ls; cd -'` |
| `unalias` | | Remove a previously defined alias | `unalias foo` |

---

## Chapter 9

### Vocabulary

| Term | Definition |
| :--- | :--- |
| **Multi-tasking System** | An operating system capable of executing multiple programs or processes concurrently by sharing and scheduling system resources like CPU and memory. |
| **Multi-user System** | An operating system designed to allow multiple users to log in and interact with the system simultaneously (locally or over a network), while isolating user sessions and preventing users from interfering with one another's files or system operations. |
| **User** | An individual account configured on a Linux system that owns files, runs programs, and possesses specific permissions; identified numerically by a User ID (UID). |
| **Group** | A defined collection of user accounts in Linux that share access permissions to specific files and directories; identified numerically by a Group ID (GID). On modern Linux systems, each user typically has a user private group sharing their username. |
| **Others** | The permission category (also referred to as the "world") that applies to all system users who are neither the owner of the file nor members of the file's assigned group. |
| **User ID (UID)** | A unique numeric identifier assigned by the operating system to each user account, mapped to a username in the `/etc/passwd` file (e.g., UID 0 is root). |
| **Primary Group ID (GID)** | A numeric identifier representing the primary group assigned to a user account, mapped to a group name in `/etc/group` and listed in `/etc/passwd`. |
| **File Attributes** | The metadata properties associated with a file, including file type, permission modes, hard link count, owner, group ownership, file size, and timestamp data. |
| **File Mode** | The nine permission bits of a file's attributes (often represented as a 9-character string in `ls -l` or a 3-digit octal number) specifying read (`r`), write (`w`), and execute (`x`) permissions for the user (owner), group, and others. |
| **Mask** | A bitwise value (represented in octal and managed via the `umask` command) that specifies which permission bits are automatically stripped (unset) when creating new files or directories. |
| **Superuser** | The root administrative account (UID 0) that possesses unrestricted privileges to read, write, and execute any file, run any command, and perform administrative configuration changes across the system. |

### Commands Covered

| Command | Option | Purpose | Example Usage |
| :--- | :--- | :--- | :--- |
| `id` | | Display user and group identity information | `id` |
| `chmod` | | Change file access permissions (mode) | `chmod 600 foo.txt` |
| `umask` | | Display or set the default file mode creation mask | `umask 0002` |
| `su` | | Run a shell with substitute user and group IDs | `su -` |
| | `-l`, `-` | Start a login shell loading the target user's environment | `su -` |
| | `-c` | Pass a single command string to execute as the substitute user | `su -c 'ls -l /root/*'` |
| `sudo` | | Execute a command as another user (typically superuser) | `sudo backup_script` |
| | `-l` | List allowed and forbidden commands for the current user | `sudo -l` |
| | `-i` | Start an interactive login shell as superuser | `sudo -i` |
| `chown` | | Change file owner and/or group ownership | `chown tony:users myfile.txt` |
| `chgrp` | | Change file group ownership | `chgrp music myfile.txt` |
| `groupadd` | | Create a new group account | `sudo groupadd music` |
| `usermod` | | Modify a user account | `sudo usermod -a -G music tony` |
| | `-a -G`, `--append --groups` | Append user to supplementary group(s) | `sudo usermod -a -G music tony` |
| `passwd` | | Change a user's password | `passwd` |
| `useradd` | | Create a new user account | `sudo useradd newuser` |
| `userdel` | | Delete a user account and related files | `sudo userdel newuser` |
| `lastlog` | | Report the most recent login of all users or a given user | `lastlog` |

---

## Chapter 17

### Vocabulary

| Term | Definition |
| :--- | :--- |
| **Find Options** | Arguments passed to `find` (such as `-maxdepth`, `-mindepth`, or `-mount`) that control the overall scope and traversal behavior of the directory search rather than filtering files based on attributes. |
| **Find Actions** | Operations performed by `find` on files matching the search criteria, including predefined actions (such as `-print`, `-ls`, or `-delete`) and user-defined commands executed via `-exec` or `-ok`. |
| **Find Tests** | Evaluation criteria applied by `find` to examine a file's attributes and metadata (such as `-type`, `-name`, `-size`, `-perm`, or `-user`), evaluating to true or false for each visited file. |
| **Logical Relationships** | The boolean evaluation rules connecting multiple tests and actions in a `find` command, defaulting to an implicit AND relationship where subsequent tests and actions are only executed if preceding tests evaluate to true. |
| **Logical Operators** | Operators provided by `find` (`-and` / `-a`, `-or` / `-o`, `-not` / `!`, and escaped grouping parentheses `\(` `\)`) that combine and alter the evaluation order of tests and actions to construct complex search logic. |

### Commands Covered

| Command | Option | Purpose | Example Usage |
| :--- | :--- | :--- | :--- |
| `locate` | | Rapidly search for files by name using a prebuilt database | `locate bin/zip` |
| `updatedb` | | Update or create the database used by locate | `sudo updatedb` |
| `find` | | Search for files in a directory hierarchy | `find ~` |
| | `-type` | Match files of specified type (e.g., `f` for regular file, `d` for directory) | `find ~ -type f` |
| | `-name` | Match files with specified wildcard pattern | `find ~ -name "*.JPG"` |
| | `-iname` | Case-insensitive match with specified wildcard pattern | `find ~ -iname "*.jpg"` |
| | `-size` | Match files of specified size (+ for greater than, - for less than) | `find ~ -size +1M` |
| | `-perm` | Match files with permissions set to specified octal or symbolic mode | `find ~ -perm 0600` |
| | `-newer` | Match files modified more recently than specified reference file | `find ~ -newer timestamp` |
| | `-empty` | Match empty regular files and directories | `find ~ -empty` |
| | `-user` | Match files belonging to specified user name or UID | `find ~ -user me` |
| | `-group` | Match files belonging to specified group name or GID | `find ~ -group music` |
| | `-nouser` | Match files that do not belong to a valid user | `find / -nouser` |
| | `-nogroup` | Match files that do not belong to a valid group | `find / -nogroup` |
| | `-inum` | Match files with specified inode number | `find ~ -inum 14265061` |
| | `-samefile` | Match files sharing the same inode number as specified file | `find ~ -samefile file1` |
| | `-mtime` | Match files whose contents were last modified n*24 hours ago | `find ~ -mtime -1` |
| | `-mmin` | Match files whose contents were last modified n minutes ago | `find ~ -mmin -60` |
| | `-print` | Output full pathname of matching files (default action) | `find ~ -type f -print` |
| | `-print0` | Output full pathname followed by a null character (for xargs -0) | `find ~ -print0` |
| | `-delete` | Delete currently matching files | `find ~ -name '*.bak' -delete` |
| | `-ls` | Perform equivalent of `ls -dils` on matching files | `find ~ -name '*.txt' -ls` |
| | `-exec` | Execute arbitrary command on matching files (terminate with `';'` or `'+'`) | `find ~ -name '*.bak' -exec rm '{}' ';'` |
| | `-ok` | Prompt user before executing command on matching files | `find ~ -name 'foo*' -ok ls -l '{}' ';'` |
| | `-maxdepth` | Set maximum depth level to descend into directory tree | `find ~ -maxdepth 2` |
| | `-mindepth` | Set minimum depth level before applying tests and actions | `find ~ -mindepth 1` |
| | `-mount` | Do not traverse directories mounted on other filesystems | `find / -mount` |
| `xargs` | | Build and execute command lines from standard input | `find ~ -print \| xargs ls -l` |
| | `-0`, `--null` | Accept null-delimited input instead of whitespace-delimited | `find ~ -print0 \| xargs --null ls -l` |
| `touch` | | Change file access and modification times, or create empty file if nonexistent | `touch timestamp` |
| `stat` | | Display detailed file or filesystem status and metadata | `stat playground/timestamp` |
