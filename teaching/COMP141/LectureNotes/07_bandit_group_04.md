---
layout: page
title: COMP141 - Lecture Notes 7 - Data Encoding
permalink: /teaching/COMP141/LectureNotes/06_bandit_group_07/
mathjax: true
---

# *Different Names for the Same Thing* - Codes and Encoding

We've already encountered one of the most critical aspects of computing: **data encoding**. How things are represented and how we move between representations is a pivotal component of most, if not *all*, computing systems. Humanity had devised the ways and means for representing and encoding information long before the dawn of the computer age.  Now that we have a general-purpose information processor, a computer, we need encoding schemes for the machine and the ability to translate between machine encoding and human encoding. Here's what we've seen so far:

*   People encode numbers in decimal (base 10).
*   Computers encode numbers (and everything else...) in binary (base 2).
*   Hexadecimal (base 16) and Octal (base 8) offer a good compromise between binary and decimal.
*   In Linux, user permissions can be encoded in Octal.
*   Cryptographic Ciphers, like the Caesar Cipher, encode plaintext into ciphertext in order to hide information.

In these notes, we'll dive deeper into data encoding and some of its critical applications.

## *The Linux Command Line*

These notes accompany the following sections of the text:
*   All of *Chapter 18*
*   From *Chapter 20*, the sections on *tr*.
See [vocab and commands covered here](/teaching/COMP141/LectureNotes/tlcl_bandit04/)

## Table of Contents

