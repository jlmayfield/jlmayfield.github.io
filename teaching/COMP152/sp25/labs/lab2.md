---
layout: page
title: COMP151 - Lab 2
permalink: /teaching/COMP152/sp25/labs/lab2/
---

[Github Classroom Assignment](https://classroom.github.com/a/oTKsdxV7)


##  More Iteration Patterns and Python's Data Structures

The following problems will force you to explore some iteration patterns that involve nested loops and will ask you to use some non-list python data structures.  

1. Design and implement a function that takes a string and returns that string with all punctuation removed. **Do not use repeated concatenation (+ operator)**. *Use lists and the str join method instead*. **Cool points bonus if you can do this as a one-liner with a list comprehension**. 
2. Design and implement a function that takes a list of [Any](https://docs.python.org/3/library/typing.html#the-any-type) and returns the full *cartesian product* of the list with itself as a List of Tuples (of Any). The cartesian product all possible ordered pairs, i.e. pair every item in the list with every other item in the list including itself. 
3. Design and implement a function that takes a list of [Any](https://docs.python.org/3/library/typing.html#the-any-type) and returns a list of all the unordered pairs of items in that list as [Tuples](https://docs.python.org/3/library/typing.html#annotating-tuples). This is like the previous problem but does not include pairs of an item with itself and every pair appears only once (rather than twice for each ordering).
4. Design and implement a function that takes a list of strings and counts the frequency for each string in that list. The frequencies should be stored in a python dictionary which maps the string to its count. 

## Experimental Coding Practice

Throughout the semester we'll be writing programs whose purpose is to provide data and insight about other code. In short, we'll be running experiments with our code. Let's get a bit of practicing using our computers for this kind of thing. 

The [Birthday Paradox](https://en.wikipedia.org/wiki/Birthday_problem) tells that there is a greater than 50% chance that in a group of 23 or more people, two will have the same birthday.  The link above shows you how to prove this analytically by using probability theory to calculate the probability of a shared birthday for *n* people. Rather than do that, you're going to generate strong evidence of the paradox through simulation and experimentation.  

In a full study we want to test several group sizes ranging form small to large. For each group size we should generate multiple random sets of birthdays and check each set for a shared/duplicate birthday. Finally, for each group size in the study, we want to calculate and report on the percentage of groups of that size that had a shared birthday. Below you'll be asked to create a series of functions that lead up a full data-gathering study of the birthday paradox. Notice how the problem is broken down into distinct functions that ultimately come together into a single function that can be used to run any number of studies you wish. 

1. Design a function that takes the group size *n* and generates a list of size *n* containing random birthdays.  To make things easy, we'll ignore dates and just index days by year. This means a birthdate is just a number from 1 to 365.  Use the python [random.randint](https://docs.python.org/3/library/random.html#random.randint) function to generate a single birthday. *Once you've got it working using a DIY loop and randint*, you're welcome to revise your function to use [random.choices](https://docs.python.org/3/library/random.html#random.choices). *You cannot (easily) unit test this function due to the use of random numbers. You should still test it in isolation to ensure that it behaves as expected.*
2. Design function that takes a birthday list and returns true or false if a duplicate exists in the list.  *Use the set-based method to detect duplicates.*  *Write unit tests for this function!*
3. Design a function that runs a birthday paradox experiment. This function takes two arguments, *n*, the size of the group, and *k* the number of groups of size *n* to check.  Your function should then generate *k* random groups of size *n* and return the percent that contained a shared birthday. *Again, you don't need to unit test this, but should test it in isolation to verify the expected behavior.* This function should make use of the prior two functions. 
4. Now, design a function to run a complete birthday paradox study. This function should take a sequence of group sizes (think list or range that provides a collection of sizes on which you'd like to run an experiment) along with a *k* (which serves the same purpose as it does with an experiment).  This function should run an experiment for each group size in the sequence, save the results to a dictionary that maps group sizes to the percent reported by the experiment, and return the dictionary. *Again, you don't need to unit test this, but should test it in isolation to verify the expected behavior.* This function should make use of the Experiment function (which makes use of the other functions from this part of the lab). 