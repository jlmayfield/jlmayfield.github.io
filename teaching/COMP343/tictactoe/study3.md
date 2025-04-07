---
layout: page
title: COMP343 - Shannon's Type-A Agents 
permalink: /teaching/COMP343/tictactoe/study3/
---


# Study 3: Heuristic Agents

Pure minimax searches are often impractical. Shannon knew this to be the case back in 1950. Alpha-Beta pruning can help take the edge off but for complex games, we need to do more to focus the Agent's search. To make AI play practical, Shannon proposed heuristic evaluation, depth-limits, and informed-pruning to narrow and guide the search. Study three will focus on these types of agents. 

## Your Todo

1. Implement the `TypeA` agent in the `heuristic` module. This agent should use a depth limit of 2 when states at the limit are quiescent. When evaluating non-terminal nodes, it should employ a heuristic like the one used in exercise 9 from chapter 5. Quiescent states in tic-tac-toe and the heuristic evaluation function are discussed below.
2. (Optional) Implement an enhanced Type A agent, `TypeAPlus` that includes alpha-beta pruning and move prioritization. 

# Shannon's Type A Agent

Shannon's Type A strategy has two key features:

1.  Depth-limited Searching with Quiescent State Cutoffs.   
2.  Heuristic Evaluation at non-terminal nodes

## Depth-Limits and Search Cutoff 

Complex games often balance the breadth of the search and depth of the search: How many potential moves should be considered and how far ahead should each move be played out. A Type-A agent will put a mostly-hard limit on the depth in order to devote resources to the breadth. When a search reaches it's depth limit and is in a quiescent state, then it should stop and evaluate the state. If the search is at or beyond it's depth limit but the state is not quiescent, then the search should continue until a quiescent state or a terminal state is found. Depth-limits can be managed through basic counters, but quiescence evaluation requires a heuristic-like function that can identify stability in the game.  So, what makes a tic-tac-toe state quiescent?


### Quiescence in Tic-Tac-Toe

Tic-tac-toe does not have the kind of action that games like chess have. The only threat is that you might lose. That threat is only serious when your opponent has two marks in one of the rows, columns, or diagonals, and you have not yet blocked them.  Conversely, if you can win because you control two of the tree spots in a row, column, or diagonal and have not been blocked, then the state is not quiescent. So, we define a **quiescent state in tic-tac-toe as any state in which nobody is one play away from winning.**  Notice that these states are largely confined to the early game and by allowing the search to stop early in the game we should be able to reduce the search time where it is typically at its highest. Cool.  

### Heuristic Evaluation

A heuristic evaluation function for non-terminal states should tell us if that state is good for the player or good for the opponent. Shannon points out that approximate evaluation functions (aka heuristic functions) should produce values that fall between the terminal state evaluation functions of +1 and -1.  In short, we want our heuristic to provide values between 0 and 1 if the state is better for our agent than it is for their opponent and values between -1 and 0 if the opposite is true. Ideally, the heuristic produces a 0 in a equally matched state and only produces 1 and -1 when the state is a terminal state. We can use heuristics that do not fall within the terminal state utility bounds, but that the requires careful management to ensure that agents weigh terminal states more seriously than heuristically evaluated non-terminal states. 

The text gave us a heuristic that makes a lot of sense (see Ch5, Ex9).  We'll generalize it here.  For simplicity's sake, define a **lane** to be an arbitrary row, column, or diagonal, i.e. one of the subsets of locations in which someone can win tic-tac-toe. Let *P2(st)* be the number of lanes where our player has two marks and the opponent has none. *P1(st)* is the same but with one mark. Then *O2* and *O1* are the same for our opponent. Our generalization of the book's heuristic then follows: 
```
H(st) = (3*P2(st) + P1(st)) - (3*O2(st) + O1(st))
```
This nearly fits Shannon's criteria. It should produce positive values when the player has a lot of open lanes in play and negative when their opponent does. It does not, however, produce values on a -1 to 1 scale. We can fix that easy enough by finding or choosing a normalizing value that, when used to divide H(st) will scale values to our desired scale. There are lots of systematic ways to do this, but really, we can just pick any positive number *n* such that `-1 < H(st)/n < 1`.  The ideal is something just less than the maximum of the absolute value of `H(st)` for all possible states `st`. We could actually compute this for tic-tac-toe using brute force. Let's just use a bit of reasoning to arrive at something reasonable.

The function `H` is going to produce it's highest values mid-game, when players have the chance to obtain an open lane with two marks.  If we assume *x* goes first and some wildly irrational play, then states like this are the kind that will maximize `H(st)`.
```
x|o| 
-----
 |x| 
-----
x|o| 

```
This state has a heuristic value of 10. Once *o* makes its next move, that value will go down and then *x* must either win or play in a lane that has no value. So, if the max value when players are doing weird things meant ot maximize the heuristic and not win the game is probably 10, then *10 seems like a good normalizer for real play*.  We can likely go lower. We can definitely go higher. Using 10 hedges are bits and makes sure that we can meaningful values that align with the utility of terminal states. We now update `H`:
```
H(st) = ((3*P2(st) + P1(st)) - (3*O2(st) + O1(st)))/10
```

# Towards a Type-B Agent

Notice that Shannon's Type A agent does not prune the search space. It constrains the search through depth-limits. If we can prune the breadth of the search as well, then, for complex games, we can trade the decrease in breadth for more depth.  In the end, we imagine that our agent would be searching as deep as possible but only doing so on paths that might matter. 

Your `TypeAPlus` agent keeps everything form the `TypeA` agent and adds alpha-beta pruning with move prioritization. We already know how to use alpha-beta pruning, so now we need to figure how to prioritize moves. 

## Move Prioritization

Basic Alpha-Beta pruning will fine-tune the breadth of the breadth of the search, but it is sensitive to the order in which you consider moves.  When you start with the best moves, then it will do better at pruning.  Of course, we can't really know, in general, which moves are best, so we apply a heuristic move evaluator. Shannon named this function `h`, we'll instead use `p`.  

The move evaluation function `p` takes the current state `s`, a move `m`, and the player making that move `p` and returns a estimate the quality of that move that we can use to prioritize moves. *In our case, we'll imagine that `p` is proposing an order from 1 on up* as follows:

1. Win: If the move causes the player to win. It's top priority, 1. 
2. Block: If the move prevents the opponent from wining on their next turn, it's priority 2. 
3. If the move improves the player's position according to our heuristic, then it's priority 3. 
4. If the move maintains the player's position according to our heuristic, then it's priority 4.
5. Otherwise, it's a bad move and makes the player's position worse. This is priority 5. 

We could be more detailed, more fine-grained, but we want `p` have low overhead and work quickly. But incorporating our heuristic, it's already going to incur some slowdown.  What we have above will at least prioritize the obviously good moves then try to make some attempt at then working through moves in a way that benefits the player. 

### Getting Moves in Priority Order 

We're currently getting moves in whatever order the `getOpen` method provides them. To get them in priority order we have some options. The most on-the-nose one being to use a **priority queue**. Thankfully, python provides what we need in the [`heapq`](https://docs.python.org/3/library/heapq.html) module. Here's what we do:

1. Put all the open moves in a list as a `(priority,move)` tuple.
2. Use `heapify` to convert the list into a min-heap in linear time.
3. Use `heappop` to remove each move in the desired order. *Don't forget the heap is built from Tuples and you'll need to separate the move from its priority. 

With that, we can now direct our agent to explore moves in what we hope will be best to worst order. When combined with alpha-beta pruning, we can expect some more efficient, intensional searching and a little less brute-force. 



