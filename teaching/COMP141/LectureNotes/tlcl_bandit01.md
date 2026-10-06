---
layout: page
title: COMP141 - Vocab and Commands from TLCL Chapters 1-4
permalink: /teaching/COMP141/LectureNotes/tlcl_bandit01/
mathjax: true
---
# TLCL Chapters 1–4: Vocabulary and Commands Covered

## Chapter 1

### Vocabulary

| Term | Definition |
| :--- | :--- |
| **Shell** | A program that accepts keyboard input and passes commands to the operating system kernel to carry out. It is the text-based interface at the heart of the command line. |
| **Bash** | "Bourne Again SHell," an enhanced replacement for `sh` (the original Unix shell program written by Steve Bourne) developed by Brian Fox for the GNU Project; it is the default shell across most Linux distributions. |
| **Terminal Emulator** | A graphical user interface (GUI) application (such as `gnome-terminal` or `konsole`) that opens a window providing access to a shell session. |
| **Shell Prompt** | A character sequence printed by the shell signaling that it is ready to accept user input; typically formatted as `[username@hostname cwd]$` (ending in `$` for unprivileged users or `#` for superusers). |
| **Superuser** | The administrative user account (the `root` account) possessing unrestricted privileges to access and modify all files and system configurations; indicated by a `#` at the end of the shell prompt. |
| **Command History** | A shell feature that logs previously entered commands (defaulting to the last 1,000 commands), enabling rapid recall and navigation using the Up and Down arrow keys. |

### Commands Covered

| Command | Purpose |
| --- | --- |
| `date` | Displays the current date and time |
| `uptime` | Displays how long the system has been running |
| `df` | Displays the amount of free space on disk drives |
| `free` | Displays the amount of free memory |
| `exit` | Ends a terminal session |

---

## Chapter 2

### Vocabulary

| Term | Definition |
| :--- | :--- |
| **Hierarchical Directory Structure** | An organization of files and directories arranged in an inverted, tree-like pattern of parent-child relationships under a single unified filesystem hierarchy. |
| **Root Directory** | The first and topmost directory of the Linux filesystem tree, designated by a single forward slash (`/`), from which all other files, subdirectories, and mounted storage devices branch. |
| **System Administrator** | The person (or people) responsible for managing, configuring, and maintaining the operating system, including attaching (mounting) storage devices at points in the filesystem tree. |
| **Parent Directory** | The directory located immediately one level above the current directory in the filesystem tree hierarchy; referred to in relative paths using the special notation `..`. |
| **Subdirectory** | A directory located inside another directory lower down in the filesystem tree hierarchy. |
| **Current Working Directory** | The directory in the filesystem tree in which the user is currently located ("standing"), reported by the `pwd` command. |
| **Home Directory** | The dedicated personal directory assigned to a user account (typically `/home/username`), where regular users have write permissions to create and manage files. |
| **Absolute Pathname** | A complete file path that starts from the root directory (`/`) and follows the filesystem tree branch by branch to the target file or directory; always begins with a leading slash (`/`). |
| **Relative Pathname** | A file path that starts from the current working directory and navigates relative to where the user is currently located, utilizing notations such as `.` (current directory) and `..` (parent directory). |

### Commands Covered

| Command | Option | Purpose | Example Usage |
| :--- | :--- | :--- | :--- |
| `pwd` | | Print the name of the current working directory | `pwd` |
| `cd` | | Change the current working directory | `cd /usr/bin` |
| `ls` | | List directory contents | `ls` |
| | `-a` | List all files, including hidden files (names beginning with a period) | `ls -a` |

---

## Chapter 3

### Vocabulary

| Term | Definition |
| :--- | :--- |
| **Options** | Flags following a command name that modify its default behavior, written as single characters preceded by a single dash (e.g., `-l`) or word-based options preceded by two dashes (e.g., `--all`); options are case-sensitive and short options may be combined. |
| **Arguments** | The items (such as files, directories, or strings) passed into a command upon which the command performs its actions. |
| **Scripts** | Executable programs stored as plain ASCII text files containing sequences of shell commands interpreted by the system rather than compiled into binary form. |
| **Symbolic Link** | A special file type (also known as a soft link or symlink, indicated by `l` in `ls -l` and `->`) that contains a text pointer referencing another file or directory across the filesystem, allowing resources to have multiple names and simplifying version management. |

