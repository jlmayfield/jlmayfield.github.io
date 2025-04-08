---
layout: page
title: COMP151 - Lab 9 - Searching and Applications of Sorting
permalink: /teaching/COMP152/sp25/labs/lab9/
mathjax: true
---

[Github Classroom Assignment](https://classroom.github.com/a/GXA8H9Qr)


# Lab 9 - Search, Sort, and their Applications

Today's lab has two main goals:
1.  Explore basic search implementations using more generalized python functions with default parameters.
2.  Explore the applications of search and sort by using python's built-in sort and binary search to implement other algorithms. 

All told, you get a bit of very practical python (default function parameters, more generic functions, built-in sort and search) along with a nice dose of algorithm design and programming .

## Search For Location

We've mostly focused on searching for the existence of an item, i.e. python's `in` operator. Today you'll look at searching for the location of an item within a collection. This type of search has two standard options: location of the first occurrence and location of the last occurrence. When combined with our existence search, we end up with 3 searches: existence, first location, and last location. 

You're going to combine all of these into one general purpose search function: 
```python
def search(loa : List[Any], key : Any, loc : bool = False, first : bool = True) -> bool | Optional[int]:
    """
    A flexible search that can find the existence or location of the first or last item in a list. By default, search will return a bool indicating if the key exists in the list loa. When True is passed for loc, the search will return the location of key if it is found or None if it is not. The first parameter determines if the first location or last location is desired. 

    Parameters:
        loa : List[Any] - List to be searched
        key : Any - Searched for value
        loc : bool - True if location of key is desired, False if existence is desired.
        first : bool - True if first occurrence is desired, False if last is desired. Has not impact on existence searches. 
    
    Return:
        bool | Optional[int] -  Existence searches return booleans. Location searches return ints or None
    """
```

### Todo
1. Write `pytest` tests to cover all the sub-searches and their individual cases. Minimally, this means six tests. 
2. Complete the definition for the super flexible `search` as specified in `lab9.py`.  *Try to confine conditionals to the least amount of code possible.* Hint: One loop can serve the needs of all 4 versions of the search.

## Applications of Sort 

Many problems are meant to work on unsorted data. Sorting that data can often make problems easier to solve. Here we'll explore several problems and solve them by first sorting the data. We'll discuss this in class, but here's a rough sense of your target algorithms:

1.  For kth smallest, sort the data in ascending order and return the kth element in the sorted list. 
2.  For has duplicates, sort the data. If there is a duplicate, then you'll find those elements next to one another. Scan the sorted list and check if any element is equal to its neighbor. *Hint: Be mindful of how you iterate and how you check neighbors.*
3.  For closet pair, you first sort the data. The closest pair will be next to one another. Scan all the adjacent pairs of the sorted list and return the pair with the smallest difference. *Hint: Again, be mindful of how you iterate over pairs.*


### Todo

In `lab9.py` you'll find the specifications for three functions: `kth_smallest`, `has_duplicate`, and `closest_pair`.  For each of these functions you must:
1. Write `pytest` tests.
2. Complete the definition. Use python's [built-in sort](https://docs.python.org/3/howto/sorting.html) to first sort the data, then solve the problem on a sorted list. 

## MultiSearch 

We now know that standard search operates in linear time on unsorted data where binary search operates in logarithmic time on sorted data. When you need to perform multiple searches, it can be really helpful and efficient to first sort the data and perform binary searches rather than perform multiple linear searches. You already know how to use python's built-in sorting mechanisms, now we'll combine that with their built in binary search `bisect`.

The [`bisect`](https://docs.python.org/3/library/bisect.html) module contains two methods [`bisect_left`](https://docs.python.org/3/library/bisect.html#bisect.bisect_left) and [`bisect_right`](https://docs.python.org/3/library/bisect.html#bisect.bisect_right) that effectively carry out a binary search. They return the location where that item should be inserted into a sorted list, not the location of the item. So, they're not exactly a binary search but can be used as such with a little tweaking. Take a moment to read the documentation for the two methods listed above. 

### Todo

You have one required task and one optional task.
1.  Write `pytest` tests for `multi_search` as specified in `lab9.py`, and then complete the function definition. 
2. (Optional) Write `pytest` tests for `multi_search_idx`, the location-oriented version of `multi_search`, as specified in `lab9.py`, and then complete the function definition. This is tricky because you want to return the *original* location of the items, not their sorted location. The pythonic way of doing this would involve the use of the [`enumerate`](https://docs.python.org/3/library/functions.html#enumerate) function. *Hint: Python can sort tuples. When it does, they're sorted in a radix sort like manner, by first element, then second, and so on.* 