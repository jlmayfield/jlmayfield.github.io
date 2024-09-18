---
layout: page
title: Game Dev Project - Game v1
permalink: /teaching/comp151/fa24/game/gamev1
---

Version 1 of your game adds interactivity in the form of player controlled movement while also exposing how we might implement and transition between multiple game loops, each with different goals and controls. We still lack any kind challenge for your player to overcome, so it's a bit of stretch to call the outcome of version 1 a full game. None the less, it does make for a good prototype and a solid foundation on which we can build a true game.

# Requirements

The requirements for version 1 of your game are less specific than version 0. You'll need to envision a style or genre of game you'd like to create, and then implement a player movement system that supports your larger vision. In addition to adding a player movement system to your game, you'll learn to transform your animation into a start screen for your game.

  1. Have and be able to present an overall movement design goal for your game.
  2. Implement player movement that is sufficient for achieving your game's design.
  3. Turn your animation from version 0 into an introduction screen. The screen should instruct the player to press a key to play, then transition into a scene that allows the player to move according to your stated design. *The introduction and playing portion of the game should utilize two distinct game loops*. Add text to the intro screen (title and instructions).
  4. Use different music for the introduction and game portion of the program. See [the music documentation](https://www.pygame.org/docs/ref/music.html) for how to unload, load, start, and stop music.

# Code Quality

Goal number one is to meet the feature specifications, i.e. to correctly implement the movement dictated by your design. If you've done that, then your code meets the basic *correctness* standard. After that, we turn to other quality metrics like style, efficiency, and maintainability.  We'll clean a lot of this up on an as needed basis, but for now here are some things to consider as you code:
  * Are you variable names descriptive? Do that make the code more readable for humans?
  * Did you use uppercase names for constants and lowercase for variables?
  * Could you provide more annotation with comments?
  * Do you have unnamed values that repeat over and over? If so, you should make them constants.
  * Do you have variables or constants declared but then never use them? If so, get rid of them.