### Commands Covered

| Command | Option | Purpose | Example Usage |
| :--- | :--- | :--- | :--- |
| `ls` | | List directory contents | `ls` |
| | `-a`, `--all` | List all files, including hidden files (names beginning with a period) | `ls -a` |
| | `-A`, `--almost-all` | List all files including hidden files, but omit `.` and `..` | `ls -A` |
| | `-d`, `--directory` | List details about the directory itself rather than its contents | `ls -d` |
| | `-F`, `--classify` | Append an indicator character to the end of each name (e.g., `/` for directories) | `ls -F` |
| | `-h`, `--human-readable` | In long format, display file sizes in human-readable format rather than bytes | `ls -lh` |
| | `-l` | Display results in long format | `ls -l` |
| | `-r`, `--reverse` | Display results in reverse order | `ls -r` |
| | `-S` | Sort results by file size | `ls -S` |
| | `-t` | Sort results by modification time | `ls -t` |
| `file` | | Determine a file's type | `file picture.jpg` |
| `less` | | View text file contents interactively (pager) | `less /etc/passwd` |

---

## Chapter 4

### Vocabulary

| Term | Definition |
| :--- | :--- |
| **Wildcards** | Special characters (such as `*`, `?`, and bracket expressions `[...]`) supported by the shell to rapidly construct patterns for matching groups of filenames. |
| **Globbing** | The process performed by the shell when it expands wildcard patterns into matching lists of filenames before passing them to an executing command. |
| **Hard Link** | An additional directory entry (filename) that points directly to an existing file's underlying inode on the same filesystem; hard links share identical attributes and data blocks, and are indistinguishable from the original file. |
| **Inode** | A fundamental filesystem data structure that indexes and stores all metadata about a file (permissions, owner, size, timestamps, and disk block pointers) except its human-readable name. |

### Commands Covered

| Command | Option | Purpose | Example Usage |
| :--- | :--- | :--- | :--- |
| `cp` | | Copy files and directories | `cp file1 file2` |
| | `-a`, `--archive` | Copy files and directories and all attributes (permissions, timestamps, ownership) | `cp -a dir1 dir2` |
| | `-i`, `--interactive` | Prompt for confirmation before overwriting an existing file | `cp -i file1 file2` |
| | `-r`, `--recursive` | Recursively copy directories and their contents | `cp -r dir1 dir2` |
| | `-u`, `--update` | Only copy files that do not exist or are newer than existing destination files | `cp -u *.html destination` |
| | `-v`, `--verbose` | Display informative progress messages as copying is performed | `cp -v file1 file2` |
| `mv` | | Move or rename files and directories | `mv file1 file2` |
| | `-i`, `--interactive` | Prompt for confirmation before overwriting an existing file | `mv -i file1 file2` |
| | `-u`, `--update` | Only move files that do not exist or are newer than existing destination files | `mv -u file1 dir1` |
| | `-v`, `--verbose` | Display informative progress messages as moving is performed | `mv -v file1 file2` |
| `mkdir` | | Create one or more directories | `mkdir dir1 dir2` |
| `rm` | | Remove (delete) files and directories | `rm file1` |
| | `-i`, `--interactive` | Prompt for confirmation before deleting an existing file | `rm -i file1` |
| | `-r`, `--recursive` | Recursively delete directories and their contents | `rm -r playground` |
| | `-f`, `--force` | Force deletion by ignoring nonexistent files and suppressing prompts | `rm -f file1` |
| | `-v`, `--verbose` | Display informative progress messages as deletions are performed | `rm -v file1` |
| `ln` | | Create hard links to files | `ln fun fun-hard` |
| | `-s` | Create symbolic (soft) links instead of hard links | `ln -s fun fun-sym` |
| `ls` | | List directory contents | `ls` |
| | `-i` | Display inode numbers for listed files (used to identify hard links) | `ls -li` |
