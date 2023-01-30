---
layout: page
title: Game Dev Project - Game v0
permalink: /teaching/comp151/game/gamev0
---

**Due and Presented on Wednesday 2/8**

Your first game is less a game and more an exercise in basic graphics and animation. You can do whatever you want so long as your program does the following:
  1. Resizes an image
  2. Draws static (does not move) images to the screen
  3. Draws images dynamically (they move) to create animation
  4. Draws text to the screen either statically or dynamically
  5. Plays music
Some images and sound have been provided, but you are free to find or create your own game assets.  You can find a vast wealth of freely available game art at [Open Game Art](https://opengameart.org). In fact, all the assets provided with the project came from this site.

# Feature Progression

Programming is not an all or nothing proposition. Good programmers add new *features* to the program one at a time using a process called *iterative refinement*.  This means adding something new to the program, testing it, then building on top of that foundation. Each step is called an *iteration* of your program and represents a refinement of all prior iterations. You can also think of these *iterations* as versions.

For this game, I recommend you follow the following series of iterations. Remember, each iteration adds something to all prior iterations.

  1. Load and Play music.
  2. Place a whole image in the scene. *Example: Draw one background image*.
  3. Layer images. *Example: place backgrounds over one another.*
  4. Place part of an image in the scene. *Example: Put one character from a sheet into the scene*
  5. Resize an image. *Example: change the sizes of previously used images to make the scene bigger or smaller.*
  6. Make one thing move. *Example: Cycle through player animations*
  7. Make many things move. *Example: Infinite scrolling background with walking character.*

The key here is that you have a fully functioning program after each of the above iterations. If possible, you might even break down a step into sub-steps. For example, when layering images, you might plan to layer 4-5 images, but you'll want to do each one at a time to avoid accumulating too many bugs.

# Code Quality

Goal number one is to meet the feature specifications. If you've done that then your code meets the basic *correctness* standard. After that, we turn to other quality metrics like style, efficiency, and maintainability.  We'll clean a lot of this up on an as needed basis, but for now here are some things to consider as you code:
  * Are you variable names descriptive? Do that make the code more readable for humans?
  * Did you use uppercase names for constants and lowercase for variables?
  * Could you provide more annotation with comments?
  * Do you have unnamed values that repeat over and over? If so, you should make them constants.
  * Do you have variables or constants declared but then never use them? If so, get rid of them.