- [Goals](#goals)
- [Objectives](#objectives)
- [Numerical Encoding](#numerical-encoding)
  - [Binary and Hex Recap](#binary-and-hex-recap)
- [Text](#text)
- [Hex Dumps: Seeing the encoding.](#hex-dumps-seeing-the-encoding)
  - [Decoding a Hex Dump](#decoding-a-hex-dump)
- [`base64`](#base64)
  - [The `base64` command](#the-base64-command)
- [Transliteration with `tr` and Classic Cryptography](#transliteration-with-tr-and-classic-cryptography)
  - [Other uses of `tr`](#other-uses-of-tr)
- [Data Compression](#data-compression)
  - [`gzip` and `gunzip`](#gzip-and-gunzip)
  - [`bzip2` and `bunzip2`](#bzip2-and-bunzip2)
  - [Compression in Media](#compression-in-media)
- [Files of Files](#files-of-files)
  - [Tape Archive - `tar`](#tape-archive---tar)
- [Glossary](#glossary)

## Goals

1. Understand the distinction between information and the ways in which it is represented via encoded and decoded
2. Understand the role and use of binary, hex, and base64 encoding schemes for computer data and human interaction with computer data
3. Be familiar with ASCII and Unicode standards for text encoding
4. Understand the usage and interpretation of hex dumps
5. Be familiar with basic principles of cryptography
6. Be familiar with basic ideas and shell commands for data compression and archiving
7. Compare and contrast different information encoding schemes and their goals.

## Objectives

1. Convert to and from hex and binary, by hand.
2. Compare and contrast the ASCII and Unicode text encoding standards.
3. Create, read, and revert hex dumps using `xxd`
4. Encode and decode base64 using the `base64` command.
5. Identify use cases for base64 encoding.
6. Identify standard components of a cryptographic encoding scheme and their respective roles in symmetric key cryptography.
7. Carryout single letter encoding and decoding with `tr`.
8. Archive and compress data with `tar`, `gzip`, or `bzip2` as well as decompress and extract data prepared with those same shell commands.


# Numerical Encoding

It's important to recognize that writing a number in decimal, binary, hex, octal, or any other encoding does not change the number, it only changes how we express that number.  For that matter, decimal `5` and `2+3` both express the same numerical quantity. One is a direct expression of *five*, the other expresses *five* as the sum of two other quantities, *two* and *three*.  By separating the things we want to express from the means of expression, we open ourselves up to the wider world with many, many, interesting ways to say one thing.

## Binary and Hex Recap

We previously looked at the relationship between binary and hex. Let's recap. It'll be important moving forward. Hex is base 16. We use 0-9 to represent the same values they do in decimal. We then use A-F for ten, eleven, twelve, thirteen, fourteen, and fifteen. Because $2^4 = 16$, we get a clear four bits to one hex digit correspondence.

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

Why does this matter? Computers work with binary information. We work with, well, just information. We prefer our numbers in base 10 and 10 is not a power of two.  Hex is a compromise and, when working with binary information, we get a **compression** effect. Every four bits is reduced to a single symbol. However, the compression is only for our benefit. We get to look at one quarter the number of symbols. The computer *must* store data in binary, so if we want to compress something in storage, we need to reduce the number of bits needed to represent the thing, not the number of symbols.

# Text

Computers work with numbers but people most often work with symbolic text. We have languages with which we attempt to express *everything* and have developed written systems to encode and store those expressions. Once we wanted computers to do more than just calculate with numbers, we needed ways to encode the base symbols of our languages into more numerical-like information that the computer could manipulate.

The **American Standard Code for Information Interchange (ASCII)** represents all the symbols needed for American English in 7 bits, which are then readily represented as one 8-bit Byte or two hex digits if you'd like. In effect, ASCII assigns a number to a **character**, a single letter or symbol, and that number is then encoded into whatever base you'd like.  Using 7 bits allows for $2^7 = 128$ possible characters (numbered 0 to 127).  You can see all of them at sites like [https://www.ibm.com/docs/en/aix/7.3.0?topic=adapters-ascii-decimal-hexadecimal-octal-binary-conversion-table](https://www.ibm.com/docs/en/aix/7.3.0?topic=adapters-ascii-decimal-hexadecimal-octal-binary-conversion-table).  Just do a web search for *ASCII Table*, and you'll have more options to choose from than there are characters on the table!

First, turn your attention to 32-126 (aka `0x20` to `0x7E`). These are the **printable characters**, the characters that produce visible output or visible effects to output when they are printed. The remaining characters are **control characters**; they are not printable but are there to control hardware or encode signals used by the computer. If you ever need to express them in text, you have to use backslash, `\`, to escape a printable character and communicate to the computer that you're expressing a control character.  Some highlights from this group are symbol 0, **null**, written as `\0`. Null is used to represent nothing. Characters 10, 12, and 13, **linefeed**, **formfeed**, and **carriage return**, are expressed as `\n`, `\f`, and `\r`.  They are used to express what you typically expect to happen when you press enter while typing text, starting a new line.  One fun quirk of history, in the Unix/Linux/MacOS world, the `\n` linefeed character is used to start a new line. In the Windows world, a combination of `\r\n` is used. If unaccounted for, this can lead to all kinds of bugs and quirks when sharing files between the two operating systems.

Of course, humanity uses more than just English. This makes the ASCII standard not a very inclusive standard. This led to the development of the **Unicode** standard and **UTF-8**. Unicode supports over 1.1 million characters. That, in turn, covers all human languages and leaves room for things like Emojis. The UTF-8 standard uses a variable number of bits (1 to 4 bytes) and can accommodate the ASCII standard using 1 byte per character.

# Hex Dumps: Seeing the encoding.

When you view a human-readable text file with something like `cat` or `less`, it will, in part, **decode** the numerically **encode**d data according to the ASCII or UTF-8 standard. If we want to see the bits, see the numerical encoding, and understand just exactly how that data is laid out byte-by-byte, then we can make a **hex dump** of the file. There are multiple programs that can create and reverse hex dumps, but we'll focus on `xxd`.

Let's pipe some text into `xxd` and see what happens. The `echo` command will just send whatever you give it back to `stdout`. Try this (`-e` will make `echo` interpret `\n` as a new line character):
```bash
echo -e "hello world. hello world\n hello world" | xxd
```

You should be greeted with this:
```
00000000: 6865 6c6c 6f20 776f 726c 642e 2068 656c  hello world. hel
00000010: 6c6f 2077 6f72 6c64 0a20 6865 6c6c 6f20  lo world. hello
00000020: 776f 726c 640a                           world.
```

The output of `xxd` has three columns to it. The first, the column that starts with `00000000:` is the address, expressed in *hexadecimal*, of the first byte of the line. The next column, which starts with `6865 6c6c 6f20 776f 726c 642e 2068 656c` contains the bytes, again, in *hexadecimal*.  They are grouped into four hex digits, which equates to *two bytes*, one byte per pair of hex digits. Notice there are *16* bytes on line one and the value in column one, row two is `00000010:`, which is 16 in hex!  The last column is the source text, aligned with the lines.  *That middle column is the machine encoding, expressed in hex, of the text shown in the last column.*

## Decoding a Hex Dump

If you have a hex dump, you can use the `-r` option to reverse it.  If you want to do a quick check of this, then you can do a there-and-back, encode-decode pipeline:

```bash
echo "Hello!" | xxd | xxd -r
```

In practice, you're not likely to do this, but you might have a hex dump in a file. In that case, reversing the dump can reconstruct the original file.

# `base64`

Much of the core web and internet standards assumed the 7-bit ASCII standard, transmitted in Bytes.  As new standards and new encodings were developed, a way was needed to encode data from expanded standards into something based on the ASCII standard. Enter `base64`.

If we want the same kind of relationship that binary and hex share, then we need a numerical encoding system whose base is a power of two.  Recall that ASCII has 95 printable characters.  The largest power of two that this accommodates is 64, and so we can build a base 64 system out of 64 printable, ASCII characters.  The standard uses `A-Z`, `a-z`, `0-9`, `+` and `/`.  The last two are sometimes replaced with `-` and `_` to avoid the need for escape characters.  A `=` is used to indicate padding.

For humans that need to look at binary data, base64 is not a good replacement for hex because it does not align well with bytes. Every two hex digits is one byte. Every base64 digit is 0.75 bytes. Alignment on a byte doesn't happen until 4 base64 digits (24 bits) which is three bytes. That's a very awkward alignment pattern and would take a lot of effort to unwind when compared to hex.

For the machine, we once again do not achieve any kind of compression and in fact will increase the number of bits needed for the information. The base64 encoding **algorithm**, the steps taken to carry out a task or solve a problem, also has to deal with the odd alignment of base 64 to bytes. Computers will only read and write data along byte-aligned boundaries. To encode, you'll typically take 24 bits (3 Bytes) of data at a time, break that into four 6-bit chunks, and encode that into base64 digits. In the end, a single base64 digit is represented with an ASCII character, which will require 1 byte. That's 8 bits to represent 6 bits.  That's a 33% increase in bits.

Using base64 encoding, binary data *of any kind* can be encoded with standard ASCII characters. That makes it an incredibly useful connective glue between systems that use different encoding standards. That's the win here.

## The `base64` command

Your shell has a base64 encoder that can also decode.  Run `man base64` to see the manual. It works as you should expect.

For a fun test-run, try:
```bash
echo 'hello world! this is a test!' | base64
```

You'll be greeted with:
```
aGVsbG8gd29ybGQhIHRoaXMgaXMgYSB0ZXN0IQo=
```
Notice the padding (`=`) at the end? The encoded data was 39 base64 digits long, that's 234 bits, and that's *not* a multiple of 8. We need the next common multiple of 6 and 8, which is 240. A sequence of 240 bits encodes to 30 bytes and 40 base64 digits.

To decode, you can use the `-d` option:

```bash
echo "aGVsbG8gd29ybGQhIHRoaXMgaXMgYSB0ZXN0IQo=" | base64 -d
```
Which will give you back the original text.


# Transliteration with `tr` and Classic Cryptography

So far we've largely looked at encoding schemes for text to binary and binary to text. Humanity has a rich, long history of devising schemes for replacing text with other text. Prior to the computing era, **cryptography** was in large part based on replacing letters for different letters in order to hide the information content of a message. The encoding and decoding algorithms used in cryptography are called **ciphers**.  The message that you're trying to hide is called the **plaintext** and the message you get when you encode the plaintext with your cipher is called the **ciphertext**. Ciphers usually provide general rules for encoding that are made concrete with the addition of a secret **key**.  Prior to the computing era, ciphers used what is now known as a **symmetric key**. This means the encoder and decoder share the same key.  (We now have **asymmetric key** ciphers where encoder and decoder use different keys.)  Putting this all together, the encoder will use the plaintext and the key to create the ciphertext. The decoder can then use the ciphertext and the key to reconstruct the plaintext. The inclusion of a key and the goal of secrecy is really what differentiates cryptographic encoding schemes from the kinds of encoding we've looked at thus far.

The simplest form of cipher is the one used by the Caesar shift. In it, you replace one letter for a different letter. The **key** for this cipher is a **mapping** from plaintext letters to ciphertext letters, i.e. a one-to-one assignment of plaintext letters to their associated letter in the ciphertext.  Caesar devised a system to generate keys by starting with two aligned alphabets and then shifting one. This makes managing your key easy, but means that with only 25 possible keys, a persistent eavesdropper can brute-force decode your ciphertext by trying all possible keys. In general, you can choose any kind of assignment of letters to letters that you want.  This opens up the space of possible keys to something on the order of $10^{26}$ (that's septillion).  That's a lot for people and computers. Unfortunately, letter-to-letter substitution doesn't hide the language statistics in the message. As a result, that eavesdropper can still decode the message with a relatively small amount of effort.

Modern cryptography has moved on quite a bit from letter-based substitution, but the *transliterate* command, `tr`, covered in chapter 20 of the text, does let you play around with and carry out some classic ciphers.  Assuming your plaintext is only letters and that all the letters are lower-case, you can use the `tr` command. The `tr` command takes input from `stdin` and writes it to `stdout`. So, if you want to work through files, then you'll need to use the file-to-stdin redirect `<` and a stdout-to-file redirect `>` to read your plaintext to stdin then write it to a file.

```bash
tr 'a-z' 'CIPHERLETTERS...' < PATH/TO/file.txt > PATH/TO/ciphertext.txt
```

Here `CIPHERLETTERS...` is some arrangement of A to Z. The combination of the letter range `a-z` plus your `CIPHERLETTERS...` is the key, and the `tr` command performs the letter substitutions.  Your plaintext is in the file `file.txt`, which is in `PATH/TO/`.  The `<` redirect reads your plaintext to `stdin`, which is read by `tr`. The result is then sent to `stdout`, which is redirected by `>` to the file `ciphertext.txt`, which is in `PATH/TO`.

## Other uses of `tr`

As the text points out, `tr` can be useful for more than playing around with cryptography. The `-s` option will *squeeze* text and get rid of repeated letters.  You can also use it to clean up text.

Make all lowercase letters uppercase,
```bash
tr 'a-z' 'A-Z'
```

Use `-d` (*delete*) to remove all spaces:
```bash
tr -d ' '
```

Replace the newline `\n` with a space to remove line breaks.
```bash
tr '\n' ' '
```

Get rid of `\r` in a Windows file to get standard `\n` Unix/Mac line endings:
```bash
tr -d '\r'
```

The list goes on. The point is that `tr` is a really great, fast tool for cleaning up text.


# Data Compression

The compression we've seen so far isn't true data compression, i.e. a reduction in the number of bits needed to represent and store something in a computer, but compression of information at the symbolic level, i.e. a reduction in the number of symbols needed to represent something in human-readable text. There are lots of compression algorithms out there because with high compression comes a high cost of encoding and decoding. Different algorithms make different decisions about the **time-space trade-off** of compression, between time to encode and decode and space saved.

Chapter 18 of your text covers the standard data compression programs at the shell.  *I'll let it do most of the talking here, so you should definitely read it now.* What I want to do is quickly highlight the commands and options.

## `gzip` and `gunzip`

The `gzip` command will compress a single file and produce a `.gz` file. You can reverse this process with `gunzip` or `gzip -d`. The key observation here is that `gzip` only works on a single file.

## `bzip2` and `bunzip2`

The `bzip2` command uses a different compression algorithm, a different encoding. It creates a file with the `.bz2` extension.  The `bunzip2` command will decompress the file. Like `gzip`, it can only compress a single file.

## Compression in Media

When compressing most files we need the result of decompression (decoding) to be a perfect reconstruction of the original file. This means that nothing can be lost by compression (encoding) nor by decompression. This is called **lossless compression**.

It turns out that sometimes, we actually can sacrifice some information.  By sacrificing data, we can achieve even greater compression.  The classic examples of this occur in our media: images and audio.  The classic encoding scheme for audio is Waveform Audio File Format (wav). Think of this a bit like ASCII for audio. For images we have the Bitmap Image File (bmp).  These formats are uncompressed and are designed to solve the problem of accurately encoding audio and images. You're more likely to have encountered them if you're producing and editing audio or images. They typically result in large files and as a result are not ideal.

In modern computing we have an array of **lossless compression** algorithms that can replace the legacy formats. Furthermore, we have several **lossy compression** algorithms that can achieve higher compression, often by sacrificing sounds and colors that our ears and eyes cannot distinguish. Below are a few highlights from the audio and image realm.

| Algorithm (file extension) | Media Type | Lossy or Lossless |
| :--- | :--- | :--- |
| wav | audio | uncompressed |
| flac | audio | lossless |
| alac | audio | lossless |
| aac | audio | lossy |
| mp3 | audio | lossy |
| vorbis | audio | lossy |
| bmp | image | uncompressed |
| png | image | lossless |
| gif | image | lossless (up to 256 colors) |
| jpg/jpeg | image | lossy |


# Files of Files

Up to this point we've had files, which contain the data, and directories, which contain the files. This works well until we need to archive or transmit multiple files. At that point, we need a type of file encoding that lets us encode multiple files into a single file, then decode that file back to the collection of files.  Combine this with data compression and we got something really great going!

## Tape Archive - `tar`

Sometimes you just want the digital equivalent of stapling a bunch of files together or throwing a binder clip on a big stack of documents.  This is *archiving*, and the shell program to carry this out, `tar`, is also covered in chapter 18. The `tar` command is so classic that its name, shorthand for *tape archive*, refers to early storage tapes used for data archiving.

The quintessential use of tar is to archive multiple files into a single file, then use `gzip` or `bzip2` to compress the archive.  For this reason you see a lot of `.tar.gz` and `.tar.bz2` files.

The chapter covers `tar`, but I want to highlight that its usage is a bit different than most commands: the options do not require a `-`.  The book doesn't use the `-`, but you can if you want. The book explains all the things. I'll list the most common command patterns without explanation:

Make archive `myarchive.tar` from file/directory `archiveme`:
```bash
tar cf myarchive.tar archiveme
```

View contents of archive:
```bash
tar tf myarchive.tar
```

Extract archive:
```bash
tar xf myarchive.tar
```

# Glossary


| Term | Definition |
| :--- | :--- |
| **Algorithm** | The steps taken to carry out a task or solve a problem (such as encoding, decoding, or compressing data). |
| **American Standard Code for Information Interchange (ASCII)** | A text encoding standard that represents all the symbols needed for American English in 7 bits (128 possible characters numbered 0 to 127), readily stored as one 8-bit byte or two hex digits. |
| **Asymmetric Key** | A cryptographic cipher system in which the encoder and decoder use different keys. |
| **Carriage Return (`\r`)** | ASCII control character 13 (`\r`), used in combination with linefeed (`\r\n`) in the Windows world to start a new line when typing text. |
| **Character** | A single letter or symbol assigned a numerical value by a text encoding standard such as ASCII or Unicode. |
| **Cipher (Ciphers)** | The encoding and decoding algorithms used in cryptography to hide the information content of a message. |
| **Ciphertext** | The encoded message produced when plaintext is encoded using a cipher and a key. |
| **Compression** | A reduction in the representation of information—either at the symbolic level for human benefit (reducing the number of symbols, such as four binary bits to one hex digit) or true data compression in computer storage (reducing the number of bits needed to store data). |
| **Control Characters** | Non-printable characters in an encoding standard (such as ASCII characters outside 32–126) used to control hardware or encode signals used by the computer; expressed in text using a backslash (`\`) escape sequence. |
| **Cryptography** | The practice and study of schemes for encoding messages (such as replacing letters for different letters) in order to hide their information content and maintain secrecy. |
| **Data Encoding** | How information is represented and how we move (translate) between representations, such as between human encodings and machine binary encodings. |
| **Decode** | To translate encoded data (such as numerically encoded binary, hex dumps, base64, or ciphertext) back into its original or human-readable representation. |
| **Encode** | To convert information or data from one representation into another according to a specific scheme, standard, or cipher. |
| **Formfeed (`\f`)** | ASCII control character 12 (`\f`), one of the control characters used to control text layout and page/line breaks. |
| **Hex Dump** | A byte-by-byte hexadecimal view of a file's numerical machine encoding (created and reversed with tools like `xxd`), typically displaying the hexadecimal byte address, pairs of hex digits representing bytes, and the corresponding source text. |
| **Key** | Secret information combined with a cipher's general encoding rules to encode plaintext into ciphertext and decode ciphertext back into plaintext. |
| **Linefeed (`\n`)** | ASCII control character 10 (`\n`), used in Unix/Linux/macOS systems (and with `\r` in Windows) to start a new line of text. |
| **Lossless Compression** | Data compression in which nothing is lost during encoding or decoding, ensuring that decompression produces a perfect reconstruction of the original file (e.g., `gzip`, `bzip2`, `flac`, `png`). |
| **Lossy Compression** | Data compression that sacrifices some information (such as sounds or colors that human ears and eyes cannot distinguish) to achieve greater compression ratios (e.g., `mp3`, `aac`, `jpg`/`jpeg`). |
| **Mapping** | A one-to-one assignment of elements from one set to another, such as assigning plaintext letters to their associated ciphertext letters in a substitution cipher. |
| **Null (`\0`)** | ASCII control character 0 (`\0`), used in computing to represent nothing. |
| **Plaintext** | The original, unencoded message that you are trying to hide using a cryptographic cipher. |
| **Printable Characters** | Characters in an encoding standard (such as ASCII 32–126, or `0x20` to `0x7E`) that produce visible output or visible effects when printed. |
| **Symmetric Key** | A cryptographic key scheme in which both the encoder and the decoder share and use the same secret key. |
| **Time-Space Trade-off** | The balance in compression algorithms between the computational time required to encode and decode data and the storage space saved. |
| **Unicode** | An inclusive character encoding standard supporting over 1.1 million characters, covering all human languages as well as symbols like emojis. |
| **UTF-8** | A variable-length character encoding for Unicode that uses 1 to 4 bytes per character and accommodates the standard ASCII character set using 1 byte per character. |


