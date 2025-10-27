---
layout: page
title: Game 0.5 - Animation Refactoring
permalink: /teaching/comp151/docs/game0_5/
---

To prepare for a game with user interactions, we first want to do a bit of refactoring of our animation as well as add a couple of small features.

## Preliminary File Sync

New files have been added to the project. To get them, you'll need to merge a pull request on github.  We'll walk through this in class, but *if you need help stepping through it, just ask.* **Be sure to do the merge before making the changes described below.**

## Game 0.5 Feature Requirements

1. The animation now includes a title with instructions to press space bar (or any specific key you want) to start.
2. Pressing space bar (or your chosen key) will end the introduction animation and launch the level 1 main.
3. The level 1 main prints `"Level 1"` to the terminal.


## Game 0.5 Specifications

The bulk of your work is to reorganized the code into modules (separate files).
1. All start animation code is in a file/module named `intro.py`.
2. All game constants are declared in a file/module named `constants.py`. This module is imported into `intro.py` to supply the necessary constants; explicit constant declarations are removed from `intro.py`.
3. A new module named `level1.py` is created for level 1. For starters it only has one function, `main` that prints `"Level 1!"`.
4. There is a module named `main.py` that has one function, `main`, that initializes pygame and the display, then launches the intro `main` followed by the level 1 `main`

## TODO

To meet your specifications, you should work through the following steps.
1. Create `constants.py`. Move all *global* constants from the current `main.py` to this file. Import this file into `main.py` and fix constant references as needed. *Run your `main.py` to ensure your animation runs as it did before.*
2. Rename `main.py` to `intro.py` and create a new `main.py`.  In the new `main.py`, add the necessary imports, then create a function `main` (called `main.main` from here on) that calls the the `main` from `intro.py` (now called `intro.main`). Add the standard "if main" conditional to the end of `main.py` such that `main.main` is called when run. *Run `main.py` to ensure your animation runs as before.*
3. In `tests.py` correct imports and/or function calls as needed so that all tests for the functions that are now in `intro.py` are run when you run `tests.py` with pytest.
4. Modify `intro.main` so that it takes a single `SurfaceType` parameter, the display surface.  Move the code  that initializes pygame and the display from `intro.main` to the `main.main`, then pass the display surface (probably named `display_surf`) to `intro.main` when you call it. *Run `main.main` to ensure your animation once again runs like it did before.*
5. Create `level1.py`. Include the necessary imports and a single function, `main` (here on called `level1.main`) that only prints `"Level 1!"` when executed.  Add a call to `level1.main` in `main.main` after the call to `intro.main`.
5. Modify `intro.main` to include the title and request to press a key to start in the animation.
6. Modify `intro.main` so that pressing the key will end the game loop. If everything is working, then you'll see the *Level 1!* output on the terminal after you press the designated key.
