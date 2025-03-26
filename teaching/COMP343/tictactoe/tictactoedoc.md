---
layout: page
title: COMP343 - Tic-Tac-Toe States and Playing Tic-Tac-Toe
permalink: /teaching/COMP343/tictactoe/tictactoe/
---

# Tic-Tac-Toe Documentation 

You have access to all of the tic-tac-toe logic that you need. This includes representing states, checking states for key features, generating potential moves for agents, etc.  In short, the formulation of the tic-tac-toe problem has been done for you. What's more, you also have at your disposal a means for your agents to play complete game against other agents. For every game played you can get the result, a play-by-play account of the game, and a measurement of how much time it took your agent to make its move. In what follows you'll find documentation and examples on how you can make use of this code. 

# The `tictactoe` module and `TTTState` Objects

The module `tictactoe` encapsulates all of the move-level logic in a single class: `TTTState`.  A `TTTState` is, at its core, a representation of the current state of the game. From here it gives you everything you need other than the ability to actually complete a game. You are encouraged to explore the implementation of `TTTState`, but don't need to know how it works to complete your agent programs. 

## Boards as flat strings and Constructing Game States

A `TTTState` object maintains the board state as a flat string of `'x'`, `'o'`, and `'_'` which we'll call the **board string**. There are *nine* spaces on the tic-tac-toe board so a board string must be a length nine string. The board string flattens the 2D game board by listing each spot in row-major order: the first three locations are the top row in left-to-right order, then the middle row, then the bottom. For example, this state:

```
x| |o
-----
 |x| 
-----
o| | 
```

is represented as the board string `'x_o_x_o__'`.  

You can construct any board state by passing the appropriate board string to the constructor `TTTState`. If an invalid state or something not recognized as a board string is passed to the `TTTState` constructor, then it will throw an error. 

You can access the board string via the `board` property. Given a `TTTState` named `st`, `st.board` will return the board string for `st`. This state is immutable. You cannot change it. You can also get the board string via the `repr` method, i.e. `repr(st)`. If you wish to see the 2D board, then you can use the `str` method. So, `str(TTTState('x_o_x_o__'))` will return the 2D string representation of the board shown above. 

Finally, the `TTTState` class has implemented `__eq__` and `__ne__`. This means you can check states for (in)equality. There is also an implementation of `__hash__`, which means you can build `set`s and `dict`s with `TTTState` objects as the key. 

## Marks and Locations

In `TTTState` world, the player symbols *x* and *o* are referred to as *marks*. These should always be the strings `'x'` and `'o'`. While the `TTTState` objects generally work of flat representations of the 2D board. Most methods for interacting with the board operate in 2D space. Locations are the board are specified by row and column coordinates using, of course, zero-based indexing and row-column ordering. This gives each location the following coordinates. 

```
(0,0)|(0,1)|(0,2)
-----------------
(1,0)|(1,1)|(1,2)
-----------------
(2,0)|(2,1)|(2,2)
```

## Checking Locations and Making Moves

When presented with a board state, you're often needing to do one of the following:
*   check if a specific location is open or if mark has been placed at that location
*   get all the currently open locations on the board
*   determine what state follows from making a mark at a specific location 

All of these are available through `TTTState`. Given at `TTTState` object `st`:
*   `st.get(r,c)` will return `'x'` or `'o'` if a player has placed their mark at row `r` column `c` and will return `'_'` if location `r`,`c`, is open. 
*   `st.isOpen(r,c)` returns `True` or `False` if row `r`, column `c` is open. 
*   `st.getOpen()` is a generator that will generate, as a `Tuple`, the row,column coordinates for all the open locations on the board. 
*   `st.play(r,c,mark)` will return the state that results from placing `mark` at row `r`, column `c`. 

Of particular importance to agent developers are the methods `getOpen` and `play` as they will drive searches by generating potential moves and the states the result from those moves. 

## Checking the Game Status

In the event that you want to know the status of the game rather than a specific board position, `TTTState` provide a full complement of game state queries. For `TTTState` object st:
*   `st.isWin(mark)` returns `True` or `False` the state is a win state for the player with mark `mark`.
*   `st.isDraw()` returns `True` or `False` if all possible moves have been made and the game is draw.
*   `st.gameOver()` returns `True` or `False` if the state is final game state (win/loss or draw).
*   `st.getState()` will return the string `'x'` or `'o'` if the state is a win for that player, `'_'` if the game is over and is a draw, and `'?'` if the game is currently in-progress and undecided. 

As all tic-tac-toe agents are concerned with the goal of winning, agent developers will find `isWin` to be of use. The other methods might also find some use depending on your agent. 

# `tttengine` and playing games of tic-tac-toe using a `TTTEngine`

The `TTTState` class provides the logic for individual states and the transitions between those states. The module `tttengine` uses this class to deliver a playable tic-tac-toe environment via the `TTTEngine` class. A `TTTEngine` can oversee playing standard tic-tac-toe and time-limited variant of tic-tac-toe where each player as a fixed amount of time to complete all of their moves. We begin by focusing on standard tic-tac-toe and will discuss time-limited tic-tac-toe after. 

