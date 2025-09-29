---
layout: page
title: Introduction to Pygame and the Starter Code
permalink: /teaching/comp151/docs/pygame-intro/
---

We'll be using games as a platform to exercise our new-found programming abilities while having fun and being creative.  It is certainly possible to build games from the ground up using base Python, but a more measured approach starts by using a python library called [Pygame](https://pygame.org). Libraries effectively extend base Python with new data types, functions, and operations, in order for programmers to more easily take on certain problems.  Pygame provides everything you'd need to build video games or game-like programs.

This document will show you how to use Pygame to:
  1. Load and manage game assets such as images and sounds.
  2. Resize images
  3. Draw some or all of an image to a screen.
  4. Play sound.
  5. Draw text on the screen.

Once we add variables into the mix, then we have everything we need to make game-style animations and set those animations to music.

# Preliminaries - Python Packages

Python **packages** are collections of code for others to use. They are typically organized into a series of **modules** or *sub-packages*. A module provides a collection of related data types and functions.  We'll be directly or indirectly interacting with the pygame modules listed below. The parts of the modules you need will be discussed in this document. For now, just make note of their names. You can come back later and explore the full documentation for these modules by clicking the links.

  * [pygame](https://www.pygame.org/docs/ref/pygame.html) *The main Pygame module*
  * [Surface](https://www.pygame.org/docs/ref/surface.html) **Key Module** A module for representing and constructing images as SurfaceType data.
  * [Rect](https://www.pygame.org/docs/ref/rect.html) *Subtly Important* A module for rectangular coordinates.
  * [transform](https://www.pygame.org/docs/ref/transform.html) A module for modifying surfaces (aka images)
  * [image](https://www.pygame.org/docs/ref/image.html) A module for loading images to Surface data types
  * [font](https://www.pygame.org/docs/ref/font.html) A module for loading and rendering text
  * [mixer](https://www.pygame.org/docs/ref/mixer.html) A module for loading and playing sounds
  * [display](https://www.pygame.org/docs/ref/display.html) A module to control the display window and screen. (Seen and mostly not used.)
  * [time](https://www.pygame.org/docs/ref/time.html) A module for monitoring time (Seen, mostly not used.)
  * [locals](https://www.pygame.org/docs/ref/locals.html) Some key Pygame constants. (Seen but not used)
  * [event](https://www.pygame.org/docs/ref/event.html) A module for interacting with events and queues (*More important in the future*)


## Importing and Referencing Packages and Modules

To incorporate these modules into our program we must first **import** the pygame library.  The starter program you've been given has the following lines of Python:
```python
import pygame
```

This imports the pygame package and gives us access to all of its modules. For example, throughout the starter code you see the expression `pygame.SurfaceType`.  The `pygame` signals that we're using something defined within the pygame package. That definition is the definition for the data type `SurfaceType`. The dot operator `.` indicates the thing to the left determines the thing to the right. In this case, `SurfaceType` can be found within `pygame`.  You'll see this kind of expression throughout the code. We could use different imports to avoid the `pygame` qualifier, but by keeping the **fully qualified name**, we can tell exactly where within the pygame package certain definitions can be found.

# Preliminaries - Working with Files

Any game requires media assets: images, music, etc. This data is stored in files that packages like `pygame` allow us to interact with. What this almost always means is first read the file and use that to construct some data object that we can manipulate. This means we need to know how to tell `pygame` where a file is located.

Locations are specified as a **path** within the computer's file system. While you can specify the *absolute* path, which is like the global address for a home. It is often easier to give the *relative* path, like a street address within an assumed town. Thankfully, we only need to give `pygame` the path as as basic `str` data and it can take care of the rest.

Assets for this project are all stored in a folder (aka directory) named *assets*. Within that folder are three sub-folders: *background*, *people*, and *music*.  These store background images, character animation sheet images, and music mp3s, respectively. Their relative paths are stored in three constants (more on that later) defined at the top of `main.py`.
```python
# asset directories
BG_HOME : str = './assets/background/'
PPL_HOME : str = './assets/people/'
MUSIC_HOME : str = './assets/music/'
```
Lets read these paths from right to left. I'll use the `BG_HOME` path as an example. First you see `"background/"`. The `"/"` signifies a folder and `"background"` is its' name. So, "the background folder". There's more to the path. Next you see `"assets/"` which gives us `"assets/background"`, i.e. "the background folder in the assets folder". Finally, we see `"./"` which is a short cut for the path of the *current working directory". That is the folder in which the running file, `main.py`, is found, i.e. your project folder. All together, `"./assets/background/"` is, "the background folder, in the assets folder, in my project folder.".

These constants give us the path to each of our key asset folders. When we want to specify the path to a specific file, we can concatenate the folder path with the file name. For example, within the program you'll see the expression: `PPL_HOME + '_01.png'`. This computes to `"./assets/people/_01.png"` and is the path to one of the character animation sheets.

# Code Walk Through

The starter code provides a lot of basic stuff to get you started. Let's look at it all and focus on understanding *what* it does more so than *how* it works under the hood.

First things first, it's organized like all the other python programs you've seen.  At the top are imports.  Below this are multiple function definitions with the main program residing in the `main` function. Prior to the function definitions are *constant* definitions. These are variables that we do not intend to change and that are useful throughout the program. As a matter of style, we write their names in all capital letters to signify that they are different than other variables.

While we could read this program from top to bottom, it's helpful to instead read it in execution order. Take note of the imports and the constants, then jump to `main` and start reading the program as it will be executed.

## The `main` Function

The first thing you'll see after the module imports is:
```python
pygame.init()
```
This calls the `init` function from the main pygame module.  As the name and context implies, this function initializes the pygame modules.  We can assume that pygame needs to do some setup in the background in order to work and this function initiates that setup process.

Next we see more setup code. In particular, we need access to the display for the window that graphical window that will contain the game and we need access to a clock for managing and tracking the game's framerate.

Pygame gives us easy access to the main display through the module `pygame.display`. Two functions from this module are used during setup. The first sets the width and height (measured in pixels) and the second sets the window caption.
```python
# set main surface
display_surf : pygame.SurfaceType = pygame.display.set_mode((SCREEN_W, SCREEN_H))
# set window caption
pygame.display.set_caption("My First Game")
```
Pygame defines a `Surface` datatype this is used for images. Here we create a variable named `display_surf` that will act as the image seen on the display. When we want the user to see a different image, then we modify that surface.

The module `pygame.time` gives us access to clocks.  All we need to do at this point is get a `Clock` object that we can use to interact with the animation framerate.
```python
# get Clock for fixed framerate animation
fps_clock : pygame.time.Clock = pygame.time.Clock()
```
Notice that the code above is a familiar expression `varable = value`. What's different here is that value comes from a special function called a **constructor**.  Unlike `int`, `float`, and `str` data, the `Clock` datatype does not have a literal specification. Instead, pygame provides a function which will construct and return a default `Clock` datum, or **object**.  The definitions for the `Clock` type also include functions and *methods* for operations on or with the clock. This means that we, the user of a `Clock` can work with it without needed to know or understand it's internal workings. Such a datatype is called an *abstract data type* or ADT.  The `Surface` type is also an ADT. The creation of use of ADTs is often a vital part of modern programming.

Next in `main` we get `Surface` objects for the background image and the character animation sheet.
```python
# get the image surfaces
sheet : pygame.SurfaceType = init_character()
bg_0 : pygame.SurfaceType = init_bg_0()

```
Once again, we're just declaring variables and assigning values to them. Here we use our own functions to accomplish this: `init_character` and `init_bg_0`. Given that our goal is to understand the program at the level of `main`, our only concern is the *purpose* and *usage* of these functions and not their inner workings. We can see from the code with type hints that both take no arguments and return `Surface` objects. A quick check of their docstrings (in VS Code you can just mouse over the names!) reveals that they get the character sheet image and the back-most background, respectively.

Next up, music. The module `pygame.mixer` provides the means for managing sound in pygame. Here we want to load an mp3 file and play it on infinite repeat.
```python
 # prepare music
pygame.mixer.music.load(MUSIC_HOME + 'Amber Forest.mp3')
#start music
pygame.mixer.music.play(-1)
```
### **Game State Variables**

Game programers use key variables to specify what's going on and what a player should see. When combined these variables describe the **state** of the game, and in particular provide all the necessary information about the dynamic, moving parts of the game.  *The visuals that the player sees are a function of the game state.*

The starter game only has two logical bits of state: the location of the player sheet and the current frames per second. The location is, of course, specified by both an x and y coordinate.  Before the game proper can begin, the state must be initialized. We see that in the following code:

```python
# initialize game variables
sheet_x : int = SCREEN_W // 2  #x coordinate for player
sheet_y : int = SCREEN_H // 2  #y coordinate for player
curr_fps : int = 0   # current fps
```

There is more to say about object locations in games, but we'll get into that when we look more closely at drawing.  For now, the most important thing here is the very nature of game state variables, the hidden variables that describe and control the game and what the player sees.

## *The Game Loop*

The last block of code is where all the action is happening. It's the main *game loop*. It will cause the computer to repeat, indefinitely, the following actions in the following order:
  1. Check if the user pressed the X in the upper-right corner of the window and if they did shut down the game. Eventually this step will include checking for other user interactions, i.e. keyboard presses, and updating game variables accordingly.
  2. Process time-based, game variable updates.
  3. Redraw the scene according to game variables.
  4. Set the game clock to match the desired frame rate stored in `FPS`.

Let's look at the whole block then break it down into parts.
```python
while True:
    # close game when x in window is hit
    for event in pygame.event.get():
        if event.type == pygame.QUIT: # pylint: disable=E1101
            pygame.quit() # pylint: disable=E1101
            sys.exit()

    # UPDATE GAME VARIABLES
    #  time-based game clock update
    curr_fps = tick_fps(fps_clock)

    # DRAW THE SCENE ACCORDING TO GAME STATE VARIABLES
    #  draw in back to front order
    draw_bg(display_surf,bg_0) # background
    draw_pc(display_surf,sheet,sheet_x,sheet_y) # player
    draw_fps(display_surf,curr_fps) # FPS clock
    pygame.display.update()#always do last to force screen refresh

    # fix clock to FPS to end the loop
    fps_clock.tick(FPS)
    # END GAME LOOP
```

On the first line of code we see `while True:`. This is the line that causes the indefinite repetition. The `while` keyword signifies the start of a loop statement. Such statements are used to make code repeat. Specifically, *any **indented** code on the lines below this line will be repeat*. When you add code to this loop it must be indented to match the `for` on the second line.

Next we see the code block responsible for shutting down the game when it is time to do so.
```python
for event in pygame.event.get():
    if event.type == pygame.QUIT:
        pygame.quit()
        sys.exit()
```
We're not going to discuss this in any detail at this point. We'll interact with it a lot in future versions of our game, but for now just know that the combined effect of those four lines of codes is to end your game when the user closes the window and that you should not change them or move them.

Next we see the start of the time-based game variable updates. *You'll be adding code here.* For now, the only time-based update is to get the current framerate according to our pygame clock.
```python
# UPDATE GAME VARIABLES
#  time-based game clock update
curr_fps = tick_fps(fps_clock)
```

Now that all the game variable updates have occurred, we see the code to redraw the scene. This is all being done by series of functions, each responsible for drawing one component of the scene.
```python
# DRAW THE SCENE ACCORDING TO GAME STATE VARIABLES
#  draw in back to front order
draw_bg(display_surf,bg_0) # background
draw_pc(display_surf,sheet,sheet_x,sheet_y) # player
draw_fps(display_surf,curr_fps) # FPS clock
pygame.display.update()#always do last to force screen refresh
```
The three functions will modify a display buffer. The last line is what causes pygame to refresh the display.  The buffer is essential storage for the next image. The `update` method causes the current image to be replaced with the buffer's contents.

At this point the core game logic is done. Before the loop starts over, we update the `Clock` and suggest our desired framerate to pygame.
```python
# fix clock to FPS to end the loop
fps_clock.tick(FPS)
# END GAME LOOP
```

Understanding the high-level logic of the game loop is vital to writing animation and game programs.  To recap, the loop is composed of the following steps:
1. Check for user interactions (keyboard, mouse, controller, etc.) and update game variables accordingly.
2. Update any game variables that change over time.
3. Redraw the scene according to the current state of the game variables.
The key here is that user actions and time change variables *not images*.  Image updates, changes to what our user sees, are all determined by the state of our variables. The separation of the game logic from the visualization of the game is a vital technique in game programming. In general, programs are often developed by separating core program logic and computation from the interface.

## The Functions

The starter uses several user-defined functions. The can be logically divided into three groups: functions to initialize assets and game state, functions to process game state updates, and functions to draw according to game state. Each group of function exposes us to some more `pygame` functionality.

### Initialization Functions - Loading, Scaling, and Preparing Images

The functions `init_character` and `init_bg_0` load and prepare the character sheet and the background. The result is returned as a pygame `Surface`, the datatype used for images in the game. They effectively do the same thing, so let's just look at `init_bg_0`.

```python
def init_bg_0()->pygame.SurfaceType:
    """
    Load and initialize character animation sheet
    Parameters:
        None

    Return
       Surface : the back-most background
    """
    # background
    bg_0 : pygame.SurfaceType = pygame.image.load(BG_HOME + 'parallax-forest-back-trees.png')
    #print bg size for logging/debugging
    print("background size:",bg_0.get_width(), bg_0.get_height())
    bg_0 = pygame.transform.scale(bg_0, (SCREEN_W, SCREEN_H))
    bg_0 = bg_0.convert_alpha()
    return bg_0
```
Images are stored on your computer as standard *png* image files. They could also be *jpg* or *bmp* files. In order to manipulate the image, pygame needs to convert that file into something more mailable: a `Surface`. The `load` function will read the image file and convert it to `Surface` data. The original image attributes (size, color, etc) are all preserved.
```python
bg_0 = pygame.image.load(BG_HOME + 'parallax-forest-back-trees.png')
```
The `load` function takes the *path* to your image, loads that image into a pygame Surface object, and returns that object.  That object can then be saved to a variable for later. Notice above that we've created the path to one of our background images by *concatenating* the filename with the path we previously declared as a constant.

It is typically necessary to know the width and height of an image image. For example, either you want to set the screen size to match your background or you need to scale the background up, and in both cases you'll want to know the image dimensions. We can get these object *attributes* using the Surface object **methods** `get_width` and `get_height`.

A method is a function that acts upon an object by using the `.` operator. This is different than calling functions. When using a function you pass all the needed objects to the function by listing them within the parenthesis. With methods the calling object is to the left of the `.` and the method, along with any other inputs needed, is to the right. In the `init` functions, these are used to write the image size to the terminal. This is a basic form of logging. The player won't see this, but the developer will. If later they need to know the original image size, then can check their logs. *You can and should make use of print statements to help you view/log useful information.*

```python
print("background size:",bg_0.get_width(), bg_0.get_height())
```

Scaling an image, technically a Surface, can be done using the `scale` function from the transform module. This function takes two arguments, the surface to scale and it's new dimensions. The dimensions are given as a tuple containing the width and height you want the result to have.  Here we scale `bg_0` to match a previously declared width and height, namely `SCREEN_W` and `SCREEN_H`. The resized image is returned and saved to a variable. Notice that we're reusing the name `bg_0`. We don't need a copy of both the original and resized image, and it makes sense to replace the old image with the new.
```python
bg_0 = pygame.transform.scale(bg_0, (SCREEN_W, SCREEN_H))
```
The last thing to notice about `scale` is that you must provide the *exact* width and height of the new image. This can make things like doubling the size a bit tricky as you must first get the original width and height and then use twice those values when invoking `scale`.

Once you've got the image ready to go, it's helpful to optimize it so that pygame can draw it as fast as possible. For this we'll use the Surface method, `convert_alpha`.  This method converts not just  RGB color values but RGBA values that include the alpha, or transparency, channel to a format that is optimized for pygame. Once again, we can just replace old `bg_0` with the converted surface as we don't need both copies.
```python
bg_0 = bg_0.convert_alpha()
```

### Functions for Time-based Updates

Any game that provides a sense of real-time or just animations has time-based updates of game variables. In the starter, the only thing that is changing over time is the framerate. We track this with a single variable and update that variable in the function `tick_fps`. The `tick` part of the name is meant to remind us that this function handles time events, i.e. gets run with the clock goes tick.

Usually, a `tick` function that updates a variable will take as a parameter a that variable and return that variables new value. For example, if we have a variable named `hitpoints`, then we might have a function `tick_hitpoints` that is used like `hitpoints = tick_hitpoints(hitpoints)`.  This is just a function-based way of expressing things like `x = x + 5`.

In the starter program, the time variable `curr_fps` does not update based on it's previous value but instead pulls its next value from the `Clock`. As a result, `tick_fps` does not take `curr_fps` as a parameter.

```python
## TICK FUNCTIONS
def tick_fps(game_clock : pygame.time.Clock) -> int:
    """
    Get the current frames per second as an integer

    Parameters:
       game_clock : Clock  a pygame clock for the game

    Return:
       int : current fps as an int
    """
    return int(game_clock.get_fps())
```

The bit of `pygame` worth noting here is the `Clock` method for getting the current frames per second (fps) for our game: `get_fps`.  For now, we just want this so that we can display the value. Eventually, we might need this to more carefully account for the passage of time.


### Functions for Drawing Images

Our last group of functions manage drawing the scene. Once again, what is drawn is determined by the game variables. The starter takes the approach of essentially writing one function per scene component: `draw_bg` for the one background we have right now, `draw_pc` to draw the player sheet, and `draw_fps` to draw the fps text.

The background is a *static* property of the scene. It doesn't move and does not change over time. Thus, we have no game variables for the background, just the `Surface` variable `bg_0`. The background image must be drawn onto the display buffer, so we also need the variable for that `Surface`, `display_surf`.

To draw the background onto the display buffer we use the `Surface` method `blit`. Blit stands for *block transfer*. As the name sort of implies, the method will transfer one block region of a surface onto another. The calling surface, the one to the right of the `.`, is the one onto which you'll transfer/draw. You then give `blit` at least two arguments. The first is the surface to be transferred/drawn and the second is the left and top coordinate (think (x,y)) where the transfer image should be placed in the receiving image.  *What's important to remember is that the location (0,0) is the upper left hand corner of a surface and coordinates go up as you move down and right.*

We've scaled `bg_0` to match the screen, so it and `display_surf` are the same size. We then want to place the top-left corner of `bg_0` to the top-left, (0,0), of `display_surf`.
```python
def draw_bg(screen : pygame.SurfaceType, bg : pygame.SurfaceType) -> None:
    """
    Render the current animation frame/scene

    Parameters:
        screen : Surface - the surface for the game screen
        bg : Surface - the background image surface
    """
    screen.blit(bg, (0,0))
```

If you change `(0,0)` to different numbers, then your background image won't be lined up properly and something is likely to be cut off from view.  If either value is negative, then part of the image at the top or right is cropped off. If, in the case of two surfaces with the same size, they are not zero, then something gets cropped off on the right or the bottom.  In either case, the system will draw as much as it can into the receiving surface.

The starter simply places the entire player animation sheet on the scene.  The location of the sheet is determined by the game variables `sheet_x` and `sheet_y` so the function `draw_pc` (pc = player character) takes those two variables as parameters. Like `draw_bg` we also need the display surface and the source image (this time the player surface, not the background).

```python
def draw_pc(screen : pygame.SurfaceType, csheet : pygame.SurfaceType,\
            cx : int, cy : int) -> None:
    """
    Draw the player to the screen

    Parameters:
        screen : Surface - the surface for the game screen
        csheet : Surface - the character animation sheet
        cx : int - x coordinate of character
        cy : int - y coordinate of character
    """
    screen.blit(csheet,(cx,cy))
```

Notice the use of `blit` in `draw_pc` and `draw_bg` is identical. The only difference is the use of variables. In practice, you do not want to draw the entire animation sheet to the screen but instead want to draw a single player image from that sheet.  For this you can also use `blit`.

Another, *very important*, way to use `blit` is to draw only part of an image. For this we pass a third argument to blit. This argument is a tuple of 4 numbers representing the left coordinate, top coordinate, width, and height of the region you wish to be drawn.  This 4-tuple specifies a rectangle and we'll be working with this kind of data a lot in the future. Let's say we only want to draw to `display_surf` the region of `bg_0` that starts at (10,50), that's 10 pixels right of the upper left corner and 50 pixels down, and has a width of 100 and height of 125. Then we'd make the following call to `blit`:
```python
display_surf.blit(bg_0, (0,0), (10,50,100,125))
```
Much of your first game project involves working with this form of `blit`.


Now that we have the background and player images on the screen, we might like to put some text up as well.  For development purposes, it can be nice to see the frames per second at which our our game is currently running.  So, we've captured this information as a game variable `curr_fps` and now want to draw, or *render* that value to the screen.

Drawing text and printing are not the same. To draw text you need to decide things like font, size, and color. Thankfully, `pygame` provides everything we need to create an image of text. This means to create a `Surface` that contains our text data in a desired font, size, and color. The function `draw_fps` manages all these details for us.

Like all other `draw` functions, `draw_fps` needs the display surface to do its job. Unlike our other draw functions, `draw_fps` creates a surface when called. So, we only need to pass it the current fps variable and it will use it to construct the appropriate image and draw it to the display.
```python
def draw_fps(screen : pygame.SurfaceType, curr_fps : int  ) -> None:
    """
    Render the current fps to the screen

    Parameters:
        screen : Surface - game screen where all images are drawn
        curr_fps : int - current fps as int

    Return:
        None
    """
    font : pygame.font.Font = pygame.font.SysFont('Helvetica', 24)
    font_clr : Tuple[int,int,int] = (100,150,100)
    txt = font.render(str(curr_fps), 1, font_clr)
    screen.blit(txt,(0,0))
```

First, `draw_fps` creates a `Font` object. This will manage the text rendering.
```python
font : pygame.font.Font = pygame.font.SysFont('Helvetica', 24)
```
Next we specify the color as a (Red,Green,Blue) tuple.
```python
font_clr : Tuple[int,int,int] = (100,150,100)
```
We can no render the text as a `Surface` and use `blit` to draw it onto the display.

```python
txt = font.render(str(curr_fps), 1, font_clr)
screen.blit(txt,(0,0))
```

# Conclusion

You now have all the tools you need to turn variables into animations. You can find a lot more information about the functions and methods described here by looking at the official [pygame documentation](https://www.pygame.org/docs/).  At the top of that page you'll find a banner containing links to individual module documentation. Each of those pages gives full descriptions for everything provided by the module. For example, if you want to read more about `blit`, then you'd go look for it in the the `Surface` module documentation as it is a surface method. We've just barely scratched the surface of what we can do with pygame, but don't worry. We'll be expanding our pygame toolkit soon.
