---
layout: page
title: Game 2 - A Game!
permalink: /teaching/comp151/docs/gamev2/
---

You final game will, at last, be a game!  We'll add a dynamic environment, touches of randomness, a clear objective for the player, and a game over condition.  Read on for project requirements, specifications, and a recommended feature set. There are also notes on new parts of python and pygame that will be necessary for this project.


## Required Features

Your game must have the following features:

1. Objects that spawn with some element of randomness, move, and must be avoided by the player.
2. The game ends when the player collides with an object too many times. Too many can be just once.
3. A game-over screen is displayed when the game is over. Once on this screen, the player must press a key to end/close the game. Pressing this key should only have an effect when the game is over.
4. Objects are removed from play when they are out of view or when the player collides with them before the game is over.
5. There is some kind of score. This can be the number of objects dodged, time passed, etc.  The score is displayed while playing and when the game is over.

### Technical Specifications

Your game must still adhere to the v1 specifications but should now also:
1. Utilize lists to manage the state of non-player, game objects.
2. Design, write, and unit-test functions to process and manage object state lists.

In general, you want to keep the code in the loop high-level. This means any additional loops should be hidden within a function. If a task can be accomplished with a one or two lines of code, then that can be in main.  Anymore than that should get moved to a function. When in doubt, create functions.

## Recommended Game Mechanics

You'll be shown a demo of the recommended game. The key features are:

* Objects spawn at the top of the screen at a random x-coordinate with a random, positive y-velocity, i.e. objects appear at random at the top of the screen and *fall* at a constant rate with each object falling independently. The player's goal is to not get hit.
* Object have a random time between spawns (after one spawns, another will spawn in *x* to *y* milliseconds).
* The game is over when the player is hit once.
* The goal is to stay alive as long as possible. The game clock is displayed  in min:sec while the game is running and the final time is given when the game is over.

## Recommended Feature Iteration

If you intended to implement the recommend game, then the following sequence of tasks is recommended. You can deviate from this sequence, but should still work in small, incremental chunks marked by functioning programs with clearly identifiable behaviors.

1. **Drawing Objects** Design and implement a function to draw the objects. You can use pygame's [draw module](https://www.pygame.org/docs/ref/draw.html) to mock out objects or find an image online.  Test your function by hand-coding a small list of the object rectangles to draw. The list should be created when you initialize state variables, not within the loop.
2. **Moving Objects** Design and implement a function to make the objects move. This function can and should be unit-tested.  You can (and should) also hand-code the object velocities for your game and watch your hand coded objects move on the screen and their hand coded rates.
3. **Cleaning Up Objects** Design and implement functions to get rid of objects that are no longer in the playable game area. This feature is a bit more involved than the prior features:
  * It is recommended that you use a `pygame.Rect` to represent the playable area. This allows you to use the built in `Rect` containment checks (see below).
  * Design and write a function that produces a list of the indexes of all the objects that are outside the playable area. This can and should be unit-tested.
  * Design and write a function that, when given a list of indexes, will remove all the items from a list at the given indexes.  This can and should be unit-tested.
  * You should now be able to use the above two functions in your came to clean up objects outside the playable area. Test this by watching your hand coded objects disappear when they leave the area.
4. **Spawning Rocks** Design a function (or functions) that produce all the state for a new, randomly created object. This likely means a `Rect` with an random *x* but fixed *y*, *width*, and *height* as well as a random y-velocity (possibly as a `Vector2`, but not necessarily). This is hard to unit-test. Can you guess why?  To test this, replace the hand-coded object state in your game with randomly generated state.
5. **Spawning Rocks, part 2** Add code to your game (possibly functions, possibly not) to track the time until an object should spawn. This should be a countdown based on real clock-time. Check out the side-scroller notes for details on getting information about real-time. When the time-to-spawn counts down to zero, spawn an object (add it to the list). Test this by removing your hand coded objects, starting your object lists empty, and using your spawn function(s) to  populate your object lists.
6. **Player-Object Collision** Design and implement a function to determine if the player has been hit.  This can and should be unit-tested. The function can return a bool or it can return the index of the object that hit the player. The later is most useful if you plan to allow your player to get hit more than once.  You'll need that index to remove the offending object.  Add code to your game so that the game ends, prints something to the terminal, *and closes* when the player is hit.
7. **Game-Over Screen**  Design and implement a function that displays the game-over text. Modify your game so that this is displayed if and only if the player has been hit and so that the game will not end until the player presses a quit-key. Be certain the quit key only has an effect if the game is over.  Similarly, be certain objects (including the player) will not move if the game is over. *Hint: use a state variable to track if the game is over or not. Condition things on this variable.*

