---
layout: page
title: Game Dev Project - Game v2
permalink: /teaching/comp151/fa24/game/gamev2
---

# Requirements & Specifications

We now come to the part of the project where we complete a full game or at least a solid prototype for a game. 

## Requirements

To complete your game you must include the following to the version 1 code: 

  1. *An Interactive Environment* - Stuff to collect, Enemies to contend with, Platforms or walls to navigate, obstacles to avoid, etc..     
  2. *An Objective* - Complete a task before time runs out, Defeat an enemy, Solve a puzzle, last as long as you can in a hostile environment, etc.
  3. *A Game Over Screen*  When the game is over, present the player with some indication of how well they did and ask them to hit Q (or some specified key) to quit. 

These requirements are very broad in order to leave you room to be creative. If you'd prefer a very specific objective to work on, then there is a game, with starter code, discussed below. You can also use this as a point of reference when considering your own ideas. When in doubt, *ask if your ideas meet the requirements before getting too far down the programming rabbit hole.*.

### Getting More Art

As a reminder, you can find some fun, free artwork at [opengameart.org](https://opengameart.org/). Limit your search to 2D art.  The starter code I've provided includes a two-animation-frame ghost image.  You can also just draw shapes as placeholders and not worry about art. 

## Specifications 

Where the requirements are fairly broad, the specifications are a bit more strict.  You must:

* Make use of one more more lists to manage the state of objects in the environment.  
* Utilize functions effectively, and in particular, list-processing should be managed via functions designed specifically for the task at hand. 
* All functions must be properly documented with docstrings and type declarations in the header.
* Test at least the list-processing functions *using unittests and `pytest`*. Unittesting of other functions is encouraged.
* Make use of randomness. 


## A Concrete Game-Project and Starter Code

If you'd rather just build a game on top of a pre-built set of code instead of continuing to work with your existing game code, then you can do this. [This github classroom assignment](https://classroom.github.com/a/ynHEh9tC) contains starter code for a top-down style game. There is a start screen and the start for a level.  You just need to complete the requirements given above. Here's a good way to do that: 

* Have objects (rocks/ghosts/fireballs/etc.) spawn randomly at the edges of the screen and move, at random speeds, towards the opposite side of the screen.  
* The game ends when the player is hit by one of the objects.  
* When the game ends, report back on how long the player survived (in seconds). Longer is better, obviously.

To implement this game you'll need to use lists of `Rect` and `Vector2` data as described below in order to manage the moving objects. You'll need to use randomness, as described below, to (a) decide on which of the 4 walls an object should appear (b) where, the x or y coordinate, on that wall it should appear, and (c) the velocity of the object. Finally, you need to keep track of the total time, as described below, the player stayed alive. 

### Recommended Feature Iteration Order 

I recommend the follow series of iterations on the program features:
1. Add a clock to the game and display the current time, in seconds, at the top of the screen. 
2. Add "rocks", but have them only spawn on one side of the screen. Do not worry about collisions. Just have them spawn, move, and disappear (make certain the disappear form your list when then disappear from view). 
3. Add player+rock collisions. When the player is hit by a rock, have the game end without a game over screen.
4. Add the game-over screen. **At this point your game is feature complete. Beyond here you're making it more engaging for the player.**
5. Have rocks spawn from the remaining 3 walls (add 1 wall at a time). 

# Expanding Your Game-Dev Toolkit

Before we look specifically at adding interactivity and objectives to our game, let's look a few helpful general-purpose things that can enhance your game development process. The first is random numbers; a bit of randomness keeps games from feeling like running through a script. Second, we'll see how we can make animation a bit easier and flexible by using lists. Finally, we need to re-visit the relationship between the rectangles representing a player or thing on screen and the rectangle that covers an animation image.

## Random Numbers

Python includes a `random` module for utilizing randomness in your programs. One of the ways randomness occurs in games is to assign random starting locations and/or velocities to objects.  What this boils down to is a random integer from some interval \[min,max\].  The function `randrange` gives you exactly that. If *min* is the smallest possible value you want and *max* is the largest, then `random.randrange(min,max+1)` will give you a value from your desired range with an equal chance of getting any number in the range.

Another likely scenario is that you want either something from \[-max,-1\] or \[1,max\], or equivalently something from \[-max,max\] except for zero. Such situations occur when you want random velocities but want to make sure something is moving. You can still achieve this with only `randrange`. First we generate a number from `randrange(1,max+1)`. Then, we essentially flip a coin to see if the number stays positive or goes negative.  We can accomplish the coin flip with `randrange(0,2)`.  We can put this together using either a conditional or a bit of math.
```python
# Option A: Conditional Based
rand_val = random.randrange(1,max+1)
if random.randrange(0,2) == 1:
  rand_val *= -1

# Option B: Math
# recall -1^0 = 1 and -1^1 = -1
rand_val = -1**random.randrange(0,2) * random.randrange(1,max+1)
```
The `random` module provides other ways to generate random numbers along with other forms of randomness.  Feel free to explore it, but you can most likely get whatever you need by using `randrange` one way or another.

## Animation and Modular Arithmetic

So far our animations have assumed regularly spaced image in a grid like pattern. We could then use modular arithmetic to count through the row or column  coordinates associated with the images. For example, if your images are 16x17 and you have a column of 4 images, then we used `(y+17) % 68` to cycle the y coordinate for our image rectangle through the four images in the column. With lists we can trivialize the modular arithmetic. Consider the following code:

```python
img_y = [0,17,34,51] # the actual y coordinates
curr_img = 0 # which image we're using (0,1,2, or 3)
...
y =  img_y[curr_img] # get current image y coordinate
curr_img = (curr_img + 1) % len(img_y) # update for next image
```

What this does is simply collect the actual coordinates for our image into a list then cycle through the locations of the list using modular arithmetic. The modular arithmetic is simple counting by 1 up to, but excluding, the size of the list. Here's the really, really cool thing about this approach: *it works for any number of images and even when there is no relationship between the coordinates*.  This means you can use animation sheets with variably sized and spaced images by collecting their relevant coordinates (and possibly the width and heights) into lists.  *You can also take this one step forward by replacing coordinates with a full `Rect` for your animation image or even just the image itself!* In this case, you create the lists during the initialization phase of the game/level then select from them during the game loop. 

## Image Rectangle Size vs Environment Rectangle Size 

Thus far we've just assumed the player's location rectangle and their image rectangle have the same width and height. Now that players and objects are colliding, this might not be the case. Images often have a border of (transpartent) pixels on them.  So, *if you want good, realistic looking collisions, then you want to make sure the on-screen rectangle for your player and objects is tight around the viewable character/object or even just a hair smaller.*  You'll likely need to experiment with this. It's also highly dependent on the art with which you're working. 

# Implementing Interactivity and Objects in the Environment with Lists

In order to create interactivity, you need something with which your player can interact. Fortunately, we already know how to add things into the environment because we've added the player character into the environment.

  * *Everything* needs a `Rect` to represent the space it occupies within the playing area. See above for notes on tightening up these rectangles relative to the image for the object.
  * *If the thing can move*, then you should be using `Vector2` objects to represent velocity, and acceleration as needed. Just like with your player, the style of movement your game requires will determine the number of variables/`Vector2`s you need to represent the thing.
  * *If the thing is animated* (and you're using an animation sheet like we have been), then you also need a `Rect` to represent which animation frame you are currently showing the player.

Let's say your game has some bad guys, that those bad guys move in a sliding-gliding, velocity-based pattern with animation, and that both the player and the bad guys shoot projectiles that use velocity-based movement but no animation.  Then:

  * Every enemy needs it's own screen Rect, image Rect, and velocity Vector2
  * Every projectile needs it's own screen Rect and velocity Vector2.

Even if you only have one bad guy, you're likely to have multiple active projectiles. What's more, the number of projectiles on the screen can vary from frame to frame.  So, we don't know how many sets of variables we need!  That's OK, because we have lists!

## Lists and the *Structure of Array* Pattern

Let's now consider a game with multiple bad guys that move independently and are animated. This means each bad guy needs four attributes/objects: location vector, velocity vector, screen rectangle and image rectangle. We can organize this data into four lists, one per attribute. This data-organization pattern is called a **structure of arrays**. Let's work a simple, made-up example with two enemies.

Assume that `NPC_W` and `NPC_H` are the width and height of the enemy's on screen rectangle, `NPC_IW` and `NPC_IH` are the image rectangle dimensions, and that `SCREEN_W` and `SCREEN_H` are the width and height of the screen. Then we might initialize two enemies as follows:

```python
# start with loc and velocity. Set x,y accordingly. Perhaps random!
npc_loc = [ Rect( (... , ...) , (NPC_W,NPC_H)), Rect( (... , ...) , (NPC_W,NPC_H) ) ]
npc_vel = [Vector2(..., ...), Vector2(...,...)] #again, maybe random starting velocity
# animation image rects. again, set x and y accordingly
npc_img = [ Rect(... , ... , NPC_IW,NPC_IH), Rect(... , ... , NPC_IW,NPC_IH)]
```

The data for the first enemy is at index 0 in each list, i.e. their location is `npc_loc[0]`, velocity is `npc_vel[0]`, and image rectangle `npc_img[0]`. Each subsequent enemy has their data at their own shared index.

If you have lots of objects to manage, then functions can make the setup easier. In all cases, functions will make managing and coordinating the lists easier. For example, if you're starting bad guys at random locations, then you can write a function to generate that list (think: given number of desired bad guys, generate list of that many location rectangles). The same goes for velocity. 

### Removing Objects From Play

Where things can get tricky is removing objects from the game. This happens if a projectile moves beyond the borders of the screen, if the player destroys a bad guy, when something is collected, etc. If you want to get rid of something whose data is located at index `i` in a structure of arrays design, then you must remove that data from index `i` in all the lists. We did not see this kind of thing in our load data lab.  

To accomplish this you'll first want to collect the index values for any/all objects that need to be removed from the game. For this you should be thinking in terms of a function that takes some or all of your lists and returns a list of indexes for the objects you need to remove. You can then remove those locations from each list. This is a *filter* operation according to index: *given a list of bad guy data and a list of index values to get rid off, keep all the items in the bad guy list that are not located at one of the values in the index values*. This can be tricky, so we'll work out a version of this in-class to help you out. 


## Collisions

We use object screen rectangles to manage collisions. This is why having tight screen rectangles is really important. Generally speaking, a collision occurs when two objects occupy the same space, i.e. when their rectangles touch or overlap.  Thankfully, the pygame `Rect` type provides a wide array of collision *predicates*, functions that return `True`/`False` values.  Perhaps the most fundamental of these is [`colliderect`](https://www.pygame.org/docs/ref/rect.html#pygame.Rect.colliderect).

The `colliderect` method acts on a rectangle and takes a rectangle as an argument. It returns `True` if the rectangles collide and `False` otherwise. For example, if `pc_rect` is the screen rectangle for our player and `npc_rect` is the rectangle for a non-player character, then we can use `colliderect` as the basis for a simple collision conditional.
```python
if pc_rect.colliderect(npc_rect):
  ...
```

It's up to you, the programmer, to determine what should happen in the event of a collision. Pygame, at least, gives you the ability to easily check collisions. Check out the documentation for `Rect` to see about other collision detection methods. There is one for collision with a point and two for handling collision with a list of rectangles and not just a single rectangle.


# Game Objectives

Games have goals. Players need to score points, beat the clock, survive a hostile environment, etc. Pygame provides a means for tracking time and most other scoring or point systems can be managed with simple variables.

## Time in PyGame

The tick method for pygame clocks does two things: set the frame rate and return the number of milliseconds since the last time you called tick. Because we call tick every frame, what is returned is the number of milliseconds since the last frame. From this we can begin to count the total time our loop has been running using accumulation. For example, let's say we want our game to have some time limit like 90 seconds. We can save that to a variable `TIME_LIMIT`, then keep track of the total seconds passed since the start of the loop by having an accumulator variable `time` which we start at 0 and to which we add, each time through the game loop, the seconds since the last frame.
```python
# within the game loop
sec_passed = clock.tick(60) / 1000
time += sec_passed # total time passed (in sec.)
time_left = TIME_LIMIT - time  # time left (in sec)
```

From here we can set stop conditions on our game based on time passed or time left, whichever you need! Remember, *you can keep track of lots of independent timers by applying this pattern to multiple sets of variables*. For example, if you want objects to appear at random, you might first pick a random wait time, say something between 500 and 2000 milliseconds, then use the above to "count down" the time until spawning the object. All this can happen while you're also tracking timers for the player like time left to play, time played, etc. 

## Points, Hit-Points, and other Counters.

If your game has a scoring system, player or enemy hit-points, or any other mechanic involving something that is counted, then you're in luck. The solution is more variables! Does your game keep score? If so, then create a `score` variable (name is up to you) that is declared outside the loop, starts at 0, and add to it whenever the player earns points. Do the player and bad guys have hit points? Any object with hit points or something hit point like gets a variable that is, again, declared before the game loop, initialized to the max hit points, and from which you can subtract points as needed.  For object groups stored in a structure of arrays you'll need to add another list to you collection to store the hit points.

It's really helpful to notice that every situation described above is effectively an accumulator variable.  You create it prior to the game loop, then for each frame of your game, you update or let be the variable.  In fact, all the key game variables are accumulators. What's unique in this situation is that we're not iterating over a sequence of data. Instead the game loop is essentially iterating over frames of our game as it generates them. Even though we lack an obvious sequence over which we're traversing, the underlying logic is still one of iterate and accumulate.
