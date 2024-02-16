---
layout: page
title: COMP 337 - Chapter 2 Socket Programming
permalink: /teaching/COMP337/sp24/program/sockets
---

[Get the assignment starter from github](https://classroom.github.com/a/9N__bdUj)

There are three socket programming exercises for you to do:

1. [Web Server Program](https://gaia.cs.umass.edu/kurose_ross/programming/Python_code_only/WebServer_programming_lab_only.pdf)
2. Simple web client. This is the second optional program on the web server program (above). You do not need to make it a command-line program. That being said, this is an excellent change to learn/reinforce how to build command-line tools in python. Check out [this article from the Python tutorial](https://docs.python.org/3/tutorial/stdlib.html#command-line-arguments).  
3. [UDP Pinger Program](https://gaia.cs.umass.edu/kurose_ross/programming/Python_code_only/UDP_Pinger_programming_lab_only.pdf) 


Any other optional programming assignment on the above two pdf is, in fact, optional. 


##### On Running Network Applications Locally

If you have access to two different hosts on the internet, then you can run your server on one host and your client on another.  When developing your application, it's often easy and helpful to run them both on the same machine.  When doing this, *you do not send/receive traffic via you IP address for the internet*.  Instead, you use an address specifically reserved for local-only network communications. That address is *127.0.0.1*.  On many (most?) systems you can use the name *localhost* to refer to this address as well.  So, when setting up your servers, try *127.0.0.1* and/or *localhost* until you get some verified connectivity.  