# Notes on New Elements of python and pygame

In addition to using lists and the accumulator pattern, you'll need to utilize several new features of python and pygame to complete this project.

## Drawing

You can use the [draw module](https://www.pygame.org/docs/ref/draw.html) to draw objects. For example, if the surface for your game screen is `screen` and you want to put a red circle with radius 10 smack dab in the middle you'd do:
```python
pygame.draw.circle(screen,(150,0,0),(screen.get_width()//2,screen.get_height()//2),10)
```
The documentation above describes the circle function more along with all the other drawing function provided by the module.

## Random Integers

The python module `random` provides a lot of helpful functions for generating randomness. For you game you can get away with only [random integers](https://docs.python.org/3/library/random.html#functions-for-integers). First, be certain you import the module along with your other imports.

```python
import random
```

To get a random integer from a specific range you can just use `randrange`, which uses the same arguments as `range` but instead returns a single random number from that range.
```python
# random value from 5 to 24
random.randrange(5,25)
```

## Rectangle Collision and Hitboxes

The pygame `Rect` object can readily manage the detection of collisions involving other `Rect` objects and provides a series of [Collision Methods](https://www.pygame.org/docs/ref/rect.html#pygame.Rect.contains). Three in particular might prove useful:

```python
# does Rect r2 touch Rect r1 in any way?
r1.colliderect(r2)
# Is Rect r2 completely contained within Rect r1?
r1.contains(r2)
# What is the index of the first Rect in the List[Rect] lor
#  that collides with Rect r1. Return -1 if no collision occurs
r1.collidelist(lor)
```

### On Rectangles and Hitboxes

So far we've equated the image rectangle with the player rectangle. In practice, this should not be the case. The image rectangle includes transparent pixels around the actual graphic and these pixels should not be taken into account when dealing with collisions. On-screen rectangles should instead be a slightly smaller version of the image rectangle that bounds the actual image. This constitutes the rectangle that collides with other rectangles, i.e. the *hitbox*.

What you want is for the center of the hitbox and the center of the image rectangle to be aligned on screen. This means their natural (x,y) coordinates differ by the same amount that their width and height, respectively, differ.  For example, if the width of your hitbox is 10 pixels less than the width of the image, than the x coordinate for the top-left corner of your image is 10 *less* than the x coordinate for your hitbox (because its to the left). The same is true of the y coordinate and the height. You'll need to account for this somewhere in your code. You have options for where and when to do that.

## Game-Over

The game ending event is a new *event* in our game. It's special in that when it occurs we need our game loop and overall event handling to change.


### The Game-Over Event

Currently our loop runs as follows:
```
While the level is running:
    1. Process Keyboard Events
    2. Process Time-based Events
    3. Process Drawing
```

Now, with the addition of the game-over event, we do the following:
```
While the level is running:
    1. Process Keyboard Events
    2. Process Time-based Events
    3. Check for and process game over event
    3. Process Drawing
```

Checking for and handling a gameover event can be reduced to managing a variable that tells you if the game is on or over. The real work comes from incorporating this information into the loop generally.


### The Game-Over Screen

Our loop now has two basic phases. When the game is on, it runs the game logic. When the game is over, it provides an end of game screen with a different set of actions (probably just press a key to quit). We can understand this as a **state machine**: There is one state in which the game is not yet over and for which we have one set of rules/handlers, then the game over event occurs and we switch to a different state with different rules/handlers. We've seen this already with the introduction to level 1 transition. Thankfully, the game-over state requires very little in the way of handlers and we don't necessarily need to manage it like we did then.

A simpler way of managing a state machine is with a state variable. That variable tells you which state you're in.  In this case a `bool` will work, but you can also use other data types. You can then apply the following pattern to your game loop:

```
while the loop needs to run:
    if you're in the gameon state:
        handle game play keys
    else (you're in the game over state):
        handle game over keys

    if you're in the gameon state:
        handle game play time events
    else (you're in the game over state):
        handle game over time events

    if you're in the gameon state and the game over event occurred:
        change to the game over state

    if you're in the gameon state:
        draw game on stuff
    else (you're in the game over state):
        draw game over stuff
```

*Your code need not follow this pattern literally.* There can be considerable overlap between handlers. **The point is that we can make one loop run multiple sets of event handlers by conditioning on a game state variable**.  This gives you an alternative way to create a **state machine** than what you've already done: completely separate, decoupled, sets of code per state.