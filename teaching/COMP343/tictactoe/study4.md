---
layout: page
title: COMP343 - Reinforcement Learning  
permalink: /teaching/COMP343/tictactoe/study4/
---

# Study 4 : Reinforcement Learning

Our final study is a quick and dirty introduction to reinforcement learning, specifically **temporal-difference Q-learning**.  A learning agent has been started for you. You'll polish it off, train it, and test it. The specifics of the algorithm will be discussed in the remaining class sessions. A set of [quick-notes with references to the relevant sections of the text](/teaching/COMP343/tictactoe/RL.pdf) will be provided. 

## ToDo

1. In the `TDQ` class in `learning.py`, implement an *exploration function* based policy in the `_selection` method. 
2. In the `TDQ` class in `learning.py`, implement temporal-difference updates in the `learn` method. Note that this method learns from a complete decision sequence and is, in practice, called after a game is played and given the history of that game. 
3. In `testlearning.py`  develop code to train then test your `TDQ` agent.  


## Finishing the `TDQ` Agent

Much of the learning agent has been completed or stubbed out for you. You're responsible for two things: implementing a learning selection policy that utilizes an *exploration function* and implementing a function that learns by updating the Q-function estimates using temporal difference updates. Below is a brief look at what's already done and some reminders and pointers about what's left for you to do.

### What's Done

**Construction** The `TDQ` agent constructor is complete and creates an agent with Q-function table `self._Q` and a (state,action) count table `self._N`. Both of these are implemented as `defaultdict` (aka Default dictionary) structures with a default value of 0. Keys are `(state,action)` tuples. Accessing a key that has not previously been added to the dictionary will return the default value and create an entry for that key. 

**MDP Modelling Functions** A **reward function** and **learning rate function** have been provided for you as `_reward` and `_alpha`, respectively. You are encouraged to start with them but welcome to try different functions if needed. 

**Learning and Playing Policies** The `TDQ` agent can function in two modes: learning mode and playing mode. In learning mode, the agent will use it's exploration-based selection policy. In playing mode it uses a mixed-strategy based on its current estimates for the Q-function. The method `gameTime` turns on playing mode while `studyTime` turns on learning mode. The playing mode policy has been provided as `_play`. The `getMove` function is already setup to choose a policy based on the agent's mode. You do not need to modify `getMove`. You also do not need to modify `_play` but are welcome to tinker with this policy if you wish.  You will be implementing the learning time policy `_selection`.

**Study Buddy** The `TTTEngine` will provide a complete, move-by-move history of a game. Your agent just wants it's decisions, i.e. the states it was presented with and the actions it took in those states. *Assuming your agent is player 1*, the helper method `_getp1` will take a game history and extract these decisions for you. What's more it will include with those decisions the state the followed the action. That means that `_getp1` returns the `(state,action,next_state)` triples for each of your agent's decisions. This lets you focus on learning and not worry about pre-processing a game history. Because that pre-processing should proceed learning updates, a line invoking `_getp1` has already been added to the stub for `learn`. 

### To Do 1: `_selection`

When learning, your agent should not just play moves that it thinks are good (exploitation) but try out moves of unknown quality as well (exploration). As discussed, the *exploration function* rates an action in a given state such that the agent can choose the highest rated action. The rating system is such that a balance is struck between exploration and exploitation. Our notes offers two different exploration functions for you to choose from. The `_selection` function should rate all the available actions for the current state and return the highest rated action according to your exploration function.

### To Do 2: `learn`

Your agent learns by first playing a complete game using it's exploration-function based selection policy and then using the decisions made in that game to update it's Q-function estimates. The `learn` method in `TDQ` manages these updates. It's given the history of game and uses `_getp1` to extract your agent's decision sequence. You need to update `self._Q` with that sequence using the temporal-difference update method. Once again, a learning rate function has been provided for you, `_alpha`.  You'll need to decide on a *discount rate* and update the Q-function estimates based off each decision in the sequence. Discount rates should be high (one or near one) as our problem is really about the pay out in the future (the end of the game). That being said, you're welcome to play with different discount rates and see what happens. 

## Learning

Before your `TDQ` agent is ready for prime-time, it should practice and learn the game. In `testlearning.py`, you will setup an informal test for your agent. It goes like this:

1. In learning-mode, play N games against another agent and learn from each game. 
2. In playing-mode, play M games against a opponent. 
    *   If your agent has truly learned the game and if the opponent is perfect (or human), then you would expect all M games to be a draw.eng.re
    *   If your agent has truly learned the game and if the opponent is not-perfect (maybe also human...), then you would expect it to either win or play to draw in all M games. No losses.
    *   If your agent still has things to learn, then you might expect it to lose some of the M games. 

There are definitely more rigorous ways to test a machine-learning based system, but we'll save that for Applied Machine-Learning.  For now, we'll just stick to the "looks like a duck, quacks like a duck, must be a duck" method of verifying that our agent has learned. 

### Experimentation and Validation

Your code in `testlearning.py` should be setup to run a single experiment. That means start with an un-trained `TDQ` agent, train it (step 1), then test it (step 2). Here are some variables you should explore when your agent is learning:

1.  Vary the opponent when training. Try random and a perfect agent. The truly patient of you will play your agent while it learns and get the benefit of watching it improve (warning: be ready to play 100s or 1000s of games...)
2.  Vary the number of training games. Try to find out the minimum number needed for your agent to "get good". 
3. Combine 1 and 2. Does your agent learn faster or better when playing random agents, perfect agents, or imperfect agents? 
4. Vary things like the learning rate, discount rate, exploration function, and reward function. 

The goal here is to figure out the requirements and limitations of learning. The ideal is learning to play perfect tic-tac-toe using the least amount of computation resources as possible. Do some informal experimentation and see what you can learn about learning tic-tac-toe. 

When checking just how well your agent plays, you should always play M>1 games. You should also check your agent's play against an opponent other than the one it played against when learning. The easiest, but most time consuming way to do this, is for you to play against the `TDQ` agent and mix up your own play. Play well, play poorly, play with a mixed-strategy, just probe the agent with your play style. The fastest way to check your agent is to use a mixed-strategy, perfect agent, play M silent games and count our draws and losses. Two computation agents will play 50+ games faster than you and your agent. Try a bit a both.

Whenever your agent plays a game via a `TTTEngine` you **must** reset the engine before it's next game. This is done via the `TTTEngine` method `resetGame`. Do not forget this step. If you do, then your agent will play one game and one game only. 




