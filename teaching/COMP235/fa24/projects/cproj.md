---
layout: page
title: C Programming Project
permalink: /teaching/comp235/fa24/projects/cproj
---

[Github Classroom Assignment for Project](https://classroom.github.com/a/lZ0bcPxB)

To wrap-up our study of C, we'll do a bit of [computational linguistics](https://en.wikipedia.org/wiki/Computational_linguistics) style work in C. While we're at it, we'll dip our toes into file input/output and command-line arguments. 


# Feature Requirements

Your program must:
1. Take, as a command-line argument, the name of a file full of whitespace separated tokens.
2. Read the tokens from the file into a dynamically allocated array whose size is exactly the number of tokens in the file.  
3. Sort the tokens by length
4. Write a file whose name is the same as the token file but with *-report* added (for example if the given file is *tokens.txt* the written file is *tokens-report.txt*). That file should contain the following:
    * Minimum, maximum, mean, and median token length. 
    * Counts for each length of token
5. The written file should have the following format, where the first four lines report the min, max, mean and median, then there's a blank line, then lines for the lengths counts where the length and the count is reported.  The ... in the example below should be the appropriate numbers. 
```
min: ...
max: ...
mean: ...
median: ...

1 ....
2 ...
3 ...
4 ...
  and so on
```

## Program Specifications

To meet the above requirements you must adhere to the following code specifications:

1. Functions should be used as appropriate. When in doubt, write a function. 
2. The size of the array of tokens should be equivalent to the number of tokens in the file. 
3. Use the C `qsort` function to sort. Excellent example [here](https://stackoverflow.com/a/1788048/1042494) and [official documentation and example code here](https://en.cppreference.com/w/c/algorithm/qsort)
4. Use the [C string library](https://diveintosystems.org/book/C2-C_depth/strings.html) as described in the text book.
5. Use [C File I/O](https://diveintosystems.org/book/C2-C_depth/IO.html#_file_inputoutput) as described in the text book. 
6. Manage [C Command-Line Arguments](https://diveintosystems.org/book/C2-C_depth/advanced_cmd_line_args.html#_c_cmd_line_args_) as described in the textbook. 
7. The submitted code should compile and run. If need be, submit an incomplete set of features rather than code that cannot compile or regularly crashes at runtime. 

## Development Advice

*   You've been given token files for testing and development purposes. One is small and easy to check statistics on. The other is larger and meant to test program scaling once you're sure the program is producing correct statistics. *You can and should try the program with a file of your own making to make sure you're not hardcoding things for those two files.*
*   *If you don't close the file, it will not save to the hard drive and you will not see what was written to the file.* So, **don't forget to close files for writing before you end your program.**.
*   Utilize *iterative refinement* and work through small bits of the feature set.  For example, you might work the following series of program iterations:
    1. Write a program that opens the file from the command-line argument then reads and prints the first token.
    2. Now read some (first 5-10) or all of the tokens into a possibly oversized array (static or dynamic). 
    3. Now have the program count and print the number of tokens in the file but don't put them in an array yet.
    4. Now that you can count tokens, read them into an ideally sized, dynamically allocated array. Print some our all of the array to test.
    5. Now sort the array. Print some or all of the array to test. 
    6. Now find the minimum (first in sort), maximum (last in sort), and median (middle in sorted) length. Print the values to test.
    7. Write the min,max,median to a file with the appropriate name. 
    8. Find the mean (average) length, write it to the file. 
    9. Compute the length counts. Print them to test, then write them to the file. 