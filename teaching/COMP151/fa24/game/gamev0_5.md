---
layout: page
title: Game Dev Project - Game v0.5
permalink: /teaching/comp151/fa24/game/gamev0_5
---

Before we add player-controlled movement to our game, we need to **refactor** the code a bit. To refactor a program means to change its design and structure without changing its behavior and purpose. Externally, the program appears no different. Internally, the code is organized and written differently.

# From Game 0 to Game 1

Our refactoring has two goals:
1.  Extract the animation from main 
2.  Redo player animation and location in terms of Rect data rather than 

An example of what a refactored program might look like can be found [here](https://classroom.github.com/a/k0qSU0b3).  Use the code to guide your own refactoring and to help clear up any lingering bugs in your own code. *Do not use this code as the starting place for your game. Continue to work with your code from the first game project.* Below you can find a bit about why we're pursuing these goals in our refactoring. 

## Reorganizing `main`

Our current game is an animation, not a game. We'll use that animation as the start screen for a game.  Perviously, running the main function meant running the animation. In version 1 of our game running main will mean playing the animation until the player presses a specific key, and then running a level in which the player can move their character. This roughly means we have two distinct programs within our game: run the start animation and run the movement level. We'll want to move the main logic for the animation into it's own "main" and then call that in the real `main`. Additionally, it's a good idea to rename functions used specifically for the starter animation to make them distinct from functions used in the movement level as both parts of the program need some form of *tick* and *draw* logic. 

## From `int`s to `Rect`s

Movement and game mechanics generally will benefit from the use of pygame's `Rect` objects. We can redo our player animation logic in terms of Rects to prepare for this and just for a bit of practice using new Object data in a familiar context. You'll also notice that 

# Refactoring - To DO

Here's your to do list for refactoring your existing program:
0. If you have any lingering bugs or missing functionality from your original game, you might consider sorting that out before the refactor. However, code related to the player moving is going to change from integer variables to `Rect` variables and you might just skip that and work things out with `Rect`s.
1. Move animation logic from `main` to a new function then call that function in main. Once done, run the program and enjoy your animation. If something breaks when making the move, debug the problem to recoup your animation. 
2. Rework player animation in terms of `Rect` data
    * You need two `Rect`s, one for the player's location on the screen and one for the animation image. These are declared and initialized before the animation loop. 
    * Modify tick logic to update the animation rectangle y coordinate. Remember to change both the definition of functions as well as calls to functions. If you don't have functions, then now is the time to make them.
    * Modify draw logic to draw the player using the location and animation rectangles. Remember to change both the definition of functions as well as calls to functions. If you don't have functions, then now is the time to make them.

Once your program has been refactored, be certain to commit your changes and sync them to GitHub before launching into adding new features to the program. 

# Game v1 Prep - To Do

Once you've finished the refactoring, then there are a few small additions we can make to prepare for the new movement level.
1. To the animation screen, add a game title and instructions to press space (or whatever key you want) to start. (Hint: look at how the FPS text is placed on the screen).  
2. Modify the program so that the starting animation loop (and thereby the whole program) ends when the player presses the appropriate key. 

Once you've made these changes you're ready to focus on adding the movement level. 