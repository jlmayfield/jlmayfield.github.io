---
layout: page
title: COMP151 - Project 1 Prep Lab
permalink: /teaching/COMP151/labs/project1prep
---

This lab is all about gearing up for your first project by focusing on organizing and designing your code using hierarchical decomposition. You've seen two examples of this in my code for the art projects from labs 4 and 6. The book also gave us some preparation for this in chapter 5.  In this lab you'll work and rework several programs to exhibit clear top-down, hierarchical design and along the way get the chance to revisit some old image manipulation patterns while getting a preview of what's to come.


* Don't forget that at the end of each chapter contains a *Programming Summary* section that provides a quick dictionary of all of the important function and encoding names introduced thus far. When you run into problems don't forget to check the *Common Bugs* and *Debugging Tips* scattered throughout the chapters as well. If you're stuck on an error try looking at these items.
* As always switch the *driver* (person typing the code) and *navigator* (person watching, helping spot typos, etc.) on every new problem **or** every half hour, whichever comes first.
* Do all of the problems in a single python file. Put everyone's name in a comment at the top of the file. Label the start of each problem with a comment.

### To Do

0. If you still don't have the images that go with the book you need to get them now. These problems are dependent on specific images. If you don't have my code from labs 4 and 6, then search your inbox, find them, and save them to your computer so you can open them from JES as needed. 
1. Program 48 (pg 116) is an example of single main function design. The function *turnRed* handles loading and displaying the image as well as the image manipulation.  It can be **refactored** so that the brown to red color change is handled by a sub-function much like you see in my code. Create such a function and rewrite *turnRed* so that it uses that function. (Hint: All the code is there, you just need to reorganize it.) To wrap things up, modify your program so it writes the finished product to the hard drive as well as displaying it.  
2. Program 49 (pg 117) is a rewrite of program 48 that focuses only on the region of the image that contains Katie's head. We can do the same refactoring of this program to include a sub-function that handles the brown to red color change. Your sub-function should be written so that it is reusable beyond the scope of program 49. This means you cannot use the bounding coordinates that are specific to Katie's picture but should instead write a function that takes starting and ending x and y coordinates for the range of pixels you want to perform a brown to red transformation on. *Do not modify code from the previous problem. Just write new functions with different names as needed.* (Hint: Look to program 50 for a big clue)
3. In chapter 6 we'll pick back up our range-based loops in order to more efficiently work with regions of a picture by counting out both x and y coordinates. A basic example of this is seen in program 64 (page 149). Study program 64 and use this coordinate counting style to write another version of the sub-function that you wrote for the previous program. Once again, do not modify your code from the previous problem. Write new definitions with new names. At this point you should have three different versions of the "make Katie a redhead" program.
4. Study program 65 (page 150) carefully.  Notice that it actually includes code to time how long it takes to execute some block of python code.  This is called **profiling**. Go back to your Katie program from the previous two problems and add similar code in order to profile your two sub-functions, i.e. the one written in the style of chapter 5 and the one written in the style of chapter 6. Which *feels* faster? Can you tell a difference without the clock? Which does the clock say is faster? Rerun the programs a few times, does it always take the same amount of time?