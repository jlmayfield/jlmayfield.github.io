---
layout: page
title: COMP151 - Lab 7 - Linked-List Processing
permalink: /teaching/COMP152/sp25/labs/lab7/
mathjax: true
---


[Github Classroom Assignment Link](https://classroom.github.com/a/FDxSEefM)



# Lab 7 - Linked List Programming Practice

The `Node` based linked-list data structure is deeply fundamental to computing and underlies a lot of important abstract data types, include the *unordered list* and *ordered list* presented in our text.  In today's lab, you'll set aside the abstract data types for a bit and focus on just writing functions that work with linked-lists. Basically, we're going to repeat some classics but replace the python `List` type with our new linked list. 

### A Note on the `Node`Class

The book makes use of the `property` function (technically a class but just think function right now) to setup an easy to use `Node`.  At first, just focus on using `Node` as described in the book and illustrated in the class tests.  Once you've worked through this lab, it's worth a moment to at least skim [this article](https://realpython.com/python-property/) to better understand what `property` is doing and why.  

### Pointers on Linked-Lists

We'll discuss this in class but these points bear repeating. When dealing with lists, our usual source of bugs comes from *off-by-one* errors. With linked-lists the analogous problem is *None pointer* error, aka the *Null pointer* error.  All lists end with a `None` value and the `None` value plays the role of `[]` in representing the empty list.  The `None` value is **not** a Node. So, if we're not careful, we can assign `None` to a variable, say `curr`, then do something like `curr.data`.  This will cause the program to crash because we are attempting a Node operation on something that's not there. How do we avoid this? 

Remember that for any `Node` `n`, `n.next` either references a Node, or it references `None`.  So...
    *  Don't double reference (i.e `n.next.data`) unless you're absolutely certain next is a node. That kind of certainty is rare.
    *  If a variable takes is value from `n.next`, i.e. `n = n.next`, then do not hesitate to be aggressive with conditionals and check to see if that variable is `None` before doing `Node` operations. 
    *  If you view a variable as "a linked-list" or "a Node", then it can be `None` as well. Empty linked-lists are represented by the `None` value. Again, use a conditional and check to see if your "list" is empty, i.e. if it is `None`. 

As you're learning the ins and outs of linked-lists and Node-based structures, expect to get a lot of `None`-related errors. It's just a part of the process. 

### Typing Linked-Lists

Given the comments above, it seems we need a new way to express the type of a "linked-list".  In particular, any linked-list is either a `Node` object (possibly with more `Node`s following it) or it is `None`.  Thankfully, Python's `typing` module supports such a scenario.  If we want to say that something is a value of specific type or it is `None`, then we can use the `Optional` specifier. In this case, we want `Optional[Node]` to express "Node or None". This requires that we import `Optional` from the module `typing`, hence the `from typing import Optional` in `lab7.py`. 

### Problems

Here's today's TODO:
1.  You've been given a *sum* method to get started. Write tests for it.  More specifically, write three tests: (1) check that the sum of the empty list is 0 (2) check the sum of a list with only 1 number in it, and (3) check the sum of a list with at least 4 numbers. 
2. Now write the definition and tests for `sumbetween`. This time write 4 tests: one for the empty list, one for a list of length 1 where the value falls between a and b, one for a list of length 1 where the value does not fall between a and b, and one for a list of length at least 4 with a mixture of values in and out of the a to b range.  
3. Now things get interesting. Write the definition for `collectbetween` which returns a head reference to a new linked-list that contains all the values that fall between a and b. This will require extra Node/List variables above and beyond the `curr` that drives the traversal.  You'll need 2, specifically (1) a variable to point to the start of the new list (it should never change once set!) (2) a variable that points to the end of the new list so that you can *append* to that spot without having to traverse the list with each new value. We'll visualize this process in class. For testing, mirror the four tests you did for `sumbetween`. 
4. Write the definition for `reverse` that will compute and return the reverse of a linked list. Once again, this requires more than just the standard `curr` reference. I'll leave it to you to ponder out. I recommend you draw some pictures and work out an example. To test this you should once again write three tests: an empty list test, a length one list test, and a length >= 4 list test. 
5. (*Challenge!*) Let's do reverse again but this time do it *in place*. This means we want to modify the list we're given so that it's now in reverse. *You should not create any new nodes when doing this. Just modify the existing nodes*.  Hint: You have options here. Move data or more next pointers. 