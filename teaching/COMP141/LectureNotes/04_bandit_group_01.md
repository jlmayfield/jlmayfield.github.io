---
layout: page
title: COMP141 - Lecture Notes 4 - Files, Filesystems, and Bandit
permalink: /teaching/COMP141/LectureNotes/04_bandit_group_01/
mathjax: true
---

# Getting Started with Bandit and the CLI

Your first round of Bandit problems gets you in touch with getting access to and reading files. As your text pointed out, in Linux, everything is a file. Finding and accessing files is an essential part of working with and administering a system. In these notes we'll cover a few things to help you work through the Bandit problems and by extension work with files all over a computer.

## Table of Contents

- [Goals](#goals)
- [Objectives](#objectives)
- [What's the Big Picture Here: Files, the File System, and Knowing Where You Are](#whats-the-big-picture-here-files-the-file-system-and-knowing-where-you-are)
- [Notes and Pointers for the Bandit Labs](#notes-and-pointers-for-the-bandit-labs)
  - [Getting There with SSH at the CLI](#getting-there-with-ssh-at-the-cli)
  - [Double-Click in a Text World](#double-click-in-a-text-world)
  - [Cleaning Up](#cleaning-up)
  - [Escaping the Norm](#escaping-the-norm)
  - [Taking a Peek](#taking-a-peek)
  - [Saving Your Work](#saving-your-work)
- [Glossary](#glossary)

## Goals

1. Understand the central role of files and filesystems in computing and working at the shell.
2. Begin developing a sense of place within the filesystem when working at the shell.
3. Understand the role of hostname/IP, username, and port number when connecting to ssh servers.
4. Understand the purpose of escape characters and quotes at the shell.
5. Begin to work with more shell commands.

## Objectives

1. Be able to specify an ssh connection command from host, user, and port information.
2. Be able to specify absolute and relative paths to files and directories.
3. Be able to explain the role and importance of the root directory and user home directories.
4. Be able to use and interpret escape characters and quotes in shell commands.

# What's the Big Picture Here: Files, the File System, and Knowing Where You Are

Your first several chapters of the text and your first set of Bandit labs all revolve around interacting with files. Why? One of the biggest ideas in computing is that of the **stored-program computer**.  That means all the code and the data that a computer operates on are stored in the same memory system while they're being used. While you're not using those data and instructions, they are stored to long-term storage, your HDD or SSD. This means working with files is fundamental to computing and the more we ourselves know how to work with and manage files, the better off we'll be when doing technical computing work.

When you work at the shell you're always working out of your **current working directory**.  As a standard user, you start in your **user home directory** that's stored within the directory `/home/`.  All of this is stored in your **filesystem**, which on Linux is organized hierarchically starting with the root directory `/`. You can then move around with `cd` as much as your user permissions allow or even just look around with `ls`. Commands that you run are all either part of the shell or stored in a few different locations that, by default, the shell will look in when you call for a given command. Even when you don't think you're working with a file, you probably are. So, building and maintaining that sense that, **"I am here."** and **"This file is over there."** will serve you incredibly well in the long run. Your GUI often lets you live in a filesystem black box. You can't get very far like that on the shell.

As you work through the reading, the labs, and your first experiences at the shell, imagine you're an explorer. You've been dumped in a place called the home directory. Your goal is to map out the wilderness that is some or all of the filesystem.  If you maintain this attitude, you'll quickly begin to learn the landscape, the creatures that inhabit it, and feel more at home on the shell and when using the GUI.


# Notes and Pointers for the Bandit Labs

Below you'll find some pointers that are either essential or helpful when solving the bandit problems or when working at the shell. Some are covered later in the textbook. I'm introducing them now to give you a leg up on the labs.

## Getting There with SSH at the CLI

Every Bandit problem begins by logging into the shell of their machine as one user and gaining the password to log back in as another user. You'll do this from the shell of your linux system using the `ssh` (secure shell) command. You've used `ssh` to connect to your VM, but the Google Cloud Console and CLI manage the connection. Now it's your turn.

`ssh` is a **client-server** program, like the world-wide web. The machine you wish to connect to hosts a **server**. On your computer, you run a **client** program that will connect to the server over the internet.  As you already know, to connect to a machine on the internet, you need its IP or FQDN. To connect with a specific application on that machine you need a **port number**.  The IP protocol gets the packet to and from the end systems. The port number, which is part of a different layer of the network not part of IP, is used by the operating system to get the data to the correct application. In the case of SSH, another protocol called **Transmission Control Protocol (TCP)** uses port numbers to deliver packets to the client and server applications. The SSH server traditionally accepts connections on port 22. The administrator for the server can, however, choose to use other ports. This is the case for the Bandit server.

Given that `ssh` is meant for a secure connection to a system's shell, you'll need to do some security checks as you connect. On your first time connecting to a server, the server will present you with a digitally certified, public, cryptographic key. If you opt to trust the server, then that key is stored locally and can be used later to verify that you're connecting to that same server you said you trusted. With that settled, you can move on to authenticating your account with the server.

When you `ssh` into your VM, Google uses cryptographic keys. The traditional way to login to a system via `ssh`, and the way you'll use for almost all the Bandit problems, is using the password associated with a user. Putting this all together, you need four pieces of information to carry out an ssh login:

1.  `HOST` - The IP or FQDN of the server
2.  `PORT` - The port number for the ssh server on the Host.
3.  `USER` - The username for the account on the server that you're logging into
4.  `PASSWORD` - The password for the user

We can now stitch together the command to initiate the SSH session. Here you replace the `HOST`, `PORT`, `USER` with the actual values.
```
$ ssh -p PORT USER@HOST
```
You'll be prompted to enter `PASSWORD`. When you do, *it looks like nothing is happening but it really is. Type, trust, hit enter.*.

## Double-Click in a Text World

Very often you find yourself navigating from one folder to another in search of a file. In a GUI environment you would double click a folder and the GUI would automatically update your directory to that folder and show you the contents of this new location.  Not so at the terminal.

I find it very helpful to view directory contents as soon as I change my working directory. You might too. This means developing a habit of following a `cd` with an `ls`. As you get started, try making this a reflex and see if it helps you develop your sense of moving around from place to place within the file system.

```
$ cd TARGET_DIRECTORY
$ ls
TARGET_DIRECTORY CONTENTS ...
```
If you want to see even more information you can use `ls -a`, `ls -l`, or `ls -al` and get even more context about your new working directory.


## Cleaning Up

If you are overwhelmed by the text on the screen and want a nice clear prompt and nothing else, then use:
```
$ clear
```
Depending on your terminal emulator, this is likely to prevent you from scrolling back to see the text that just got cleared. If you wish to preserve that text, then do:
```
$ clear -x
```

## Escaping the Norm

At the terminal, a space means separating parts of a command. If you have or want a space in a filename or some argument value, then you need to either use the **escape character** or **quote** the text in question.

On your shell, the escape character is the backslash `\`. When the shell sees this character within text it will *escape* the normal rules for the next character it sees.  For example `\` followed by a space, ` `, tells the computer not to read that space as the end of the token but as a normal space.  Where `hello there` is two tokens, `hello` and `there`, `hello\ there` is just one token.

The space character ` ` isn't the only **[special character](https://tldp.org/LDP/abs/html/special-chars.html)**, a character with a meaning beyond what it looks like, in bash. In fact, the escape character *must* be special. If you want to include a single `\` in some text, then you have to escape the escape and use `\\`. You'll learn about more special characters, for now, we're mostly worried about spaces and maybe backslashes. If you're dealing with a one-off special character, then `\` will help you escape its special meaning, if you know you have lots of them to deal with, then you might consider *quotes*.


Surrounding some text in quotes tells the shell that the text isn't something to be read, interpreted, and evaluated, but that it's just a literal piece of text, a quote. There are two quotes you can use, the **single quote** (aka apostrophe), `'`, or the **double quote**, `"`. When you surround text with single quotes, then it is treated literally. *Nothing within the single quotes can be escaped.* It is just exactly the text it looks like; no part of it will be subject to interpretation and evaluation by the shell.  If you surround text with double quotes, then certain things within the text *will* be interpreted and evaluated. For now, you should stick to `'` until we find a need or use for `"`.

To illustrate the point compare `ls -al` with `'ls -al'`.  If you enter the first at the terminal the computer will read it and recognize that you want to run `ls` with the `-a` and `-l` options. If you enter the second at the terminal, then the computer just sees a single, literal token of text, and will give you a *command not found* error message.


## Taking a Peek

In the text you learned about `less`. This is a nice, interactive file viewer that runs at the terminal. Sometimes you don't really want to interact with the file, you just want to take a peek.  By this I mean, see what's in it without having to enter and quit an interactive program.  At the CLI this means getting the shell to print some or all of the file contents then immediately give you a new prompt. I find myself doing this a lot while hunting around for just the right file. You might find it useful when solving bandit puzzles.

In chapter 6 of the text you'll learn about some commands that let you do this. I'll give you quick preview of them here but skip any of the options. If you're dying to know more, go look at chapter 6.

To display the entire contents of a file on the terminal, use the `cat` (concatenate) command:
```
$ cat FILEPATH
```

To display just the first few lines of the file, use the `head` command:
```
$ head FILEPATH
```

To display the last few lines of a file, use the `tail` command:
```
$ tail FILEPATH
```

Notice, I used `FILEPATH` not `FILENAME`. At the terminal, you can view files *anywhere* on the computer so long as you know the path to that file and have permissions to view that file. So, while you're working relative to your **current working directory**, you can act upon files in any other location. This is one of the super-powers of the terminal. If you know where something is, you probably don't need to go to it in order to work on it.

Remember, when passing files to commands as arguments, you are *always* passing the file path. If you start with `/` then the path is the **absolute path**, the path starting at the root directory. If you don't start with `/`, then the computer reads it as a **relative path**, the path starting from your current working directory.  If you want to be explicit, you can start a relative path with `./`, here the `.` is a shortcut for your current working directory. This can be *very* helpful at times and is also a nice way to be more explicit about paths. If you remember this, then you'll begin to unlock the pathing super-power of the terminal.

## Saving Your Work

Solving a bandit puzzle means discovering a password. You can and should write these down, but you might also wish to save them in a file on your GCP linux VM.  You'll find many ways to do this, but I'll show you a fun one-command, don't even leave the terminal way to do this right now.

If you want to save the password, `PASSWORD` into some file `FILEPATH`, you can use the following:
```
echo PASSWORD > FILEPATH
```
Just beware, bandit passwords might contain special characters that you'll need to handle with escape characters or quotes.

What I recommend is creating a directory named `bandit_passwords` in your GCP home directory and putting a file for each password in that directory. This will make it very easy to find/lookup previous puzzle passwords later, should you need them. If you first make the `bandit_passwords` directory with `mkdir`, then you can do something like this:

```
$ echo bandit0 > bandit_passwords/bandit0.password
```
Will write `bandit0` to a file named `bandit0.password` located in the directory `bandit_passwords` which should be in your current working directory. Now you have the only easy-to-remember password saved to a file for later use. *Just remember that you cannot create permanent directories and files on the bandit servers. Do this kind of thing on your GCP VM and the files will remain there for use at a later date.*


# Glossary


| Term | Definition |
| :--- | :--- |
| **Absolute Path** | A file path starting at the root directory (`/`), specifying the location of a file anywhere on the computer regardless of the current working directory. |
| **Client** | A program running on a local computer that initiates a connection to a remote server program over the internet (such as `ssh`). |
| **Client-Server** | A network application architecture where a client program on a local computer connects across the internet to a server program hosted on another machine. |
| **Current Working Directory** | The directory in the filesystem that the shell is currently working out of, serving as the base reference point for relative paths. |
| **Double Quote (`"`)** | Quotation marks (`"`) used to group text into a single literal token while still allowing certain variables and expressions within it to be interpreted and evaluated by the shell. |
| **Escape Character** | A special character (the backslash `\` in bash) that instructs the shell to bypass normal syntactic rules for the next character it sees (e.g., treating a space as part of a token rather than an argument separator). |
| **Filesystem** | The overall system for storing and managing files on a computer, organized hierarchically on Linux starting from the root directory `/`. |
| **Port Number** | A numerical identifier used at the network transport layer (such as TCP) by the operating system to deliver network packets to the correct application on a host. |
| **Quote** | Punctuation marks (single `'` or double `"`) used to enclose text so the shell treats it as a literal piece of text rather than code to be interpreted or split into separate tokens. |
| **Relative Path** | A file path that does not start with `/`, specifying the location of a file or directory relative to the current working directory (optionally written explicitly using `./`). |
| **Root Directory** | The topmost directory in the Linux hierarchical filesystem, represented by a single forward slash (`/`), from which all other paths branch. |
| **Secure Shell (SSH)** | A client-server command (`ssh`) and protocol used to establish a secure, encrypted connection to a remote machine's shell over the internet. |
| **Server** | A program or host machine that provides services or resources and listens for incoming connections from clients across a network. |
| **Single Quote (`'`)** | Quotation marks (`'`) used to treat enclosed text completely literally so that no part is evaluated by the shell; nothing within single quotes can be escaped. |
| **Special Character** | A character in bash (such as a space, backslash, or quote) that possesses a functional or syntactic meaning beyond its literal appearance. |
| **Stored-Program Computer** | A fundamental computer architecture where all the code and data that a computer operates on are stored in the same memory system while being used, and kept in long-term storage (HDD or SSD) when not in use. |
| **Transmission Control Protocol (TCP)** | A core networking protocol at the transport layer that uses port numbers to deliver packets between client and server applications. |
| **User Home Directory** | The default starting directory assigned to a user upon login, typically stored within `/home/` for standard Linux users. |