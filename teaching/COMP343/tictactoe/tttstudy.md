---
layout: page
title: COMP343 - Tic-Tac-Toe Agent Study
permalink: /teaching/COMP343/tictactoe/
---

# A Game Playing Agent Program Study via Tic-Tac-Toe  

Tic-tac-toe is a simple enough game that we can implement and run agents that play **perfectly** via the standard minimax algorithm. Games last no more than 9 moves and the branching factor decreases as the game progresses. You don't even need to account for symmetry. Further more, the state-space is so small that we can compute a complete table of the true minimax *utility* of each state and use that as the basis for a perfect tic-tac-toe agent. So, while it's not a game that really requires modern AI techniques, it is a game where we can, using PC-level hardware, explore these techniques and benchmark them against AI with provably perfect play. 

You've been given all the game logic for tic-tac-toe as well as code that can run and report on complete games between two agents. The module `tictactoe` provides the class `TTTState` which encapsulates the representation of a game state along with all the necessary game logic. The module `tttengine` provides a single class, `TTTEngine` which is used to play games. 

The module `agent` provides the basis for building tic-tac-toe agents and contains two pre-implemented agents, `Human` for human players, and `Random` for a completely random agent. 

### Documentation Links

*   [`tictactoe` and `tttengine` module documentation](/teaching/COMP343/tictactoe/tictactoe/)
*   [`agent` module documentation](/teaching/COMP343/tictactoe/agents/)

### Specific Agent Assignment Links

1.  [Study 1: Perfect Agents](/teaching/COMP343/tictactoe/study1/)
2.  [Study 2: Alpha-Beta Pruning](/teaching/COMP343/tictactoe/study2/)

