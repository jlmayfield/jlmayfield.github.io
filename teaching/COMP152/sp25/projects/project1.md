---
layout: page
title: COMP151 - Project 1
permalink: /teaching/COMP152/sp25/projects/project1/
mathjax: true
---

[Github Classroom Link](https://classroom.github.com/a/MG3UmgPm)

# Project 1 - Experimental Comparison of List-based and Array-based Linear Structures

For your first project you'll carry out an experimental study of the performance of list and array based implementations of the Stack and Queue ADT in the context of real-world code. More specifically, you'll use the stack-based decimal to binary conversion algorithm to compare stacks and radix sort to compare queues. 

Below you'll find everything you need to get going on the project. 

## TODO

At a high-level, your project consists of the following five tasks:

1. Implement (in `linearstructures.py`) and Test (in `tests_linstruct.py`) the `class`es `ListStack` and `ListQueue`.
2. Write and test the function `writeToCsv` as described in `util.py`. Testing for `writeToCsv` should be done in `util.py`. 
3. Carry out a performance comparison experiment between `ArrayStack` and `ListStack` when used in the `to_bin` function. Results of the experiment should be written to a *csv* file. 
4. Write the function `randList` as described in `queueperf.py`.
5. Carry out a performance comparison experiment between `ArrayQueue` and `ListQueue` when used in the `radixsort` function. Results of the experiment should be written to a *csv* file.
6. (Optional, but highly recommended!) Use `visualize.py` to visualize the results of your experimental studies! 

More details about these tasks can be found below. Of particular importance are the parameters for the experiments. 

# Experiments

An experimental study of algorithm and program performance is largely statistical. You run the algorithm against multiple inputs of various sizes and then evaluate the results. Your task for this project is to collect the data. I've provided a simple visualizer for the results; we'll skip the more detailed statistical analysis. 

An **experiment** consists of several **trials**. A trial provides one point of comparison for our algorithms. All of our experiments involve the comparison of two different ADT implementations, so *a single trial will provide information about how those implementations perform when given the exact same input*. Our performance measure of interest is time. Your code will need to record the time it takes the algorithm to complete. This measure is determined by by the function's input, specifically the *size* of the input. A good experiment will run trials on a range of sizes with multiple trials per size; being a statistical study, you need multiple data points per size in order to determine any real pattern in the relationship between input size and computation time.   

## Comparing Performance - Stacks and Decimal to Binary Conversion

For our stack experiment, a **trial** consists of feeding a single random, `k` digit integer `n` to `toBin` using `ArrayStack` and again using a `ListStack`.  In each case we record the following 3-tuple: which stack was used (string `"List"` or `"Array"`), the value of `k` (i.e. the input size), and the number of milliseconds required to complete `toBin`. The function `toBin` has already been written for you and is found in `stackperf.py`. Here's the header and documentation:
```python
def toBin(n : int, Stack=ArrayStack) -> str:
    """
    Given a positive integer value, compute it's binary representation and 
    return it as a string.

    Parameters:
        n : int - the integer
        Stack - the Stack to be used to collect the bits

    Return:
        str - binary representation of n
    """    
```
The second argument let's you determine which type of stack gets used. You'll either pass `ArrayStack` (the default) or `ListStack`. So, a call to `toBin` will look something like `toBin(n,'ListStack')`.

Our stack **experiment** then consists of running multiple trials for an increasingly large value of `k`.  More specifically: *For each `k` ranging from 50 to 1000 in increments of 50, complete 10 trials, each on a different `k` digit number*. You're welcome to play with larger values of `k` and different step sizes. Just ensure that what you submit contains at least the range of values listed above and at least 10 trials per `k`.

In the file `stackperf.py`, write code to carry out a complete experiment and record the collected data to a single csv file. Writing to the file should be done via your `writeToCsv` function. To be clear, running he file should produce a csv file with the complete results of the experiment. 

## Comparing Performance - Queues and RadixSort 

A queue comparison **trial** consists of generating a length `n` list consisting of randomly generated `k` digit numbers and sorting that list is using both the `ArrayQueue` and `ListQueue` versions of `radixSort`. In each case, you should record the 3-tuple: the data structure used (`"Array"` or `"List"`, the value of `n`, and the number of milliseconds it took to complete the sort.  A `radixSort` function has been provided and can be found in `queueperf.py`. Here's its header and documentation:
```python
def radixSort(aloi : List[int],Queue=ArrayQueue) -> List[int]:
    """
    Given list of numbers, return a list containing those numbers in sorted order. 
    This takes O(kn) time where n is the length of aloi and k is the "length" of 
    the largest value in aloi. The length of a number m is log(m). 
    

    Parameters: 
        aloi : List[int] - list on integers 
        Queue - Queue Implementation to be used for sorting
    
    Return:
        List[int] - aloi sorted
    """
```
Once again, the second argument lets you control the type of Queue used. You should only pass `ArrayQueue` (the default) or `ListQueue`. This function is used similarly to `toBin`. 

Our **experiment** consists of running multiple trials for increasingly larger list sizes, or `n`s. To simplify matters, we'll choose `k= ceil(log10(n))` to mimic something in the ballpark of an *O(nlog(n))* algorithm. More specifically, *for each `n` ranging from 1000 to 20000 in increments of 1000, complete 5 trials, each on a randomly generated list of `n`, `k=ceil(log10(n))` digit numbers*. You are, once again, welcome to expand upon the experiment but increasing the max value of `n` and/or using smaller increments.  

In the file `queueperf.py`, write code to carry out a complete experiment and record the collected data to a csv file. Writing to the file should be done via your `writeToCsv` function. Once again, running the file should result in the creation of a csv file with all of your experimental data. 

## Generating Algorithm Inputs

In `util.py` you'll find the function `randintDigits` which takes a single integer `k` and returns a randomly generated `k` digit number. This function can be used out of the box to generate inputs for your stack study. You'll be responsible for writing the function `randList` which should make use of `randintDigits` to produce randomly generated lists of k digit numbers. Such lists can then be used to run `radixSort` trials.

# Visualizing the Results  

You've been given code, in `visualize.py`, to produce graphs of your collected data. What you'll see are points for every collected time and a line showing the average time per size. To run this code you must have the python packages [plotly](https://plotly.com/python/getting-started/#installation) and [pandas](https://pandas.pydata.org/docs/getting_started/install.html#installing-from-pypi).  *Graphs will be displayed in your web-browser!* I highly encourage you to use these visuals to gut check your data; please do not hesitate to ask for help getting it the packages setup. 

# A Note on *Inner Classes*

In this code, the `Node` class is nested within the class definitions for both `ListQueue` and `ListStack`.  Such classes are called **inner classes**. Think of this as an expression of a sub-definition. The `Node` class within `ListQueue` is "*ListQueue's Node Type*".  To refer to this type we would use `ListQueue.Node` as opposed to just `Node`. Similarly, the `Node` definition with `ListStack` is a definition for the type `ListStack.Node`. Python views these two definitions as unique definitions due to the nesting.  

In general, these doesn't change much with how you program using your respective `Node` definitions. If you need to refer to the type, then use the fully qualified names: `ListStack.Node` and `ListQueue.Node`. When constructing a Node object, you'll also need to use the fully qualified name. For example, to construct a new node containing the number 5 as part of a `ListStack`, you would write, `ListStack.Node(5)`. 

# A Note on Timing Code

As you may recall from pervious labs, to get a precise measure of how long it took to execute some code, we get from the computer the time before the code starts, after it ends, and then subtract the difference. The computer can measure [time down to the nano-second](https://docs.python.org/3/library/time.html#time.perf_counter_ns), so we'll use that. What this looks like in practice is something like this:
```python
import time 

start = time.perf_counter_ns()
# code you want to time
stop = time.perf_counter_ns()
elapsed = stop-start #elapsed is the total nanoseconds needed for the code 
```
Once the elapsed time is computed in nanoseconds, you can convert to other time units as needed. For this project we're using milliseconds and *1,000,000 nanoseconds = 1 millisecond.* 

