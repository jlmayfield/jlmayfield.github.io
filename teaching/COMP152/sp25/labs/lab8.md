---
layout: page
title: COMP151 - Lab 8 - Greedy and Dynamic Programming
permalink: /teaching/COMP152/sp25/labs/lab8/
mathjax: true
---


[Github Classroom Assignment Link](https://classroom.github.com/a/3vMfJHhl)

#  Recursion-Motivated Algorithm Design

For this lab you'll explore the recursion-motivated algorithm design methods we've been looking at. We discussed the following problems in class, so your job is to turn ideas into working code. You are welcome and encouraged to make use of [list comprehensions](https://docs.python.org/3/tutorial/datastructures.html#tut-listcomps) and [set comprehensions](https://docs.python.org/3/tutorial/datastructures.html#sets) as needed. You may also use build-in list methods like `sum`.  

Any problem labeled *extra* is optional and should only be worked on after completing the non-extra problems. 

## Test-Driven Design

I highly encourage you to explore a test-driven process today. That means working through each function in the following manner:
1.  Write the header (*with type declarations*), the docstring, and stub the function.
2.  Write a suite of tests for the function that includes base cases as well as larger, more interesting cases.  
3.  Complete the function.
4.  Use your tests to check and debug the function. 

## Problem 1

1. Write the **greedy** version of `make_change`: `greedy_make_change`.  *Do not assume coin values are given in greatest to least order. Instead, make use of [python's built in sorts](https://docs.python.org/3.13/howto/sorting.html).* Come up with some interesting test cases for which the greedy method will not yield the optimal set of change. The finalized version of dynamic-programming based `make_change` has been provided for you as a frame of reference.
    *   (Extra) Compare and contrast the results and performance of the dynamic programming based function and your greedy method. 

## Problem 2

This problem really benefits from the use of [Python's Set Data Structure](https://docs.python.org/3/tutorial/datastructures.html#sets). **As discussed in class, you must use sets as both an input and an output for your function.** A reminder of the basic Set usage covered in class follows the problem; it's more or less a restatement of what you'll find at the link above. 

2. The following problem is from our book. You'll need to:    
    *   Write a dynamic programming based function named `knapsack` to help you maximize your profit.
    *   (Extra) Write a Greedy-Method function named `greedy_knapsack` to help maximize your profit 
    *   (Extra) Compare and contrast the performance and result of each of your art thief programs. 
>Suppose you are a computer scientist/art thief who has broken into a major art gallery. All you have with you to haul out your stolen art is your knapsack which only holds pounds of art, but for every piece of art you know its value and its weight. Here is a sample problem for you to get started: suppose your knapsack can hold a total weight of 20 pounds. You have 5 items as follows: 
 >|item|weight|value|
 >|:---:|:--:|:--:|
 >| 1 |2 |3 |
 >| 2 |3 |4 |
 >| 3 |4 |8 |
 >| 4 |5 |8 |
 >| 5 |9 |10|

### Sets

A set is a data structure that comes directly from Math. Key properties of sets are (1) there can be no duplicate items in sets (2) there is no sense of order in sets. They are ideal when we just need a collection of unique items. In the case of our problem, we need a set of `(item,weight,value)` tuples, where item numbers are unique and therefore each tuple is unique. After all, you can't steal an item twice. 

The follow table more or less covers everything you'll need for your art-theft program. 

| Task | Python |
| :--- | :--- |
| Build an Empty set | `s = set()` |
| Build a non-empty set | `s = {a,b,c,...}` |
| Combine Set `a` and `b` (aka Union) | `a \| b` |
| Get everything in `a` but not `b` (aka Difference) | `a - b` |
| Get everything in both `a` and `b` (aka Intersection) | `a & b` |
| Iterate over `a` | `for item in a: ...` |
| Check if `item` is in `a` | `item in a` |
| Check if `item` is not in `a` | `item not in a` | 
