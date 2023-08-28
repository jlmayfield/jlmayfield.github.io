---
layout: page
title: COMP 235 - C Problem Set I
permalink: /teaching/COMP235/fa23/chwk/set1
---

# Problem Set I

The goal of this problem set is to give you practice working with C variables,
conditionals, loops, functions, and arrays as covered in 1.1 - 1.5 of [Dive Into Systems](https://diveintosystems.org/). To the greatest extent possible, you should collect all this work into a single program in order to practice managing a C project with lots of moving parts.

  1. Write a program that asks the user for their birth year and reports back to them if it [was or was not a leap year](https://learn.microsoft.com/en-us/office/troubleshoot/excel/determine-a-leap-year) that year.  You should write and use a function that takes their birth year as an input and returns true (1) if it's a leap year and false (0) if not.
  2. Modify the program from class so that the array is filled via user input and not by random integers.
  3. Write a function to find the min of an array. Add that function to the program from class and have the program report on both the min and max.
  4. Write a function to compute the sum of the array. Add that function to the program from class and have it report on both the max, (min if you did it), and the sum.
  5. Write a function to compute the number of values in an array that are between *a* and *b* where *a* and *b* are parameters of the function.  To test it, integrate it into your running program, run it multiple times with different values for a and b, and print the results.
  6. Write a Fizzbuzz function that takes an array of integers and for each integer it will print Fizz if it's divisible by 3, Buzz if divisible by 5, Fizzbuzz if divisible by both, and the number itself otherwise.  Put all output on one line, separated by a space or tab. Integrate this into your running program and test it on whatever random/user-generate array you're working with. Just be certain that you test it in such a way as to cover all your Fizzbuzz cases.
  7. Write a function that takes an array of integers and computes the number of even integers found at odd indices. Integrate it into your running program, where ever you see fit, and test it.
  8. Write a function that takes an array of integers and determines if it's palindromic, i.e. the same when read left-to-right or right-to-left. Have it return true (1) if it is, and false (0) otherwise. Integrate it into your running program and test it.
  9. Write a function that modifies an array of integers by tripling all the values. Integrate it into your program. Use to triple the starting values before running other functions.
  10. Write a function that takes two arrays of integers, *v* and *w*, and then modifies *v* such that the ith value in *v* is now the original value at index i multiplied by the ith value in w.
  11. Come up with one or more toy-problems that let you exercise the use of conditionals, functions, and arrays. 
