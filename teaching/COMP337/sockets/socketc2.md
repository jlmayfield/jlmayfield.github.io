---
layout: page
title: COMP337 - Chapter 2 Socket Assignments
permalink: /teaching/COMP337/sockets/socket2c/
---

For chapter two you'll be doing some programming assignments in lieu of an exam.

### Lab 1 - Web Server

**DUE FRIDAY 2/14**

The first set of programs consists of a bare bones server along with two simple clients. The first uses basic sockets where the second uses a modern HTTP client library. Your goal is to get your feet wet sending and receiving messages using HTTP. First you write a server and test it with **the** client, a browser. Then write your own client using a modern library. Finally, write a client using sockets to get a taste for what goes on behind the scenes of the library. Be sure to checkout the TCP client template discussed in section 2.8 and use that as a starter for your client.

* Complete the web server as described in the handout.
* Do exercise 2 but use the [requests](https://requests.readthedocs.io/en/master/) library rather than low level sockets.
* Do exercise 2 but drop down to low level sockets. No request module.

### Lab 2 - UDP Pinger

**DUE MONDAY 2/17**

The second set of programs is about building your own protocol for a well known application: ping. We'll tackle the real ping protocol later, but for now you'll try to get at the same information via a this roll-your-own protocol. The lack of an established protocol means you cannot find or use some preexisting library and must stay within sockets.  Be sure to checkout the UDP client template discussed in section 2.8 and use that as a starter for your client.

* Complete the lab as written
* Do both optional exercises

You'll want to run your servers for this lab on the departmental server.

### Now REST

**DUE WEDNESDAY 2/19**

Now that you've cut your teeth on some client-server applications lets build a [RESTful API](https://restfulapi.net/).  These kinds of APIs are at the heart of a lot of the modern web. They let developers layer on top of other web-applications in much the same way that they do with libraries and modules for native applications. You're API is a straight forward [dice rolling API](/teaching/COMP337/sockets/diceweb).
