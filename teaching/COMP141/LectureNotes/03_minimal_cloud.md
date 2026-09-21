layout: page
title: COMP141 - Lecture Notes 3 - Cloud Compute
permalink: /teaching/COMP141/LectureNotes/02_binary_hex_for_networks/
mathjax: true
---

# A Minimal Introduction to Cloud Computing

Much of our work from here on out will revolve around working with the Linux terminal. To gain access to a computer running Linux, we'll make use of the Google Cloud Platform, Google's cloud computing service.  These notes are a very quick introduction to cloud computing and some of the things you'll run into when getting set up with GCP. The point here is to get some context and background.  We'll get into the details if and when they are needed. The one topic that we'll get a bit more detailed on is the core attributes of computer systems, or *compute*.

## Table of Contents

- [Goals](#goals)
- [Objectives](#objectives)
- [From Bare Metal to the Cloud](#from-bare-metal-to-the-cloud)
- [Compute in a Nutshell](#compute-in-a-nutshell)
  - [The CPU](#the-cpu)
  - [Memory](#memory)
  - [Storage](#storage)
  - [Operating System](#operating-system)
    - [Windows](#windows)
    - [macOS](#macos)
    - [Linux](#linux)
- [Google Cloud and You](#google-cloud-and-you)
  - [Choose Your Machine Configuration](#choose-your-machine-configuration)
  - [Choose the Location of Your Machine](#choose-the-location-of-your-machine)
  - [Set Up Network Connectivity](#set-up-network-connectivity)
- [Glossary](#glossary)

## Goals

1. Be familiar with cloud computing and how it differs from on-premises computing.
2. Know the role and function of CPUs, RAM, Storage Disks, and Operating Systems within a computer system and how their primary capabilities are measured, i.e., CPU core speed, and storage capacity for RAM and Disk.
3. Be familiar with the major Operating Systems and how they are developed.

## Objectives

1. Be able to differentiate between bare metal and virtual compute resources.
2. Be able to compare and contrast CPUs in terms of available cores and clock speed.
3. Be able to compare and contrast the role and properties of RAM and Disk Storage as they pertain to the work done by a CPU.
4. Be able to compare and contrast the Windows, macOS, and Linux Operating Systems.
5. Be able to explain the role of the Operating System when executing programs on computing hardware.
6. Be able to compare and contrast the OS Kernel and the Shell.
7. Know the difference and relationship between the Linux Kernel and a Linux Distribution.


# From Bare Metal to the Cloud

Historically, if you needed a computing resource, be it actual computers, a network, anything, then you'd have to have a physical location to house those resources, purchase and maintain the hardware and software that run those resources, and then build and maintain whatever it was that caused you to need those resources. For example, if I wanted to create a massively multiplayer online game, then I'd need computers to develop the game as well as computers and a network on which I'd host the game. In the long run, I will need developers to build and maintain the software, IT to build and maintain my infrastructure, and the financial resources to cover all the people and infrastructure. This paradigm is called **on-premises (on-prem)**.

One major downside to on-prem infrastructure is all that overhead. One way to avoid that overhead is to rent infrastructure from a third party. They cover some of the maintenance, and in particular, they make sure the hardware you're paying for is in working order. If something goes down, they replace it. You can now focus on system administration and less on hardware administration. If what you're renting is actual hardware, then this describes something not unlike **bare metal** cloud computing.

This now creates a downside for the hardware providers. Hardware isn't cheap and economies of scale make having a smaller number of high-powered systems better than a large number of low-powered systems. Furthermore, it's often the case that users don't fully utilize all of the resources available on a system.  A low-traffic web server just doesn't need 100% of the computing (CPU) and storage (RAM, solid-state or hard-disk). In a purely bare metal world, there can be a lot of resources left on the table.  The solution to this is **virtualization**.

In **virtualization**, a single machine runs a program called a **hypervisor**. In some cases, called a *bare metal hypervisor*, the hypervisor runs directly on the hardware and replaces the operating system.  In either case, a hypervisor runs multiple, independent **virtual machines (VMs)**.  To the user, the virtual machine appears to be an actual physical device. It has computing and storage resources and runs an operating system of their choosing.  In reality, the hypervisor splits the actual physical resources among the VMs and translates virtual operations to physical operations. From this paradigm arose **cloud computing**.

In cloud computing, organizations can pay for virtual and bare metal computing resources from a *cloud service provider*. Modern cloud services provide a wide array of computing (aka **compute**), network, and storage services and enable users to choose how much of the infrastructure management needs of their project or organization they wish to offload to the cloud service provider. Major cloud service providers include [Amazon Web Services](https://aws.amazon.com/) and [Google Cloud Platform](https://cloud.google.com/). In this class, we'll be using Google's cloud offerings.


# Compute in a Nutshell

**Compute** resources are the resources that provide computational power. They include bare metal machines, VMs, options with and without *graphics processing units* (GPUs), among other things that will do your computing for you. Our main use case is VMs and, as such, it's important to identify the key resources of a computing machine, be it virtual or bare metal.

## The CPU

All computation and calculation is carried out by the **central processing unit (CPU)**. Nearly all modern CPUs are **multicore**, meaning they have multiple independent computing cores that can work in parallel. The speed of the CPU is reported in terms of the **clock rate** of a single core. This is reported as cycles per second, i.e., **Hertz (Hz)**. Modern CPU cores operate at *billions* of cycles per second, a.k.a. **Gigahertz (GHz)**.  Actual computing instructions can take many cycles to execute. The clock rate tells you the rate at which a single core gets its work done, which gives you a *rough* idea of the rate it will get your logical work done.

## Memory

All programs executed by, and data operated on by, the CPU must exist in a machine's working storage, aka **memory**. This storage is *volatile*; when the machine is off, its contents are "forgotten". We associate working memory with a machine's **Random-Access Memory (RAM)**, so named because the computer can access any part of it and does not need to scan through to find a specific location. RAM is measured in **Bytes (B)**. A byte is eight **bits (b)**, the smallest unit of information in a computer. Modern systems usually have billions of bytes of RAM, i.e., **Gigabytes (GB)** (when talking about RAM 1 GB = $2^{30}$ B, 1 MB = $2^{20}$ B, and 1 KB = $2^{10}$ B).

The CPU has its own storage that it uses to work; RAM really acts as the place to keep the stuff you're likely to need soon.  Imagine you're working in the library, without a computer. You have a notebook in which you do your work. That's the storage that's onboard the CPU.  The table at which you sit is your RAM. The larger the table, the more books you can have readily available.  If all you have is a coffee table, then you can only have one or two books out at a time. If, instead, you have a whole 8-person table, then you can have *a lot* of books ready to use. Those books, of course, are coming from the library stacks, your long-term storage.

## Storage

Your nonvolatile, persistent, long-term storage is your *disk*.  This is where everything is kept while the computer is off, where it is read from when you need it, and where persistent changes are stored. This storage capacity is also measured in bytes with modern systems reaching trillions of bytes, or **Terabytes (TB)**.  This kind of storage comes in two flavors: **Solid-State Drives (SSD)** and **Hard-disk Drives (HDD)**.  The former is built from nonvolatile semiconductor technology, has no moving parts, and is fast but expensive per byte. Its speed comes in part from the complete lack of moving parts. The slower, but more budget-friendly option, is the HDD which is made from spinning, magnetic disks. The speed of your storage disk can have a big impact on system boot and program start time because starting something means loading that program from the disk into RAM. It also turns out that your system uses part of your disk as memory (known as *swap space* or *virtual memory*), and if your computing workload requires a lot of memory, then the speed of your storage disk can have a noticeable impact on performance. As the cost of SSDs comes down, they are becoming the standard choice, but there is still a place for the old workhorse that is the HDD.

## Operating System

All your programs must, somehow, share the same CPU, RAM, and Storage.  Managing this is definitely not a job for the user and is also not a job for application programmers.  Instead, we let the **Operating System (OS)** act as the interface between software and hardware and the overseer of the resource sharing that this requires. When you buy a computer, it almost always comes with the operating system pre-installed and people often associate their system type with their OS.  However, most hardware can run a wide variety of operating systems. When talking about computers, we can generally boil down OS options to three choices: Windows, macOS, and Linux. Linux, however, is not a singular OS, but a family of Linux distributions.  More on that in a bit.

> [!NOTE]
> Apple's iOS is their OS for mobile phones. Android is the mobile OS owned and developed by Google. It wasn't originally a Google project; they acquired Android, Inc. in the 2000s.

### Windows

Windows is created by [Microsoft](https://www.microsoft.com/en-us). The majority of computers run a version of Windows. You've almost certainly used it or are currently using it. The first Windows OS came out in the mid-1980s and its dominance has continued since then.

### macOS

macOS is the operating system used by [Apple](https://www.apple.com/). If you buy an Apple laptop or desktop (Mac), then you get macOS. Modern macOS is built on an open-source core called *Darwin* (derived from BSD UNIX and the Mach microkernel). While macOS and Linux use different kernels, both adhere to UNIX / POSIX standards. This is why many terminal commands in macOS are the same as those in Linux.

### Linux

Linux is not one single OS, but a whole family of OSes built off the same core, called the **Kernel**. The Linux Kernel was created by Linus Torvalds in 1991. He is still its lead developer. The kernel is developed as an **open-source** project. This means anyone can [view the code](https://github.com/torvalds/linux) and anyone can attempt to make contributions to the kernel.

You cannot run a computer on the kernel alone. Users need a way to interact with the system—typically through the **shell** (command line) or a **graphical user interface (GUI)**. Running programs, meanwhile, interact with the kernel directly through **system calls**. Generally speaking, you also need programs and applications that are neither in the kernel nor the shell. A **Linux Distribution (Distro)** is a collection of applications, shells, and utilities along with a Linux kernel that are put together and maintained by some group, organization, or individual, and is analogous to Windows and macOS. Most Linux distributions maintain the open-source ethos of the kernel and are distributed free of charge to all.

Our Google VMs will typically make use of the [Debian](https://www.debian.org/) Linux distribution. The Canonical corporation supports and develops the popular [Ubuntu](https://ubuntu.com/) distribution. [Linux Mint](https://linuxmint.com/) is a popular first-timer distribution, while [Arch](https://archlinux.org/) Linux is a minimalist distribution that rewards the persistent, patient, and experienced user. I use [Pop!_OS](https://system76.com/pop), which is developed by System76, which sells computers meant to run Linux. There are also specialized distributions. [Kali](https://www.kali.org/) Linux is designed for ethical hacking and penetration testing and, along with [Parrot Security OS](https://parrotsec.org/), sees use in the cybersecurity space. These Linux distros are less often used as a day-to-day OS and are instead used as part of technical security work, often run on a VM or a security sandbox environment.

# Google Cloud and You

As you work through your first cloud lab, you'll be told to make certain choices. For the purposes of this class, you don't need to know the exact impact of those choices, but it's good to have at least a surface-level understanding of why you're configuring things the way you are.

## Choose Your Machine Configuration

We'll be using Google Cloud Platform (GCP), and our primary goal with GCP is to gain access to a (virtual) Linux machine or, in cloud computing parlance, *spin up* a Linux VM. The CPU, RAM, and Storage available to us is largely constrained by our desire to not have to pay for anything. Your lab instructions will tell you what options to choose, but do take a moment to note the CPU, RAM, Storage, and OS that your VM will have. You can also poke around and look at Google's paid offerings. Your student credit isn't meant to pay for a more capable VM, but you can at least look!

## Choose the Location of Your Machine

While *the cloud* can be nebulous and ephemeral, Google still has to have actual physical hardware. When spinning up a VM, or launching any resource, you can choose where that resource will be located in the world. Google organizes their cloud into large **regions** spread across the globe. Each region contains multiple **zones**. Once again, our desire to work off freely available resources reduces our choices. For the best experience, you should spin up your VM close by (e.g., Iowa).

## Set Up Network Connectivity

Cloud resources are resources hosted remotely and accessed over a network. It's possible to have resources on a private network that you can access through Google, but we're interested in having a single (virtual) machine that is on the public internet (has a public IP) and to which we can connect using Secure Shell (SSH). For the most part we get this by default. We'll also take a few extra steps so that we can traceroute to our VM if we so choose.

Google will give you a free **ephemeral**, public IP address. This means the IP will change over time. Specifically, stopping and restarting the machine will result in a new IP address. If you wanted a single, fixed, unchanging IP, then you'd need to pay for a **static** IP address. Be certain to take note not only of your initial IP address, but also of how to figure out the IP of your VM as it is changed by Google.

All Google Cloud compute resources have a **firewall**. This is a network service that filters incoming and outgoing internet traffic.  One way this is done is by allowing and disallowing traffic on certain **ports** and **protocols**.

We've talked about how traffic moves across networks using IP. When it arrives at its final destination, the OS must determine which application should receive the message/packet/data. This is carried out using **ports**. Where IP deals with routing and moving between networks, the work of ports is focused on end-to-end communication with the assumption that protocols like IP will handle the routing. Ports help address the problem of getting the data to the correct program once it reaches its final destination. Networked applications are typically assigned a 2-byte (16-bit) number, i.e., a *port number*. This acts like a mailbox number. When traffic goes out, it goes along with both the IP and port number on the destination host and the IP and port number on the sending host. The IP addresses get it through the internet. The port numbers get it to the right program.

Just like with IP addresses, certain programs will use specific ports. Here are a few key, familiar examples:
| Protocol/Program | Port Number |
| :--- | :--- |
| DNS | 53 |
| HTTP | 80 |
| HTTPS | 443 |
| SSH | 22  |

Additionally, there are two main protocols that go along with port numbers and manage the logic of the end-to-end communication (rather than network routing): **Transmission Control Protocol (TCP)** and **User Datagram Protocol (UDP)**.  Firewalls can be more fine-grained by targeting a protocol and port combination.

Finally, you'll come across the acronym **ICMP**, or **Internet Control Message Protocol**. This is a protocol more closely aligned with IP. It uses IP to traverse networks, but doesn't use ports as discussed earlier. It's primarily involved in issues of network diagnostics and error reporting, not end-user applications.  The `ping` program uses ICMP to check if a host is reachable. When a traceroute packet reaches the end of its TTL, then the router at which it stops is expected to use ICMP to report back to the sender that the packet was dropped (via an ICMP Time Exceeded message).

The default firewall rules on your VM are pretty good for our purposes, but do lean towards security (as they should). For example, to ensure traceroutes targeted at your VM work from macOS or Linux, you'll need to allow UDP over certain ports. Running `tracert` from a Windows computer and `ping` from any computer will work right out of the box.


# Glossary


| Term | Definition |
| :--- | :--- |
| **Bare Metal** | Physical computer hardware dedicated directly to a single tenant or operating system without a virtualization layer running beneath it. |
| **Bits (b)** | The smallest unit of digital information in a computer, representing a single binary value of `0` or `1`; eight bits constitute one byte. |
| **Bytes (B)** | A standard unit of digital information and memory storage consisting of eight bits. |
| **Central Processing Unit (CPU)** | The primary hardware component of a computer that carries out computation and calculation by executing instructions across one or more cores. |
| **Clock Rate** | The speed of a single CPU core, measured in cycles per second (Hertz), providing a general indication of how rapidly it processes instructions. |
| **Cloud Computing** | A computing model where organizations pay for virtual or bare metal computing, storage, and networking resources on demand from a cloud service provider over a network. |
| **Compute** | The computing resources—including bare metal machines, virtual machines (VMs), CPUs, and GPUs—that provide computational power for executing workloads. |
| **Ephemeral (IP Address)** | A temporary public IP address assigned to a cloud VM that can change over time, specifically when the virtual machine is stopped and restarted. |
| **Firewall** | A network security service that filters incoming and outgoing internet traffic by allowing or blocking traffic on specified ports and protocols. |
| **Gigabytes (GB)** | A unit of digital storage equal to approximately one billion bytes; when measuring RAM, traditionally calculated as $2^{30}$ (1,073,741,824) bytes. |
| **Gigahertz (GHz)** | A unit of frequency equal to one billion cycles per second ($10^9$ Hz), used to measure modern CPU core clock rates. |
| **Graphical User Interface (GUI)** | A visual, graphics-based interface that allows users to interact with an operating system and software through windows, icons, and menus. |
| **Hard-disk Drives (HDD)** | Persistent, non-volatile data storage hardware that reads and writes data magnetically onto spinning disks; budget-friendly but slower than solid-state drives. |
| **Hertz (Hz)** | A unit of frequency measuring cycles per second, used to quantify CPU clock rates. |
| **Hypervisor** | A program or bare-metal layer that creates and manages multiple independent virtual machines (VMs) by partitioning physical hardware resources and translating virtual operations to physical ones. |
| **Internet Control Message Protocol (ICMP)** | A network-layer protocol closely aligned with IP that operates without transport port numbers, used primarily for network diagnostics (such as `ping`) and error reporting (such as router TTL expiration messages). |
| **Kernel** | The central core of an operating system that runs directly on hardware, managing CPU, memory, and storage sharing, and providing low-level services to running software. |
| **Linux Distribution (Distro)** | A complete operating system package that bundles a Linux kernel together with shells, utilities, system libraries, and applications maintained by an organization or community (e.g., Debian, Ubuntu, Arch). |
| **Memory** | The fast, volatile working storage of a computer (Random-Access Memory) where programs and data must reside while being actively processed by the CPU. |
| **Multicore** | A CPU design that integrates multiple independent processing cores on a single chip to execute computing tasks in parallel. |
| **On-Premises (On-Prem)** | A traditional infrastructure model where an organization purchases, houses, and maintains physical computers, networking hardware, and software in its own facilities. |
| **Open-Source** | A model of software development where the source code is made publicly accessible for anyone to inspect, modify, and contribute to. |
| **Operating System (OS)** | The fundamental system software that acts as an interface between applications and hardware, overseeing resource sharing among competing programs. |
| **Ports** | 16-bit numerical identifiers (ranging from 0 to 65,535) used by transport protocols (TCP and UDP) to direct incoming and outgoing network traffic to the correct application or service on a host. |
| **Protocols** | Standardized sets of rules and communication conventions that govern how data moves and is processed across networks and between endpoints. |
| **Random-Access Memory (RAM)** | Volatile working memory that allows direct, rapid access to any memory location; stores the programs and data currently needed by the CPU. |
| **Regions** | Large geographic areas around the world where cloud providers house their data centers, each containing multiple isolated zones (e.g., Iowa / `us-central1`). |
| **Shell** | A command-line program that serves as a text-based user interface to the operating system, allowing users to run commands and launch applications. |
| **Solid-State Drives (SSD)** | High-speed, non-volatile storage drives built using semiconductor flash technology with no moving parts, offering much faster boot and application load times than mechanical hard drives. |
| **Static (IP Address)** | A fixed, permanent public IP address assigned to a cloud resource that does not change across machine reboots. |
| **System Calls** | The programmatic requests and interfaces through which running user programs communicate directly with the operating system kernel to request system services (e.g., file I/O, memory allocation, network operations). |
| **Terabytes (TB)** | A unit of digital storage capacity equal to one trillion bytes ($10^{12}$ bytes or $2^{40}$ bytes), common for modern persistent storage drives. |
| **Transmission Control Protocol (TCP)** | A connection-oriented transport protocol that works with port numbers to provide reliable, ordered, end-to-end communication between networked programs. |
| **User Datagram Protocol (UDP)** | A lightweight, connectionless transport protocol that works with port numbers to send independent packets with minimal overhead and without delivery guarantees. |
| **Virtual Machines (VMs)** | Independent, software-emulated computers created by a hypervisor that run their own operating systems and utilize allocated shares of physical CPU, memory, and storage. |
| **Virtualization** | The technology of running a hypervisor on a physical computer to host multiple independent virtual machines, maximizing hardware utilization. |
| **Zones** | Distinct, fault-isolated data center locations within a cloud provider's geographic region. |

