---
layout: page
title: COMP 235 - C Problem Set II
permalink: /teaching/COMP235/fa23/chwk/set2
---

# Problem Set II

We now turn our attention to pointers and dynamic memory allocation as covered in 2.1 - 2.5 of [Dive Into Systems](https://diveintosystems.org/). To the greatest extent possible, you should collect all this work into a single program in order to practice managing a C project with lots of moving parts. (General Hint: Remember that all array variables are really just pointers. Declaring, passing, returning arrays just means declaring, passing, or returning a pointer.)

  1. Rewrite the leap year function so that it takes and returns pointers. Be sure to redo any tests for the function in order to meet the new pointer-based design. (This kind of use of pointers is not a recommended way of programming, but it lets you just focus on basic pointer behaviors.)
  2. Write a function that takes two arrays of integers, *v* and *w*, and then returns a (dynamically allocated) array where ith value is the product of *v[i]* and *w[i]*. The arrays *v* and *w* should not be modified. If *v* and *w* are not the same size, then your function should return *NULL*. Once again, redo testing code to meet the new function design.
  3. Write a function that takes an array of numbers as well as two integers *a* and *b* and returns a (dynamically allocated) array containing all the numbers from the given array that fall between *a* and *b*. Return *NULL* if no values within that range are found. (Hint: Try to first count the number of values between *a* and *b*, then allocate the new array, then copy the values to the new array. Alternatively, you can allocate an array that is the same size as the given array, copy values towards the front of that array, then, once you know how many numbers you have, allocate a third array, copy the numbers to that array and free up the intermediate array.)
