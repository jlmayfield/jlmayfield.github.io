---
layout: page
title: COMP151 - Project 2
permalink: /teaching/COMP152/sp25/projects/project2/
mathjax: true
---

[Github Classroom Assignment](https://classroom.github.com/a/BeeOtmU3)


Your final project asks you to implement [Huffman Codes](/teaching/COMP152/sp25/labs/huffman/). This includes computing the code by constructing a huffman tree from symbol frequencies, encoding a message, and decoding a message. 

# Huffman Trees

Huffman trees are binary trees. Leaf nodes have an associated letter/symbol and all internal nodes have exactly two children. Due to the regularity of their structure, we can avoid the use of `None` and implement two variations: the `Leaf` and the `Internal`

In general, the `HuffTree` has the following recursive, structural definition:
> A `HuffTree` is either:
> - A `Leaf` with an associated *symbol*
> - An `Internal` with a subtree *left* and sub-tree *right*

The `HuffTree` class and it's two concrete sub-classes `Leaf` and `Internal` have been fully implemented in the file `HuffTree.py`.  Tests that demonstrate their basic usage and functionality can be seen in `tests.py`. You do not have to add, nor should you modify, these class definitions. You will, instead, be using them. Class time will be spent discussing both the definition and basic concepts of programming with them, and binary trees generally. 


# Extracting Codes from Trees

Once a Huffman tree has been constructed we need to extract the code embedded within the tree. Doing this requires a delicate recursive traversal that includes accumulating a running code and the code dictionary in function arguments. The function has the following declaration and stub in `project2.py`. 

```python3
def extractCode(htree : 'HuffTree',prefix : str = '',codes : Dict[str,str]=dict()) -> Dict[str,str]:
    """
    Extract the codes from the huffman tree and write them to a dictionary. The code parameter is assumed to be the code corresponding to the current node's ancestors, i.e. the current code's prefix. 

    Parameters:
        prefix : str - current path code.
        codes : Dict[str,str] - codes collected so far
    
    Return:
        Dict[str,str] - the complete dictionary.
    """
    return dict()
```

Using this function is a bit interesting and presents us with two issues. First, in order to have a code for a symbol in a leaf node, we need to accumulate a code as we traverse down a path. For internal nodes, we need to traverse both left and right. Meaning, our traversal is non-linear, direct iteration and accumulation will be tricky. So, we will use recursion and use the `prefix` argument to accumulate and pass codes from the calling instance of `extractCode` to the callee. We default this argument to the empty string `''` because when `extractCode` is called on the huffman tree root node, there is no prefix. Code accumulation can then occur as expected. This is just standard accumulator initialization but reworked for recursive functions rather than iterative loops. 

Our second issue stems from the fact that we also need to accumulate the code dictionary as we make recursive calls. Once again, the non-linear recursion presents a challenge. In general, we might imagine getting a dictionary of codes from the left sub-tree and another from the right. We can use dictionary `update` to merge these, but doing so in the midst of recursion creates the same kind of inefficiency that we encounter with using repeated `str` concatenation. Codes will get repeatedly re-written into dictionaries. So, rather than return and combine dictionaries, we can *thread* a dictionary through the recursion as a third argument. As codes are completed, they can be added to the dictionary. By initializing the dictionary to `dict()` by default, we can begin all extractions with an empty dictionary. Once again, standard iterate and accumulate logic molded to fit non-linear recursion. 

Finally, we can, after all the real work is done, return the dictionary argument. It should now be complete. Doing this along with the default empty dictionary argument allows users to use the function in an intuitive manner. 

```python3
# assume H is a HuffTree Root Node
codes = extractCode(H) #will default to '' prefix and dict() codes. 
```
## Diving Deeper into `extractCode`. 

A central goal of code extraction is to accumulate a path code (and dictionary) as we proceed down the path so that when we hit a leaf node, we have the code for the letter in that leaf. Mapping this to the tree's recursive structure leads to the following algorithmic logic:

> If you're dealing with a Leaf
>   *   then the value of prefix *is the code* associated with the leaf's symbol. Add this symbol and code to the code dictionary and return the dictionary. 

> If you're dealing with a Internal 
>    1. Recurse to the left tree with a 1 appended to the current value of prefix. Pass the in-progress dictionary.
>    2. Recurse to the right tree with a 0 appended to the current value of prefix. Pass on the in-progress dictionary. 
>    3. You're done. Return the code dictionary. It contains all the codes for this tree. 

What's important in the `Internal` case is that when `prefix` is the code on the path thus far, you recurse to the left with `prefix +'1'` and to the right with `prefix +'0'`.  Be on the lookout for accidental accumulation in the prefix that can lead to traversing right wit h`prefix + '10'`. 

# Message Encoding & Decoding 

Given a code dictionary, encoding a message is pretty straight forward. Traverse the message one symbol at a time and effectively replace it with its associated code. You'll be implementing this as the following function:

```python3
def encodeMessage(msg : str, codes : Dict[str,str])->str:
    """
    Given a message and a huffman code dictionary for that message, produce the encoded version of the message. It is assumed that every symbol in the message has a code in the dictionary. 

    Parameters:
        msg : str - String to be encoded.
        codes : Dict[str,str] - code dictionary

    Return:
        str - msg encoded with codes.     
    """
    return ''
```
In practice, be wary of using repeated string concatenation. Remember, `join` is your friend. By they way, you can absolutely complete this function in a single line of python using list comprehensions. See if you can work out the one-liner!

Decoding is a bit trickier. To do it efficiently we need to simultaneously traverse the huffman tree and the message. The tree traversal is, thankfully, linear. We only need to follow one path/code at at time. The 1s and 0s of the message will determine whether we continue left or right from internal nodes. Once we've reached a leaf node, then we decoded a single symbol. These symbols are accumulated and `join`ed into the final, complete message. You'll implement this process in the function:

```python3
def decodeMessage(msg : str, htree : HuffTree) -> str:
    """
    Given a message, msg, as a binary string and a huffman tree used to code that message, compute the 
    encoded message. 

    Parameters:
        msg : str - binary string (sequence of '0' and '1')
        htree : HuffTree - a huffman tree for the code used to encode msg. 
    
    Return:
        str - the decoded form of msg 
    """ 
    return ''
```
We'll discuss this algorithm a bit more in class, but it's similar in form to the linked-list traversals we've studied. You'll need pointers to tree nodes that get modified while you simultaneously traverse the message. 

# Huffman's Algorithm 

We'll step into Huffman's algorithm with the assumption that we've done a complete frequency analysis of the message we wish to encode and just need to produce the huffman tree itself. You'll implement this process as the function:

```python3
def buildTree(freq : Dict[str,float | int]) -> HuffTree:
    """
    Given a dictionary mapping symbols to their frequencies, use Huffman's algorithm to compute 
    a huffman tree relative to the symbols/frequencies in the dictionary.
    
    Parameters:
        freq : Dict[str,float] - dictionary of symbols found in a message mapped to their relative or absolute frequency in that message.

    Return:
        HuffTree - A huffman tree corresponding to the provided frequency analysis. 
    """
    return Leaf(None)
```
You can logically divide Huffman's algorithm into two parts:
1. Initializing the priority queue with the leaf nodes
2. Processing the queue and building the tree

For the first part, you'll need to traverse the the dictionary, create `Leaf` nodes for each symbol and combine them with their frequency to build a priority queue of leaves.  More on this below. One piece of good news is that that Python has a built-in [*minimum heap* module](https://docs.python.org/3/library/heapq.html#module-heapq) which can be used as a basic priority queue. This module does not provide a heap class, but instead provides the methods needed to use a python list as a heap. There are some definite quirks to using this module, which we'll discuss, but you should definitely take some time to read the above linked documentation. Your main task will be interfacing with the module in order to carry out Huffman's algorithm. 

## Initializing the Queue and File IO

Let's say we have the following frequency dictionary:
```python3
{ 'a':.571, 'b':.285, 'c':.143 }
```

[As discussed in the documentation](https://docs.python.org/3/library/heapq.html#priority-queue-implementation-notes), getting python's `heapq` to work as a proper priority queue takes a little tweaking.  In or case, we need elements in the queue to be a 3-*tuples* of *(frequency,insert order,tree)* where *frequency* is just the weight of the root of *tree* and insert order is an integer that says when the tree was inserted (0 for first, 1 for second, etc.). 

Assuming we inserted our three letters in alphabetic order, they would have the following tuples:
```python
(.571, 0, Leaf('a'))
(.285, 1, Leaf('b'))
(.143, 2, Leaf('c'))
```

In cases like this, where we have a bunch of initial values for the queue and we just want to get them in order, the most efficient process is to (1) put the items in a list then (2) [`heapify`](https://docs.python.org/3/library/heapq.html#heapq.heapify) that list. From there, we have what need to to work as a priority queue. 

## Python's Heapq: Heap-based Priority Queue

Once you've initialized the heap, you can carry out Huffman's algorithm. Review lab 1 for a refresher, but in  a nutshell you:
> Until there is only one item left in the heap
>    take the next two items out the heap (see [`heappop`](https://docs.python.org/3/library/heapq.html#heapq.heapify)) and combine them into a singular tree/node
>    insert that node back into the heap based on their frequency (and overall insertion order) (see [`heappush`](https://docs.python.org/3/library/heapq.html#heapq.heapify))   

The `heapq` module gives you all the methods you need to push and pop from the heap. Packing our trees into 3-tuples based on frequency and insertion order will ensure we get priority queue behavior out of our heap. The challenge you'll face is that at a conceptual level, we view the heap as a collection of Huffman trees, but really it's a collection of tuples containing Nodes and Leaves.  So, you'll need to rethink the conceptual steps with respect to our heap tuples. All of this gets hidden away inside `buildTree` which should return the final tree. 

# Dictionary Data Structure 

Dictionaries are a data structure that let you associate values with other values just like a dictionary associates a word with it's definition. In this project, we use them to associate a character/letter with its relative frequency or with it's binary code. The [official documentation](https://docs.python.org/3/tutorial/datastructures.html#dictionaries) offers a lot of guidance and examples. 

In python the "words" of the dictionary are called *keys* and the "definitions" are called *values*, thus we say a python dictionary as a map between keys and values. There are a lot of helpful things you can do to and with dictionaries, here's the essential methods from the [full list of dictionary methods](https://docs.python.org/3/library/stdtypes.html#mapping-types-dict). 

For any dictionary `d`:
*   `d.keys()` generate a sequence of the keys in d
*   `d.values()` generate a sequence of the values in d
*   `d.items()` generate a sequence of the (key,value) pairs in d as tuples. 
*   `key in d` return True if key is in d, False otherwise. (`key not in d` also available)
*   `d[key]` return the value associated with key in d. Raises error if key is not in d. 
*   `d[key] = value` associate key with value in d (adds if not there, modifies if already there)
*   `del d[key]` remove key,value association from d. Raises error if key not in d

Looping over a dictionary can be done a couple of ways. In general, you're interested in iterating over keys and values combined. 

```python
# get key and value from items
for k,v in d.items():
    ...k...v...

# iterate over keys, select values... like range loops and arrays
for k in d.keys():
    ...d[k]... 

```



# Putting it All Together

You can now put all the pieces together. You've been provided with a message and it's frequency analysis. From here we can do the following:

```python
msg = #your message
freq = #frequency analysis of message
htree = buildTree(freq) # run huffman's algorithm to get tree
mycodes = extractCode(htree) # get codes from htree
msg_encoded = encodeMessage(msg,mycodes) #encode message in binary
msg_decoded = decodeMessage(msg_encoded,htree) #decode binary from tree
print(msg,msg_decoded) # should be the same!
```

# (Optional) Dictionary Based Frequency Analysis 

If you really want to round out this project, then write a function that takes a raw text file and produces the frequency analysis of that file. From that you can start to encode things like an entire book from [Project Gutenberg](https://www.gutenberg.org/). 

*   `freq = getfrequencies(intxt)` given the name of an input text file, open the file, read the contents, do a frequency analysis of the letters, and return the results of the analysis as a dictionary.

# Requirements! 

1.  First Lab Warm-up: Use the contents of `lab1.txt` to write `pytest` tests for `extractCode`, `buildTree`, `encodeMessage`, and `decodeMessage`. Place these in the tests in `tests.py` with the prefix `Base`.
2.  Complete `encodeMessage` in `project2.py`
3.  Complete `decodeMessage` in `project2.py`
4.  Complete `extractCode` in `project2.py`
5.  Complete `buildTree` in `project2.py`
6.  In `tests.py`, construct a `pytest` test using the example in `testdata.txt`.  This test does not need to check the tree but should verify that encoding then decoding reproduces the original message.  Place this test in `tests.py` in the test called `bigsystemtest`.