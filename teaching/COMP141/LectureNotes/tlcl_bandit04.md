---
layout: page
title: COMP141 - Vocab and Commands from TLCL Chapters 18 and 20
permalink: /teaching/COMP141/LectureNotes/tlcl_bandit04/
mathjax: true
---
# TLCL Chapters 18 and 20 (`tr`): Vocabulary and Commands Covered

## Chapter 18

### Vocabulary

| Term | Definition |
| :--- | :--- |
| **Data Compression** | The process of removing redundancy from data so that it can be stored or transmitted in the smallest available space. |
| **Run-length Encoding** | A rudimentary data compression scheme that replaces consecutive repeated data values (such as a block of identical pixels) with a count followed by a single instance of the value. |
| **Lossless Compression Algorithms** | Compression techniques that preserve all data contained in the original file, ensuring that when a file is restored from its compressed version, it matches the original uncompressed file byte-for-byte (e.g., `gzip`, `bzip2`). |
| **Lossy Compression Algorithms** | Compression techniques that permanently remove non-essential or imperceptible data during compression to achieve higher compression ratios, producing a close approximation rather than an exact match when restored (e.g., JPEG for images, MP3 for audio). |
| **Archiving** | The process of gathering multiple files and directory hierarchies and bundling them together into a single large file (often combined with compression for system backups or long-term storage). |

### Commands Covered

| Command | Option | Purpose | Example Usage |
| :--- | :--- | :--- | :--- |
| `gzip` | | Compress or expand files (replaces original file with `.gz` compressed version) | `gzip foo.txt` |
| | `-c`, `--stdout`, `--to-stdout` | Write output to standard output and keep the original files | `gzip -c foo.txt > foo.txt.gz` |
| | `-d`, `--decompress`, `--uncompress` | Decompress file (causes `gzip` to act like `gunzip`) | `gzip -d foo.txt.gz` |
| | `-f`, `--force` | Force compression even if a compressed version of the original file already exists | `gzip -f foo.txt` |
| | `-h`, `--help` | Display usage information | `gzip -h` |
| | `-l`, `--list` | List compression statistics for each file compressed | `gzip -l foo.txt.gz` |
| | `-r`, `--recursive` | Recursively compress files contained within specified directories | `gzip -r dir` |
| | `-t`, `--test` | Test the integrity of a compressed file | `gzip -tv foo.txt.gz` |
| | `-v`, `--verbose` | Display verbose messages while compressing or testing | `gzip -tv foo.txt.gz` |
| | `-number`, `--fast`, `--best` | Set compression level from `1` (`--fast`, fastest/least) to `9` (`--best`, slowest/most; default `6`) | `gzip -9 foo.txt` |
| `gunzip` | | Restore `.gz` compressed files to their original, uncompressed form | `gunzip foo.txt` |
| | `-c` | Write uncompressed output to standard output and keep original file | `gunzip -c foo.txt \| less` |
| `zcat` | | Write uncompressed contents of `.gz` files to standard output (equivalent to `gunzip -c`) | `zcat foo.txt.gz \| less` |
| `zless` | | View `.gz` compressed text files interactively using a pager | `zless foo.txt.gz` |
| `bzip2` | | Compress files using a block-sorting algorithm (creates `.bz2` files; supports `gzip` options except `-r`) | `bzip2 foo.txt` |
| `bunzip2` | | Restore `.bz2` compressed files to their original, uncompressed form | `bunzip2 foo.txt.bz2` |
| `bzcat` | | Write uncompressed contents of `.bz2` files to standard output | `bzcat foo.txt.bz2 \| less` |
| `bzip2recover` | | Attempt to recover data from damaged `.bz2` files | `bzip2recover foo.txt.bz2` |
| `tar` | | Tape archiving utility for bundling and extracting collections of files and directories | `tar cf playground.tar playground` |
| | `c` | Create an archive from a list of files and/or directories (mode) | `tar cf playground.tar playground` |
| | `x` | Extract an archive (mode) | `tar xf ../playground.tar` |
| | `r` | Append specified pathnames to the end of an archive; creates archive if nonexistent (mode) | `find playground -name 'file-A' -exec tar rf playground.tar '{}' '+'` |
| | `t` | List the contents of an archive (mode) | `tar tf playground.tar` |
| | `f` | Specify the pathname of the tar archive file (or `-` for standard input/output) | `tar cf playground.tar playground` |
| | `v` | Display verbose file listings during archive operations | `tar tvf playground.tar` |
| | `z` | Compress or decompress the archive directly using `gzip` | `find playground -name 'file-A' \| tar czf playground.tgz -T -` |
| | `j` | Compress or decompress the archive directly using `bzip2` | `find playground -name 'file-A' \| tar cjf playground.tbz -T -` |
| | `--wildcards` | Enable wildcard matching when specifying pathnames to extract | `tar xf ../playground2.tar --wildcards 'home/me/playground/dir-*/file-A'` |
| | `-T`, `--files-from` | Read list of pathnames to archive from a file (or `-` for standard input) | `find playground -name 'file-A' \| tar cf - --files-from=- \| gzip > playground.tgz` |

---

## Chapter 20 (`tr`)

### Vocabulary

| Term | Definition |
| :--- | :--- |
| **Transliterate** | To convert or substitute characters from one alphabet or character set into corresponding characters in another set on a character-by-character basis (e.g., converting lowercase to uppercase with `tr`). |
| **ROT13** | "Rotate by 13 places"; a simple substitution cipher where each letter of the alphabet is shifted by 13 positions, frequently used to obscure spoilers or potentially offensive text. |

### Commands Covered

| Command | Option | Purpose | Example Usage |
| :--- | :--- | :--- | :--- |
| `tr` | | Transliterate (translate) or delete characters from standard input to standard output | `echo "lowercase" \| tr a-z A-Z` |
| | `-d`, `--delete` | Delete characters matching specified set from input | `tr -d '\r' < dos_file > unix_file` |
| | `-s`, `--squeeze-repeats` | Squeeze repeated occurrences of characters in specified set to single occurrences | `echo "aaabbbccc" \| tr -s ab` |
