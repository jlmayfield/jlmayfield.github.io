---
layout: page
title: COMP151 - Lab 5 - DIY Data Structures and Classes
permalink: /teaching/COMP152/sp24/labs/lab5
mathjax: true
---

[Get the Github Classroom Assignment Here](https://classroom.github.com/a/cgI5GQuZ)

In this lab we'll explore using Python's classes to create our own data structures. We'll begin with problem **R-2.4** from chapter 2. We'll then extend that problem with new class methods and functions that work with our new data structure and lists of our new structure.  *More details coming soon. For the eager, be sure to read section 2.3 from the text*

### Setting Up A Basic Class

1.  **Complete R-2.4** -  The `CreditCard` class shown in Code Fragment 2.1 (page 70) is an excellent point of reference for completing a basic class.  We should have studied it a bit in class. 
2. Printing the value of an object and checking if two objects have the same value are fundamental programming operations. They show up in many, many programs and we use them A LOT to debug our code.  We can integrate our new class into python's equality checking and printing by implementing the methods `__eq__` (for ==), `__ne__` (for !=), `__repr__` (used behind the scenes to print), and `__str__` (also used to print). **Add these four methods to your `Flower` class. 
3. At this point we have a class without a problem. Before we get to that, write tests that demonstrate/show that our `Flower` class behaves as it should, i.e. that once constructed, all the methods for setting attributes and getting attributes work as expected, that the equal/not-equal methods work, and that you can print a `Flower` object and see something meaningful. 
4. Now, let's add a more interesting method to the class. **Add a method called `pricePerPetal` that returns the per petal cost of the flower. For example, if a flower has 5 petals and costs $0.25, then it's price per petal is $0.05.  

### Solving `Flower` Problems. 

We can now start programming with `Flowers`.  When a customer places an order we can stick all the flowers they want into a list.  There are then several things we're likely to want to do with that order/list.  Be sure to write tests. In fact, I recommend you try the stub-tests-write method we explored in class. *You do not need to use recursion, but this is an opportunity to practice writing recursive functions.  Your call.*

* *Do these, in this order*. Notice they are familiar problems made new by the inclusion of Flowers 
    5. (sum) Write a function that takes a list of flowers and returns the total cost (sum of prices) for the order associated with that list. 
    6. (max) Write a function that takes the list of flowers and returns the Flower with the highest price per petal.  
    7. (contains duplicates) Write a function that takes a list of flowers and returns true if a flower appears in that list more than once. 
* *Time permitting, choose some or all of these to work on*. These functions correspond to newer problems. 
    8. Write a function that takes a list of flowers and returns a list of the names (only names) of all the flowers in the list. 
    9. Write a function that computes the average price of the flowers in the list. 
    10. Write a function that takes a list of flowers and a price and returns a list containing all the flowers whose price is at least the given price. 