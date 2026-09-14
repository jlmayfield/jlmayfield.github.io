---
layout: page
title: COMP141 - Lab 2 - You're a Codebreaker, Harry!
permalink: /teaching/COMP141/Assignments/02_lab2/
mathjax: True
---


# Lab 2 - You're a Codebreaker, Harry!

In this lab, we'll explore some of the basic principles of cryptography by looking at and using historical cryptographic algorithms. Below, you'll first find some background on cryptography and the algorithms and systems in use for today's lab. Following that are the actual tasks for today. You'll be put into teams. When the time comes to break codes, work together!

# Algorithms for Encryption and Decryption

The bedrock of cryptography is **algorithms** for **encrypting** and **decrypting** messages. An algorithm is a step-by-step set of instructions for completing a specific task or solving a specific problem. In this case, the tasks are *encryption*, which converts readable *plaintext* messages into seemingly gibberish-looking *ciphertext* messages, and *decryption*, which does the reverse of encryption. Of course, the trick is that we don't want true gibberish; we want something that looks like gibberish unless you're "in the know."

## Caesar Shift

The [Caesar Cipher](https://en.wikipedia.org/wiki/Caesar_cipher) is a literal classic in the cryptography world. The idea is simple.

*   Imagine you've lined up the alphabet with another copy of itself below it. Now, shift the bottom (or top) alphabet so that the letters no longer line up with themselves. This is your **key**. It tells you how to create and unlock the gibberish. To simplify matters, the *key* can simply be the number of places the bottom sequence was shifted. For example, shifting the bottom alphabet 4 places puts the A under the E.
*   To encrypt, we *substitute* each letter in the plaintext message from the first row with the letter below it in the second row.
*   To decrypt, we do the opposite. Substitute each ciphertext letter from the bottom row with the letter above it.


### The Problem with Caesar

There are only 25 possible Caesar shift keys. Even for people, that can be relatively easily brute-forced by trying all the possible keys. What makes it worse is that you really only need to be certain about one or two letter substitutions; then the remainder of the key and the decryption will follow. To fix this problem, you need an unpredictable key.

## Monoalphabetic Uniliteral Substitution

The Caesar shift is a specific form of a *monoalphabetic uniliteral substitution cipher*.  Monoalphabetic means there is just one alphabet (key) at work. Uniliteral here means we are working with one literal (letter) at a time.  Altogether, it is a system for encryption (cipher) where one letter at a time is substituted with another letter according to a single alphabet.

In this more general cipher, we can choose any random assortment of the alphabet as our substitution sequence. To set up your encryption key, just place a random ordering of the alphabet below the ordered alphabet. That's it. This random order means there are now about $$4 \times 10^{26}$$ possible keys. That is much harder to brute-force! The tradeoff is that random keys are a lot harder to remember than a single shift number. So, using this system is harder in practice than the Caesar shift.

### Frequency Analysis Attack

When attempting to crack a monoalphabetic uniliteral substitution cipher, one can make a great deal of headway by observing that *all the statistics of English (or the plaintext language) still exist in the ciphertext; they have just shifted to different letters!*  Attackers often count the frequency of individual letters and adjacent pairs of letters, compare these to [single and double letter frequencies in English](https://www.norvig.com/mayzner.html), and begin to unravel the puzzle.

The weakness of the Caesar shift is the regular structure of the key. The weakness of monoalphabetic uniliteral substitution generally is the *regular structures of English and the languages people use to communicate.*


# Cryptosystems

The encryption and decryption algorithms are just part of a complete **cryptosystem**.  In total, we need (at least):
*   A process for generating, exchanging, and managing keys.
*   Agreed-upon procedures for preparing and managing plaintext and ciphertext messages.
*   Encryption and decryption algorithms.

The worst thing one can do is continue to reuse a key. If a key gets compromised, then you might as well just communicate in plaintext. The key management procedures determine when and how keys are updated, rotated, and exchanged safely.

It's usually necessary to process and clean the plaintext to obscure word boundaries and convert any letters not in the key sequence to letters in the key sequence (think 10 to ten). Then, after encryption, you can spread the ciphertext out into regular blocks to hide words even more. The person doing the decryption will need to work around this and undo it as they decrypt.

## The Ultimate Goal of an Attacker

An *attacker*, someone who wants to break a cryptosystem and read all the secret messages, isn't just interested in figuring out the contents of a single message; they want to know everything about the system so that they can read *every message* sent using that system.

## An Example Cryptosystem

Let's say two parties, Alice and Bob, wish to communicate using a monoalphabetic uniliteral cipher. They might do the following:

1. Agree on a special keyword, like CRYPT.  The letters of this word determine a shift amount for a Caesar cipher based on their order in the alphabet. In this case: 2, 17, 24, 15, 19.
2. The first message sender begins with key 2, and the receiver responds with key 2. The next round of communication uses 17, and so on, starting over at 2 as needed.
3. All plaintext messages are stripped of spaces and punctuation. Numbers and dates are replaced with spelled-out equivalents. The end result is a single-line stream of letters.
4. After encryption, the ciphertext is split into blocks of five letters before being sent on.

### An Example Attack

Now let's say Eve wishes to eavesdrop on Alice and Bob and is able to intercept and copy every message sent. She doesn't stop them; she just gets copies. This is known as a *ciphertext-only* attack because all the adversary has is the ciphertext, the encrypted messages. What can Eve do?

* Eve gets the first message. On a hunch, Eve starts checking some Caesar shift keys. She gets lucky, and key 2 seems to work on the first message.
* Upon receiving the reply to the first message, she quickly tries key 2. It works!
* A new message arrives. Key 2 no longer works. She sticks with Caesar and eventually unlocks key 17.  This also works for the reply. Maybe they're rotating keys?
* As new messages come in, Eve retries old keys. Eventually, messages with key 2 show up again, then 17, and so on. The sequence is repeating.  She's got 'em now!
* Eve happily reads all their messages. She eventually wonders if the key sequence isn't a keyword. She's heard of that system. Turns out it's CRYPT.  If ever they change the keyword, she'll start over again, but will start trying to deduce the new keyword sooner. Maybe she can even break it before they complete a sequence!  What if next they use GRPHY for cryptography?

As you can see, in this scenario, Eve has completely compromised the communication between Alice and Bob. They think they're communicating in secret, but they are not.

# Lab Tasks

Okay, let's get our hands dirty. Remember, work with your team! Discuss as you go.

## Encrypt and Decrypt

First, you'll play the role of the communicators, Alice and Bob.

1. Agree on a key with your team. Record the key on an [encryption worksheet](/teaching/COMP141/Assignments/lab2/caesar_encryption.pdf).
2. Encrypt *short* messages to each other. Record your work on the worksheet.
3. Reorient your key for decryption. Record it on a [decryption worksheet](/teaching/COMP141/Assignments/lab2/caesar_decryption.pdf). Decrypt one of your teammates' messages. Record your work on your decryption worksheet.

Now that you've done some basic encryption and decryption, let's put our attacker hats on.

## Puzzle Progression

Now you'll play Eve and try to decrypt some messages. A successful decryption recovers the full plaintext *and* the key.

We'll start with simple cryptogram puzzles that leak a lot of information through punctuation and word length.

1. Decipher cryptogram [puzzle 0002](/teaching/COMP141/Assignments/lab2/worksheet_0002.pdf). It was created with a Caesar shift.
2. Decipher cryptogram [puzzle 0003](/teaching/COMP141/Assignments/lab2/worksheet_0003.pdf). It was created with a random key. Word lengths and sentence structure let you do this without doing a frequency analysis. Work as a team!
3. Decipher the advanced cryptogram [puzzle 0006](/teaching/COMP141/Assignments/lab2/worksheet_0006.pdf). This was created with a Caesar shift. Maybe your team can work together to brute-force it?
4. Decipher the advanced cryptogram [puzzle 0007](/teaching/COMP141/Assignments/lab2/worksheet_0007.pdf). This was created with a random key. Your team will need to get *very* lucky or start counting and see if counting letters helps. [Worksheets for frequency analysis](/teaching/COMP141/Assignments/lab2/uniliteral_frequency_analysis.pdf) are available.

The major theme here is that any predictable, regular structure in the system is a potential sign of weakness. More advanced algorithms and systems work hard to remove regularity and produce ciphertext that appears to be truly random.


# Optional Challenge - A Cryptosystem

Looking for a challenge? Want to decipher a lot of messages? Want to see a story unfold before you as you crack the code?

1. Tackle a full [cryptographic scenario](/teaching/COMP141/Assignments/lab2/solver_packet_0004.pdf) like the one described above. Alice and Bob used a keyword and Caesar shifts to protect their messages. Can you find out what they're talking about and break their system?
