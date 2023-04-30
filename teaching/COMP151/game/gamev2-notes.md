---
layout: page
title: Game Dev Project - Game v2
permalink: /teaching/comp151/game/gamev2
---

We now come to the part of the project where we complete a full game or at least a solid prototype for a game.  For this we really need two things:

  1. *Interactivity* - Stuff to collect, Enemies to contend with, Platforms or walls to navigate, obstacles to avoid, etc.
  2. *An Objective* - Complete a task before time runs out, Defeat an enemy, Solve a puzzle, last as long as you can in a hostile environment, etc.

# A Few Helpful Additions to Our Game-Dev Toolkit

Before we look specifically at adding interactivity and objectives to our game, let's look a few helpful general-purpose things that can enhance your game development process. The first is random numbers; a bit of randomness keeps games from feeling like running through a script. Second, we'll see how we can make animation a bit easier and flexible by using lists. Finally, we need to re-visit the relationship between the rectangles representing a player or thing on screen and the rectangle that covers an animation image.

## Random Numbers

Section 4.3 of our RuneStone text covers the python random module. I just want to draw your attention to one function: `randrange`.  One of the ways randomness occurs in games is to assign random starting locations and/or velocities to objects.  What this boils down to is a random integer from some interval \[min,max\].  The function `randrange` gives you exactly that. If *min* is the smallest possible value you want and *max* is the largest, then `random.randrange(min,max+1)` will give you a value from your desired range with an equal chance of getting any number in the range.

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

What this does is simply collect the actual coordinates for our image into a list then cycle through the locations of the list using modular arithmetic. The modular arithmetic is simple counting by 1 up to, but excluding, the size of the list. Here's the really, really cool thing about this approach: *it works for any number of images and even when there is no relationship between the coordinates*.  This means you can use animation sheets with variably sized and spaced images by collecting their relevant coordinates (and possibly the width and heights) into lists.  You can also take this one step forward by replacing coordinates with a full `Rect` for your animation image or even just the image itself!

## Screen Rectangles vs Image Rectangles

Thus far we've just assumed the player was the same size as their image. This isn't typically the case. The image we draw is usually the character surrounded by some transparent pixels. When there's nothing in the environment for our player to interact with, then the difference isn't all that important. When we add something with which the player can collide, then we want to make sure that the screen rectangle is a good, tight box around the region occupied by our player.

Assuming your player image is centered within the rectangle, we can manage this by choosing some offset value for their screen rectangle. First we imagine a tight rectangle covering most or all of the player image with very little transparency within it. This rectangle sits at the center of our player image rectangle and it's upper-left corner is at *(offset,offset)*.  What we've effectively done is shaved off *offset* number of pixels from the top, left, bottom, and right of the player image.

Let `PC_W` and `PC_H` be the width and height of the player image rectangle.  Our onscreen rectangle can then be constructed as follows:
```python
PC_OFFSET = 5
# x and y are wherever your player starts
# The width and height account for the excess space relative to
# the animation image
pc_rect = Rect(x,y,PC_W-2*PC_OFFSET,PC_H-2*PC_OFFSET)
```
When it's time to draw the player, we need to account for the offset. We'll assume that all player images are drawn from the image named `PC`.
```python
DS.blit(PC, pc_rect.move(-PC_OFFSET,-PC_OFFSET), pc_img_rect)
```
The `Rect` method `move` computes and returns a new `RECT` with the x and y coordinates adjusted according to the given values.  Alternatively, we can do the calculation ourselves.
```python
DS.blit(PC, (pc_rect.x - PC_OFFSET, pc_rect.y - PC_OFFSET), pc_img_rect)
```

To find the right offset for your player images, or any other image you're using in your game, you can use trial and error or find a program or website that lets you find pixel coordinates within an image. What you're looking for is the (x,y) coordinates of the upper-left corner of the rectangular area you want to represent the character or object's physical space. In the example above the x and y were the same, but they don't have to be. You'll just need fewer variables if they are.


# Interactivity and Objects in the Environment

