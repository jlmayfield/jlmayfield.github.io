---
layout: page
title: Game Dev Project - Game v0
permalink: /teaching/comp151/fa24/game/gamev0
---

[Accept the Project Starter](https://classroom.github.com/a/HDfysqdN)

**This stage of the game is due on Friday 10/4. Games will be demoed to the class on that day!**

Your first game is less a game and more an exercise in basic graphics and animation. You're free to be creative and have fun with the project so long as you stick the specifications and requirements listed later in this page. If you have any questions about this or just want confirmation that what you plan to do meets the requirements, then do not hesitate to ask. 
  
Some images and sound have been provided, but you are free to find or create your own game assets.  You can find a vast wealth of freely available game art at [Open Game Art](https://opengameart.org). In fact, all the assets provided with the project came from this site.

# Requirements and Specifications

Your project *requirements* are about **what** your program must do and not about *how*. The **how** of your program, as in restrictions on how *requirements* are met, is a part of the program *specifications*.  In a nutshell, you should create a version (or replication) of the demo that you've been show in class. 

### Requirements 

Your program must:
1. Have one or more images that have been resized or otherwise transformed. 
2. Have one or more images that are drawn statically (exactly the same in each frame).
3. Have one or more background images that are drawn dynamically (changes over time) to create the moving, parallax background effect.
4. Have one or more character images that are drawn dynamically to produce movement-like animation. The position of the character need not change, but when combined with the parallax background, it should appear as though the character is moving. 
5. Render text to the screen either statically (like a title) or dynamically (like the FPS display)
6. Play music

### Specifications

Your program must:
0. Utilize functions for initialize of key assets and optionally of game variables. 
1. Utilize functions for *tick* event updates of **all** variables for dynamic animation elements. For example, a function could be written called `tickCharacter` which takes the current character animation variable and returns the next value for that variable. Options include, but are not limited too, one function per variable or one function that returns multiple values (one per variable). 
2. Utilize functions for *draw* events for **all** variables for dynamic animation. These functions will typically take at least two arguments, the surface on which drawing is to take place and the variable that determines what is drawn on the surface. 
3. You are encouraged, but not required, to have a function called `onTick` and another called `onDraw`. The function `onTick` will manage all tick even variable updates (possibly by calling functions for each variable) where `onDraw` will similarly manage all draw event updates (again, by possibly calling other functions to draw parts of the scene relative to individual variables).
4. All functions must include proper docstrings and type declarations. 
5. Adhere to good naming conventions including lowercase starting names for variables and all capital letter names for constants. 
6. Use globals *only* for constants. All variables must be declared within functions (`main` or otherwise) and passed to other functions as needed. 
7. Avoid the use of *magic numbers* and *hardcoded* values. Use named and computed constants whenever prudent. 
7. Submitted programs **must** run. A functioning program that meets some but not all of the requirements is infinitely better than a program that "meets the requirements" but doesn't run.  Running and then eventually crashing should be avoided but is better than crashing before it runs. (The later is usually a syntax problem where the former is a runtime or logic error). Do not hesitate to comment out buggy code in order to recapture a previously working version of your program. 


# Feature Progression

Programming is not an all or nothing proposition. Good programmers add new *features* to the program one at a time using a process called *iterative refinement*.  This means adding something new to the program, testing it, then building on top of that foundation. Each step is called an *iteration* of your program and represents a refinement of all prior iterations. You can also think of these *iterations* as versions although versions usually involve multiple features and bug fixes. 

In addition to giving you a functioning (albeit static) animation, the starter program gives you a pretty big head start on meeting the project requirements and specifications. It already plays music, displays a static image, and utilizes functions as specified. Your task to *iterate* on this program to complete the requirements. As you complete an iteration, you should go ahead and *commit and sync* your code. 

Here's what I advise:
1.  Modify the program to scale the character sheet and display only a single character. 
2.  Modify the program to place the remaining background images (do one at a time and test!) while keeping the player character image visible (move it as/if needed).
4.  Modify the program so that the character is "walking in place" (i.e. add character animation).  
5.  Modify the program so that one of the background images is animated. 

After the five iterations above are complete, you will have met the minimal requirements. You can then add on some creative flairs as you see fit. Here's some fun ideas:
* Have a story in mind, give your game a title, and display it on the screen. 
* Add more characters. Maybe they're all marching in a line? Maybe two characters are approaching each other? Maybe some are standing still? Don't forget, you can scale each character! Maybe there are kids or hobbits in your game! 
* Try to make the background animation rate change over time. (Hint: the amount you add/subtract on each update is now a variable.) 


