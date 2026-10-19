---
layout: page
title: COMP141 - Vocab and Commands from TLCL Chapters 6,19, & 20
permalink: /teaching/COMP141/LectureNotes/tlcl_bandit03/
mathjax: true
---
# TLCL Chapters 6, 19, and 20: Vocabulary and Commands Covered

## Chapter 6

### Vocabulary

| Term | Definition |
| :--- | :--- |
| **I/O** | Input/Output; the mechanism by which data enters a program (input) and is emitted from a program (output). In Unix-like systems, command-line programs commonly read input from the keyboard or data streams and print output to the terminal display or files. |
| **I/O Redirection** | A powerful shell feature enabling users to redirect standard input, standard output, and standard error streams to and from files or devices using redirection operators such as `<`, `>`, `>>`, and `<&` instead of relying on default terminal keyboard and screen endpoints. |
| **Pipelines** | The mechanism of connecting the standard output of one command directly to the standard input of another using the pipe operator (`\|`), allowing multiple smaller, specialized commands to be chained together into complex processing pipelines. |
| **Standard Output (stdout)** | The default stream (file descriptor 1) used by programs to send their normal output data. By default, it is sent to the terminal display, but it can be redirected to a file or piped into another program. |
| **Standard Error (stderr)** | The default stream (file descriptor 2) reserved for error and diagnostic messages. By default, it is sent to the terminal display so that errors remain visible even when standard output has been redirected elsewhere. |
| **Group Command (;)** | The use of a semicolon (`;`) as a command separator to execute multiple commands sequentially on a single command line from left to right, regardless of whether preceding commands succeed or fail. |
| **File Descriptors** | Non-negative integer values used by the operating system kernel to reference open files and data streams within a process. The primary standard streams are 0 (`stdin`), 1 (`stdout`), and 2 (`stderr`). |
| **Bit Bucket (/dev/null)** | A special Unix pseudo-device file (often called the bit bucket) that accepts and discards any input written to it, producing an immediate end-of-file (EOF) when read. Frequently used to suppress unwanted output or errors (e.g., `2> /dev/null`). |
| **EOF (End-Of-File)** | A condition or control signal (typically entered interactively in a terminal session via `Ctrl-d`) indicating that an input stream has reached its end and no further data is available to read. |
| **Filters** | Command-line programs that read a stream of text from standard input, perform transformations or selections on that data, and send the results to standard output, making them ideal components within pipelines (e.g., `sort`, `uniq`, `grep`, `wc`, `head`, `tail`). |
| **Regular Expressions** | Symbolic notation and pattern syntax used to define complex text search patterns across files and streams, allowing programs like `grep` to locate lines matching specific structures. |

### Commands Covered

| Command | Option | Purpose | Example Usage |
| :--- | :--- | :--- | :--- |
| `cat` | | Concatenate files and print to standard output | `cat ls-output.txt` |
| `sort` | | Sort lines of text | `sort file.txt` |
| `uniq` | | Report or omit repeated lines | `uniq file.txt` |
| | `-d` | Output only repeated (duplicate) lines | `uniq -d file.txt` |
| `wc` | | Print newline, word, and byte counts for each file | `wc ls-output.txt` |
| | `-l` | Limit reporting to line count only | `wc -l ls-output.txt` |
| `grep` | | Print lines matching a pattern | `grep zip ls-output.txt` |
| | `-i` | Ignore case when searching | `grep -i zip ls-output.txt` |
| | `-l` | Output only the names of files containing matching text | `grep -l zip *.txt` |
| | `-v` | Invert match; print only lines that do not match the pattern | `grep -v zip ls-output.txt` |
| | `-w` | Match only whole words | `grep -w zip ls-output.txt` |
| `head` | | Output the first part of a file (default 10 lines) | `head ls-output.txt` |
| | `-n` | Output the first n lines, or all but the last n lines if negative | `head -n 5 ls-output.txt` |
| `tail` | | Output the last part of a file (default 10 lines) | `tail ls-output.txt` |
| | `-n` | Output the last n lines, or starting at line n if prefixed with `+` | `tail -n 5 ls-output.txt` |
| | `-f` | Follow and view file contents in real time as data is appended | `tail -f /var/log/messages` |
| `tee` | | Read from standard input and write to standard output and files | `ls /usr/bin \| tee ls.txt` |

---

## Chapter 19

### Vocabulary

