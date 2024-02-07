---
layout: page
title: COMP151 - Lab 4 - Thinking and Programming Recursively
permalink: /teaching/COMP152/sp24/labs/lab4
mathjax: true
---

### A primer for Chapter 4

When we say that something is **recursive** we are saying that it is, in a consistent way, *self-referencing*.  A recursive function will, when needed, call itself.  In doing so, it creates repetition in programs and provides us with an alternative to loops and iteration. Data models and data structures can also be recursive in that they contain smaller versions of the same structure within themselves. For example,  lists contain smaller sub-lists, trees contain sub-trees, etc. 

Today we look specifically at lists as recursive structures and explore how we can design recursive functions that mirror the recursive structure of a list. We'll begin by working together to solve problems at the model level using recursion.  You'll then work on implementing our recursive solutions using Python's list data structure and functions. 

#### Lists are Recursive

Let's dive right in and look at a recursive definition for the structure of a list. 

> Any list L is either:
>*   Any empty list with length 0
>*   A list with one element at the front (called the first) followed by a sub-list (called the rest).

Let's test this definition from the bottom up. First off, the empty list `[]` is a list. *It's the only list that satisfies the first case of the recursive list definition*. A step up from there is a list with one element, like `L=[5]`.  The list `L` not empty so its structure falls under the second case of our definition. The first of L is the number 5, but the rest of L is nothing, and nothing, in this case, is perfectly described by the empty list `[]`.  So, any list with one element has as it's first that single element and as it's rest an empty list. Now on to a list of length 2, like `L=[2,3]`. Again, L is not empty.  It has as the first item the number 2. The rest of the list, following 2, is the list `[3]`, and because that's a list of length one, we've satisfied our definition of "one element followed by a sub-list".  We could continue this game, but hopefully you see the pattern: any non-empty list has one element at the front and a sub-list following that element that is one element smaller. If you follow that rabbit-hole, you end at the very special, non-recursive empty list. 

Like we've done with the ranges used in iteration, you can adjust as needed from the basic definition give above. Here's a few useful options to ponder. 

> Any non-empty list L is either:
>*   A list of length 1
>*   A list with one element at the front (called the first) followed by a non-empty list list (called the rest).

> Any list L is either:
>*   Any empty list with length 0
>*   A list with one element at the back (called the last) preceded by a list (called the but-last, i.e. "all but the last".).

> Any list L is either:
>*   Any empty list with length 0
>*   A list of length 1
>*   A list with one element at the front (called the first) followed by a list (called the rest).

Or maybe we can get weird and creative:
> Any list L is either:
>*   Any empty list with length 0
>*   A list of length 1
>*   Two sub-lists, one called left followed by one called right. 


#### From Recursive List to Recursive Function 

If you understand the recursive structure of your data model, then you can design algorithms to follow that structure. Namely:
*   For each case in the definition, have a case in your code. 
*   Make recursive function calls only on recursive structure and ONLY on the recursive part. 

If we look at our basic recursive list definition that means:
1. Two cases, one for empty lists and one for non-empty lists.
2. The non-empty list case should make a recursive function call on the rest of the list (i.e. the recursive part of the list).

To make this work we need at least three basic operations for our list structure:
1. the ability to tell empty from non-empty. Let's call this a function named `empty` that returns True/False if a given list is empty.
2. the ability to select the first of the list. Let's call this `first`. It returns the first item in a non-empty list. 
3. the ability to select the rest of the list. This will be `rest`, and it returns the rest of a non-empty list. 

Now let's look at our first problem: *add up all the numbers in the list of numbers named `S`*. 

If we follow the above recipe, then we end up with the following **pseudo-code** design. *Notice how it reads more like a definition for the sum of a list rather than a description of how to solve for the sum?* 

```
sum(L):
    if empty(L):
      return 0
    else:
      return first(L) + sum(rest(L))

```

We've written this in a python-like style, but it's not python. It's a concrete, code-like idea for an algorithm. Now that we have that algorithm in mind, we need to implement it using python and it's built-in data structures. 

#### Inductive Reasoning and Recursion 

Before we get to coding, let's take a moment to consider the algorithm design one last time. There's a familiar reasoning pattern at play.  Designing this algorithm requires asking and answering the following questions: 

