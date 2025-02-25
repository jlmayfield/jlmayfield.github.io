---
layout: page
title: COMP151 - Lab 6 - Stacks and Queues
permalink: /teaching/COMP152/sp25/labs/lab6/
mathjax: true
---


[Github Classroom Assignment Link](https://classroom.github.com/a/HXg6Fbsq)


In this lab you'll be writing functions that implement algorithms that make use of stacks and queues. The big conceptual change here is that the function does not directly tackle the problem using the given data structure, strings and lists, but instead moves the letters and numbers through stacks and queues in order to solve the problem. 

A Stack and Queue class have already been implemented for you. They have the same interface as the ADTs described in the text. The class definitions can be found in `linearstructures.py`. *You do not need to do anything to these classes but are welcome to look at them.* The `Stack` and `Queue` classes have already been imported to `lab6.py`, where you'll put your code.  Both the `Stack` and `Queue` implementations used here require O(1) operations for all the standard methods. In the case of the Queue, this is an improvement over the book; we'll explore this future in the future. 

Today you effectively have two problems to tackle: palindrome detection and sorting.  Details for each can be found below. Each problem has some extra questions about the running time of the algorithms. Answers to those questions should appear in the functions' docstrings. 

## Palindromes, Again

Consider the following algorithm for string palindrome detections:
> Read a string, one character at a time, into both a queue and a stack. Then, so long as neither the queue nor the stack is empty, remove the next item from each structure and compare them. If the are not the same character, then the string is not a palindrome. If the are the same character, then continue the process. If both stacks empty and the same time and all the characters were equivalent, then the string was a palindrome. 

1. Implement this algorithm as a function that takes a single string and returns a boolean. Write pytest tests to check your code. 
2. Assuming all stack and queue operations take O(1) time, what's the Big-O complexity of this algorithm? Put your answer in the docstring of your function. 


## Radix Sort

Consider the following problem from your text. 
>18. Implement a radix sorting machine. A radix sort for base 10 integers is a mechanical sorting technique that utilizes a collection of bins, one main bin and 10 digit bins. Each bin acts like a queue and maintains its values in the order that they arrive. The algorithm begins by placing each number in the main bin. Then it considers each value digit by digit. The first value is removed and placed in a digit bin corresponding to the digit being considered. For example, if the ones digit is being considered, 534 is placed in digit bin 4 and 667 is placed in digit bin 7. Once all the values are placed in the corresponding digit bins, the values are collected from bin 0 to bin 9 and placed back in the main bin. The process continues with the tens digit, the hundreds, and so on. After the last digit is processed, the main bin contains the values in order.

1. Implement this *machine* as a function that takes a list of integers and returns a sorted list. The original list should be left unchanged. Write pytest tests to check your code. **Assume that all the integers are in the range [0,10000).** (Hint: It might make sense to create a `List[Queue]` for your digit bins.  While not necessary, it will prevent tedious, potentially error prone duplication of code and can avoid long conditionals.)   
2. Assuming that all *queue* operations are O(1), what is the Big-O runtime of this algorithm? Put you answer in the docstring for your function.
3. (**Challenge**) Write another radix sort function that allows for arbitrarily large integers. 
4. (**Challenge, part duex!**) Assuming that all *queue* operations are O(1), what is the Big-O runtime of this algorithm? Put you answer in the docstring for your function. 

## A Note on Digit Extraction

We can easily extract digits from an integer using the integer division operations `//` and `%`.  Consider the number 1357.  Let's say we'd like to isolate the 5.  First we note the place of the 5; the ten's place. We can then use that place to deconstruct the number: `1357//10 = 135` and`1357%10 = 7`.  Now notice that the digit we want, the `5` is in the 1's place of the `135`. Applying the same logic, we get `135%10=5`.

In general, if from some integer `n` we want the digit in the $10^k$ place, then we can compute that by doing (n//10^k)%10. This requires *O(1)* operations.  

Alternatively, we can convert the integer to a string and select the location: `str(n)[k]`. However, the string conversion presumably requires at least $O(log(n))$ operations. In fact, it requires $O(log(n)^2)$ due to the fact that we convert  So, the mathematical approach is preferred. 

5. (**Challenge**) Why does `str` for integers require at least $O(log(n))$ time? 