| Term | Definition |
| :--- | :--- |
| **Regular Expressions** | Complex symbolic patterns composed of literal characters and metacharacters used to describe, search, and match character combinations in text data. |
| **Grep (Global Regular Expression Print)** | A core command-line utility derived from the `ed` editor command `g/re/p` that searches text files or standard input for lines matching a specified regular expression and prints matching lines. |
| **Regex** | A widely used abbreviation for a regular expression. |
| **Literal Characters** | Characters in a regular expression that have no special syntactic meaning and match only themselves (e.g., alphanumeric letters and numbers). |
| **Metacharacters** | Special characters within regular expressions (such as `^`, `$`, `.`, `[`, `]`, `*`, `\`) that have specific syntactic meanings instead of matching themselves literally. |
| **Meta Sequences** | Character sequences created by preceding metacharacters or literals with a backslash (e.g., `\.` or `\\`) to either escape a metacharacter so it is treated as a literal or invoke special matching behaviors. |
| **Anchors** | Metacharacters that constrain where in a line a match can occur; the caret (`^`) anchors a match to the beginning of a line and the dollar sign (`$`) anchors a match to the end of a line. |
| **Bracket Expressions** | Regular expression constructs enclosed in square brackets (`[...]`) that match any single character from a defined set or character range (e.g., `[A-Z]`, `[0-9]`), or negate the set when beginning with a caret (`[^...]`). |

### Commands Covered

| Command | Option | Purpose | Example Usage |
| :--- | :--- | :--- | :--- |
| `grep` | | Print lines matching a regular expression pattern | `grep bzip dirlist*.txt` |
| | `-i`, `--ignore-case` | Ignore case distinctions when matching | `grep -i bzip file` |
| | `-v`, `--invert-match` | Invert match; output only lines that do not match pattern | `grep -v bzip dirlist*.txt` |
| | `-c`, `--count` | Print number of matching lines instead of lines themselves | `grep -c bzip dirlist*.txt` |
| | `-l`, `--files-with-matches` | Print only names of files that contain matching lines | `grep -l bzip dirlist*.txt` |
| | `-L`, `--files-without-match` | Print only names of files that do not contain matching lines | `grep -L bzip dirlist*.txt` |
| | `-n`, `--line-number` | Prefix each matching line with its line number within the file | `grep -n bzip file` |
| | `-h`, `--no-filename` | Suppress output of filenames in multi-file searches | `grep -h bzip dirlist*.txt` |
| | `-q`, `--quiet`, `--silent` | Suppress all output; exit immediately with zero status if match found | `grep -q bzip file` |
| `find` | | Search for files in a directory hierarchy | `find .` |
| | `-regex` | Match full pathname against a regular expression | `find . -regex '.*[^-_./0-9a-zA-Z].*'` |
| `locate` | | Search file database using regular expressions | `locate --regex 'bin/(bz|gz|zip)'` |
| | `--regex` | Perform locate search using extended regular expressions (ERE) | `locate --regex 'bin/(bz|gz|zip)'` |
| | `--regexp` | Perform locate search using basic regular expressions (BRE) | `locate --regexp 'pattern'` |
| `zgrep` | | Search compressed (.gz) files using grep | `zgrep -El 'regex' *.gz` |

---

## Chapter 20

### Vocabulary

| Term | Definition |
| :--- | :--- |
| **Markup Language** | A system of annotating plain text documents with tags, symbols, or special syntax (e.g., HTML, XML, Markdown) to describe layout, structure, or formatting when rendered. |
| **HTML** | HyperText Markup Language; the standard markup language used to structure web pages and related multimedia documents on the World Wide Web. |
| **XML** | Extensible Markup Language; a flexible markup language defining rules for encoding structured data into a format that is both human-readable and machine-readable. |
| **Header** | Contextual metadata lines positioned at the beginning of a document, file, or comparison output (e.g., unified diff headers) that identify filenames, timestamps, or field structures. |
| **Source Code** | Human-readable instructions written by programmers in a programming language prior to compilation or interpretation into executable software. |
| **Non-printing Characters** | Control characters and invisible whitespace elements (such as tab characters `^I` and end-of-line carriage returns `\r`) embedded within text; detectable and visualized using `cat -A`. |
| **Tabular Data** | Information arranged in structured records of rows and columns (fields) separated by delimiters such as tabs, spaces, or colons, well suited for sorting and deduplication. |
| **Source Trees** | The hierarchical directory tree structure housing all source code files, configurations, and build scripts comprising a software project. |
| **Transliterate** | To convert or substitute characters from one alphabet or character set into corresponding characters in another set on a character-by-character basis (e.g., converting lowercase to uppercase with `tr`). |
| **ROT13** | "Rotate by 13 places"; a simple substitution cipher where each letter of the alphabet is shifted by 13 positions, frequently used to obscure spoilers or potentially offensive text. |

### Commands Covered

| Command | Option | Purpose | Example Usage |
| :--- | :--- | :--- | :--- |
| `cat` | | Concatenate files and print to standard output (visualize control characters and modify text) | `cat -A foo.txt` |
| | `-A`, `--show-all` | Display non-printing characters (show tabs as `^I` and line ends as `$`) | `cat -A foo.txt` |
| | `-n`, `--number` | Number all output lines | `cat -ns foo.txt` |
| | `-s`, `--squeeze-blank` | Suppress multiple adjacent blank lines | `cat -ns foo.txt` |
| `dos2unix` | | Convert text files from MS-DOS format (CRLF) to Unix format (LF) | `dos2unix file.txt` |
| `unix2dos` | | Convert text files from Unix format (LF) to MS-DOS format (CRLF) | `unix2dos file.txt` |
| `sort` | | Sort lines of text files or standard input | `sort distros.txt` |
| | `-b`, `--ignore-leading-blanks` | Ignore leading spaces in lines and sort based on first non-whitespace character | `sort -k 3.7nbr distros.txt` |
| | `-f`, `--ignore-case` | Make sorting case-insensitive | `sort -f file.txt` |
| | `-n`, `--numeric-sort` | Perform sorting based on numeric evaluation rather than alphabetic values | `du -s /usr/share/* \| sort -nr \| head` |
| | `-r`, `--reverse` | Sort in reverse (descending) order | `sort -nr file.txt` |
| | `-k`, `--key=field1[,field2]` | Sort based on a key field located from `field1` to `field2` (supports field offsets and sort flags) | `sort --key=1,1 --key=2n distros.txt` |
| | `-m`, `--merge` | Merge multiple presorted files into a single sorted result without extra sorting | `sort -m file1.txt file2.txt` |
| | `-o`, `--output=file` | Send sorted output to a specified file rather than standard output | `sort -o sorted.txt file.txt` |
| | `-t`, `--field-separator=char` | Define the field-separator character (default is whitespace) | `sort -t ':' -k 7 /etc/passwd` |
| | `-u`, `--unique` | Output only unique lines, removing duplicates from the sorted output | `sort -u file.txt` |
| `uniq` | | Report or omit adjacent duplicate lines from sorted input | `sort foo.txt \| uniq` |
| | `-c`, `--count` | Output a list of duplicate lines preceded by the number of times each line occurs | `sort foo.txt \| uniq -c` |
| | `-d`, `--repeated` | Output only repeated (duplicate) lines | `uniq -d foo.txt` |
| | `-f n`, `--skip-fields=n` | Ignore `n` leading fields in each line when comparing | `uniq -f 2 foo.txt` |
| | `-i`, `--ignore-case` | Ignore differences in case during line comparisons | `uniq -i foo.txt` |
| | `-s n`, `--skip-chars=n` | Skip (ignore) the leading `n` characters of each line | `uniq -s 4 foo.txt` |
| | `-u`, `--unique` | Output only unique lines (suppress lines with duplicates) | `uniq -u foo.txt` |
| `diff` | | Detect and report differences between files or directories line by line | `diff file1.txt file2.txt` |
| | `-c`, `--context` | Display differences using the context format | `diff -c file1.txt file2.txt` |
| | `-u`, `--unified` | Display differences using the unified format | `diff -u file1.txt file2.txt` |
| | `-r`, `--recursive` | Recursively compare any subdirectories found | `diff -r dir1 dir2` |
| `tr` | | Transliterate (translate) or delete characters from standard input to standard output | `echo "lowercase" \| tr a-z A-Z` |
| | `-d`, `--delete` | Delete characters matching specified set from input | `tr -d '\r' < dos_file > unix_file` |
| | `-s`, `--squeeze-repeats` | Squeeze repeated occurrences of characters in specified set to single occurrences | `echo "aaabbbccc" \| tr -s ab` |
