---
layout: page
title: COMP141 - Core Data Filters Commands from CYOA
permalink: /teaching/COMP141/LectureNotes/cyoa_command_list/
mathjax: true
---


# Commands from CYOA Exercise

* Paths can be relative or absolute.
* This table only provides single commands with single options. You can, and must at times, combine options and combine commands via pipes.  Review the *Filters* section in chapter 6 if you need more details and examples.
* In the examples below, files can be actual files or are left out entirely when building filters using piping. When building filters, the "file input" proceeds the command, i.e. `CMD file` vs `OTHERCMD ... | CMD`.

|  Task | Command | Template |
| :-- | :-- | :--- |
| Change working directory using  | `cd` | `cd PATH/TO/DIR/` |
| View directory contents         | `ls` | `ls PATH/TO/DIR/` |
| View Details of Contents        |  `ls -l`  | `ls -l PATH/TO/DIR/` |
| View Contents and Hidden Contents | `ls -a` | `ls -a PATH/TO/DIR/` |
| Write/Concatenate File Contents to CLI | `cat` | `cat PATH/TO/file.txt` |
| View and Page File Contents | `less` | `less PATH/TO/file.txt` |
| Line wrap file contents to `n` lines | `fold -w n` | `fold -w n PATH/TO/file.txt` |
| Count lines of a file | `wc -l` | `wc -l PATH/TO/file.txt` |
| Count characters of a file | `wc -c` | `wc -c PATH/TO/file.txt` |
| Make a file group executable (user, others) | `chmod` | `chmod g+x PATH/TO/file.sh` (`u+x` or `o+x`) |
| Make a file group readable (users, others) | `chmod` | `chmod g+r PATH/TO/file.sh` (`u+r` or `o+r`)|
| Execute file `foo.sh` in working directory|  | `./foo.sh` |
| Execute file `foo.sh` in another directory|  | `./REL/PATH/foo.sh` or `/ABS/PATH/foo.sh` |
| Find regular files | `find -type f` | `find START/HERE -type f` |
| Find directories | `find -type d` | `find START/HERE -type d` |
| Find file by name | `find -name` | `find START/HERE -name NAMEPATTERN` |
| Find file by owner | `find -owner` | `find START/HERE -owner OWNERNAME` |
| Find file by group | `find -group` | `find START/HERE -group GROUPNAME` |
| Find file by exact match to regex | `find -regex` | `find START/HERE -regex "REGEX"` |
| Find file larger than size | `find -size +SIZE` | `find START/HERE -size +SIZE` |
| Find file smaller than size | `find -size -SIZE` | `find START/HERE -size -SIZE` |
| Find file with exact size | `find -size SIZE` | `find START/HERE -size SIZE` |
| Find file modified more than `n` hours ago | `find -ctime +n` | `find START/HERE -ctime +n` |
| Find file modified less than `n` hours ago | `find -ctime -n` | `find START/HERE -ctime -n` |
| Find file modified exactly `n` hours ago | `find -ctime n` | `find START/HERE -ctime n` |
| Find file with permissions UGO (in octal) | `find -perm UGO` | `find START/HERE -perm UGO` |
| Find lines that match REGEX | `grep` | `grep "REGEX" PATH/TO/file.txt` |
| Find lines that DO NOT match REGEX | `grep -v | `grep -v "REGEX" PATH/TO/file.txt` |
| Sort lines | `sort` | `sort PATH/TO/file.txt` |
| Remove adjacent duplicates | `uniq` | `uniq PATH/TO/file.txt` |

# Regular Expressions (regexs)

* This just barely scratches the surface. I recommend you build a regex *cookbook* from chapter 19 or build it as you find the need for a regex. These patterns can get your cookbook started.
* Surround your regex patterns with double quotes `"`. The double quotes are *not* part of the pattern.


| Pattern | Regex Template |
| :---  |  :---- |
| Has One of anything | `"."` |
| Has zero or more of anything `".*"` |
| Contains PATTERN | `"PATTERN"` |
| Starts with PATTERN | `"^PATTERN"` |
| Ends with PATTERN | `"PATTERN$` |

