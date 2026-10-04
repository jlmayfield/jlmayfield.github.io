---
layout: page
title: COMP141 - Lecture Notes 5 - Files, You, and Everyone Else
permalink: /teaching/COMP141/LectureNotes/05_bandit_group_02/
mathjax: true
---

# Finding and Getting to Know Your Files

Right now we know *just enough* to wander around aimlessly on a file system, but not enough to move around with intention and with purpose.  We know files are everything, but we don't really know all that much about files. We know they contain data, but we don't understand the **metadata** of files, the information that tells us about the file and not the information stored within the file. Your next set of bandit labs revolves around finding files that meet certain properties and criteria. To do this we really need to understand what kind of metadata is used on our Linux systems and how to access it.

The other skill we need to avoid being lost at the shell is knowing how to get help from the shell. More specifically, we need to know how to get information about commands from the shell so that we can more effectively work at the shell without relying on external resources.

## Table of Contents

- [Goals](#goals)
- [Objectives](#objectives)
- [Big Picture: The Where, What, and Who of Files](#big-picture-the-where-what-and-who-of-files)
- [Learning More About Your Files](#learning-more-about-your-files)
  - [Name, Extension, and Association](#name-extension-and-association)
  - [Linux Type, Permissions and Ownership](#linux-type-permissions-and-ownership)
  - [Size and Last Modified](#size-and-last-modified)
  - [`stat`](#stat)
- [`find`ing Your Files](#finding-your-files)
  - [Pipes](#pipes)
- [Getting to Know Your Commands](#getting-to-know-your-commands)
- [Glossary](#glossary)

## Goals

1.  Understand the role and use of **users** and **groups** in Linux and **multi-user** computing environments.
2.  Understand the relationship between files, file permissions, and users, groups, and **others**.
3.  Have familiarity with basic file metadata and how to access it.
4.  Know how to use `type`, `which`, `man`, and `help` to find command documentation.
5.  Know how to search for files using a variety of metadata attributes.

## Objectives

1. Be able to read and interpret file type metadata as presented by the command `ls -l`.
2. Be able to read and interpret file permissions and ownership metadata as presented by the command `ls -l`.
3. Be able to use `find` to carry out simple to complex searches for files based on properties and other metadata.
4. Be able to differentiate between shell builtin commands and executables or scripts using `type`, and determine the path of a non-builtin command using `which`.
5. Be able to get command documentation using `help` and `man`.


# Big Picture: The Where, What, and Who of Files

Everything is a file. Every file has a **user** that owns it and is assigned to a **group** of users. On modern Linux systems, every user belongs to at least one group, a user private group, which has the same name as their username. Access permissions to files are managed through users and groups. Understanding users, groups, and file permissions is *essential* to your long-term success in a computing environment.

At a deeper level, the interaction between files and users is what makes a computer not just a storage device but a tool for people to use. The embedding of ownership and permissions creates a fundamental relationship between the system (everything is a file) and the people that use it. To fully understand computing you have to understand this relationship and know how to work with not only the data and programs contained within a file but with the users, groups, and permissions associated with that file.

# Learning More About Your Files

Let's think of some key questions we might ask about a file that have nothing to do with the actual contents of that file:
* What's the file name? Even though extensions aren't required by Linux, does it have one?
* What's the absolute path (location) for the file?
* Is this file human-readable or binary?
* What type of file is this, as in what kind of format, encoding, or application is it most closely associated with?
* According to the shell, what is the **file type**?
* Who owns this file? What group is assigned to the file?
* What are the file's **permissions**?
* How big is the file?
* When was the file last modified?

We could go on, but the point here is that as an informed user of a computing system, files have a life beyond the data they contain. They have properties and features that determine how they interact with the rest of the files on the system and how they can be interacted with by system users.

## Name, Extension, and Association

Names, locations, and extensions are things we're already more or less comfortable with, but when you don't know the true location, only some or all of the name, then `locate` and `find` come into play as described in *Chapter 17*.

Chapter 3 introduced you to the `file` command. It more or less plays the role of `type` for files. You can use it to learn about the associated encodings and human readability.

## Linux Type, Permissions and Ownership

We get *a lot* of metadata details from `ls -l`. *Chapter 9 covers permissions and ownership. We also encountered information about `ls -l` output back in Chapter 3.*

At the start of a line of output from `ls -l` that describes a file, we see type and permissions information:
```
tuuugggooo
```
The `t` is the type: regular file `-` and directory `d` are the most common and our focus for now. You should be familiar with the other possible types though.

Next we get permissions: the `uuu` are the owner/user permissions, `ggg` for group, and `ooo` for others. You see `r` for read, `w` for write, and `x` for execute. A `-` means they lack that permission.

Next is the hard link count, followed by the username of the file owner and the associated group name. When combined with permissions, we now know how this file is tied to and used by people that use the system. Trying to run a program but it won't run? There's a good chance it's a permissions problem. Knowing how the file relates to users and permissions is absolutely essential if you want to be an informed and effective user of the system. It's not just a security thing.

## Size and Last Modified

The size and age of a file are often important. Once again, `ls -l` gives you this information. File size follows the group, followed by the last modified date and time. For human-readable files, you can sometimes get good "size" information from `wc`, which is short for word count. This tells you the number of lines, "words", and bytes in a file.

## `stat`

There is also a command named `stat` that gives you pretty detailed information about a file. Most of what it tells you is covered by `ls -l` but it gives more detail on the history of the file. Check it out.

# `find`ing Your Files

Chapter 17 is a wealth of information about how to make really, really good use of `find`. Your takeaway should be, *"Wow! That's a very powerful search tool! With it I can build searches that involve all kinds of file metadata!"* Of course, everything the chapter covers is also covered in the `man` page for `find`. Read the chapter, use it to help with the labs, and keep it handy. You'll learn how to `find` things with practice.

## Pipes

Chapter 17 shows you a lot of commands like this:
```bash
find ~ -type f -name "*.JPG" -size +1M | wc -l
```
The `|` in the middle is a **pipe**.  We'll cover them in detail in Chapter 6. For now, you just need to know a few things about them in order to get what you need to know about `find` from these examples.

1. A pipe shows up between separate commands. The example above is two commands `find ~ -type f -name "*.JPG" -size +1M` and `wc -l`.
2. The pipe **redirects** the output of the first command. Instead of going to the terminal for you to read, it is sent to the second command *as input*.

If your interest is, "how to use `find`", then you just drop everything but the `find` command and work with that. However, the example above is actually really useful and in the context of studying `find` a good entry point into the world of pipes. What does it do? Well, `find` produces, as output, the path to the files that meet your search criteria, one per line. If you redirect that to `wc -l`, then you *count the number of lines in that output*, i.e. *you count how many files meet your criteria*. Odds are high that this kind of information is something you often want. What you've just learned is that by using redirects, and `|` in particular, you can begin to create sophisticated, multi-step commands.


# Getting to Know Your Commands

Chapter 5 of our text provides more details about commands, the types of commands, and how to work with commands. To be effective with a computer, it's not enough to view commands and actions as black-boxes. You need to know where that command is coming from: is it a **builtin** of the shell? Is it an **executable program** or **script** stored on the file system, and if so, where is it and where did it come from? These commands are your tools and a good crafts-person, a good artist, a good technician *knows their tools*.

The most important skill to pull from Chapter 5 is how to learn about your tools. The command `type` will tell you what kind of command you have. Using `type -a` will account for possible aliases. Using `type` is generally the most reliable way to figure out what command you're dealing with. The `which` command can also give you clues, but `type -a` or `type` should be your first stop.

The command `man` will pull up the documentation for your non-builtin commands and some commands that exist both as builtins and executables. These are your *primary sources* for the command; they are never wrong. They might be overwhelming at first, but like anything, you can learn to manage them with practice. For builtins, you can access the docs using `help`.  While websites, textbooks, and YouTube tutorials are great, knowing how to find and read the official documentation is a vital skill. Furthermore, you might someday find yourself on a system but lacking internet access. If you know how to use `man` and `help`, then you'll never be wanting for documentation.


# Glossary


| Term | Definition |
| :--- | :--- |
| **Builtin** | A command implemented directly inside the shell program itself (e.g., `cd`, `type`, `help`), rather than stored as an external executable file on the filesystem. |
| **Executable Program** | A compiled binary program stored as a file on the filesystem (such as tools in `/usr/bin`), written in languages like C or C++, that the operating system can load and execute directly. |
| **File Type** | Metadata indicating the category of a file (e.g., regular file `-`, directory `d`, symbolic link `l`), represented by the leading character of the permissions string in `ls -l`. |
| **Group (Groups)** | A defined collection of user accounts in Linux that can share access permissions to files and directories. |
| **Metadata** | Information describing a file (such as its filename, location, file type, owner, group, permissions, size, and modification timestamps) rather than the actual data contents stored within the file. |
| **Multi-user** | A computing environment where multiple users can access the system simultaneously (locally or over a network), with access permissions managing privacy and security between accounts. |
| **Others** | The permission category that applies to all users on the system who are neither the owner of the file nor members of the file's assigned group (sometimes referred to as the "world"). |
| **Permissions** | Access rights assigned to the user/owner (`u`), group (`g`), and others (`o`) defining who can read (`r`), write (`w`), or execute (`x`) a file, or access directory contents. |
| **Pipe** | A shell operator (`|`) placed between separate commands that redirects the standard output (`stdout`) of the first command directly into the standard input (`stdin`) of the second command. |
| **Redirects** | The shell mechanism of routing a command's standard output or input away from the default terminal screen, directing data into a file or into another command via a pipe. |
| **Script** | A program stored as an executable text file containing commands written in an interpreted scripting or programming language (such as a shell script or Python), which is carried out by an interpreter. |
| **User (Users)** | An individual account on a Linux system that owns files, runs programs, and belongs to at least one group (including a primary user private group). |

