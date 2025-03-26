---
layout: page
title: COMP343 - Perfect-Play Agents
permalink: /teaching/COMP343/tictactoe/study1/
---

# Study 1: Perfect-Play Agents

Our fist foray into tic-tac-toe agents is a direction not often available: absolute perfect play via direct minimax calculations. Given the relative simplicity of tic-tac-toe, this approach is achievable and fairly reasonable with standard hardware. We start here as perfect-play agents provide points of comparison and benchmarks for future agent programs that employ more pragmatic algorithms. After all, if other, not-necessarily perfect, agents can compete with our perfect agents, then they're clearly doing well! What's more, if they can compete with perfect-play agent while using fewer computational resources, then we can get a concrete feel for the ways in which they "work smarter, not harder." 

You're tasked with developing three agents. The first is a textbook minimax agent. The second agent opts to trade compute time for storage by pre-computing *all* the minimax values, writing them to a dictionary, and referencing that dictionary while playing. The final agent extends our tabular-agent by employing a mixed strategy. 

#### Your TODO

1. Implement the three agents described below.
2. Test and otherwise evaluate the performance of these agents. 

## Minimax Agent

A minimax agent performs a complete minimax search for every move. This is, by far, the most brute force of our agents. With each new move, the agent will need to play out all possible games from the current state and determine the optimal move. It does not pre-computing nor does it prune the search tree. 

**In the module `perfect.py` you'll find a stub for the `Minimax` agent class. Complete this class.** Remember, you must implement a *getMove* method with the specified signature. Your welcome to add any other helper-methods. You can also add extra attributes and properties as you see fit so long as you do not violate the design-constraints of the base class `Agent`. 

## Tabular

On the opening move of the game, a `Minimax` agent computes the utility for every possible state of tic-tac-toe.  The fact that this works in practice means we can, prior to the start of the game, pre-compute the utility of *every* state reached by every possible game of tic-tac-toe. If we store these values in a `dict` mapping `TTTState`s to their utility, then our agents can skip the search and lookup values as needed when choosing their best value. 

**In the module `perfect.py` you'll find a stub for the `Tabular` agent class. Complete this class.**.  Your agent should compute all the utility values for tic-tac-toe when it is constructed and store those values in a local attribute named `__util`. The good news is that you can and should use a modification of the minimax search to carry out this process; if you completed `Minimax`, then you have a good chunk of this work done. 

With this agent you'll need to be careful with how utility is calculate and used. In particular, be mindful of whether or not the agent is player 1 or player 2. If you want your agent to always be *max*, then the minimax procedure used to compute utility for player 2 actually starts with *min*'s play, not max, as we would expect from our minimax agent. 


## Tabular with Mixed Strategy Play

Both `Minimax` and `Tabular` choose the move associated with best utility for the agent.  This should lead you to a *pure strategy* where they agent will always choose the same move for a given state. A more interesting agent, and one that might fare better against other less-perfect agents, should employ a *mixed strategy*; when multiple moves have the same utility, the agent should choose from them at random. 

**In the module `perfect.py` you'll find a stub for the `MixedTabular` agent class. Complete this class.**  This agent is a relatively simple extension of your `TabularAgent`. If you've completed that agent, then this one follows pretty quickly.  Nothing changes about the calculation of utility values. It's all about how moves are choosen. Hint: you might want to check out [`random.choice`](https://docs.python.org/3/library/random.html#random.choice). It's really useful here. It was also used as part of the `Random` agent. 


## Testing Your Agents

In general, you'll want to at least spot-check that your `getMove` method works as intended. This can be done with unit-testing or basic run and print testing.  Once you know your agent will produce legal moves when presented with a state, you can turn to the real test: is this agent acting rationally? 

With games like tic-tac-toe we're a little less concerned with a performance measure and generally satisfied if the agent achieves their goal: to win. It turns out that when two people play a perfect game of tic-tac-toe, then the game ends in a draw. You'll prove this when you compute the minimax utility of the starting state. This means that a perfect agent playing an agent of unknown skill *should never lose*. This gives us a way to evaluate our agent's overall performance when playing. 

### Unit-testing and Checking `getMove`

Before you unleash your agent on a game of tic-tac-toe, you should verify that `getMove` will produce valid moves. You can use unit-tests for this (I like [pytest](https://docs.pytest.org/en/stable/)). However, you'll need to choose test cases for which you know the *right* move and maybe for which there is only one *right* move. It's also OK to just throw a bunch of states at `getMove` and check, by hand, that the agent is returning a valid, legal move. All you really need to test for is your agent's ability to engage in the problem, i.e. pick moves that work in a given state. The quality of the moves is largely then a function of it's overall performance in context. 

### Testing Performance 

Once you're confident that `getMove` is choosing moves, then you can start playing games and evaluating the performance of your agent.  In general, you have two options:
1.  Use the `Human` agent and play against your agent. Play lots of game. Play different moves. Get creative. If it always plays you to a draw when you're trying to win, then it's probably near-perfect or perfect. If you leave it an opening to win and it always takes it, then it's probably near-perfect or perfect. No matter what, your agent should not lose. 
2. Use `Random` and automate the play of *a lot* of games. Your agent should never lose. Given that a `Random` agent is likely to make mistakes, it should win. Maybe a lot. Either way, we can use repeated play against a `Random` agent to measure performance statistically in terms of your agent's win, loss, draw record. 

Once you have a perfect-agent at hand, then you have a third option:
3. Have you agent play *a lot* of games against perfect-play agent. They should *all* end in a draw. 

While playing against the computer is fun and a good way to spot check your agent, we'll be focusing on options 2 and 3 to evaluate overall performance. 

