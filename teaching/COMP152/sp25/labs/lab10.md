---
layout: page
title: COMP151 - Lab 10 - Tracing Algorithms - Search and Sort
permalink: /teaching/COMP152/sp25/labs/lab10/
mathjax: true
---

[Github Classroom Assignment for Source Code](https://classroom.github.com/a/kGFbpkHC)

# Key Searching and Sorting Algorithm Analysis

Understanding the how and why of the searching and sorting algorithms that we're studying helps to unlock new problem solving and programming paradigms.  Two vital parts of this process are tracing the algorithms on real data and analyzing their performance. In this lab you'll focus on tracing the behavior of these algorithms under difference conditions. *This is a pen a paper lab.*  You'll use the code here as a reference. Answers to the questions should be written on paper and submitted at the end of lab. Do not modify the code to print out results. In fact, don't run the code at all.  Let your brain be the computer. **You'll be asked to do these kinds of traces on a forthcoming exam.**

## Tracing Algorithms  

Tracing algorithms is a skill that you need to develop and hone over time. It means really knowing what the computer does and when while also understanding the high-level, logical structure of the algorithm. The key is knowing what to trace and what to track. While it is sometimes necessary to work in a *very* stepwise fashion like the computer, it's often better to boil the process down to it's key *logical* components. Today, you'll be told what to track. As you do your traces take a moment to consider what aspects of the code are glossed over, what's explicitly tracked, and why that might be. 

# Binary Search

**What to trace:**  We can understand the overall behavior of binary search by *tracking the sequence of values that are assigned to `mid`*, i.e. where the algorithm looks for our search key. *For each trace, write these out on a single line.* It's also nice to track the values assigned to first and last, but we don't necessarily need to record these. 

All our searches will be done on the following list: `[1,3,5,7,9,11,13,15,17,19]`. 
1. *Average Case* - An average binary search occurs when the value you're looking for is in the list but maybe isn't in first few places you check. **Trace a search for the number 7.**
2. *Worst Case* - Like most searches, the worst case occurs when the search key is not in the last.  For binary search this could mean the number is smaller than the first item in the list, larger than the last, or falls in between two numbers in the list. **Trace a search for the number 21 and another search for the number 16**. 

# Insertion Sort

**What to trace:**  When tracing any in place sort, you'll almost always want to track the state of the list across each iteration/repetition. For insertion sort, this means *showing what the list looks like at the end of each repetition of the outer `for` loop. For each repetition, write out the list on a single line.*

1. *Best Case* - Insertion sort will complete its work in O(n) time *if* the list is already sorted. *Trace what happens with `[1,2,3,4,5,6]` is sorted.*  
2. *Worst Case* - Insertion sorts worst case is O(n^2). This occurs when the the list is sorted in the reverse order that we want.  *Trace what happens when `[6,5,4,3,2,1]` is sorted.*
3. *Average Case* - When the list isn't sort, then insertion sort does somewhere between O(n) and O(n^2) operations. *Trace what happens when `[2,1,3,6,4,5]` is sorted. 

### Tracing Insert (Optional Exercise)

If you really want to understand all that insertion sort has to teach us, then you should also trace its somewhat hidden subroutine, *insert*.  Our implementation embeds this in the code as the block within the outer `for` loop. To trace this we can, once again, track the change to the list. This time, we focus on the state of the list at the end of each repetition of the inner `while` loop. 

You'll encounter the following cases when doing your full sort traces: 
1. *Best Case* - The value at `i`, the value being inserted, is larger than everything to it's left. (i.e. it's sorted relative to the list preceding it).#
2. *Worst Case* - The value at `i` is smaller than everything preceding it.
3. *Average Case* - ... Neither a best nor worst case scenario. 

# Selection Sort

**What to trace:**  Again, we want to show the state of the list after each repetition of the outer `for` loop. 

Selection sort has no distinct cases. It will always perform O(n^2) operations regardless of the arrangement of the values within the list. After doing the trace listed below, take a moment to pinpoint why that must be. 
1. Trace the sorting of `[2,1,3,6,4,5]` using selection sort. 

### Tracing Select (Optional Exercise)

The subroutine to selection sort should seem really familiar to you: it's a min finder that produces the location of the min rather than the min value. If you wish to trace it, the track the value of `min_idx` at the end of each repetition of the inner `for` loop. Note that the final `if` statement isn't part of the subroutine. It's a bit of work left for the sort to carry out after the minimum value has been found. 

# Quicksort 

Quick sort is a bit easier to trace than merge sort because it works strictly in place and modifies the list prior to making its recursive calls. **What to trace:**  You guessed it, the state of the list. In this case, we want to know what the list looks like after each call to `partition`. The trick will be determining when and one what portion of the list partition is called. It's pretty much impossible to do a good trace of quicksort without also tracing `partition`. Check below for those details. 

Quicksort has a worst case of O(n^2). It's easy to encounter as its written in the text, but we'll learn how to make it an exceedingly rare occurrence. It's best and average case is O(n log n). 
1. *Average Case* Trace quicksort for the list `[3,5,2,6,4,1]`. *Show a trace of `partition` for the first two calls to `partition`. 
2. *Worst Case* The book's quicksort exhibits it's worst case when the list is already sorted, in any order. *Trace quick sort on the list `[1,2,3,4,5,6]`. 
3. *Best Case* There are some arrangements of quicksort that will achieve a very tight O(n log n) bound on the number of operations performed. It's actually quite tricky to tease out. Can you figure out what the best case is? Hint: Think in terms of what must be true about each pivot value? 

### Tracing Partition

The `partition` routine was actually setup as a function for quicksort. That makes it a bit easier to think about tracing. **What to trace**  Yup, the state of the list after each repetition of the outer loop. You'll need to track the values assigned to `left_mark` and `right_mark`, but we don't necessarily need to report those. It's also a good idea to show what the list looks like after the final swap before the return. It's also ok to only show the portion of the list that partition is working on, i.e. `first:last+1`. 

# Merge Sort (Optional, Practice/Study)

We'll do merge sort together in class, but you need to be able to do it on your own as well. Once again, we want to track the state of the array. In this case, we should show what it looks like after the merge, i.e. right before the function call terminates. The hard part here is knowing what portions of the list get sorted and merged and in what order. For practice trace mergesort (and some merges) for the list `[2,1,3,6,4,5]`.  Like selection sort, merge sort has no value-dependent cases.  Do you see why? 