1. What's the sum of an empty list? *It's 0*
2. If I have `sum(rest(S))` (the sum of the rest of the list) and `first(S)` (the first number in the list), then what must I do with those to get sum(S) (the sum of the whole list)? *Add them, so first(S) + sum(rest(S)).*

It may seem odd to imagine that you can have `sum(rest(S))` given that you've yet to complete the definition for `sum`, but it's not at all odd. First off, we're being optimists (you'll get it!) and, secondly, we're employing *inductive reasoning*. We'll explore this in some detail as the same reasoning pattern let's us think through the design of iterate and accumulate pattern we use with loops. For now, we'll trust the process, make it work, and then dig into why and how it works later. 


#### When Data Models and Data Structures Don't Match

Ok, we know that what we'd like from python is a list with the following capabilities:e
1. Constant-time selection from the front: `first`
2. Constant-time selection of every thing but the front. `rest`
3. Constant-time determination of empty vs non-empty lists. `empty` 
Having these operations working at $$O(1)$$ time means we can worry less about the costs of the data structure and more about the cost of the algorithm. 

Python has a list and it delivers on (1) and (2).  The `len` function takes $$O(1)$$ time and can be used to differentiate empty (`len(S)==0`) from not empty (`len(S) > 0`). It over delivers on selecting from the front. The natural front is at index 0, which we can select with `S[0]` If we want some other index to be the front, say `i`, then I can also select `S[i]` in $O(1)$ time. Cool.

 Unfortunately, we cannot select the rest, everything after the front as a list, in $$O(1)$$ time. We *can* use a slice like `S[1:]` or `S[i:]` (equivalently `S[1:len(S)]` or `S[i:len(S)]`, but this is $$O(n)$$ where $$n$$ is the length of the slice.  Not cool. We'll see that this cost will add up. So, we need to adapt and, surprisingly, we need to *generalize* our algorithm.

 Consider the following two "list sum" problem statements:

 >Problem 1: Given list of numbers S, compute the sum of all the numbers in S. 

 >Problem 2: Given list of numbers S and list index i with $$0 <= i <= len(S)$$, compute the Sum of all the elements in S from index $$i$$ to the end of S. (Basic the sum of list suffix.)

The difference boils down to "sum of all" versus "sum of some".  The later being a more general problem as "sum of some starting at i=0" is just a long-winded way of saying "sum of all". So, if we can solve "sum of some" we can solve "some of all". Let's do that, recursively. 

First we have to adjust what empty, first and rest mean in terms of $$i$$. Basically we're looking not just at list `S` but the combination of `S` and index `i`, (formally, we'd say the tuple $$(S,i)$$). 
> A list index pair (L,i) is either:
>*  empty where i == len(S)
>*  not empty where 0<=i<=len(S)

Python lets us manage this new funky list,index pair structure efficiently: 
* empty -> i == len(S)
* first -> S[i]
* rest -> S and (i+1)
Operations for `empty` and `first` are still $$O(1)$$. To get the rest all we do is increment the integer `i`, which is an $$O(1)$$ operation.  Nice. 

Adapting our code, we get the following near-python pseudo-code:
```
sum(S,i):
    if i == len(S):
        return 0
    else:
        return S[i] + sum(S,i+1)
```

If we want to recapture the "sum of all" problem, then we can do this:
```
sum(S):
  return sum(S,0)
```

In Python we can use default parameters (**See section 1.5.1, page 26**) to accomplish the same thing:
```python
def sum(S,i=0):
  ...
```
Here, if a value for `i` is given, then we use that. If it's not, then `i` is set to zero. So, for list `L` `sum(L)` is the same as `sum(L,0)` and yields the sum of `L`. 

Now we can make it fully Python and test it! 

### Lab 

Practice time. Together, we'll solve the following problems at the model level using recursion and write down the associated recursive list definitions and algorithm pseudo-code. You will then code them in python using in the efficient style given above, including default parameters. No linear-time slices!

Here are your problems: 
1. Sum all the numbers in a list of numbers (i.e. finish the example above)
2. Count the number of even numbers in the list. 
3. Given a list of numbers and the number `k`, return True if `k` is in the list and False otherwise. 
4. Given a list of at least length 1, find the minimum value in the list. 

Get the [assignment on Github Classroom](https://classroom.github.com/a/RAqrp_oJ) and get cracking! 