In order to create interactivity, you need something with which your player can interact. Fortunately, we already know how to add things into the environment because we've added the player character into the environment.

  * *Everything* needs a `Rect` to represent the space it occupies within the playing area. See above for notes on tightening up these rectangles relative to the image for the object.
  * *If the thing can move*, then you should be using `Vector2` objects to represent location, velocity, and acceleration as needed. Just like with your player, the style of movement your game requires will determine the number of variables/`Vector2`s you need to represent the thing.
  * *If the thing is animated* (and you're using an animation sheet like we have been), then you also need a `Rect` to represent which animation frame you are currently showing the player.

Let's say your game has some bad guys, that those bad guys move in a sliding-gliding, velocity-based pattern with animation, and that both the player and the bad guys shoot projectiles that use velocity-based movement but no animation.  Then:

  * Every enemy needs it's own screen Rect, image Rect, location Vector2, and velocity Vector2
  * Every projectile needs it's own screen Rect, location Vector2, and velocity Vector2.

Even if you only have one bad guy, you're likely to have multiple active projectiles. What's more, the number of projectiles on the screen can vary from frame to frame.  So, we don't know how many sets of variables we need!  That's OK, because we have lists!

## Lists and the *Structure of Array* Pattern

Let's now consider a game with multiple bad guys that move independently and are animated. This means each bad guys needs four attributes/objects: location vector, velocity vector, screen rectangle and image rectangle. We can organize this data into four lists, one per attribute. This data-organization pattern is called a **structure of arrays**. We worked with an example of this in the international loan data lab. Let's work a simple, made-up example with two enemies.

Assume that `NPC_W` and `NPC_H` are the width and height of the enemy image, that `NPC_OFFSET` is the offset for their screen rectangle (see above), and that `SCREEN_W` and `SCREEN_H` are the width and height of the screen. Then we might initialize two enemies as follows:

```python
# start with loc and velocity. Set x,y accordingly. Perhaps random!
npc_loc = [Vector2(... , ...), Vector2(..., ...)]
npc_vel = [Vector2(..., ...), Vector2(...,...)]
npc_rects = [ Rect( npc_loc[0] , (NPC_W-2*NPC_OFFSET,NPC_H-2*NPC_OFFSET)), Rect( npc_loc[1] , (NPC_W-2*NPC_OFFSET,NPC_H-2*NPC_OFFSET) ) ]
# animation image rects. again, set x and y accordingly
npc_img = [ Rect(... , ... , NPC_W,NPC_H), Rect(... , ... , NPC_W,NPC_H)]
```

The data for the first enemy is at index 0 in each list, i.e. their location is `npc_loc[0]`, velocity is `npc_vel[0]`, screen rectangle is `npc_rects[0]`, and image rectangle `npc_img[0]`. Each subsequent enemy has their data at their own shared index.

If you have lots of objects to manage, then functions can make the setup easier. In all cases, functions will make managing and coordinating the lists easier. First off, generating the screen rectangles is a *map* style function using the location list and the offsets. If you're starting bad guys at random locations, then you can write a function to generate that list (think: given number of desired bad guys, generate list of that many location vectors). The same goes for velocity.

Where things can get tricky is removing objects from the game. This happens if a projectile moves beyond the borders of the screen, if the player destroys a bad guy, when something is collected, etc. If you want to get rid of something whose data is located at index `i` in a structure of arrays design, then you must remove that data from index `i` in all the lists. We did not see this kind of thing in our load data lab.  To manage this you'll first want to collect the index values for any/all objects that need to be removed from the game. For this you should be thinking in terms of a function that takes some or all of your lists and returns a list of indexes for the objects you need to remove. You can then remove those locations from each list. This is a *filter* operation according to index: *given a list of bad guy data and a list of index values to get rid off, keep all the items in the bad guy list that are not located at one of the values in the index values*.


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

From here we can set stop conditions on our game based on time passed or time left, whichever you need!

## Points, Hit-Points, and other Counters.

If your game has a scoring system, player or enemy hit-points, or any other mechanic involving something that is counted, then you're in luck. The solution is more variables! Does your game keep score? If so, then create a `score` variable (name is up to you) that is declared outside the loop, starts at 0, and add to it whenever the player earns points. Do the player and bad guys have hit points? Any object with hit points or something hit point like gets a variable that is, again, declared before the game loop, initialized to the max hit points, and from which you can subtract points as needed.  For object groups stored in a structure of arrays you'll need to add another list to you collection to store the hit points.

It's really helpful to notice that every situation described above is effectively an accumulator variable.  You create it prior to the game loop, then for each frame of your game, you update or let be the variable.  In fact, all the key game variables are accumulators. What's unique in this situation is that we're not iterating over a sequence of data. Instead the game loop is essentially iterating over frames of our game as it generates them. Even though we lack an obvious sequence over which we're traversing, the underlying logic is still one of iterate and accumulate.
