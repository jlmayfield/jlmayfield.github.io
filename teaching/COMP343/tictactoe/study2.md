---
layout: page
title: COMP343 - Alpha-Beta Pruning Study
permalink: /teaching/COMP343/tictactoe/study2/
---


# Study 2: Alpha-Beta Pruning

The first way we can look to improve on pure minimax search is by pruning. For this study you'll need to implement basic alpha-beta pruning and then compare it to standard minimax. 

### Your Todo

1. Implement an agent that uses alpha-beta pruning and minimax search.
2. Test said agent and compare play and the search times needed to your `Minimax` agent. 
3. Compare per-move search times to that of a Tabular agent. 

## The `ABPruning` agent.

A simple alpha-beta pruning agent will run standard minimax (no heuristics, no early cutoff) and use alpha-beta pruning to prune the search tree where possible. That's it. New heuristics, no prioritizing certain moves. Just take moves as presented by the `TTTState` and do minimax with alpha-beta pruning. 

In `pruning.py` you'll find a stub for the `ABPrune` agent. Complete the definition for this agent. It should be clear that you can base a large portion of this code off your `Minimax` agent. 

### Evaluating Alpha-Beta Pruning

Before worrying about performance, we need to ensure that our agent is playing rational.  A pure alpha-beta search agent should play perfectly; it's just a pruned version of minimax. So, have `ABPruning` play a lot of games against `MixedTabular`. They should all end in a draw. Here we use `MixedTabular` because it will play perfectly and it will play different games. If `ABPruning` can play it to a draw, then it too is playing perfectly. 

Once we know `ABPruning` is playing well, then we can worry about its efficiency. Given that we set out reduce the search needed by minimax, our expectation is that `ABPruning` will take less time to make a move than our `Minimax` agent. Have these agents play lots of games and compare their time-to-move. 

Finally, the `Tabular` agents represent an ideal in terms of time needed to carry out `getMove`. You can't do much better than a simple table lookup. Comparing move times needed for `ABPruning` to our `Tabular` agents gives us some clue as to how close to the ideal we've achieved. 