## Engine Construction

In order for your agents to play a game of tic-tac-toe, you must first construct a `TTTEngine`. This requires two `Agent` objects. For demonstration purposes, we'll use the `Random` agent that simply chooses an available move at random. To construct and engine that will pit two `Random` agents against one another, you would do the following:
```python
import agent

eng = TTTEngine(agent.Random('x'),agent.Random('o'))
```
Here we've chosen player 1 as *x* and player 2 as *o*. It is assumed that all `Agent` objects will declare their marks. Marks are error checked, but nothing stops you from having both agents play the same mark. The game will happily play and produce a garbage result. What's critical is that *you must specific the player agents when constructing your `TTTEngine`.*

## Playing With Output

A `TTTEngine` objects will play games in one of two ways: with output and silently. Here we focus on games with output. Such games will announce turns, moves, and results as the game progresses.  This kind of play is generally intended for use with `Human` agents but can be used with artificial `Agents` to get more robust feedback. To play out a game between our `Random` agents, we'd do the following:
```python
import agent

eng = TTTEngine(agent.Random('x'),agent.Random('o'))
result,history = eng.playGame()
```
Invoking the method `playGame` will start and complete one full game of tic-tac-toe. It returns two things: the result of the game and the move-by-move history of the game. These return values will be discussed in more detail below. 

## Silent Games

When benchmarking and otherwise evaluating an agent program, it's often preferable to forgo the detailed output and evaluate the game's outcome and move-to-move history via the engine's returned values. For this situation we have `playSilent`. To run our `Random` agent game in silent mode, we'd do the following:
```python
import agent

eng = TTTEngine(agent.Random('x'),agent.Random('o'))
result,history = eng.playSilent()
```

The return values of `playGame` and `playSilent` are the same. We'll now discuss them further. 

## Move History and Data Returned from play

A `TTTEngine` will record and return details about games played. More specifically, it will return a tuple consisting of the game's result (as a `str`) and a dictionary containing the complete move-by-move history of the game. In standard tic-tac-toe, the game result will be `'x'` or `'o'` if a player won the game and `'_'` if the game was a draw. 

### Move-by-Move History

The move-by-move history returned by `playGame` and `playSilent` consists of a python `dict` with `TTTState` keys. The keys correspond to the state in which a move was made. Values associated with that state are a three-tuple consisting of 
1.  The player mark for the player that made a move in that state as `'x'` or `'o'`.
2.  The row and column coordinates for their move as a `Tuple[int,int]`. 
3.  The number of milliseconds the took to make their move as a standard `float`. 

If `history` is our move-by-move dictionary, then `fst = history[TTTState()]` would be assign the move tuple for the first move of the game to `fst`. This means `fst[0]` is the first player's mark, `fst[1]` is the coordinates for their first move, and `fst[2]` is the time they took to make that move. The entry for the final board state will always have an empty tuple for the move, the game's result as the player, and the total time used by all players as the time to move. 

Here we see a short script for playing two `Random` agents against one another then reporting the results in a human-readable format. 

```python
from tttengine import TTTEngine
import agent


p1 = agent.Random('x')
p2 = agent.Random('o')
eng = TTTEngine(p1,p2)

result,history = eng.playSilent()

print(f"{result} won.")
for board in history:  
    if board.gameOver():
        print("Final Board:")
        print(board)
        print(f"Total time to play the game: {history[board][2]:.2f}ms")
    else:
        player = history[board][0]
        move = history[board][1]
        ttmove = history[board][2]
        print(f"From {board.board}, player {player} took {ttmove:.4f}ms to place their mark at {move}")
```

## Playing Multiple Games

When evaluating an agent program, it's likely that you'll want to play more than one game. For this `TTTEngine` provides the `resetGame` method. For `TTTEngine` object `eng`, `eng.resetGame()` will simply reset the board to the empty, starting board. You may then use `playGame` or `playSilent` to play another game. If you want to play with different agents (or a different time limit), then you need to construct a new `TTTEngine` object. 

## Playing Time-Limited Tic-Tac-Toe

A perfect tic-tac-toe agent is viable on off-the-shelf, personal computing hardware. To make things more challenging, `TTTEngine` objects can play a version of tic-tac-toe where players have a limit on the total time they can use to make all their moves. If a player uses up their alloted time, they lose. 

Below we have code to run and report on a game between two `Random` agents where each agent has at most 1 second to make *all* their moves. 

```python
from tttengine import TTTEngine
import agent


p1 = agent.Random('x')
p2 = agent.Random('o')
eng = TTTEngine(p1,p2,1)
result,history = eng.playSilent()

print(f"{result} won.")
for board in history:  
    if board.gameOver():
        print("Final Board:")
        print(board)
        print(f"Total time to play the game: {history[board][2]:.2f}ms")
    else:
        player = history[board][0]
        move = history[board][1]
        ttmove = history[board][2]
        print(f"From {board.board}, player {player} took {ttmove:.4f}ms to place their mark at {move}")
```

The only real change here is that the result of the game can now be `'x_clock'` or `'o_clock'` if *x* or *o* won due to their opponent running out the clock. 