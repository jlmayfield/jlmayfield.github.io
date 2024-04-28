---
layout: page
title: COMP151 - Project 2 - Huffman Codes
permalink: /teaching/COMP152/sp24/projects/huffman
---

**[Github Classroom Link](https://classroom.github.com/a/bZo5JTIK)**

Your final project brings us back to where we began, [Huffman Codes](/teaching/COMP152/sp24/labs/lab1). We now have the tools to get the computer to do all the work for us. So, let's make that happen. 

# Huffman Trees

Huffman trees are binary trees where every node has an associated weight, a floating-point value between 0 and 1, and where leaves have an associated letter. One notable feature of Huffman trees is that, due two how they are constructed by the algorithm, nodes are either internal nodes with two children or they are leaves.  There are no single child, internal nodes. This means we can build and define them without empty trees and without using `None`. 

We arrive at the following recursive, structural definition of a Huffman Tree.
> A *Huffman Tree* is either:
> - A Leaf with an associated weight and letter
> - A Node with an weight and left and right sub-trees

From this definition, and the needs of Huffman's algorithm, we can design two classes: `Leaf` and `Node`.

## Class Interface 

Leaves and Nodes require the same interface (set of methods):
*   `__init__`  Construct the leaf/node and initialize the attributes
*   `__eq__` and `__ne__` Test for equality and non-equality (==) and (!=)
*   `__str__` and `__repr_` Provide string representations of the leaf/node

That's really about all we need. The rest of the work associated with Leaves and Nodes is done by the huffman algorithm and functions that operate on Huffman Trees broadly. 

## Extract Codes

A Huffman tree can be constructed using the leaf/node methods. Once it's been constructed we need to extract the code embedded within the tree. Doing this requires a delicate recursive traversal that includes accumulating a running code and the code dictionary in function arguments. The function has the following interface

```python
extractCodes(H,book,code="")
"""
Given Huffman Tree H, extract the codes embedded in H and write them to the dictionary book.  
book is a dictionary of the complete codes discovered so far. Typically, it begins as an empty dictionary.
code is the code associated with the ancestors on the current path. It begins/defaults to the empty string. 
"""
```

To use this function, you first create a dictionary, then pass it along with your tree to the function. When the function completes, the codes will be written to the dictionary. 

```python

# .. build up your tree h
mycodes = dict() #make an empty dictionary
extractCodes(h,mycodes)
# .. mycodes now contains the codes for each letter
```

### Extracting Codes - Accumulating while Traversing 

The high-level goal of our extracting codes traversal is that we accumulate a path code as we proceed down the path so that when we hit a leaf node, we have the code for the letter in that leaf. This leads to the following logic:

> If you're dealing with a Leaf
>   *   then the value of code is the code associated with the leaf's letter. Add an entry to book. 

> If you're dealing with a Node
>    1. Recurse to the left tree with a 1 appended to the current value of code.
>    2. Recurse to the right tree with a 0 appended to the current value of code 

What's important in the `Node` case is that when `code` is the code on the path thus far, you recurse to the left with `code+'1'` and to the right with `code+'0'` and not with `code+'01'`.  Thankfully, python's immutable strings help in this regard as we cannot share and modify a string object through the recursive function calls. None the less, be on the lookout for accidental accumulation. 
# Huffman's Algorithm 

You can logically divide Huffman's algorithm into two parts:
1. Initializing the priority queue with the leaf nodes
2. Processing the queue and building the tree

You'll begin with a file that contains letters and their relative frequencies. We'll then use three functions to carry out the two stages of the algorithm.
1.  `todict` will read the file and create a frequency dictionary and `initializeQ` will take that dictionary and use it to initialize the priority queue.
2.  `buildTree` then takes the initialized priority queue and constructs the tree. 

The good news is that Python has a built-in [*minimum heap* module](https://docs.python.org/3/library/heapq.html#module-heapq). This module does not provide a heap class, but instead provides the methods needed to use a python list as a heap. There are some definite quirks to using this module, which we'll discuss, but you should definitely take some time to read the above linked documentation. Your main task will be interfacing with the module in order to carry out Huffman's algorithm. 


## Initializing the Queue and File IO

The first stage of or algorithm reads in a file and constructs a dictionary that maps letters to their relative frequencies. 

* `todict(file)` - Given the name of a file containing letters and their relative frequency, open and read that file into a dictionary mapping letters to relative frequencies

For example, if your file looks like this:
```
a .571
b .285
c .143
```

Then `todict` should produce a dictionary equivalent to this:
```python
{ 'a':.571, 'b':.285, 'c':.143 }
```

Once you've created your frequency dictionary/map, then you can construct leaf nodes and insert them into your priority queue. 

* `initializeQ(fmap)` - Given a letter-frequency map, return a heap containing Huffman leaves for each of the letter-frequency pairs in the map. 

[As discussed in the documentation](https://docs.python.org/3/library/heapq.html#priority-queue-implementation-notes), getting python's `heapq` to work as a proper priority queue takes a little tweaking.  In or case, we need elements in the queue to be a 3-*tuples* of *(frequency,insert order,tree)* where *frequency* is just the weight of the root of *tree* and insert order is an integer that says when the tree was inserted (0 for first, 1 for second, etc.). 

Assuming we inserted our three letters in alphabetic order, they would have the following tuples:
```python
(.571, 0, Leaf('a',.571))
(.285, 1, Leaf('b',.285))
(.143, 2, Leaf('c',.143))
```
The heap/list returned by `initializeQ` should contain the above tuples. If you look purely at the list, then the order should reflect that of an array-based heap (not strictly sorted but minimum frequency tuple first). 


## Python's Heapq: Heap-based Priority Queue

Once you've initialized the heap, you can carry out Huffman's algorithm. Review lab 1 for a refresher, but in  a nutshell you:
> Until there is only one item left in the heap
>    take the next two items out the heap and combine them into a singular tree/node
>    insert that node back into the heap    

The `heapq` module gives you all the methods you need to push and pop from the heap. The challenge you'll face is that at a conceptual level, we view the heap as a collection of Nodes and Leaves, but in reality it is a collection of tuples containing Nodes and Leaves.  So, you'll need to rethink the conceptual steps with respect to our heap tuples. All of this gets hidden away inside `buildTree` which should return the final tree. 

# Putting it All Together

You can now put all the pieces together. Assuming your letter-frequency file is named *myfile.txt*, your code might look like the following:

```python

lfmap = todict("myfile.txt") # get frequency map from file
q = initializeQ(lfmap) # setup initial heap from map
htree = buildTree(q) # run huffman's algorithm on q and get tree htree
mycodes = dict() #get empty dictionary to hold codes
extractCodes(htree, mycodes) # get codes from htree, write to mycodes

# do whatever you need to with the codes in mycodes
```

# (Optional) Dictionary Based Frequency Analysis 

If you really want to round out this project, then write a function that takes a raw text file and produces the frequency map file we used to start our Huffman coding algorithm. 

*   `getfrequencies(intxt,outtxt)` given the name of an input text file, open the file, read the contents, do a frequency analysis of the letters, and write the result to a file named outfile.

For example, if *message.txt* is the message to be encoded, then `getfrequencies("message.txt","messageFreq.txt")` will create a file named *messageFreq.txt* containing the letter frequencies for every letter/character in message.txt. 

# To Do

Below you'll find the order in which you should proceed through the project. You'll have some lab time to work on this project, but you'll need to spend a good chunk of time outside of class working on the project as well.  One notable feature of this project is that *you are not given initial files and function stubs*.  So, your first order of business (in or before the first lab) is to get organized and create the necessary files and stubs. Use the last several labs and the Card Hand project as a guide. 

1.  Lab 1: Create files needed for project. Stub out required functions in appropriate files. Build and Test Huff Leaf and Node classes.  
2.  Homework: Write tests for and complete `extractCodes`
3.  Homework: Write tests for and complete `todict`
4.  Homework: Write tests for and complete `initializeQ`
5.  Homework: Write tests for and complete `buildTree`
6.  Lab 2: Open time to finish up work. 