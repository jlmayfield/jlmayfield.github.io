---
layout: page
title: COMP141 - Lecture Notes 2 - Binary And Hex
permalink: /teaching/COMP141/LectureNotes/02_binary_hex_for_networks/
mathjax: true
---

# Binary and Hexadecimal for the Internet

We have one very specific need for knowing a bit of binary: *specifying networks using* **CIDR** *notation*. CIDR is short for *Classless Inter-Domain Routing*. It is an addressing and routing system that was developed to overcome problems related to the class-based system. With it comes a specific prefix notation to specify the boundary between network and host addresses. Our focus will initially be on learning enough binary to understand and use this notation. We'll then look at hexadecimal; it shows up in **IPv6** addresses and **MAC addresses**. The former is the intended successor to IPv4 and the latter is an address for a physical network device used in systems that work to move data around your local network. MAC is short for *Media Access Control*. When getting your IP address, you're typically also told the MAC address associated with your network interface. It's 48 bits and usually specified in hexadecimal. So, while we're learning about these networking topics, we'll dip our toes into the basics of binary and the representation of data in computing.

## Table of Contents

- [Goals](#goals)
- [Objectives](#objectives)
- [Network Specifications and CIDR](#network-specifications-and-cidr)
  - [Classless Inter-Domain Routing (CIDR)](#classless-inter-domain-routing-cidr)
- [Bytes of Binary](#bytes-of-binary)
  - [From Binary to Decimal](#from-binary-to-decimal)
    - [Range of and Expressiveness of 1 Byte](#range-of-and-expressiveness-of-1-byte)
    - [How many IPv4 and IPv6 Addresses are Possible?](#how-many-ipv4-and-ipv6-addresses-are-possible)
  - [From Decimal to Binary](#from-decimal-to-binary)
    - [Decimal to Binary via Repeated Subtraction](#decimal-to-binary-via-repeated-subtraction)
    - [Decimal to Binary via Repeated Division](#decimal-to-binary-via-repeated-division)
  - [Bitwise AND](#bitwise-and)
- [CIDR and Net-Masks](#cidr-and-net-masks)
  - [From Subnet Mask to Network Size](#from-subnet-mask-to-network-size)
  - [From Number of Network Bits to Number of hosts](#from-number-of-network-bits-to-number-of-hosts)
  - [From Subnet Mask to Network address in CIDR Notation](#from-subnet-mask-to-network-address-in-cidr-notation)
  - [Recap](#recap)
- [Help from Hex](#help-from-hex)
  - [Binary To Hex and Back Again](#binary-to-hex-and-back-again)
  - [So Many Bases!](#so-many-bases)
- [Glossary](#glossary)

## Goals

1. Understand and work with CIDR notation for IP networks.
2. Recognize and generally interpret hexadecimal when used in a networking context, i.e. for specifying IPv6 and MAC addresses.
3. Know how to work with binary and hexadecimal representations for 8 bits, or 1 Byte.

## Objectives

1. Read and interpret CIDR notation.
2. Determine the CIDR specification of a network from an IP address on that network and the subnet-mask.
3. Be able to specify the subnet-mask for a network given its CIDR specification.
4. Convert 8 bit (1 Byte) binary values to and from decimal.
5. Convert 8 bit (1 Byte) binary values to and from hexadecimal.


# Network Specifications and CIDR

Recall that in terms of IP, networks are ranges of IP addresses. Originally, the plan was to have five classes. Two classes (D and E) are reserved for special purposes. Classes A-C have roughly the following structure:

| Class | IP Range | Subnet Mask | Number of Hosts |
| :--- | :-- | :--- | :--- |
| A | 1.0.0.0 to 126.255.255.255| 255.0.0.0 | over 16 million hosts |
| B | 128.0.0.0 to 191.255.255.255 | 255.255.0.0 | 65,534 |
| C | 192.0.0.0 to 223.255.255.255 | 255.255.255.0 | 254 hosts |

The problem with this plan is its a perfectly logical structure designed around networks that map cleanly to the byte boundaries of IP addresses and humans do not organize that well. Our networks vary wildly in structure. We needed to be more flexible with network sizes and that means not using byte boundaries to split network and host addresses.

## Classless Inter-Domain Routing (CIDR)

The old classes of networks were set aside and a new system for classless routing was created. This means going from using one, two, or three bytes for the network address to using a more or less arbitrary number of bits.

Each value in an IP address is represented by 1 **Byte** which is equal to 8 **bit**s. In networking 8 bits is sometimes called an octet. If a byte is 8 bits, then this means *one IP address is 32 bits*. Bits can have the value of `1` or `0`. Computers typically work at the byte level. Sometimes multiple bytes at a time. CIDR notation is a situation where we actually work down to the bit level. In CIDR, we pick how many of the 32 bits are specifying the network and how many specify the host. We then communicate *the number of bits used in the network component of the IP address*. The full notation looks like an IP address followed by a slash and a number.  Let's see examples.

For example, a class A network used 8 bits to specify the network. They are `/8` networks.  The big private network that starts with 10 can be written in CIDR as `10.0.0.0/8`.  Notice, we typically provide a full IP giving numbers for network values and 0s for host values. The 192.168 network is a `/16` network: `192.168.0.0/16`. The old class A, B, and C networks are easily expressed in CIDR notation, but CIDR also allows things like `10.11.0.0/20`.

# Bytes of Binary

For IP addresses, binary is used in its most natural way, to represent non-negative integer values using the **unsigned integer** representation. An *unsigned* number is a representation in which no bits are used to encode a negative sign and all available bits are used to encode the positive numerical value.

The only difference between binary and the numbers we use is a choice of base. Humans use base 10, i.e. the **decimal number system**. Maybe because we generally have 10 fingers and that just made sense to work in 10s. In base 10, we use 10 symbols (*digits*) to represent the values 0-9. The **binary number system** is base 2. It has two digits (bits), 0 and 1. Computers use base 2 because its easier to build them around a two-valued systems than it is 10 valued systems. People tried building computers on digits. It wasn't workable when compared to bits.

To represent large values with respect to a base, we use a positional system. The position of the digit determines its overall magnitude. Consider the decimal value `123`.  If you read that as *one-hundred twenty three*, then you recalled that the right side is the `1`s place, the next value is the `10`s place, followed finally by the `100`s place.  We can go on forever with `1000`s, `10000`s, and so on.  The key here is two fold: each place represents *a power of the base* and the value at that place is a singular value in that base (i.e. a digit here).  You can do any base you want with these rules. The values in binary are easy: 0 and 1. We probably should review the bases:

| Power (p) | Decimal ($10^p$$) | Binary ($$2^p$$) |
| :--- | :--- | :--- |
| 0 | 1 | 1 |
| 1 | 10 | 2 |
| 2 | 100 | 4 |
| 3 | 1,000 | 8 |
| 4 | 10,000 | 16  |
| 5 | 100,000 | 32  |
| 6 | 1,000,000 | 64 |
| 7 | 10,000,000 | 128 |
| 8 | 100,000,000 | 256 |

Why does `123` mean "one-hundred twenty three"? Because it means:

$$ 123 = (1\times100) + (2\times10) + (3\times1) $$

What about the *binary* value `1011`? Apply the same logic, in base 2:

$$ 1011 = (1\times8) + (0\times4) + (1\times2) + (1\times1) $$

The good news with binary is that the 0 or 1 nature of it means we're really just expressing *which powers of two we want to add together*. From here, we have a path to converting between binary and decimal.

## From Binary to Decimal

Given an unsigned integer $$n$$ in binary, we can figure out the decimal equivalent adding the powers of two for which $$n$$ has a `1` in that power's place. For example, above we looked at `1011`.  There are ones in the `1`'s place, the `2`'s place, and the `8`s place, so:

$$ 1011 = 1 + 2 + 8 = 13 $$

How about another byte-sized example. Consider `10100101`. The `1`s exist in the 1st, 3rd, 6th, and 8th places. That is the place for $$2^0$$, $$2^2$$, $$2^5$$ and $$2^7$$. This means:

$$ 10100101 = 1 + 4 + 32 + 128 = 165 $$


*Notice how the powers are one less than the place!* This difference of one is incredibly common in computing. We often start a sequence at 0, where people start with 1. When people forget about this difference, then the infamous [**off-by-one error**](https://en.wikipedia.org/wiki/Off-by-one_error) creeps into a computing system. Here, you can easily misinterpret a binary number by being off-by-one on place values.

### Range of and Expressiveness of 1 Byte

We can now determine the minimum and maximum value represented by 1 byte.  We actually already know this from IP.  The minimum is `00000000` which is, of course, `0`.  The max is `11111111`, which is  255.  If you're not convinced, the add all the powers of two from $$2^0$$ to $$2^7$$.

There are 256 values in the range of 0 to 255 when we include both 0 and 255. This means a single byte is able to represent, or express, 256 different things.  Another way we can determine this is to think of individual bits. Imagine you get to choose a value for each bit. You have two choices for the first bit, then given that choice, you get 2 choices for the next, and so on.  The total number of choices for 8 bits is then,

$$2\times2\times2\times2\times2\times2\times2\times2 = 2^8 = 256$$

This technique can be used to count choices whenever you're making a series of independent choices. We actually need this technique in computing a lot.

### How many IPv4 and IPv6 Addresses are Possible?

Let's use that counting technique and get a rough count that ignore special rules and just looks at total possible addresses. An IPv4 address is 4 bytes, each byte can take on 256 possible values. That means there are $256^4$ or $4,294,967,296$ (a bit over 4 billion) possible addresses.  This does not compare well with the current world population. We can't even give every person on earth an IPv4 address. We have ways around this, but clearly the IPv4 scheme was not prepared for the demand for internet presence.

An IPv6 address is 16 Bytes, or 128 bits. It's typically written using hexadecimal notation. We'll get to that later. For now, notice that IPv6 implies a space of $$256^{16}$$ different addresses. That's in the ballpark of $$3.4 \times 10^{38}$$. That's A LOT more.


## From Decimal to Binary

To find the binary representation of a decimal number (without using a computer/calculator) you have two options: repeated subtraction or repeated division. If you're looking at a fixed byte value, like from IPv4, then you know exactly how many bits you need and both methods are fine. If you're talking some arbitrarily long number and you don't know how many bits, then the second method, division, is probably the way to go.

### Decimal to Binary via Repeated Subtraction

This is basically the exact opposite of our binary to decimal method.  We'll just look at numbers between 255 and 0, i.e. values representable in one byte.  This method builds the binary number in left to right order (most-significant bit to least-significant bit)

0.  Start at the largest place, $$2^7$$ or $$128$$.
1.  For each place (left to right) ask, "Can I subtract this place value from my number?".
    * If yes, then write down a `1` and subtract the place value from my number. *The result of the subtraction is your new number*
    * If no, then write down a `0`.

Let's see this in practice with 195.

| My Number | Current Place | Can I subtract? | Next Number |  Current Binary |
| :--- | :---| :---| :---| :--- |
| 195 | | | | |
| 195 | 7 | yes | 195-128 = 67 | 1 |
| 67 | 6 | yes | 67-64 = 3 | 11 |
| 3 | 5 | no | 3 | 110 |
| 3 | 4 | no | 3 | 1100 |
| 3 | 3 | no | 3 | 11000 |
| 3 | 2 | no | 3 | 110000 |
| 3 | 1 | yes  | 3-2 =1 | 1100001 |
| 1 | 0 | yes | 1-1 =0  | 11000011 |

So `195` is `11000011`.  We can gut check our answer by adding up all those powers of two, but given that we just did the opposite of that, we should be good to go so long as we didn't miss a power, aren't off-by-one, and generally did the subtraction correctly.

### Decimal to Binary via Repeated Division

This method finds the answer in the opposite direction as the subtraction method; it works from right to left, or least to most significant bit. Here's the process:

1. Repeat until your target number is 0
    * If your current target is odd: record a `1`.
    * If your current target is even: record a `0`.
    * Your next target is the current target divided by *2* with any decimal value dropped.
2. If you end but don't have enough bits (i.e. 5 recorded by you want 1 full byte), then pad the left with `0`.

Recalling that we're writing bits in left to right order, let's do 195 again.

| Target | Even or Odd? | Next Target | Current Binary |
| :--- | :--- | :--- | :--- |
| 195 | Odd | 97 | 1 |
| 97 | Odd | 48 | 11 |
| 48 | Even | 24 | 011 |
| 24 | Even | 12 | 0011 |
| 12 | Even | 6  | 00011 |
| 6  | Even | 3  | 000011 |
| 3  | Odd  | 1  | 1000011 |
| 1  | Odd  | 0  | 11000011 |
| 0  |     |     | 11000011 |

This method doesn't require knowing the most significant place of the result, so you can use it all the time.  Mathematically, we're doing *integer division*. The odd even check and the assignment of `1` to odd values and `0` to even values is exactly the same as finding the integer remainder of the target divided by 2.  In integer division, there is no decimal part, just an integer quotient. For example, doing strict integer division of 195 by two yields 97 remainder 1. Computers have this kind of arithmetic built in.

## Bitwise AND

Computing technology certainly makes use of arithmetic and the numerical interpretation of binary, but they also rely heavily on a *logical* interpretation of bits.  Here we view `1` as a *true* value and `0` as *false*.  Logic has its own arithmetic. One key operation is **logical and**. This operation functions on two logical bits just like addition and multiplication work on two numbers.  In fact, *and* is the logical analog of multiplication.

Because there are only two possible bit values, we can completely describe how *and* works in a table called a **truth table**. Here's the table for `a and b`.

| a | b | a and b |
| :-- | :-- | :-- |
| 0 | 0 | 0 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 1 |

There are four possible results from a logical and operation. In the truth table, each row represents one possible set of inputs. The column header indicates the operand with the final column showing the result of the operation.

We can apply `and` to many bits, like a byte, by applying it one bit at a time. You can even write it like you're doing numerical arithmetic. Applying single bit operations across a sequence of bits is called a **bitwise operation**. Let's look at a half-byte example of *bitwise and*.

```
    1100
and 0110
    ----
    0100
```

It is this operation, bitwise and, that enables CIDR.


# CIDR and Net-Masks

Let's say your IP address is `10.11.10.47` and your computer reports that you have a subnet mask of `255.255.240.0`. What do we know about this network?

1.  The 255s in the first two bytes of the mask tell us that this network has at least 16 network bits.
2. The 0 in the last byte tells us that all those bits are host bits. That means this network has fewer than 24 network bits.
3. The 240 in the third byte means that some of the bits in the third byte are network bits and some are host bits. *Converting 240 to binary will tell us exactly how many network/host bits there are in the third byte.*

## From Subnet Mask to Network Size

To find out the size of your network from your subnet mask, you:
1. Convert the left-most, non 255 byte to binary.
2. Every bit from the right-most `1` in the binary representation up to the $$2^7$$ place (most-significant) are network bits.
3. Add these bits to left-hand 255 bytes (8 bits each) and that's your CIDR network size.

In `255.255.240.0` we have two left-hand bytes of 255. That means we have 16 network bits for sure. Now we convert 240 to determine how many more network bits we have. Let's do that. First we work out which powers of two add up to 240.
```
240 - 128 = 112
112 - 64  = 48
48 - 32  = 16
16 - 16  = 0
```
That's the 7th, 6th, 5th, and 4th powers. This means `11110000` is 240 in binary. The right-most `1` is in the $$2^4$$ place, so it and everything left of it are network bits. *This means we're on a `/20` network.

Here's the subnet mask in full binary: `11111111 11111111 11110000 00000000`.  The fact that it's a run of `1`s followed by a run of `0`s is by design. It's *always* like that. If you read it logically, then there's a `1` for every bit that's part of the network address and a `0` for the host addresses. It's still the case that the address is network portion followed by host. A subnet mask *must* always be `1`s followed by `0`s.

## From Number of Network Bits to Number of hosts

If your network uses `N` of 32 bits for the network, then there must be exactly $$32-N$$ host bits.  Our counting process from above tells us this means we have at most $$2^{32-N}$$ addresses available for hosts.  Technically, we can't have the host bits be all `0` or all `1`. This means we can have *exactly* $$2^{32-N}-2$$ hosts on our network.

If our network has 20 network bits, then we have 12 host bits to work with. This means we have $$2^{12} - 2 = 4096-2 = 4094$$ usable host addresses on *any* `/20` network.


## From Subnet Mask to Network address in CIDR Notation

If you have an IP address from your network and the subnet mask, then you are a bitwise and away from the network address on that network.  The process is just:

1. Compute the bitwise and of the subnet mask and the IP. The result is the network address.
2. Add the `/N` to specify the number of network bits and thereby imply the size of the network.

Let's just do this in full on binary with `10.11.10.47` and `255.255.240.0`

```
    11111111 11111111 11110000 00000000
and 00001010 00001011 00001010 00101111
----------------------------------------
    00001010 00001011 00000000 00000000
```
The result is `10.11.0.0` and we're on the network `10.11.0.0/20`

Notice that where ever the mask was `1`, then the result has the same value as the IP address bit, and where ever the mask was `0`, then the result has `0`. The mask will always have `0` where there are host bits and `1` where there are network bits. So, *the result of this information is to hide or clear all the host bits in the IP address while keeping the network bits.*

We didn't have to give this the binary treatment. Given the observation above, we know that every 255 byte in the subnet mask will just yield the value of IP address in that bit when the bitwise and is carried out. There's no need to actually do the logical math there. Similarly, a byte with a 0 value in the mask will zero out (mask) that byte when bitwise and is carried out. So, the only byte we needed to do the binary arithmetic with was the third byte, the one that held the value between 0 and 255.

One more example. What if our IP was `10.11.74.47` and we had the same subnet mask of `255.255.240.0`.  Well, 74 is 64 + 10.  We know from the last example that 10 is `00001010` and gets masked out by the subnet mask. That leaves 64, which is `01000000`. That `1` is in the `1111` portion of the mask. *It's part of the network address.* This means a full bitwise and will yield `10.11.64.0` and our machine is now on the network `10.11.64.0/20`.  This is a different network than the previous example.  If you saw something like this but knew you were still on the same organization's network, i.e. you moved around the campus and this happened, then you just discovered two `/20` subnets within that organization's `10.0.0.0/8` private network.

## Recap

1. Converting a subnet mask into binary will tell you which bits are network bits and which are host bits.
2. If you have `N` network bits, then you have `M=32-N` host bits.
    *   You're on a `/N` network
    *   It can accommodate $$2^{M}-2$$ hosts.
3. If you know your IP address and your subnet mask, then you can specify the network IP range in CIDR notation.
    * Compute the bitwise and of your subnet mask and your IP address. That's the network specific part of the IP.  Your network (the set of IP addresses) is expressed as that value `/N`.

# Help from Hex

Hexadecimal is the base 16 number system. The immediate problem with any base larger than 10 is that our base 10 digits are insufficient to cover that system.  In this case we need a symbol/digit for 10, 11, 12, 13, 14, and 15. Good news. We can just cherry pick some letters.  Now, check this out:

| Decimal | Binary | Hex |
| :-- | :--- | :--- |
| 0 | 0000 | 0 |
| 1 | 0001 | 1 |
| 2 | 0010 | 2 |
| 3 | 0011 | 3 |
| 4 | 0100 | 4 |
| 5 | 0101 | 5 |
| 6 | 0110 | 6 |
| 7 | 0111 | 7 |
| 8 | 1000 | 8 |
| 9 | 1001 | 9 |
| 10 | 1010 | A |
| 11 | 1011 | B |
| 12 | 1100 | C |
| 13 | 1101 | D |
| 14 | 1110 | E |
| 15 | 1111 | F |
| 16 | 10000 | 10 |

Notice that decimal 0-15 and the hex digits 0-F directly equate to half-byte (4 bit) representations. This works out so nice because $$2^4=16$$. We'd get similarly nice digit to binary conversion in any base that is a power of 2. Why this is notable is that *it provides a really easy way to compress a sequence of bits for communication*.

In computing, we routinely deal with long bit sequences (aka large binary numbers) and simply need to recognize that pattern rather than do a bunch operations with it. In our case, we'd like a shortish way to communicate the 128 bits of an IPv6 address and the 48 bits off a MAC address. Hex is great for this. It reduces the number of symbols by a factor of 4 and therefore takes less to type/write/print and is easier to visually scan and recognize.


## Binary to Hex and Back Again

We don't really ever write IPv4 as hex, but we could. Let's use an IP to practice. Say your IP is 10.11.24.57.  In binary we get:

```
00001010 00001011 00011000 00111001
```
Now break that into groups of four,

```
0000 1010 0000 1011 0001 1000 0011 1001
```
and then replace each group of four with the hex equivalent.
```
0A0B1839
```
There you have it: `10.11.24.57` in hex is `0A0B1839`.

What if your IP, in hex, was `E4D2FC53`.  Just reverse the process. Each hex digit is replaced with the binary equivalent.
```
E    4    D    2    F    C    5    3
1110 0100 1101 0010 1111 1100 0101 0011
```
Easy peazy, lemon squezy.

## So Many Bases!

What's the value of 110101?  Did you say something like "one-hundred ten-thousand..." or did you start doing the binary conversion? What about 14?  Did you say fourteen or did you start converting to base 16? When we're working in multiple number systems in computing, it's important to remove this ambiguity. We have a more or less standard notation that we use to disambiguate.

| Number System | Prefix | Example | Decimal Value |
| :--- | :--- | :--- |
| Binary | `0b` | `0b1101` | 13 |
| Decimal | | `1101` | 1,101 |
| Hex | `0x` | `0x1101` | 4,353 |

# Glossary


| Term | Definition |
| :--- | :--- |
| **Binary Number System** | A base-2 positional number system that uses two digits (bits), 0 and 1; computers use base 2 because it is easier to build hardware around two-valued systems rather than ten-valued systems. |
| **Bit** | The fundamental unit of data in computing and the binary number system, representing a single base-2 digit with a value of either `0` or `1`. |
| **Bitwise Operation** | An operation that applies a logical operation (such as logical AND) across a sequence of bits one bit at a time. |
| **Byte** | A unit of digital data consisting of 8 bits (sometimes called an octet in networking), capable of representing 256 distinct values (ranging from 0 to 255 in unsigned decimal). |
| **Classless Inter-Domain Routing (CIDR)** | An IP addressing and routing system developed to overcome class-based limitations, using prefix notation (an IP address followed by a slash and bit count, e.g., `/20`) to specify the boundary between network and host bits. |
| **Decimal Number System** | The base-10 number system commonly used by humans, where 10 symbols (digits) are used to represent values from 0 through 9, with each place value representing a power of 10. |
| **IPv6 (Internet Protocol Version 6)** | The successor to IPv4 that uses 16-byte (128-bit) addresses specified in hexadecimal, providing approximately $$3.4 \times 10^{38}$$ possible addresses. |
| **Logical AND** | A fundamental logical operation functioning on two bits (treating `1` as true and `0` as false) that evaluates to `1` (true) only when both input bits are `1`. |
| **Media Access Control (MAC) Addresses** | 48-bit physical network device addresses, usually specified in hexadecimal, used in systems that operate under IP to move data on a local network (LAN) (short for Media Access Control). |
| **Off-by-One Error** | A common computing logic error caused by being off by a value of one.  |
| **Truth Table** | A table that completely describes the behavior of a logical operation, where each row represents one possible set of inputs and the final column shows the result of the operation. |
| **Unsigned Integer** | A binary representation for non-negative integer values in which no bits are used to encode a negative sign and all available bits are used to encode the magnitude. |