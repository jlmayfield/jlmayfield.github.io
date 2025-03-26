---
layout: page
title: COMP343 - Tic-Tac-Toe Agents
permalink: /teaching/COMP343/tictactoe/agents/
---

# Agents 

For an agent to leverage the capabilities of `TTTEngine` it must provide two capabilities:
1. A read-only `marker` property which reports `'x'` or `'o'` depending on the agent's mark. 
2. A method `getMove` which takes in a board state (a `TTTState` object) and returns the row and column coordinates for the location in which the player wishes to make their mark. 

In a nutshell, agents need to be able to report on which mark their playing and where they want to play. That's it. 

## `Agent` and `AbstractAgent` Base Classes

The above requirements for an agent are captured and made explicit by the class `AbstractAgent`. This is an **abstract base class**; it provides no concrete implementation for agents but will hold any class that extends it to the required interface for an agent. 

The `AbstractAgent` class is extended by the class `Agent` this class fully implements all the needed functionality for the `marker` property. Thus, any class that extends `Agent` need only provide a concrete implementation for `getMove`. 

This means agent designers like you need only extend the `Agent` class and provide an implementation for the following method:

```python
def getMove(self,st : TTTState) -> Tuple[int,int]:
        """
        Given the current game state, return the desired move. Moves are specified by 
        the a (row,col) tuple where 0 <=row,col< 3. The move is assumed to be legal. 

        Parameters:
            st : TTTState - the current state of the game
        
        Return:
            Tuple[int,int] - return the desired move
        """
```

Let's begin by looking at `Random`, a not-so-intelligent agent build by extending `Agent`.

## `Random` Agent and Implementing Your Own Agent

A `Random` agent will make a random selection from all available moves. This is not rational, but it is agent-like behavior. The following definition for  `Random` can be found in the  `agent` module.

```python
class Random(Agent):    
    """
    Random agent. Agent will choose an available move at random.
    """
    def __init__(self, mark : str):
        super().__init__(mark)

    def getMove(self,st : TTTState) -> Tuple[int,int]:
        """
        Agent chooses a random, legal move.

        Parameters: 
            st : TTTState - current board state

        Return:
            Tuple[int,int] - row and column coordinates of the agents move.  
        """
        op = list(st.getOpen())
        return random.choice(op)
```

First, note that the class extends the `Agent` class via the declaration `class Random(Agent)`. This means that it will **inherit** all the concrete code implemented within `Agent` as well as the obligation to provide a concrete implementation for `getMove` that `Agent` inherited when it extended `AbstractAgent`. 

To successfully leverage `Agent`'s `marker` property implementation, the `Random` agent invokes the `Agent` constructor via `super().__init__(mark)` within its own constructor. *So long as your agent class repeats this pattern, it will also **inherit** all of the maker property logic.* 

Finally, `Random` provides an implementation for `getMove` with the exact signature specified by `AbstractAgent`. In doing so, it complete's the general agent interface and can be integrated with the tic-tac-toe logic provided by the tic-tac-toe modules. 

## `Human` Agent

The `Human` agent extends `Agent` and allows for a human to play tic-tac-toe using the provided tic-tac-toe logic. You can explore the code for this agent in the `agent` module. Here we'll just take note that the header and constructor follow the same pattern seen in the `Random` class: it extends `Agent` and invokes `Agent`'s construct as part of it's own constructor. 

```python
class Human(Agent):
    """
    Human tic-tac-toe player. Moves are determined via interactive text input. 
    """ 
    def __init__(self, mark : str):
        """
        Construct human agent to play as given mark.

        Parameters:
            mark : str - 'x' or 'o'
        """
        super().__init__(mark)    
```

The `getMove` implementation for `Human` is interactive. It requests, as text-input, the move from the Human. Human agents must express the row and column coordinates on a 1 to 3 scale rather than the CS standard 0 to 2 scale. Human agent provided input is checked and validated to ensure that an allowable move is selected. One notable 


## A Template for Building Agents

All of these leads to a template of sorts for building agents.  

```python
class YOURAGENT(Agent):
    
    def __init__(self,mark):
        super().__init__(mark)
        ...
    
    def getMove(self,board):
        ...
```

From here you can add more attributes to your agent and initialize them in the constructor. You can also add additional methods to the agent. Just treat `getMove` as the *main* method when it comes time to play tic-tac-toe. The `TTTEngine` that manages the game will call out to this method (and the `marker`) property and nothing else. 