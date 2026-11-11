---
layout: page
title: COMP141 - Lecture Notes 9 - Cryptography
permalink: /teaching/COMP141/LectureNotes/09_cryptography/
mathjax: true
---
# Modern Cryptography

Modern Cryptography begins by recognizing that all information used in computation is encoded into binary and that binary encoding can be interpreted as numerical values. As a result, cryptographic algorithms focus on mathematical problems rather than manipulating text as you saw with the Caesar Shift.  As we explore the foundational algorithms of cryptography in the computer era, just remember that the numbers are just a stand-in for the binary encoding of whatever information we're keeping secret or otherwise using with cryptographic protocols.

## Table of Contents

- [Goals](#goals)
- [Objectives](#objectives)
- [Modular Arithmetic](#modular-arithmetic)
  - [Numbers Modulo `N`](#numbers-modulo-n)
    - [Remainders on a Calculator](#remainders-on-a-calculator)
  - [Arithmetic Modulo `N`](#arithmetic-modulo-n)
- [Prime Numbers](#prime-numbers)
- [Hashing](#hashing)
  - [A Hash Function for ASCII Data](#a-hash-function-for-ascii-data)
    - [An Example](#an-example)
- [Public-Key Cryptography - **RSA**](#public-key-cryptography---rsa)
  - [Computing the Keys](#computing-the-keys)
  - [Encoding and Decoding](#encoding-and-decoding)
    - [`p`, `q` and Encryption Size Limits](#p-q-and-encryption-size-limits)
    - [Brute-Force Cracking RSA](#brute-force-cracking-rsa)
  - [RSA Example](#rsa-example)
  - [RSA - Secure Communications](#rsa---secure-communications)
  - [RSA - Digital Signature](#rsa---digital-signature)
- [Key-Exchange - Diffie-Hellman](#key-exchange---diffie-hellman)
  - [Sizing up DH](#sizing-up-dh)
  - [Brute-Force Cracking DH](#brute-force-cracking-dh)
  - [DH Example](#dh-example)
- [Glossary](#glossary)

## Goals

**Coming Soon**

## Objectives

**Coming Soon**

# Modular Arithmetic

**Modular Arithmetic** is an idea in mathematics that generalizes what we do with clocks.  At first glance it seems like one of those "theoretical math" things that you "don't need".  As you're about to discover, it is absolutely central to modern cryptography and modern information security. That is to say, it is used for you every day. Just like with clocks, we're only going to be working with whole valued, positive numbers (and zero) moving forward.

Let's start by looking at the arithmetic of the 12 hour clock.  Assume that it's 8am.  What time will it be in 5 hours?  That's right, 1pm. But, `8+5` does not equal `1`.  It equals `13`. With clock time, we know that once you get to `12` we start back over at `1` rather than continuing on past `12`.  This works even for large jumps in time. If it's currently 4pm, what time will it be 3 days and 2 hours from now?  That's right, 6pm.  Now, did you add 74 hours to 4 or did you just ignore the days because you know they just drop you right back at 4?  Again, that's modular arithmetic.

The same thing happens on the 24 hour clock, we just start at 0 and then restart after 23.  This kind of system, which starts with 0 and not 1, mirrors what we see in mathematics and computing.  The number that dictates when we "start over" is the **modulus**.  For 24 hour time, the modulus is 24.

Where in normal arithmetic we can get results all over the number line, in modular arithmetic, our results run from 0 to one less than the modulus.  For our clock modulus of 24, we get 0 to 23.  If our modulus were 19, we'd get 0 to 18. For a modulus of 131, we get values from 0 to 130.  You get the idea.  The reason for this is that we are, in fact, working with *remainders* of the modulus, aka **residues**.

## Numbers Modulo `N`

When someone is talking about numbers or arithmetic *modulo N*, they're saying that all numbers can and should be reduced down to *residues*, or *their remainder when divided by N*. It may have been a while since you've done *long division* in which we compute an integer *quotient* and *remainder*, so let's revisit remainders and do so by thinking specifically about all the positive integers, starting with zero, *modulo 7*.

What's `23` divided by `7`  (aka `23/7`)? My calculator tells me it's `3.285714...` with the `285714` sequence seeming to repeat forever.  If I had to do this by hand, then I might just use fractions. I know `3` times `7` (`3*7`) is `21`.  So, `23/7 = (21+2)/7 = 21/7 + 2/7 = 3+2/7`. That (`2/7`) is just our unending `0.285714...` sequence as a *ratio*. **The `2` is our remainder.** So what? Well, `23/7` expressed purely in terms of integers is `3` remainder `2`. That's what you're solving for when you do long division.

### Remainders on a Calculator

If you really want to use a calculator to get the remainder, you can.  You have to watch out for rounding errors but modern calculators should be pretty good at avoiding this. Mostly.

To find the remainder of `m/n`:
1. Calculate `m/n`
2. From the result, subtract the whole valued part. You should now have `0.` something.
3. Multiply that by `n`.  You now have the remainder.

Example:
```
Find: 23 mod 7
23/7 = 3.285714...
3.285714... - 3 = 0.285714...
0.285714... * 7 = 2
Result: 23 mod 7 = 2
```

## Arithmetic Modulo `N`

Back to modular arithmetic. When doing modular arithmetic we often write things like `m mod n` or `m (mod n)`.  Here `n` is the modulus and `m` is the value we want to look at *modulo n*, i.e. according to its remainder when divided by `n`. We just figured out that `23 mod 7` is `2`.  What about `15 mod 7`? That's `1`. How about `5 mod 7`? Turns out that's `5`; it's all remainder!  Now what about `42 mod 7`? Well, `6*7=42` is a multiple of 7. It will have no remainder, so `42 mod 7` is 0.

What we gain here is a mathematically consistent system of numbers and arithmetic that can start with all the integers, but will ultimately get reduced down to the range `0` to `n-1`. That ends up being very useful.

For our purposes, arithmetic means addition (`a+b`), multiplication (`a*b`), and exponentiation (`a^b`). Doing arithmetic "modulo n" effectively means, "do the arithmetic, then reduce the result to its residue modulo n". For example, `(5*4) mod 7 = 20 mod 7 = 6`, `(18 + 14) mod 7 = 32 mod 7 = 4`, and `(2^5) mod 7 = 32 mod 7 = 4`. We'll not cover it in detail here, but it turns out that you can do the "reduction" prior to arithmetic as well. That is to say, `(a+b) mod n = ((a mod n) + (b mod n)) mod n` and `(a*b) mod n = ((a mod n)*(b mod n)) mod n`.  The leftmost `mod n` can be viewed as one last reduction for when the result of the arithmetic exceeds the modulus.

Exponentiation, being repeated multiplication, can get simplified.  Notice (`2^5 = 2*2*2*2*2`), and so `(2^5) mod 7 = ((2 mod 7) * ((2^4) mod 7)) mod 7`.  If you continue to "unwind" the exponentiation, you can find a way to do the arithmetic modulo 7 without actually needing to compute the full `(2^5)`. These kinds of reductions might seem like extra work, but the cryptography we're about to learn uses *very large* numbers. The reductions help to reduce the computational time and space needed to do the arithmetic when compared to the direct route.

# Prime Numbers

Primes are going to come up a lot. Recall that a **prime number** is a number that is only divisible by itself and `1`.  The first few primes are 2, 3, 5, 7, 11, 13, 17, 19, 23, and 29.  Primes are *really cool*.

Did you know that:
* Every positive integer greater than `1` is a product of primes. For this reason non-prime numbers are called **composite numbers**; they are composed of primes. Primes are like numerical atoms. They can be viewed as the building blocks of numbers.
* When doing modular arithmetic with a prime modulus, some really nice things happen. For example, for any `a<n`, `(a^n) mod n = a` if `n` is prime. This is known as *Fermat's Little Theorem*. A lot more can be said here, but for now, just know that these "nice things" that happen when your modulus is prime lend themselves to good cryptographic tools.

Primes aren't just a cool idea. They have provided information security for decades.


# Hashing

A **hash function** takes an arbitrarily long number (think binary encoding of data) and **maps** it to another fixed-length number. For example, a hash function might associate all chunks of data with a 25 digit number.

Good hash functions have the following properties:
* *Hash values are **deterministic*** - A specific input will always produce the exact same output. This is why we can use them as a *digest* or a *fingerprint*.
* *Hash functions scatter similarly valued inputs* - Similar inputs will not necessarily have similar outputs. To the outside observer, the mapping of values to their hashes should seem random.
* *Hash values should be unique* - No two inputs that you hash *in practice* should have the same hash value. In a perfect world, no two inputs have the same hash value, ever. Like fingerprints.
* *Hash functions are **one-way functions*** - It is easy enough to compute a hash value, but it should be prohibitively difficult to compute the inverse of a hash value. Hash functions are effectively a one-way encoding. You can easily compute a hash value, but cannot "decode" the hash to retrieve the original data.

The second to last criterion is impossible to achieve perfectly; there are usually way more possible inputs than there are outputs.  When two inputs have the same hash value, it's called a **collision**. Well designed hash functions, especially those used for cryptographic purposes, have a very, very low rate of collision.

The cryptographic appeal of hashing is the idea that the hash of the binary encoding of some data acts as a (mostly) unique fingerprint and the one-way nature of the hash function makes forging fingerprints difficult. Hashing also has important uses in computing beyond cryptography. We're going to explore a way to hash. It's not particularly well suited to cryptography, but it does get the idea across.


## A Hash Function for ASCII Data

Let's say we want to hash any sequence of ASCII characters to a 2 Byte hash value. (Notice we can play the encoding game, view any sequence of bytes as ASCII data, and use this hash function to hash *anything*). What this gives us is a 16 bit fingerprint for arbitrarily large byte sequences.  Mathematically, we're just mapping all the positive integers to a number from 0 to `2^16-1 = 65535`.  Here's how we can design a hash function:

1. Select a *prime number* `P` that is as close to 65535 (maximum value for our desired hash value size) but does not exceed `65535`. In this case we'd use `65521`. This will be our *modulus*.
2. Now, select two more primes, `v` and `w`, each less than `P`.  Let's use `17` and `67`.

We can now compute our hash value `h` going character by character, as follows:
1. Start with `h=v`
2. For each ASCII letter,
   * get the numerical value of the letter, `n`,
   * compute an updated `h` value as `((h*w + n)*n) mod P`
When you run out of characters, then `h` is your hash value.

Let's try it.

### An Example

Say you want to hash `HasH` using the hash function described above. First, we can look up the ASCII values for `H`, `a`, and `s`, which are `72`, `97`, and  `115`.  Now, we hash...

```
h = 17
Update for H: ((17*67 +72)*72) mod 65521
   (87192) mod 65521 = 21671
h = 21671
Update for a: ((21671*67 + 97)*97) mod 65521
    (140849238) mod 65521 = 44609
h = 44609
Update for s: ((44609*67 + 115)*115) mod 65521
   (343725570) mod 65521 = 2404
h =2404
Update for H: ((2404*67 + 72)*72) mod 65521
   (11602080) mod 65521 =  4863
DONE
h = 4863
```
So, `HasH` will hash to 4863 with our hash function.


# Public-Key Cryptography - **RSA**

Recall that public-key cryptography uses one public (not secret) key along with a private (secret) key.  The RSA algorithm was the first public-key system discovered that allowed for encryption and digital signatures. There is some nuance to using it in practice, but we can get a good feel for it, and a proof of concept, using small, insecure numbers. Currently, the only version of RSA that is deemed safe to use for cryptography uses 2048 bits.

## Computing the Keys

To compute the keys we start with, you guessed it, prime numbers. Specifically, we need two primes, `p` and `q`. From them we can compute our, you guessed it, *modulus* `n=p*q`. In addition to `n`, we need another value that is derived from `p` and `q`, called *Euler's Totient*. Don't let the name intimidate you, it's just `(p-1)*(q-1)`.


1. Choose primes `p` and `q`. Let `n=p*q`.
2. Compute the Euler Totient `t=(p-1)(q-1)`.

Now we choose an *encryption index* `e`.  In practice, `e` must be **coprime** to `t`. That means their only common divisor is `1`.  If `e` is prime and is not a prime factor of `t`, then this is true. Some composite values can work as well. To keep things simple, we'll use prime numbers for `e`.

3. Choose a prime number `e < t` (or at least `e` coprime to `t`).

Next we need to find a *decryption index* `d` that is based on `e`.  More specifically, we need a `d` such that `e*d (mod t) = 1`. This makes `d` the modular multiplicative inverse of `e` modulo `t`. This step is the tricky part. When you're using small values, like we will, you can just trial-and-error your way to it.

4. Find `d` such that `e*d (mod t) = 1`, i.e. `d` is the multiplicative inverse of `e` modulo `t`.

We now have the keys.  The pair `(e,n)` is the first key and the pair `(d,n)` is the second key. You can pick one to be your public key and keep the other as the private key.

5. Key 1 is `(e,n)`. Key 2 is `(d,n)`.

## Encoding and Decoding

Finally, to encode we use, you guessed it, modular arithmetic.

**Encoding plaintext message M to ciphertext message C**
```
C=M^e (mod n)
```
**Decode ciphertext message C to plaintext message M**
```
M = C^d (mod n)
```

### `p`, `q` and Encryption Size Limits

The modulus `n=p*q` determines the size limits for using RSA.  Doing operations modulo `n` produces values from 0 to `(n-1)`.  If we're talking about data encoded as numbers rather than just abstract numbers, then we care about *the number of digits/bits used to express (n-1)*.  That determines the size of the data that we can encrypt/decrypt with RSA.  We'll forgo the math for now, but the number of base 10 digits needed to represent `n-1` is roughly `log(n)` (logarithm base 10). Similarly, the number of bits is `log_2(n)`, that's the logarithm base 2.

We don't select `n` directly, we pick `p` and `q`. If `p` and `q` are each `N` bits (or digits), then we can expect `n=p*q` to be about `2*N` digits/bits.  In general, the length of `p*q` will be roughly the length of `p` plus the length of `q`.  The current standard for RSA is *RSA-2048*. It uses a 2048 bit modulus. That means you need two prime numbers represented as roughly 1024 bit numbers. In base 10 we're talking about prime numbers around `2^(1024)`, that's on the order of `10^(308)`.  For context, scientists estimate that there are around `10^(78)` to `10^(82)` atoms in the observable universe.

### Brute-Force Cracking RSA

Assume the public key is `(e,n)`.  If you want to use brute-force mathematics to unlock an RSA message, then you need to find the private key `(d,n)` and you already know `n`. The way to find `d` is to recover the primes `p` and `q`. If you do that, then you can find `d` as easily as the person that originally computed the public-private key pairs. This means breaking RSA means *finding the prime factors of `n`*.  This is the **prime factorization problem**.

It turns out that we don't have an efficient means of finding prime factors using current computers. We can do a little better than guessing and checking, but not by much. This is what has made RSA secure: solving prime factorization is hard.  We don't yet know if there is a clever trick out there waiting to be discovered. We just know that if such a trick exists, then we haven't found it.  However, in 1994, *Peter Shor* discovered an efficient algorithm for prime factoring that required a then theoretical computer based on quantum mechanics, a **Quantum Computer**.  Now in 2026, scientists and engineers are on the verge of building a quantum computer that is capable of running Shor's Algorithm.  As a result, most cryptographic systems have moved away from RSA and use other algorithms based on different hard math problems.  These new standards are known as **Post-Quantum Cryptography**.

## RSA Example

Ok, let's do this.  Let's go extra, extra small scale here. Imagine we only want to encrypt small values, less than 65.

1. Select `p=13` and `q=5`. This yields `n=65`.
2. Compute `t=12*4=48`
3. Select `e = 11`  (any prime less than `t` that is not a factor of `t=48` will do)
4. Find `d`, where `e*d mod 48 = 1`. Turns out it's `35`. You can guess and check numbers less than 48, but you can also ask AI.
5. Public Key: `(11,65)`.  Private Key: `(35,65)`

Now, let's encrypt the number `8`.  First we'll do encryption with public and decryption with private. Again, the numbers get big if you do the direct method for doing modular arithmetic, so feel free to ask AI for help. Just be sure to verify what it tells you!

Encrypt:
```
C = (8^11) mod 65 = 57
```
Decrypt:
```
M = (57^35) mod 65 = 8 (as expected)
```

You can go the other way as well:
Encrypt:
```
C = (8^35) mod 65 = 57
```
Decrypt:
```
M = (57^11) mod 65 = 8
```
The fact that we got `57` as the ciphertext in both directions is a coincidence. Try this again with `M=2` and you'll see encryption/decryption in both directions still works as expected but without resulting in the same ciphertext in both cases.

## RSA - Secure Communications

RSA is not typically used for encryption due to the computational overhead. You can, however, use it as a means of keeping a message hidden. Assume Alice wishes to send plaintext `P` to Bob.

1. Alice asks Bob for his public key or gets it from an online listing.
2. Alice encrypts `P` with Bob's public key and gets ciphertext `C`.
3. Alice sends `C` to Bob. Bob receives `C`.
4. Bob decrypts `C` using his private key and retrieves plaintext message `P`.

## RSA - Digital Signature

RSA is more likely to be used for digital signatures than it is encryption.  This more or less comes down to doing the opposite of what you'd do for encryption. Let's say Bob has some contract `P` and wants Alice to sign it as part of an agreement.

1. Alice and Bob agree on a hash function `h`.
2. Alice computes the hash value of `P`, `h(P)`.
3. Alice encrypts `h(P)` with her *private* key. The resultant ciphertext `C = h(P)^d mod n` is the *signature*.
4. Bob uses Alice's public key to decrypt the encrypted `C` and retrieves `h(P)`. He computes his own hash of `P`. If it matches the just decrypted `h(P)`, then:
   * If Bob trusts the quality of the hash function, then Alice had `P` and hashed it.
   * Because Bob decrypted `C` with Alice's public key, then she must have encrypted it with her private key.

Dedicated digital-signature algorithms exist, but RSA and other public-key cryptographic systems can be combined with cryptographic hash functions to achieve digital signatures as described above.

# Key-Exchange - Diffie-Hellman

The Diffie-Hellman (DH) algorithm pre-dates RSA. It is a public-key cryptography system in that it uses asymmetric secrets. The big difference here is that Diffie-Hellman is used for **key exchange** or **key agreement**. After two parties carry out the Diffie-Hellman algorithm, they will have a shared secret, a key. This is most commonly a key for a *symmetric key* encryption algorithm.

1. Alice selects a prime number `p` and a *generator* `g`. A generator is a value `g<p` whose powers modulo `p` (`g,g^2,g^3,...` mod `p`) produce all the values 1 to `p-1`.  Finding `g` can be tricky. Standard values are often used because they are not secrets. *Share `p` and `g` with Bob*.
2. Simultaneously:
   * Alice selects a private, secret number `a` and computes `A = g^a mod p`. Alice sends `A` to Bob.
   * Bob selects a private, secret number `b` and computes `B = g^b mod p`. Bob sends `B` to Alice.
3. Simultaneously:
   * Alice computes `K = B^a mod p` which is `(g^b mod p)^a mod p = g^(ab) mod p`
   * Bob computes `K = A^b mod p` which is `(g^a mod p)^b mod p = g^(ba) mod p`

Alice and Bob now hold the same secret `K` which is dependent on both `a` and `b`. The fun part is that they *never* had to share `a` or `b` with anyone.

## Sizing up DH

If DH is used to exchange a shared key that is `N` bits or digits long, then we have to choose a prime number `p` that requires the same number of bits/digits or more. This is because, again, the *modulus* determines the range of values (and therefore the size) you get from modular arithmetic.


## Brute-Force Cracking DH

Eve the eavesdropper has access to the public information `p`, `g`, `A`, and `B`.  What she needs is either Alice's secret `a` or Bob's secret `b`. This means solving the **discrete logarithm problem**, which means finding an unknown exponent (`a` and `b`) given the base (`g`) and the target value (`A` and `B` mod `p`).  In this case, she needs to solve `g^a mod p = A` for `a` or `g^b mod p = B` for `b`.

Once again, there is no known efficient method to solve this problem.  For the size of numbers used by DH, it takes too much work. Like *prime factoring*, we don't know if there is a method hidden out there somewhere or if it's just plain hard, and, like *prime factoring*, Shor's algorithm can solve the discrete logarithm problem efficiently on a quantum computer.  The post-quantum cryptography standards have other key-exchange algorithms that rely on a different hard math problem.

## DH Example

Once again, let's keep it small.

1. Choose `p=11` and `g=7`. (`g=7` is a generator modulo `p=11`)
2. Compute `A` and `B`:
   * Alice selects `a=4` and `A = 7^4 mod 11 = 3`
   * Bob selects `b=3` and `B = 7^3 mod 11 = 2`
3. Compute `K`:
   * Alice computes `K = 2^4 mod 11 = 5`
   * Bob computes `K = 3^3 mod 11 = 5`

Alice and Bob now share a secret key `K=5`.

# Glossary

| Term | Definition |
| :--- | :--- |
| **Collision** | An occurrence where two distinct inputs to a hash function produce the exact same hash value. |
| **Composite Number (Composite Numbers)** | A positive integer greater than `1` that is not prime, meaning it is composed of a product of prime numbers. |
| **Coprime** | The relationship between two numbers whose only common divisor is `1` (for example, the encryption index `e` and Euler's Totient `t` in RSA). |
| **Deterministic** | A property of a function (such as a hash function) in which a specific input will always produce the exact same output, allowing the output to serve as a digest or fingerprint. |
| **Discrete Logarithm Problem** | The mathematical problem of finding an unknown exponent (`a` or `b`) given a base (`g`), a modulus (`p`), and the resulting target value (`g^a mod p = A` or `g^b mod p = B`), which forms the security basis for Diffie-Hellman key exchange. |
| **Hash Function** | A deterministic, one-way function that takes an arbitrarily long number (such as the binary encoding of data) and maps it to a fixed-length number that acts as a digest or fingerprint. |
| **Key Agreement** | Another term for key exchange, a cryptographic process (such as Diffie-Hellman) through which two parties establish a shared secret key over an insecure channel without transmitting their private local secrets. |
| **Key Exchange** | A public-key cryptographic protocol (such as Diffie-Hellman) that enables two parties to compute a shared secret key—commonly used for symmetric-key encryption—by exchanging values derived from shared public parameters and their own never-shared private secrets. |
| **Map (Maps)** | To associate or assign input values from one set (such as arbitrarily long numbers) to corresponding output values in another set (such as fixed-length hash values). |
| **Modular Arithmetic** | A mathematically consistent system of whole-number arithmetic (generalizing clock arithmetic) in which numbers and the results of operations (addition, multiplication, and exponentiation) "start over" upon reaching a modulus, reducing all values to the range `0` to `n-1`. |
| **Modulus** | The number (`n`) in modular arithmetic that dictates when values "start over," such that all numbers and arithmetic results modulo `n` are reduced to their remainder when divided by `n` (ranging from `0` to `n-1`). |
| **One-Way Function (One-Way Functions)** | A function (such as a hash function) whose output is easy to compute from an input, but whose inverse is prohibitively difficult to compute—meaning you can easily encode data into a hash value, but cannot "decode" the hash back to the original data. |
| **Post-Quantum Cryptography** | New cryptographic standards and algorithms based on hard mathematical problems other than prime factorization or discrete logarithms, designed to remain secure against quantum computers capable of running Shor's algorithm. |
| **Prime Factorization Problem** | The hard mathematical problem of finding the prime factors (`p` and `q`) of a large composite number (`n = p*q`), upon which the security of RSA relies. |
| **Prime Number** | A positive integer greater than `1` that is only divisible by itself and `1` (e.g., 2, 3, 5, 7, 11, 13), acting as the multiplicative building blocks of all positive integers greater than `1`. |
| **Quantum Computer** | A computer based on the principles of quantum mechanics, capable of running algorithms like Peter Shor's algorithm to efficiently solve prime factorization and the discrete logarithm problem. |
| **Remainder** | The integer amount left over after dividing one integer by another in long division; in modular arithmetic modulo `n`, every number is reduced to its remainder when divided by `n`. |
| **Residue (Residues)** | The remainder of a number when divided by the modulus `n` in modular arithmetic, yielding a value in the range `0` to `n-1`. |
| **RSA** | The first public-key cryptography algorithm discovered that supports both encryption/decryption and digital signatures, based on modular arithmetic and the difficulty of the prime factorization problem. |
