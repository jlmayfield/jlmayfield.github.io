---
layout: page
title: COMP151 - Lab 6 - List & String Problems
permalink: /teaching/COMP152/sp24/labs/lab6
mathjax: true
---

**[Get the Github Classroom Assignment Here](https://classroom.github.com/a/oYlBxCvS)**

### The Lab

The focus of this lab is on functions that produce data structures, namely lists and strings. We'll look specifically at two patterns commonly found when dealing with these kinds of problems. For each problem, you'll be given *Stub definitions* and a single test.  You need to (a) *write 2-3 more tests*, then (b) *complete the full definition*.  If you ask a question about the code but have not written the additional tests, then you'll be required to finish the tests prior to discussing the code. 


#### Map Operations

First we'll do a map-style operation. Maps work by applying some operation to each of the items in a list or sequence. The result is a list/sequence of the same length as the original. As we saw in class, this pattern lends itself to pre-allocation of the list, which will avoid any and all unnecessary copying 


1. Given a list of strings, produce a list of the lengths of each of the strings in the list. Use loops/iteration. 


#### Filter Operations

The second pattern we'll explore happens when you need to either (A) keep every item in a sequence that meets a specific property, or (B) remove every item from a sequence that meets a particular property. This so called "filter" operation is tricky because you do not know how many items are in the result and cannot pre-allocate your sequence to avoid extra copying. Instead, you must use efficient append operations.  When dealing with python strings, the standard practice is to first build a list, then use the string `join` operation, as discussed in 5.4.2, in order to avoid repeated concatenation.

2. Given a string, produce the string containing only the consonants in the original string. (N.B. This is equivalent to removing all the vowels.) Use loops/iteration. *Be sure to use the join method!*

####  A mix of problems. 

Write and test python code for each of the following problems.  *For each problem, identify whether it is a map, a filter, or perhaps a combination of the two.*. 

3. Given a list of numbers and two additional numbers, produce a list containing all the values in the given list that fall between the two numbers. You can assume the two numbers are given in increasing order. For example, given [1,3,5,7,9,11,13] along with 5 and 12, your function should return [7,9,11]. The 5 is excluded as it is not strictly between 5 and 12. 
4. Given a string, produce a list of all the `ord` values of the characters in the string. 
5. Given a list of strings (assume all lower case words), produce a string composed of all the strings from the list that begin with the letters t, a, or o. For example, given ['this','is','a','test'], you function should produce 'thisatest'. 



