---
layout: page
title: COMP151 - Lab 4
permalink: /teaching/COMP152/sp25/labs/lab4/
mathjax: true
---

[Github Classroom Assignment](https://classroom.github.com/a/7A52W5nX)

For this lab you'll write code to collect run time data on multiple functions.  In the process you'll get a taste for working with file input and output. Below you'll find some general pointers and requirements for running a timing experiment along with details about the three different experiments we're running. Ideally, you'll completely them all, but if time runs short that's OK; do them in whatever order you wish. 

## Run Time Experimentation

The three experiments that you'll run today are meant to give us data helpful in comparing the run time of different algorithms for a specific problem. To get this data we must:
*   Run each of the algorithms in question on inputs of increasing size.
*   For a given size, ensure that each algorithm runs on the exact same input.
Ideally, we'd also run the algorithms on multiples instances of each size and gather statistical information about the algorithms, but we'll just start out with a single data-point per size. 

The end result of a successful experiment is a *csv* (Comma separated values) file containing the measured run time for the algorithms in question for a variety of sizes.  Today that means we want three files, one for each of the experiments described below. The exact format of our CSV file is discussed below along with some general information about reading and writing files. *Be sure to add the files to your repository and submit them along with your code.*  


## Recording Data

When we run our algorithms we want to record three things: (1) the name of the algorithm/function, (2) the size of the input problem, and (3) the time (in milliseconds) it took to run the algorithm. To facilitate post experiment analysis, we'll record this data to a *comma separated values* (csv) file. 

The csv file is a very, *very* common file format for storing data. Each line of the file is, as the name implies, values separated by commas.  Those values are usually related to a single data point. In our case, each line contains the three algorithm run time data listed above like so:
```
name,size,time
name,size,time
...
```

### Getting Data

You can get the name of function as a string by referencing it's `__name__` attribute. For example, for a function defined as `def myfun(...)`, `myfun.__name__` will return `"myfun"`. 

You should be selecting the size of your problems, so just write that (as a string), when you write the name and time of the function.

To get the time we'll use the `time` module's method called `perf_counter_ns`. This method is invoked with `time.perf_counter.ns()`, which returns the current time (in nanoseconds) as an `int`.  To get the elapsed time of an event we record the time before and after the event, then compute the difference. 
```
before = time.perf_counter_ns()
# event to time
after = time.pef_counter_ns()
elapsed = after - before
```
To convert nanoseconds to milliseconds, we divide nanoseconds by 1000000.

### File Input/Output

Python has good [documentation for Reading and Writing from files](https://docs.python.org/3/tutorial/inputoutput.html#reading-and-writing-files). You can mostly draw examples of what you'll need from there. I'll just draw your attention to the important parts of that documentation. 

First, to read or write from a file you must first open it. This is discussed right away in the python documentation. Opening files for reading fails if the file does not exist. Writing can fail for other reasons. So, file I/O is an operation for which we expect to handle *exceptions*. In python, you should use the `with` style expressions show in the second example in the docs and below. The `with` expression lets you define a variable and provides built in exception handling. In file I/O you use the `with` line to open and name the file, then the indented block below contains file operations (reading and writing). Opening a file named *book.txt* for reading looks like this: 
```
with open('book.txt', 'r', encoding="utf-8") as f:
    #read from f
```

Trying to write to a file that doesn't exist will create that file. To write you need to specify whether you want to overwrite existing file contents (use `w`) or append to an existing file (use `a`):
```
with open('data.csv','w',encoding='utf=8') as f:
    #write to f (i.e. data.csv) by overwriting current contents

with open('data.csv','a',encoding='utf=8') as f:
    #write to f (i.e. data.csv) by appending to current contents
```
For recording today's data, you have two choices:
1. Write one line at a time by appending to a file. If you do this, then you're likely going to need to delete and recreate files while you're figuring things out. You don't want to keep old, possibly bad data, in a file. 
2. Generate the whole file contents as one long string, then write that to a file all at once. 

In both cases, the `join` method for strings is your good, good friend. Joining data for one line can be done with something like `",".join([data...])`.  If we want to join multiple lines, we need to break them up with the newline symbol, `\n`. This can be done with something like `"\n".join([lines...])`. If you choose not to join lines, then you'll need to explicitly write the newline at the end of each line. For details about the different read and write methods for files, check out [this part of the docs](https://docs.python.org/3/tutorial/inputoutput.html#methods-of-file-objects).

## Experiment 1 - Iterative String Construction

First we use the remove punctuation problem to compare python's `join` method for strings to repeated concatenation. While we're at it, we'll compare DIY loops to python's list comprehension syntax. In the file `functions.py` there are three versions of `removepunc`.

1. `v1` uses standard iterate and accumulate logic with repeated concatenation (`+` for strings). This is an $O(n^2)$ function due to the interaction between immutable strings and concatenation. 
2. `v2` collects non-punctuation symbols into a list (using `append`) then uses `join` to construct the final string. This is an $O(n)$ function; the `join` method avoids concatenation by pre-computing the size of the final string, allocating the necessary storage, and then writing in the result. 
3. `v3` does the same thing as `v2` but uses a list comprehension rather than a DIY `for` loop with list `append`.  This is also $O(n)$ but is expected to yield better performance when compared to `v2`. 

### Getting Strings of Varying Size

The worst possible case for all of these algorithms occurs when the given string contains no punctuation. Rather than generate such strings, we're going to engage in a bit of real-world style testing by pulling text from a book, namely *War and Peace*. 

The file *pg2600.txt* is a copy of Tolstoy's *War and Peace* downloaded from Project Gutenberg. To get a string of size *n*, just read the first *n* symbols from the file.  Alternatively, you can read the whole file into a string and slice off the first *n* symbols from that string. Again, if we were doing a deep study of these algorithms, then we'd want to generate truly worst case strings (no punctuation) and perhaps use samples of text from more than one book. For today's lab, we'll stick to seeing how these do on Tolstoy. 

### Sizes To Test

*War and Peace* contains about 3359652 symbols. Choose a range of 10-20 string sizes starting with not more than 50 symbols and running up to the whole file. You should first make sure you can get data on all three algorithms for a single string, then I recommend you setup a loop that steps through an evenly spaced series of sizes. You're welcome to gather more than 20 data points, but you should not start with a huge data set lest you risk starting a compute task on your computer that will take a lot of time. 


## Experiment 2 - Are Better Algorithms Better?

Our second experiment is a straight ahead comparison of an $O(n)$ algorithm with an $O(n^2)$ algorithm. We'll return to the prefix sum problem for this one.  I call this straight ahead because it's much less reliant on python built-in methods and instead highlights the programmer's choice of algorithm.  We have three versions of `prefixsum`

1. `v1` Computes the prefix sum by iterating through the prefix directly. The resultant list is constructed using repeated concatenation. This function is $O(n^2)$ due to the nested loop's dependency on the outer loop variable. 
2. `v2` Does the same nested iteration as `v1` but pre-allocates the list for the result and writes in the sums as they are computed. This is still $O(n^2)$, but there is a chance that the pre-allocating will yield faster run times. In theory, we expect `append` to be no different than writing to a pre-allocated list, but in practice, we might encounter subtle differences. 
3. `v3` Uses the previous prefix's sum when computing the current prefix sum to avoid the nested iteration. This results in an $O(n)$ function. 

### Getting `List[int]` data of various sizes

The actual contents of the list don't impact the performance of these algorithms, only the list size. So, we can simply convert a range to a list to get our candidate list. To do this you simply feed a range to a the `list` constructor. For example, `list(range(50))` produces a list containing the values from 0 to 49, in that order. 

### Sizes To Test 

Once again, you need to gather 10-20 data points, minimally. You're welcome to get more.  Carefully play around with finding a *very large* then get a nice spread of sizes leading up to that size. Again, feel out large sizes to avoid starting a test that runs for too long. **You will experience a slow down with this one more than any other experiment. Sizes in the 10000-25000 range will take a bit of time for sure.**

## Experiment 3 - More, Better Algorithms

Our final experiments looks at two ways to find the greatest common denominator. Once again, there is a clear difference between the two algorithm's worst cast run time. 

1. `v1` uses basic iteration to check all values starting with the smallest of the given numbers. It runs in $O(n)$ time, where $n$ is the smallest value. 
2. `v2` is Euclid's algorithm. By essentially using successive division rather than additive/subtractive steps, Euclid's algorithm achieves $O(log(n))$ run time, where $n$ is the smaller of the given numbers. 

## Choosing Numbers to Test 

The worst case scenario for gcd finding occurs when the two numbers are [relatively prime](https://en.wikipedia.org/wiki/Coprime_integers). This means their gcd is 1. We can hedge our bets by just choosing [prime numbers](http://www.prime-numbers.org/). Just ensure that the smallest value passed to `gcd` is "large" as that is the one that determines run time. To avoid some issues related to hardware integers, choose numbers that are no larger than 9,223,372,036,854,775,807. As always, carefully test your way up to large numbers before committing to running a whole suite of tests on very large primes. 

Like before, do 10-20 tests (or more).  Here I recommend you make one or more lists of primes so that you can use a loop to feed the numbers to your functions. 


## General Advice

There are no hard rules on how your write and run your code today *so long as you gather a good, clean set of data*. My advice is use functions and loops in an attempt to build a set of code that creates and records a complete data set when run.  It will quickly get tedious if you need to modify and rerun the code every time you want to try a new, larger input. So,
* Build your program(s) incrementally, like we always do, and run/test them as you go. For example, you might approach the remove punctuation experiment like this:
    1.  Write code to read the file and print it's whole contents.
    2.  Modify (1) so that the first *n* symbols in the file are read and printed.  Make sure *n* is a variable. 
    3.  Feed the first *n* into one of the functions and record the time it takes. Print the result in the csv format (name,n,time). 
    4.  Have the result of (3) written to a file (maybe don't print. up to you). 
    5.  No pass that one string to all three functions, record and report the time. 
    6.  Now slap a loop around (5) and get it to pass a sequence of increasingly larger strings to the functions. Tweak as needed/wanted. 
    7.  If you have not done so already, delete your csv file, run the full program, and get a clear dataset for submission. 

## A Picture is Worth 1000 Words

This is an optional step, but if you like graphs or are interested in data-oriented programming tasks, you might give it a try. If you'd like to see graphs of your data, then first you need tw0 python modules. 
*   [pandas](https://pandas.pydata.org/docs/getting_started/install.html#installing-from-pypi) for managing the data
*   [plotly](https://plotly.com/python/getting-started/#installation) for making graphics

If your csv conforms to the specifications above, then the following code should read your data and produce a line graph. 
```

import pandas as pd
import plotly.express as px
import plotly.io as pio
pio.renderers.default = "browser"

df = pd.read_csv('yourdata.csv',names=['name','n','time (ms)'],
                 dtype={'name':str,'n':int,'time (ms)':float})
fig = px.line(df,x='n',y='time (ms)',color='name',title='Graph Title')
fig.show()
```
You will need replace `'yourdata.csv'` with the name of your csv file and should replace `'Graph Title'` with a better title for your graph. 