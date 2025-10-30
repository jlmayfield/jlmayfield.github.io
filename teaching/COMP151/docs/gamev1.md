---
layout: page
title: Game 1 - Player Movement
permalink: /teaching/comp151/docs/gamev1/
---
Version 1 of your game adds interactivity in the form of player controlled movement while also exposing how we might implement and transition between multiple game loops, each with different goals and controls. We still lack any kind challenge for your player to overcome, so it's a bit of stretch to call the outcome of version 1 a full game. None the less, it does make for a good prototype and a solid foundation on which we can build a true game.

# Feature Requirements

The requirements for version 1 of your game are less specific than version 0. You'll need to envision a style or genre of game you'd like to create, and then implement a player movement system that supports your larger vision. In addition to adding a player movement system to your game, you'll learn to transform your animation into a start screen for your game.

  1. Have and be able to present an overall movement design goal for your game. *Player movement should be intentional in that controls make them move in ways you intend them to move.*
  2. Implement player movement that is sufficient for achieving your game's design. Movement must be animated and the animation should, in general, change as the direction of the player changes.
  3. Turn your animation from version 0 into an introduction screen. The screen should instruct the player to press a key to play, then transition into a scene that allows the player to move according to your stated design. Add text to the intro screen (title and instructions).
  4. (Optional) Use different music for the introduction and game portion of the program. See [the music documentation](https://www.pygame.org/docs/ref/music.html) for how to unload, load, start, and stop music.

# Specifications

Your code must adhere to the following specifications when meeting the requirements. These generally boil down to adhering to the style and design we've been using in labs.

  1. The player animation and movement is managed using `Rect` and `Vector2` objects and not separate variables.
  2. You should continue with the module-based design from game 0.5. All the new code for player interactivity should go in the module/file `level1`.
  3. Code for handing keyboard presses, tick updates, and drawing should be in functions which are then called as needed (either in the start/movement screen function or some other function).
  4. All functions should have types declared in the header and a proper docstring. Docstrings should match the header.
  5. Keyboard and time based update functions should have unittests in `tests.py`. Drawing functions and `main` functions do not need tests.


# Recommended Steps

Once again, you should work in small increments, or *iterations*, where each step completes part of the requirements and at the end of each step is a runnable program on top of which you can build the next step. Here's what I recommend:

1. Complete the Refactoring lab objectives including the text on the start screen and the key press to "start" the game. The program should close when the user presses the start key.
2. Get the movement screen function started and setup so that it simply draws the player image on the screen. Keys do nothing. The player does't move. The program no longer ends when the "start" key is pressed. Instead, it just shows a player character on the screen until the window is closed.  This step focuses on getting the second game loop function setup and the very, very basics of that loop running. No keyboard or time based updates need to happen yet. Things you'll likely need/want:
  * A function to load an initialize the images (probably just the player sheet)
  * Setting up the game clock and the display
  * Loading and starting music
  * A simple game loop that : runs the  quit-event handler, draws a player to the screen, sets the framerate to a fixed value (24,30,60 are all standard choices).
3. Make movement working in one direction without animation and without dealing with the walls.
4. Deal with the wall in your chosen direction.
5. Repeat 3-4 for the other three directions.
6. Add animation to movement but start by using just one column of the animation sheet.  So, legs should move while the player is moving and should stop when they stop, but the direction the player is facing never changes.
7. Change the direction of the player when they change their direction.
8. Celebrate. You're done.

You're not required to stick to this order, **but** you should work in small, incremental steps that result in a functioning but incomplete program. In the event that you cannot complete the program by the due date, you program should partially meet the requirements and function rather than "meet all the requirements but doesn't run".