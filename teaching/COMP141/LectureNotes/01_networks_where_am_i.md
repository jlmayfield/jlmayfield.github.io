---
layout: page
title: COMP141 - Lecture Notes 1 - Networks
permalink: /teaching/COMP141/LectureNotes/01_networks_where_am_i/
---

# Networks, the Internet, and Networking

While singular computing devices are obviously central to computing technology, modern computing is increasingly mediated by and dependent on networking technology.
*   Many applications are web-applications that live on the internet.
*   Many **native applications**, running on your local computer, require at least some connection to the internet.
*   Most of our resources exist on the world-wide-web.
*   Special-purpose, high-powered computing resources are available through *cloud services* and are widely used in industry and science.

So, rather than get into the details of a specific computer, let's learn a bit about what goes on under the hood of computer networks and the internet.

## Table of Contents

- [Goals](#goals)
- [Objectives](#objectives)
- [The Internet](#the-internet)
- [Identifying Hosts - The Internet Protocol - Who Am I?](#identifying-hosts---the-internet-protocol---who-am-i)
  - [Public, Private, and Special Networks](#public-private-and-special-networks)
  - [Finding Your IP Addresses](#finding-your-ip-addresses)
    - [A Note About Terminals](#a-note-about-terminals)
  - [Getting Your Public IP from the Terminal](#getting-your-public-ip-from-the-terminal)
  - [Identifying Your Router/Gateway](#identifying-your-routergateway)
  - [Investigating your Network Address](#investigating-your-network-address)
- [Names, not Numbers](#names-not-numbers)
  - [URLs In a Nutshell](#urls-in-a-nutshell)
  - [Domain Registries or *Who's this?*](#domain-registries-or-whos-this)
  - [DNS: From FQDN to IP](#dns-from-fqdn-to-ip)
    - [Who's In Charge of Resolving Names?](#whos-in-charge-of-resolving-names)
    - [Using DNS at the Terminal](#using-dns-at-the-terminal)
    - [IP Lookup and Geolocation](#ip-lookup-and-geolocation)
- [Recap - Identifying Stuff on the Web](#recap---identifying-stuff-on-the-web)
- [Following Data Across the Web](#following-data-across-the-web)
- [Networking & Internet Basics Glossary](#networking--internet-basics-glossary)

## Goals

In a nutshell, our goal is to turn the internet from an abstract, nebulous cloud of data and applications, to a dynamic and structured, global system. Toward this end we want to:

1. Approach the internet and computer networks generally in terms of concrete things existing across the globe and run by individuals and organizations.
2. Learn how to use the Internet Protocol (IP) addressing scheme and Domain Name System (DNS) to attribute devices and networks to people and places.
3. Learn how to find and interpret key networking configuration on a computer.
4. Learn to deconstruct and otherwise interpret URLs.

## Objectives

To achieve these goals we need to develop some specific knowledge and skills.

1. Understand the structure and interpretation of **IP** addresses, network addresses, **URL**s, and domain names.
2. Be able to determine the interface and network address for your computer and specify these addresses in IP and CIDR format.
3. Be able to determine the address of your gateway and dns servers and attribute them to a service provider.
4. Be able to use local and internet resources to resolve domain names and attribute IP addresses.
5. Be able to attempt to trace the route from your device to another device on the internet,  roughly map that route to the globe, and otherwise interpret route trace data.

# The Internet

The internet is a network of networks.

An individual network is a collection of devices. Some/most devices are **hosts** or **end points**. The words are largely interchangeable.  These are the consumers and producers of data.  Your smartphone, laptop, and desktop are all end points; data starts or ends at them.

Networks are connected by **routers** and **gateways**. A router connects multiple devices or networks and, as the name implies, routes data between them. A gateway is also a router but is special as it sits at the intersection of two or more networks.

The internet, as a network of networks, has a multi-tiered system to it.  At the top are major network service providers like AT&T, Verizon, NTT (Japan), and Cogent.  Look up the *Internet Backbone* to learn about more top-tier providers. Increasingly, these networks are also owned and run by corporations like Google and Amazon. These providers then connect to large organizations and regional service providers.  Individual users then get their network connection from their organization. Here in Monmouth we get internet from [https://www.mtccomm.net/about-us/](https://www.mtccomm.net/about-us/) which then connects to backbone providers. When you're on a college connection you get your internet connectivity from the college, which gets it from MTC. When I'm at home, I get it directly from MTC.

# Identifying Hosts - The Internet Protocol - Who Am I?

Devices on the internet are identified by a numerical address called the *IP* address. Like your home address, the IP address identifies both the individual device (like a street address) and the network (like the city, state, and zip code).

IP is short for the *Internet Protocol*. A **protocol** is a set of rules for how to behave and what to do in a particular situation.  Computing has a lot of protocols. The Internet Protocol specifies how devices behave on a network.  Two versions of IP see use today: *IPv4* and *IPv6*.  We'll come back to this later. For now we'll focus on some details of IPv4.

The IPv4 protocol says that every **network interface** should be assigned a numerical address. This more or less means each device, but the address is technically for your wireless or wired network hardware. If you have more than one interface, then you can have more than one address.

IP addresses are built up from 4 numbers that *range from 0 to 255* and are written like `A.B.C.D`. For example,  145.27.19.5. IP addresses are assigned to you by your network provider as part of the connection process.  They typically change over time and will definitely change if you move to a new network.

The first part of your IP address is your network address. The trick is that the network and host address cutoff is not standard.  Often, but not always, the boundary falls at one of the dots. For example, if the first two values in 145.27.19.5 are the network address, then this particular host is on network 145.27.0.0 and within that network has a host address of 0.0.19.5.  But what if I told you the network address was 145.16.0.0?  Then we know the network address begins with 145, but we can't determine the rest without working in binary. For now, just remember that *the leftmost part of the IP address specifies the network, the rest specifies the host, and the cutoff between the two can vary from network to network*.

Finally, the structure of IP addresses gives us another way to think about networks: a range of IP addresses.

## Public, Private, and Special Networks

Certain networks, i.e. ranges of IP addresses, are meant for private use. This means an organization or routing device can use them for internal traffic but not for any traffic that traverses the wider internet.  Here's a few very common private networks that you should know and learn to recognize:

*   `192.168.0.0 - 192.168.255.255`, i.e. starts with `192.168`.  For small, home networks. (your home router uses this)
*   `10.0.0.0 - 10.255.255.255`, i.e. starts with `10`.  For large organizations/networks (Monmouth College uses this)
*   `172.16.0.0 - 172.31.255.255`. i.e. starts with `172.16` through `172.31`. For medium organizations/networks.

It can be important to recognize an address from these ranges because if you think one of these addresses is your true, internet address, then you're wrong.  What's happening is your network/router is using one public IP address for multiple devices. Each device has a unique private IP. The router works out the details as it processes traffic. This technique is called **Network Address Translation** or *NAT*.


There is even a special network reserved for doing networking tasks on your local device. This is not a private network connecting devices and applications on the internet. These are IP addresses that are used for doing network-based communication on-device.

*   `127.0.0.0 - 127.255.255.255`, i.e starts with `127`.  Local, on device networking.


## Finding Your IP Addresses

Enough information. Let's go peek at some network details. There are a variety of ways to get your IP address. The big thing to keep an eye out for is whether or not you're getting your public IP or a private IP used behind NAT.

There are many websites that are happy to give you your *public IP*. In fact, that's the only IP that you should be able to get from a site or resource not on your local network. An easy one is to go to sites like [https://whatismyipaddress.com/](https://whatismyipaddress.com/). Another good option that we'll focus on is the site **[https://ifconfig.me/](https://ifconfig.me/)**.

If you want your private IP, or *if you want to check if you're behind NAT or not*, then you can get your IP address directly from your computer. This and other network settings are available through both the **Graphical User Interface** *(GUI)* and the **Commandline Interface** *(CLI)*.  We'll be playing with CLIs quite a bit in this class so let's go right to that option:


**Windows**
```
Press the Windows Key, type cmd, and press Enter to open Command Prompt.
Type ipconfig and press Enter to view your active network settings.
```

**Mac**
```
Open Spotlight (Command + Space), type Terminal, and press Enter.
Type ifconfig, press Enter to view a list all network interfaces.
```

In both cases you're first opening a graphical interface for the CLI **terminal**. A *terminal* lets you use your computer using text-based commands. The computer will often respond back with text. Sometimes it does what you tell it to do but doesn't respond with text.  In this case you're running the command `ipconfig` or `ifconfig`, both of which tell you about your network interface configurations. Tucked within that information is your IPv4 address or `inet` address.  You're likely to see multiple entries. We'll sort through some of them in time. Windows does a particularly good job at highlighting your primary network interface. Mac/Linux aren't as helpful but can be more detailed. We'll look at Mac-like output in class.

If the IP address reported by the terminal command is different than the one you got from [https://ifconfig.me/](https://ifconfig.me/), then *you're connected behind a NAT router*. The IP address your terminal displayed is your private address and the IP address [https://ifconfig.me/](https://ifconfig.me/) displayed is your public address.

### A Note About Terminals

Commands and the look and feel of terminals varies by system. In fact, you can even customize your terminal to fit your needs.  Regardless, terminals do have some universal structure to them.  Before you type anything, you see a **prompt**.  This can look different and many prompts change as you work with your terminal.  In these notes and our text you'll see `$` used as a generic prompt. You can determine your specific prompt by seeing what is displayed when you start the terminal and before you've typed anything.

The first thing you usually type at a terminal is the name of a command. Everything after that are extra bits of information that specify the behavior of the command. These are sometimes called **parameters**, **arguments**, or **options**.  Some commands require arguments and some don't.  The `ifconfig` and `ipconfig` commands do not require arguments.

Once you've typed the command and its arguments, pressing enter instructs the computer to read and execute the command. If you typed something it didn't expect, then it will give you errors messages. Deciphering these can take experience, so make errors and learn to attribute computer error messages to missteps on the terminal.

From here on out, we'll specify commands not with step-by-step instructions as seen above, but in a "what you'll see and type" kind of format. For example, this figure:

```
$ ifconfig
```

Means, "run the `ifconfig` command".

You're going to get a lot of practice with this. No worries. Ask questions.  If you're very eager to learn more, dive into the introduction and chapter 1 of our main text [The Linux Command Line](https://linuxcommand.org/tlcl.php). No rush though. We'll get there.

## Getting Your Public IP from the Terminal

It's very much possible to get your public IP from the terminal. In fact, you can do it in the exact same way described above: get it from a website.  For this we use an incredibly useful and powerful command called `curl`, which is short for *Client URL*.  The `curl` command takes one argument, a *URL* *(Uniform Resource Locator)*, fetches that resource and displays some information.  The site [https://ifconfig.me/](https://ifconfig.me/) plays really well with `curl`.  The following command should work on both Windows and Mac.

```
$ curl ifconfig.me
```

Try it out!

## Identifying Your Router/Gateway

The router or gateway that gets you off your local (possibly private) network and on to the internet is another *very* important device. In Windows, this information is provided by `ipconfig`. It's listed as the *Default Gateway*.  On Mac things are a bit trickier.

**Windows**
```
$ ipconfig
```

**Mac**
```
$ netstat -nr | grep default
```

**Linux**
```
$ ip route show default
```
or sometimes
```
$ netstat -nr
```

The Mac command has something advanced going on in it. You can safely ignore that for the time being. If you're dying to know, then ask in lab or start searching the internet and your textbook for *bash pipe*.

## Investigating your Network Address

The `ifconfig` and `ipconfig` commands also give us information that we can use to determine our network address.  What we're looking for is two things: the *netmask* (or *network mask* or **subnet mask**) and the **broadcast address**.  The *subnet mask* is used by IP to separate network and host addresses.  The *broadcast address* is used to send information to all the hosts on the network. The *subnet mask* will look like an IP address that probably ends in 0s but starts with 255. The *broadcast address* probably looks like an IP address that ends with 255s and/or large values. They tell us something about the network address.

To get the actual network address we need to use binary. That will come later. For now, here's what we can tease out:
*   A `0` in the network mask means that this value is part of the host address. You should see a `255` in the same location in your broadcast address.
*   A `255` in the network mask means that this value is part of the network address. The value in this location in your broadcast address should be the same as your IP address and is the same in your network address.
*   If the number in the network mask is some value between `0` and `255`, then the value in that part of your network address requires binary value manipulation to determine.

Thankfully, the first two rules get the job done an awful lot of the time. For example, if my *netmask* is reported as `255.255.0.0`, my broadcast address is `145.27.255.255`, and my IP is `145.27.19.5`, then my network address is `145.27.0.0` and my host address on that network is `0.0.19.5`. If, however my netmask is `255.255.240.0`, my broadcast address is `145.27.???.255`, and my IP address is `145.27.19.5`, then for sure I know my network address starts with `145.27` and ends with `0`, but it's not immediately obvious what the third from the left value should be.

# Names, not Numbers

Computers work off numbers, but people work off names. When we connect to devices and resources on the internet we often connect via a *URL*, or **Uniform Resource Locator**.  This is a text specifier for something. Usually on the internet, but not always.  Naming on the internet is based on another protocol, the **Domain Name System** or DNS protocol. Roughly speaking, a *domain* is a collection of named resources. The DNS protocol allows us to translate names, which we like, to IP addresses, which computers like. It largely happens in the background of everything we do and has huge, but hidden consequences for using the internet.

## URLs In a Nutshell
URLs and domain naming schemes can get pretty complicated so lets start simple.  Say you direct your browser to `monmouthcollege.edu`.  Your browser then fills in the missing parts of the URL:

```
https://www.monmouthcollege.edu/
```

We used to have to fill in all the details, but the `https://www.` is pretty much a given, so browsers now fill that bit in for us.

`https` specifies the protocol being used, **HyperText Transfer Protocol Secure**. The `://` separates this from the **Fully Qualified Domain Name** (FQDN), `www.monmouthcollege.edu`.

We'll approach the FQDN from right to left. The `edu` portion of the FQDN specifies a **top-level domain**.  This is like `com`, `org`, etc.  The `edu` domain is reserved for educational organizations.

The `monmouthcollege` is the **second-level domain**.  The college registered `monmouthcollege` with the `edu` domain holders and can use `monmouthcollege.edu` to name its networked resources.

Finally, the `www` specifies the **subdomain** within `monmouthcollege.edu`. `www` is standard for website resources/servers.  Organizations can more or less organize their resources into **subdomains** however they like though.

All together the name `www.monmouthcollege.edu` is a FQDN for the webserver for the college's website. The name `monmouthcollege.edu` identifies a domain the college owns and can use to build FQDNs as needed. This domain is registered through an organization called [Educause](https://www.educause.edu/edu-domain-administration), which oversees the `edu` top-level domain.

Again, it's helpful to read an FQDN from right to left, from the top of the domain hierarchy down to the subdomains following the global organizational scheme. The top is a top-level domain. Then the second-level domain. This usually identifies a specific entity within the top-level. The rest is all various levels of subdomains within that entity.


Now how about a URL like:
```
https://www.monmouthcollege.edu/academics/computer-science/
```
The `https://www.monmouthcollege.edu` part is the same, but now we have a **path** specifier, `/academics/computer-science/`.  This effectively identifies a specific resource within the one identified by the FQDN. Here we're asking the webserver `www.monmouthcollege.edu` to send the content specific to `academics` and then within that context the pages for `computer-science`. This *path* format will become very familiar to you when we start working with linux.  For now we just want to get used to the pattern `PROTOCOL://FQDN/PATH1/PATH2/.../` where forward slashes, `/`, are used to separate parts of a path in the URL.  What we're specifying is a request to use `PROTOCOL` to communicate with the resource named `FQDN` and specifically with whatever is associated with `/PATH1/PATH2/.../` on that resource.


One more pattern. Often we see more than just the resource and path information. We see things like this:
```
https://monmouthscots.com/searchresults.aspx?q=football
```

First we get the main resource specifier `https://monmouthscots.com`. This is the webserver for the college athletics page. Notice no `www`! If you go to `https://www.monmouthscots.com`, then HTTP redirects you to `https://monmouthscots.com`. This kind of redirection and using multiple names for a single resource are incredibly common on the internet. Here it's managed by HTTP, but similar things can happen through DNS.

Now, what about the `searchresults.aspx?q=football`.  That's in the *path* position but it's not quite a path. The `searchresults.aspx` part is, in fact a path. The path we saw before, `/academics/computer-science/` specified a location.  This path is to a specific file, namely
`searchresults.aspx`.

This filename has two parts, the filename proper, `searchresults`, and the file extension `aspx`; the latter more or less specifies the kind of file. In this case we have an *Active Server Page Extended* file, `aspx`. Just know that this thing runs code on the webserver. The name `searchresults` gives us a big clue as to what that code does: find search results. This file naming scheme is ubiquitous in computing: `FILENAME.EXTENSION`. You won't always see extensions, but when they do they tell you, and the computer, exactly what kind of data you're dealing with.

We're now left with `?q=football`. This is known as the **query string**. You recognize in by the inclusion of the `?` in the URL. The `q=football` is information for the webserver. In this case, it's what I typed in a search bar. A LOT of websites use and require query strings to pass information between the browser and the website. It can be a major source of security problems if not managed properly at the server.

We'll return to query strings as/if needed, but for now, start recognizing the following URL pattern. You'll see it everywhere!

```
PROTOCOL://FQDN/PATH?QUERY-STRING
```
If you really want to learn to pick apart a query string, then you can [read more](https://en.wikipedia.org/wiki/Query_string).



## Domain Registries or *Who's this?*

So, resources on the web are often given one or more FQDNs. Assuming the top-level domain has a concrete purpose (like `edu`), then you can learn a bit about the owner of that resource from the top-level domain. [Wikipedia has a pretty good list of top-level domains, who manages them, and their intended use.](https://en.wikipedia.org/wiki/List_of_Internet_top-level_domains) The second-level domain is more informative. It might name the organization directly, and if it doesn't then it must be registered to a specific person or organization. You just need to look it up. Lots of websites offer this service.  A good place to start is [ICANN](https://lookup.icann.org/en). They are a non-profit created to manage name registration. Places like [https://www.whois.com/](https://www.whois.com/) offer free domain name (and IP!) lookups and will offer to sell you unused domains!  You can also find out if a specific entity manages the top-level domain and see if they offer registry information. As we start poking around the net, you'll start to find some odd URLs. Poke around and figure out why they're there.

## DNS: From FQDN to IP

If all you have is an FQDN, you can use DNS to find the IP address associated with that FQDN.  What you'll quickly find is that many of the names you encounter in practice are in fact aliases for less human-friendly FQDNs. This is all part of modern infrastructure designed to deliver faster, more reliable, and more secure web services.

### Who's In Charge of Resolving Names?

There is no centralized, authoritative source for DNS.  Instead, the information is distributed across the web and the protocol works out how to find the information for you. The question is, *to whom do you direct the question?* This can have huge security and privacy implications. So, it's good to know how to figure this out.  You can choose a DNS server run by a reputable company. Otherwise, your internet provider will give you the IP for their name server when you connect. Here's how we can figure out the IP for our name server.

**Windows**
```
$ ipconfig /all
```

**Mac**
```
$ scutil --dns
```

**Linux**
```
$ nmcli dev show | grep DNS
```

If you see an IP that's on the same network as your IP, then you're talking to your ISP.  Otherwise, you're asking someone else.  For example, you can use [Google's Public DNS servers](https://developers.google.com/speed/public-dns) rather than your ISP.

### Using DNS at the Terminal

Windows, Mac, and Linux all use the same terminal tool for directly querying DNS, `nslookup`.

Request the IP address for `www.monmouthcollege.edu`
```
$ nslookup www.monmouthcollege.edu
```

The result of this command tells you a few things.  First, it should give you the name/ip for your primary name server. It will then give you one or more entries for that name. If the name you asked for is a true name, i.e. it maps directly to an IP, then you'll get that information. If it's an alias then it maps a name to a different name (a canonical name), and you'll get that information. In this case, you should see that `www.monmouthcollege.edu` is an alias that resolves to one or two less obvious-looking names that fall under a different second-level domain. Feel free to play detective and learn about that domain.

Sometimes you see something about non-authoritative answers. This means that name+IP matching didn't come from the source, but from someone who heard it from someone, etc.  If you want to find out what the authoritative source for this name+ip pair is, then you do a different query.

Request information about the authoritative nameserver for `www.monmouthcollege.edu` by querying its second-level domain.
```
$ nslookup -type=NS monmouthcollege.edu
```

If you want information about aliases, then you search for `CNAME` like so,
```
$ nslookup -type=CNAME www.monmouthcollege.edu
```

Finally, if you want to check with a specific nameserver, you can tell `nslookup` to request info from a specific server.  For example, you might want to ask that authoritative nameserver directly, just to check. Or, you might use Google's `8.8.8.8` to check against your ISP.  To do this, just add that nameserver IP to the end like:
```
$ nslookup www.monmouthcollege.edu 8.8.8.8
```

### IP Lookup and Geolocation

Networks (i.e. ranges of IP addresses) must be registered and purchased.  Information about who manages them is available on the web just like domain name information. Again it's good to have a nice non-profit to start with. In this case [ARIN](https://search.arin.net/rdap/) is pretty solid. After that, there is an abundance of IP lookup services out there. Some, like [https://www.geolocation.com/](https://www.geolocation.com/) focus on giving you a relative location on the globe for an IP address.

# Recap - Identifying Stuff on the Web

What do we know:
1. Everything that connects to the internet has an IP address.
2. That IP address is part of a range of addresses that make up a network.
3. The network could be public or private.
4. Public IP addresses are registered with service providers and can be looked up on the web.
5. Many things have a FQDN as well.
6. Domains must be registered with a top-level domain and can similarly be looked up on the web.
7. Many FQDNs don't refer to a specific thing but are aliases for one or more things.
8. DNS is a protocol to map FQDNs to IPs or to other FQDNs.  All roads lead to an IP.

Given a bit of poking around at the terminal and the web, you can learn a lot about who or what is behind anything on the public web. That's both cool and spooky.

# Following Data Across the Web

Recall that the internet is a network of networks. Connecting and fencing-in these networks are *routers* and *gateways*.  When you communicate with something on the web, your communications must flow through at least a few routers and gateways to get to its destination. This is called your **route**.

When sending, data is broken up into small chunks called **packets** that are rebuilt into the original data at the receiver's side. As you're about to learn, packets can and often do take different routes to get to a single destination. This is more or less like you and four friends all walking to some other place on campus where you all leave from the same starting point, but each take what you think is the best route to your destination. At which point, you regroup.  The big difference is packets don't decide on the path, the *router* does.

It is often possible to trace the likely routes between you and another resource on the web. For this we use the program `traceroute` or `tracert` on Windows.  The basic usage is:

```
$ traceroute www.monmouthcollege.edu
```
or
```
$ tracert www.monmouthcollege.edu
```

What happens next takes some unpacking. Your computer will send a series of packets designed to travel only so many hops (i.e. routers, gateways).  This is called the **time-to-live** (*ttl*). For example, one packet is designed to travel 5 hops, then be dropped. At that point, the router which drops it will send a reply to your computer. From that reply traceroute can determine the **round-trip-time** (*rtt*) and the IP of the router that dropped the packet. From that IP it can use a reverse-DNS search to get an FQDN of that router, if it exists. By default, traceroute sends triplets of packets with a ttl from 1 to 30. This means you get three RTT estimates per hop and information about network characteristics between you and your destination.

It is increasingly common for routers to not play nice with traceroute. They are under no obligation to reply. Many simply drop the traceroute packets.  When this happens, you see a `*` in the report. One OK source for sites that play nice with traceroute is [http://www.traceroute.org/](http://www.traceroute.org/).

At this point we can pick a site/resource on the web, run a trace route to that source, then do some web-sleuthing and use geolocation of IP addresses to track the path on the globe while using IP and Domain registration data to see who runs the networks that handled our data. Cool! And Spooky!



# Networking & Internet Basics Glossary


| Term | Definition |
| :--- | :--- |
| **Arguments** | Extra bits of information passed after a command name at a terminal to specify or control the behavior of the command. |
| **Broadcast Address** | A network address used to transmit information to all hosts on a network simultaneously. |
| **Commandline Interface (CLI)** | A text-based user interface that allows users to interact with a computer by typing commands into a terminal. |
| **Domain Name System (DNS)** | A protocol and system that translates human-friendly domain names (FQDNs) into numerical IP addresses used by computers. |
| **Fully Qualified Domain Name (FQDN)** | The complete domain name for a specific resource or web server (e.g., `www.monmouthcollege.edu`), combining the subdomain, second-level domain, and top-level domain. |
| **Gateways** | Routers that specifically connect distinct networks to each other. |
| **Graphical User Interface (GUI)** | A visual, graphics-based interface for interacting with a computer, using elements like windows, icons, and menus. |
| **Hosts** | Devices connected to a network that run applications and act as the origin or destination of data (also known as End Points). |
| **HyperText Transfer Protocol Secure (HTTPS)** | The secure communications protocol specified in a URL (`https://`) used for web traffic. |
| **Internet Protocol (IP)** | The set of rules specifying how devices behave and are numerically addressed on a network (such as IPv4 or IPv6). |
| **Native Applications** | Software applications that run directly on a local computer, which may require an internet connection for some features. |
| **Network Address Translation (NAT)** | A routing technique in which a router maps multiple IP addresses to a single public IP address. Commonly used to map private to public IP addresses. |
| **Network Interface** | A hardware or software interface that connects a device to a network via an assigned IP address. |
| **Packets** | Small formatted units/chunks into which larger data is divided for transmission across a network and rebuilt at the destination. |
| **Path** | The portion of a URL (separated by forward slashes `/`) that identifies a specific resource, directory, or file on a web server. |
| **Protocol** | A standardized set of rules specifying how devices or systems behave and communicate in a given situation. |
| **Prompt** | The text or symbol (such as `$`) displayed by a terminal indicating that it is ready to accept command input. |
| **Query String** | The portion of a URL starting with `?` (e.g., `?q=football`) used to pass information or search parameters from the browser to the web server. |
| **Round-Trip-Time (RTT)** | The elapsed time it takes for a data packet to travel from a source device to a router or destination and return. |
| **Route** | The path of routers and gateways through which data flows from a source device to its destination on the network. |
| **Routers** | Devices that connect multiple devices or networks together and route data traffic between them. |
| **Second-Level Domain** | The portion of a domain name directly below the top-level domain that typically identifies a specific organization or entity (e.g., `monmouthcollege` in `monmouthcollege.edu`). |
| **Subdomain** | A domain branch within a second-level domain used to organize specific servers or resources (e.g., `www` in `www.monmouthcollege.edu`). |
| **Subnet Mask** | A numerical mask used in IP networking to separate the network address portion from the host address portion of an IP address. |
| **Terminal** | A text-based application or display window that provides access to the computer's command-line interface. |
| **Time-to-Live (TTL)** | A setting on a network packet specifying the maximum number of network hops (routers/gateways) it is allowed to travel. |
| **Top-Level Domain** | The highest domain category in the Domain Name System hierarchy, appearing at the far right of an FQDN (e.g., `.edu`, `.com`, `.org`). |
| **Uniform Resource Locator (URL)** | A text specifier used to identify and locate a resource on the internet or network, structured as `PROTOCOL://FQDN/PATH?QUERY-STRING`. |
