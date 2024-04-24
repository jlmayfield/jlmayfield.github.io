---
layout: page
title: COMP151 - Lab 8 - Binary Trees 
permalink: /teaching/COMP152/sp24/labs/lab8
mathjax: true
---

**[Get the Github Classroom Assignment Here](https://classroom.github.com/a/4QILxefm)**

# Lab 8 - Basic Binary Trees   

In this lab you'll cut your teeth programming with basic binary trees. You've been given a simple node definition that mirrors our simple recursive data model for binary trees. But first, let's learn about *fixtures* for unittest.

## Fixtures

When developing tests for your code, you often find that you'd like to have certain data or other helpful things that you can reuse from test to test. In our case, because it's a bit tedious to construct trees of a decent size, it would be nice to create a set of trees that we can call on for each of our tests. We could just copy and paste code from test to test, but that creates an unnecessary mess of code. The better way is to use **fixtures**.

Fixtures are effectively data/code shared by all your tests. To understand them, it's helpful to understand how your unittests get run. When you run your test script, the unittest module finds all your `test` methods within your test class. It will then run each of them to collect the results.  *However*, before each test is run a method called `setUp` is run. After each test is run, a method called `tearDown` is run. You can provide additional code for these methods and in doing so create pre and post test code. See [this section](https://docs.python.org/3/library/unittest.html#organizing-test-code) of the documentation. 

Today, we want to create some trees in `setUp` so that every test begins with a set of trees and we can focus on the test logic rather than constructing trees. For all intents and purposes, you can treat `setUp` like a constructor today. Declare variables using `self` and then reference them later, in your tests, with `self`. The stub for `setUp` already has one such variable and you can see it used in all the non-Node tests that were provided. 



## To Do

Now, you code. Do the following:

1.  In `setup`, create several (less than 10) different trees ranging in depth from 1 to 4. Go ahead and make them all trees of numbers. Be sure you have a decent variety of structures. 
2.  In *tests.py*, use your fixture trees to write more tests for the `size` function, which is stubbed out in *lab8.py*. Size returns the number of nodes in a tree.  
3.  In *lab8.py*, complete the definition for `size`. 
4.  In *tests.py*, use your fixture trees to write more tests for the `sum` function, which is stubbed out in *lab8.py*. Sum is given a list of numbers and returns the sum off all the numbers in the tree. 
5.  In *lab8.py*, complete the definition for `size`. 
6.  We now get to the traversals. We're going to do this via generators (yield) rather than functions (return). In `test.py`, add some tests using your fixture trees. You should use your generator to generate a list of the values as seen with the empty tree tests that are given. 
7.  Once you've written you traversal generator tests, go ahead and work on implementing the generators in `lab8.py`. 