---
layout: page
title: COMP141 - Lecture Notes 8 - Secure Communications
permalink: /teaching/COMP141/LectureNotes/08_bandit_group_05/
mathjax: true
---

# Communication and Cryptography

Now that we're getting a handle on the inner workings of our local computing system, it's time to reach back out to the web and start communicating with other systems.  This means taking a more nuanced look at communications across the internet and learning how to send messages without applications like the web browser or the ssh client.

## *The Linux Command Line*

Much of what follows is not covered in TLCL. What there is comes from chapter 16, most notably the section on *ssh*.  That being said, treat chapter 16 as optional but recommended reading. If networks and networking interest you, it's worth spending time with the chapter in addition to working through these notes. Otherwise, there are no textbook-specific terms or commands to learn.

## Table of Contents

- [Goals](#goals)
- [Objectives](#objectives)
- [Reaching Out - A Return to the Web](#reaching-out---a-return-to-the-web)
  - [A Note on `localhost`](#a-note-on-localhost)
  - [The Application Layer](#the-application-layer)
  - [The Transport Layer](#the-transport-layer)
  - [The Network Layer](#the-network-layer)
  - [Unpacking a Bandit connection using SSH](#unpacking-a-bandit-connection-using-ssh)
  - [Sending Your Own Messages with `nc`](#sending-your-own-messages-with-nc)
  - [Tin-foil Time](#tin-foil-time)
- [Reaching Out - With Security](#reaching-out---with-security)
  - [Public-Key Cryptography - An alternative to Passwords](#public-key-cryptography---an-alternative-to-passwords)
- [Secure Communications on the Web - SSL/TLS and Key Exchange](#secure-communications-on-the-web---ssltls-and-key-exchange)
  - [SSL/TLS](#ssltls)
  - [Key Exchange](#key-exchange)
- [Local Authentication: Passwords and Hashing](#local-authentication-passwords-and-hashing)
- [Recap](#recap)
- [Glossary](#glossary)
- [Commands Covered](#commands-covered)

## Goals

**Coming Soon**

## Objectives

**Coming Soon**

# Reaching Out - A Return to the Web

Let's recap:
*   *Hosts* on the internet are assigned an *IP address* which specifies their location, i.e. the network on which they reside and their individual host address on that network.
*   *DNS* can determine the IP address for a *fully-qualified domain name* allowing us to specify a host either by its IP address or its FQDN.
*   A network application on a host is assigned a *port* number which is used by the operating system to route packets that arrive at the host to the correct application.

Embedded within this is the logic of a layered approach to computer networks called the **OSI model**. The *Open Systems Interconnection* is the reference framework by which we've understood networked computer communications since the 1980s. We're going to look at just three of the standard layers, the layers that pretty much define the internet: the application layer, the transport layer, and the network layer.

## A Note on `localhost`

But first, it is not uncommon for you to need to connect to your own machine using networking.  This sounds weird, but you're just sending network packets to the OS which can then re-route them to other applications on your machine.  It's incredibly useful for developing and testing things that will eventually run on a network.

The `127.0.0.0/8` network is reserved for local network traffic.  Your machine is automatically assigned the name `localhost` which maps to the IP address `127.0.0.1`. This is standard on all OSes.

## The Application Layer

At the top is the **application layer**. This is the logic of your web-browser and the server it's communicating with. It's the logic of the ssh client you use and the server it is connecting to.  This layer specifies the format and rules, i.e. the **protocols**, for exchanging messages within a specific application. If you direct your browser to `http://jlmayfield.github.io`, it will construct a message whose first two lines might look more or less like:
```
GET / HTTP/1.1
Host: jlmayfield.github.io
```
The first line specifies the type of request, `GET`, the resource requested, the root `/` and the protocol version being used for the request, `HTTP/1.1`.  The second line is a **header**, request metadata in the form of a **key, value pair**, basically a "this is that" statement. In this case the key is `Host` and the value is the host address `jlmayfield.github.io`.  By using specific applications, the user does not need to worry about the fine details of the protocols; they're handled by the application.  This is great for usability, but limits you to applications already developed by others.

## The Transport Layer

The next layer down is the **transport layer**. This layer provides end-to-end communication to the applications. This lets applications worry about the logic of the specific application protocol because the transport layer protocols will handle the client-to-server or host-to-host logic. This does *not* include the network routing, just the issue of how communication should be handled.  This is the layer that introduces *port numbers*, which are used to identify the application on the host.  There are two main protocols used at this layer: **TCP** (*Transmission Control Protocol*) and **UDP** (*User Datagram Protocol*).

TCP is a connection-oriented protocol. Think of this like communicating by phone. One party calls the other to establish communication. When the other party answers, the two parties carry out some kind of verbal **handshake** to confirm they're ready to talk. They then talk and stay on the line until they're done talking about whatever it was they needed to talk about.
* "Hi, this is Alice. Is Bob there?"
* "This is Bob. Hi, Alice! What's up?"
*  Alice and Bob start yapping.
* "Ok, that's all. See you, Bob."
* "Bye, Alice."
*  They hang up and close the connection.

TCP works in much the same way. A connection is initiated and a handshake occurs between the hosts. This includes an exchange of port numbers used to send and receive messages for the remainder of the connection. When the communication is complete, the connection is closed. This offers reliable communication. By getting Bob on the phone, Alice knows with certainty he heard what she had to say.  There is, however, some overhead. Alice and Bob must carry out pleasantries and have to dedicate some or all of their focus to communicating until they hang up.

UDP, on the other hand, is more like sending messages via txt or a messaging app. The sender prepares their message and sends it. They don't establish a connection. They don't necessarily have any clue when or if the receiver has actually seen the message. Given that there isn't an established, open channel of communication, the receiver can reply whenever they like.  If both parties are free to respond and do so quickly, then this kind of communication can be as quick or quicker than connection-oriented communication while having less overhead. If, however, the receiver is busy or otherwise misses the message, then a lot of effort might need to go into sending follow-up messages and otherwise completing whatever communication task needs to be done. If you've ever had to message someone more than once just to get a response, then you know exactly what we're talking about here.

More often than not, the application will determine whether you're using TCP or UDP. SSH runs on TCP.  The web (HTTP and HTTPS) traditionally runs on TCP. The latest standard runs on a protocol called *QUIC* which is built on top of UDP and a security protocol called *TLS* (more on that one later). Prior versions of HTTP used TCP.  What's important to notice is that nothing stops the application from including some connection-oriented logic in its own protocols and building that on top of UDP.  The reverse is not true: if your application uses TCP, you can't really just drop the whole connection part of the protocol. Some applications will give you a choice and as you start to explore building and sending your own messages across the internet, you'll often get to choose TCP or UDP as the transport backbone for that message.

## The Network Layer

The transport layer cannot do its job if the packets do not arrive at the host. The job of getting from point A to point B, traversing and routing through networks, is handled by the **network layer** and the venerable **IP** protocol. You're familiar with this layer and its protocol.  We're not going to revisit the details here. Hop back to lecture notes 1 if you need a refresher.

## Unpacking a Bandit connection using SSH

Now consider what happens when you connect to a bandit server.  We're going to ignore the username and password part right now and just focus on the "connecting to the server" logic.
* You provide the ssh client (`ssh`) with the host name (FQDN), `bandit.labs.overthewire.org`,  and the port, `2220`.
* The client asks the OS to get the IP address for `bandit.labs.overthewire.org`.
* Once the client receives the IP address it uses TCP to establish a connection to the server and sends and receives SSH protocol messages over the network.
* In the background, IP gets all the packets through the network. TCP keeps an eye on the network, manages the big picture, and gets the message to the client/server application once it safely arrives at the host.
* You do your thing over that TCP connection (including the login part) and disconnect when you're done.

## Sending Your Own Messages with `nc`

Of course, there is a shell application that lets you send and receive your own messages. It's called `nc` or *netcat*.  It does *a lot*. For now, we'll focus on sending messages. Later we'll look at setting up listeners to receive messages and maybe even using `nc` to find out what applications are listening for messages on a specific host.

To use netcat you should first determine the IP or hostname of your destination and the port number for the application on that host.  By default, `nc` uses TCP.  You can request UDP with the `-u` option. To initiate a TCP connection you pass `nc` your destination and port.

```bash
nc DESTINATION PORT
```

You can then type out your message. Each time you press `Enter`, the line of text is sent over the connection. When you're done, press `ctrl-d` to send the **End-of-File** character, which signals the end of sending data. This can cause the connection itself to close, but it may also be the case that the netcat connection is kept alive. When in doubt, `ctrl-c` will kill an open `nc` session and return you to your prompt.

Alternatively you can use `<` to redirect your message from a file or `|` and `echo` or `cat` to redirect to `nc`. For example, if you want just the HTTP headers for my website, you could do the following:

```bash
echo -e "HEAD / HTTP/1.1\r\nHost: jlmayfield.github.io\r\n\r\n" | nc jlmayfield.github.io 80
```

If, for some reason, you wanted the whole front page (as HTML!) then you could do:

```bash
echo -e "GET / HTTP/1.1\r\nHost: jlmayfield.github.io\r\n\r\n" | nc jlmayfield.github.io 80
```

In both cases, you're sending, without the aid of a web-browser, a *very* minimal HTTP request to the web-server. Cool!

## Tin-foil Time

The TCP/IP and UDP/IP protocol stacks provide a means of communication between two hosts, but they do not offer any kind of security.  If your application doesn't build in security, then every message sent over TCP/IP or UDP/IP is sent in the clear, as plaintext. That means nothing is hidden. All the networks and routers that your packets travel through can easily read everything in the application messages.

Privacy aside, this is problematic. If you're remotely logging in, then you do not want the password you type on your local terminal to be sent as plaintext across the internet. Even if you aren't bothered by that, the host or service you're logging into probably is. For example, Google gave *you* free credit to their cloud services. They don't want anyone else using your account and those credits. Sending your password across the internet for everyone to see could lead to a compromise of your account and unauthorized users using Google resources that are meant for you.  So, how do we safely communicate across an insecure internet?


# Reaching Out - With Security

The solution to our problem rests with **cryptography**.  Cryptography provides us with algorithms and protocols that help us keep information and communication secure. More specifically, we're interested in two things:
1. **Confidentiality** - We want our communication to only be visible to intended parties.
2. **Integrity** - We want assurances that our messages have not been altered. We want verification and attribution of the sources of messages.  We want **non-repudiation**, that senders cannot deny the authenticity of their message. In short, we want to be certain that all is as it seems with our messages.

Along with *availability*, confidentiality and integrity make up the *CIA triad*, one of the core models of *information security*.

## Public-Key Cryptography - An alternative to Passwords

One of the shining jewels of cryptography is **public-key cryptography**. These are algorithms that enable **asymmetric-key encryption** and through that a host of other useful security features, including password-less authentication.

Recall that encryption lets us encode data for secrecy such that those with access to a secret *key* can easily encode and decode the message but those without the key cannot.  The Caesar shift, which we've used, is an example of *symmetric-key encryption*; both the encoder and decoder use the same key.  In asymmetric-key encryption, the encoder and decoder can use different keys.  These keys are carefully selected together as part of the encryption protocol.

Public-key cryptography gets its name from the idea that one of the keys in the pair is made public while the other key is kept private. This practice opens up a wide array of protocols for information security. For example, public-key cryptography can be used to log in, or authenticate, over SSH without the need for a password.  This is known as **key-based authentication**. Here's a rough idea of how this might work based on the original public-key cryptography algorithm **RSA** (named for the discoverers Rivest, Shamir, and Adleman):
1. You keep your private key on your machine and copy your public key to the server.
2. When you wish to log in, your client creates a special blob of data that is unique to this specific SSH session. The blob includes some unique numbers, the username, and the public key.
3. The blob is encoded using a **hash function** (another bit of cryptography, more later) that produces a fixed-length encoding called the *hash*. Hash functions are designed as one-way encoders. You can encode, but not decode. For this reason a hash is often called a **digest** (as in a short summary... that you can't make sense of) or a **fingerprint**.
4. The hash is encrypted with the private key and this is included with the blob. This encrypted hash is called a **digital signature**.
5. The blob and the signature are sent to the server.
6. The server decrypts the signature with the public key, hashes the blob, and compares the signature hash with a hash it computes itself. If they're the same, then the blob must have come from the owner of the private key that goes with the public key, i.e. the user!

There are public-key algorithms that only do digital signatures and do not also provide general encryption and decryption. In fact, the `ed25519` algorithm recommended for SSH authentication is a pure digital-signature algorithm where the private key computes the signature and the public key verifies it.

The `ssh` client uses the `-i` option to enable key-based authentication:
```bash
ssh -i path/to/private_key -p PORT USER@HOST
```

It is commonplace for SSH servers to completely disable password-based authentication and only allow key-based authentication. When properly managed, key-based authentication offers much better security. The private key can also be guarded by a password. In order to use it locally, you need to know the password. This password is only checked locally. It's not sent over the insecure internet.

You can generate your own public-private key pair at the shell:
``` bash
ssh-keygen -t ed25519 -C "your_email@example.com"

```
The `-t ed25519` specifies a specific, currently recommended public-key cryptography algorithm.  The `-C` option associates the key with your email. Upon running this command you'll be prompted for a password. This is used to encrypt your key on your own machine.  Gotta protect your secrets!  Finally, you'll be asked where you want to save the key.  The directory in which you save your keys should have `700` permissions. The private key itself should have `600` permissions. Security intensifies!

Once you've generated your public and private key pair, you can copy the public key to the server and set up things for key-based authentication using `ssh-copy-id`:
```bash
ssh-copy-id -i path/to/my_custom_key.pub -p PORT USER@HOST
```
This requires your password on the remote machine.  Once it's done, you can begin using key-based authentication for that server.

Notice that public-key cryptography gave us digital signatures and key-based authentication and in turn helps to provide strong *integrity* for our SSH session. The same protocol can be adapted to other applications. What we're not getting from our public-key protocol is confidentiality.

Public-key cryptography takes considerably more computational effort than symmetric-key cryptography.  It's just too slow for general encryption. Additionally, public-key encryption has size limits on what it can encrypt. This is no problem for digital signatures and maybe small messages, but it's a big problem if we want to be able to encrypt arbitrary data. This means we still need symmetric-key algorithms if we want to achieve confidentiality.

# Secure Communications on the Web - SSL/TLS and Key Exchange

To achieve confidentiality across the internet we turn to modern symmetric-key encryption algorithms and another jewel of cryptography, **key-exchange**.  A key exchange protocol enables the establishment of a shared key without the need to communicate secrets.  Key exchange can be done with public-key cryptography, but there are also dedicated key exchange algorithms which we'll look at more closely. In a nutshell, each user comes up with a local secret while also agreeing with the other on some public information. They can then derive another public value by combining it with their secret. This new value is sent to the other user. They then combine it with their secret and the result is a computed value that is based on both their secrets. At no point do they send their local secrets. So, the only way to arrive at the final value is by having access to one of the local secrets.

SSH and HTTPS both run a key exchange algorithm during the connection handshake.  SSH manages its own key exchange. HTTPS (and many other applications) make use of *TLS*, which carries out the key exchange. As a result, the client and server both have a shared, **session key**, a key for a symmetric-key encryption algorithm that will only be used for a single communication session.  In general, any application can achieve this by making use of the **SSL** (secure socket layer) protocol or the newer **TLS** (Transport Layer Security) protocols, collectively known as **SSL/TLS**.

## SSL/TLS

The SSL/TLS protocols sit just below the application layer but are not actually a part of the transport layer. You can think of them as applications meant to be used by applications, not people. You'll be shocked (not really) to know that there is a shell program you can use to establish an SSL/TLS connection to another host.  The command is a subcommand of the `openssl` program named `s_client`. You invoke it by using `openssl s_client` and can see the `s_client` manual page by running `man openssl s_client`.

The `openssl s_client` command works a bit like `nc` but provides a secure channel, not an insecure one. The syntax is, however, different. The basic command is:

```bash
openssl s_client -connect HOST:PORT
```

It can be helpful to include the `-crlf` command to translate newlines, `\n`, into a `\r\n` when it's required by the server. When sending messages using `openssl s_client` it is helpful to use the `-ign_eof` so that the client ignores the end-of-file that comes from the terminal. This eof can cause premature termination of the connection and prevent you from seeing response messages. All together, you'd use the following to send a one-off message over a connection secured by SSL/TLS.

```bash
echo "MESSAGE" | openssl s_client -crlf -ign_eof -connect HOST:PORT
```



## Key Exchange

**Coming Soon**


# Local Authentication: Passwords and Hashing

**Coming Soon**

# Recap

**Coming Soon**

# Glossary

| Term | Definition |
| :--- | :--- |
| **Application Layer** | The top layer of the network model, representing the logic of client and server applications (such as web browsers, web servers, and SSH clients/servers) and specifying the format and rules (protocols) for exchanging messages within a specific application. |
| **Asymmetric-Key Encryption** | Cryptographic encryption schemes enabled by public-key cryptography in which the encoder and decoder use different, mathematically paired keys (a public key and a private key) rather than a single shared key. |
| **Confidentiality** | A core principle of information security (part of the CIA triad) ensuring that communication and information are visible only to intended parties. |
| **Cryptography** | The field providing mathematical algorithms and protocols to keep information and communication secure, particularly by providing confidentiality and integrity across insecure networks. |
| **Digest** | A fixed-length summary output produced by a one-way cryptographic hash function that cannot be decoded back into the original input; also referred to as a hash or fingerprint. |
| **Digital Signature** | A cryptographic value computed from a message's hash using a sender's private key (e.g., by encrypting the hash in RSA or computing a signature in `ed25519`) that allows anyone with the corresponding public key to verify the sender's identity and the message's integrity. |
| **End-of-File (`EOF`)** | A control signal (sent from the terminal via `ctrl-d`) that indicates the end of input or data transmission. |
| **Fingerprint** | Another name for a cryptographic hash or digest, functioning as a fixed-length, unique identifier for a piece of data. |
| **Handshake** | The initial exchange of messages between two hosts (such as in TCP, SSH, or SSL/TLS) used to establish connection parameters, exchange port numbers or keys, and confirm both parties are ready to communicate. |
| **Hash Function** | A one-way cryptographic algorithm that encodes arbitrary input data into a fixed-length output (called a hash, digest, or fingerprint) such that the input can be encoded into the hash, but the hash cannot be decoded back into the original input. |
| **Header** | Request or response metadata included in a network protocol message (such as HTTP), typically formatted as a key, value pair (e.g., `Host: jlmayfield.github.io`). |
| **Integrity** | A core principle of information security (part of the CIA triad) providing assurances that messages have not been altered in transit, along with verification, attribution of message sources, and non-repudiation. |
| **IP (Internet Protocol)** | The primary network-layer protocol responsible for routing and delivering packets from point A to point B across interconnected networks. |
| **Key, Value Pair** | A metadata representation format—essentially a "this is that" statement—associating a named attribute (the key, such as `Host`) with its corresponding data (the value, such as `jlmayfield.github.io`). |
| **Key-Based Authentication** | A password-less login mechanism (commonly used in SSH) that relies on public-key cryptography, where a client proves possession of a private key by signing session data and the server verifies the signature using the user's public key. |
| **Key-Exchange** | A cryptographic protocol that enables two parties to establish a shared secret key over an insecure channel by exchanging public values derived from their private local secrets and shared public parameters, without ever transmitting the local secrets themselves. |
| **Network Layer** | The layer of the network model (home to the IP protocol) responsible for routing and moving packets across networks from the source host to the destination host. |
| **Non-Repudiation** | A security property ensuring that the sender of a message cannot deny the authenticity of their message. |
| **OSI Model** | The *Open Systems Interconnection* model, a layered conceptual reference framework used since the 1980s to understand and structure networked computer communications. |
| **Protocols** | The formal rules and message formats that govern how data is exchanged between systems or applications at a given network layer. |
| **Public-Key Cryptography** | Cryptographic algorithms and protocols based on a linked pair of keys—one made public and one kept private—enabling asymmetric-key encryption, digital signatures, and key-based authentication. |
| **RSA** | One of the original public-key cryptography algorithms (named after its discoverers Rivest, Shamir, and Adleman) capable of both asymmetric encryption/decryption and digital signatures. |
| **Session Key** | A shared symmetric-key encryption key established during a connection handshake (via a key-exchange algorithm) and used to encrypt traffic for a single communication session only. |
| **SSL (Secure Socket Layer)** | An earlier cryptographic protocol designed to provide secure communications and key exchange just below the application layer; now superseded by TLS. |
| **SSL/TLS** | The collective term for the SSL (Secure Socket Layer) and TLS (Transport Layer Security) protocols that sit between the application and transport layers to provide applications with key exchange and encrypted communication channels. |
| **TCP (Transmission Control Protocol)** | A connection-oriented transport-layer protocol that establishes a connection via a handshake, exchanges port numbers, and provides reliable end-to-end delivery of messages between hosts at the cost of additional overhead. |
| **TLS (Transport Layer Security)** | The modern cryptographic protocol (succeeding SSL) used by HTTPS, QUIC, and other applications to perform key exchange and secure application traffic with a session key. |
| **Transport Layer** | The network layer below the application layer that provides end-to-end, host-to-host communication for applications using port numbers and protocols such as TCP and UDP. |
| **UDP (User Datagram Protocol)** | A connectionless transport-layer protocol that sends messages without establishing a connection or guaranteeing delivery, offering lower overhead than TCP. |

# Commands Covered

| Command | Option | Purpose | Example Usage |
| :--- | :--- | :--- | :--- |
| `nc` | | Establish TCP or UDP network connections to send and receive messages ("netcat") | `nc jlmayfield.github.io 80` |
| | `-u` | Use UDP instead of the default TCP transport protocol | `nc -u DESTINATION PORT` |
| `echo` | | Display a line of text to standard output (often piped into network utilities like `nc` or `openssl s_client`) | `echo "MESSAGE" \| nc DESTINATION PORT` |
| | `-e` | Enable interpretation of backslash escape sequences (such as `\r` and `\n`) | `echo -e "GET / HTTP/1.1\r\nHost: jlmayfield.github.io\r\n\r\n" \| nc jlmayfield.github.io 80` |
| `ssh` | | OpenSSH remote login client for establishing secure shell sessions | `ssh -p 2220 bandit0@bandit.labs.overthewire.org` |
| | `-i` | Specify the identity (private key) file to use for key-based authentication | `ssh -i path/to/private_key -p PORT USER@HOST` |
| | `-p` | Specify the port number to connect to on the remote SSH server | `ssh -i path/to/private_key -p PORT USER@HOST` |
| `ssh-keygen` | | Generate, manage, and convert authentication keys for `ssh` | `ssh-keygen -t ed25519 -C "your_email@example.com"` |
| | `-t` | Specify the type of public-key cryptography algorithm to create (e.g., `ed25519`) | `ssh-keygen -t ed25519 -C "your_email@example.com"` |
| | `-C` | Provide a comment (such as an email address) to associate with the generated key | `ssh-keygen -t ed25519 -C "your_email@example.com"` |
| `ssh-copy-id` | | Copy a local public key to a remote server's authorized keys to set up key-based authentication | `ssh-copy-id -i path/to/my_custom_key.pub -p PORT USER@HOST` |
| | `-i` | Specify the public key file (`.pub`) to copy to the remote host | `ssh-copy-id -i path/to/my_custom_key.pub -p PORT USER@HOST` |
| | `-p` | Specify the SSH port number on the remote host | `ssh-copy-id -i path/to/my_custom_key.pub -p PORT USER@HOST` |
| `openssl s_client` | | Generic SSL/TLS client program (subcommand of `openssl`) for establishing a secure SSL/TLS connection to a remote host and port | `openssl s_client -connect HOST:PORT` |
| | `-connect` | Specify the remote host and port (`HOST:PORT`) to connect to | `openssl s_client -connect HOST:PORT` |
| | `-crlf` | Translate a newline (`\n`) from input into carriage-return + linefeed (`\r\n`) when required by the server | `echo "MESSAGE" \| openssl s_client -crlf -ign_eof -connect HOST:PORT` |
| | `-ign_eof` | Ignore the End-of-File (`EOF`) signal from standard input/terminal so the connection stays open to receive the server's response | `echo "MESSAGE" \| openssl s_client -crlf -ign_eof -connect HOST:PORT` |
