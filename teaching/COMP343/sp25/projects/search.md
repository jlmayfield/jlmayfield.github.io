---
layout: page
title: COMP343 - Search Based Agents 
permalink: /teaching/COMP343/sp25/projects/search/
---


[Github Classroom Assignment Link](https://classroom.github.com/a/lkMX3q6P)


# Missionaries and Cannibals Solver      

For this assignment you'll implement and compare two search agents for the missionaries and cannibals problem: a *breadth first search* agent and an *iterative-deepening search* agent. Below you'll find a brief look at the code provided to you followed by some discussion of what you need to complete.  We'll spend some class time discussing this assignment as well.

## Starter Code

The following has been provided to get you started:
*   The file `frontiers.py` provides a `Stack` and `Queue` class.  All operations operate in constant time. *You do not need to modify any code in this file.* 
*   The file `Node.py` provides a partial definition for search tree `Node` objects. The `__init__`, `__str__`, `__eq__`, and `__ne__` methods are all complete. You've also been given a method named `getPathStateAction` which can be used to get the complete plan developed by your agent. This method will not work properly until you complete the stubbed out methods in the class (more on that below).
*   The file `problem.py` contains a partial definition for the class `MCState` which encapsulates the Missionaries and Cannibals problem logic. You've been given the methods `__init__`, `__str__`, `__repr__`, `__eq__`, `__ne__`, and `__hash__`. The remaining methods are stubbed out; you'll be completing them (more on that below).
*   The file `agent.py` has stubs for the two agent programs: `solve_bfs` and `solve_ids`. It also has a function for reporting on a solution as returned by the agent functions. Finally, a main conditional block has been written that will, when all the code is complete, run both agent programs and report on the results. 

*You should not modify any of the completed methods or functions.* You're welcome too modify and tweak the main program; you'll almost certainly want to do so for incremental testing purposes. Just ensure that what is there to start will run as expected when all the code is complete. Main-style conditionals are also in `Node.py` and `problem.py` if you want to do unit-test style testing on the code in those files.

## What You Need To Complete

Your tasks are presented here in a bottom-up fashion. That means, if you complete them in the order listed below, then you'll avoid any dependency issues between functions. You are not required to implement things in this order, and you are welcome to create extra methods/functions as auxiliary functions/methods for these functions. However, *you must complete these methods as specified*. No big changes to the overall design of the program. The docstring for each method/function provides more details about their specifications and class time will be dedicated to discussing each method as well.

1. In `problem.py`
    *   `isGoal` A method to check if the state is the/a goal state. 
    *   `isValid` A method that determines if the state is a valid puzzle state. 
    *   `getNext` Given an action, determine the state that follows by applying the action in the state in question. For example, `st.getNext((1,1))` returns the state that follows from moving one missionary and one cannibal when in state `st`.
    *   `getAllNext` A [Generator](https://wiki.python.org/moin/Generators) that yields (action,state) tuples for all actions that lead to valid stats from the state in question. For example, `st.getAllNext()` will generate all the actions one can take from `st` along with the state reached by taking that action. (This method should make use of the previous two methods: `getNext` and `isValid`.)
2. In `Node.py` 
    * `checkCycle` checks to see if the state associated with the node in question already exists along the node's parent path. For example, `nd.checkCycle()` returns true if any of `nd`'s ancestors has the same state as `nd`. 
    * `getPathActions` traverses the path starting at the node in question and collects all the actions along that path. For example, `nd.getPathActions()` returns a list of actions where the first is the action associated with `nd` followed by its parent node action, and so on.
    * `getPathStates` like `getPathActions` but for puzzle states rather than actions.    
3. In `agent.py`
    *   `solve_bfs` uses a breadth-first search to solve the missionaries and cannibals puzzle while also counting the number of nodes checked/expanded as well as the maximum size reached by the frontier/queue. It returns the node that captures the solution along with the two previously mentioned performance metrics.
    *   `solve_ids` uses iterative-deepening search and returns the same performance metrics as `solve_bfs`. Note here that we want the total nodes checked across all of the depth-limited searches as well as the max frontier/stack size reached by any depth-limited search. 

Once again, you can create any additional methods or functions you deem necessary, but your finished program must contain implementations for each of the above methods and functions and the code at the bottom of `agent.py` in the starter file should run as is. 