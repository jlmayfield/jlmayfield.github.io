---
layout: page
title: Your First Foray Into Pygame
permalink: /teaching/comp151/game/pygame-round1
---


We'll be using games as a platform to exercise our new-found programming abilities while having fun and being creative.  It is certainly possible to build games from the ground up using base Python, but a more measured approach starts by using a python library called [Pygame](https://pygame.org). Libraries effectively extend base Python with new data types, functions, and operations, in order for programmers to more easily take on certain problems.  Pygame provides everything you'd need to build video games or game-like programs.

This document will show you how to use Pygame to:
  1. Load and manage game assets such as images and sounds.
  2. Resize images
  3. Draw some or all of an image to a screen.
  4. Play sound.
  5. Draw text on the screen.

Once we add variables into the mix, then we have everything we need to make game-style animations and set those animations to music.

# Preliminaries

Python libraries are typically organized into a series of **modules**. A module provides a collection of related data types and functions.  We'll be directly or indirectly interacting with the pygame modules listed below. The parts of the modules you need will be discussed in this document. For now, just make note of their names. You can come back later and explore the full documentation for these modules by clicking the links.

  * [pygame](https://www.pygame.org/docs/ref/pygame.html) The main Pygame module
  * [display](https://www.pygame.org/docs/ref/display.html) A module to control the display window and screen.
  * [mixer](https://www.pygame.org/docs/ref/mixer.html) A module for loading and playing sounds
  * [image](https://www.pygame.org/docs/ref/image.html) A module for loading images
  * [time](https://www.pygame.org/docs/ref/time.html) A module for monitoring time
  * [locals](https://www.pygame.org/docs/ref/locals.html) Some key Pygame constants
  * [Surface](https://www.pygame.org/docs/ref/surface.html) A module for representing images
  * [transform](https://www.pygame.org/docs/ref/transform.html) A module for modifying surfaces (aka images)
  * [font](https://www.pygame.org/docs/ref/font.html) A module for loading and rendering text
  * [event](https://www.pygame.org/docs/ref/event.html) A module for interacting with events and queues

## Importing and Referencing Modules

To incorporate these modules into our program we must first **import** the pygame library.  The starter program you've been given has the following lines of Python:
```python
import pygame, sys
from pygame.locals import QUIT
```
The first link imports the pygame library and the base python module [sys](https://docs.python.org/3/library/sys.html).  You won't need to interact with sys directly.  This style of import statement makes the entire module or library available to you. Sometimes you only need or want a specific item from a module. For that you have import statements like the second line above.  `from pygame.locals import QUIT` will import the `QUIT` constant (more on those later) from the `locals` module within the `pygame` library.  We don't need to worry too much about what `QUIT` is at this point, but you should pay very close attention to how a module within a library is referenced: `pygame.locals`. The use of the `.` to separate parts of a specifier is a common idiom in program and is pervasive within the pygame library. When you write something like `pygame.time`, then you're referencing the time module within the pygame library and anything that follows is something provided by that module.

## Some Things for Free

The starter code provides a lot of basic stuff to get you started. Let's look at it all and focus on understanding *what* it does more so than *how* it works under the hood.

The first thing you'll see after the module imports is:
```python
pygame.init()
```
This calls the `init` function from the main pygame module.  As the name and context implies, this function initializes the pygame modules.  We can assume that pygame needs to do some setup in the background in order to work and this function initiates that setup process.

Next we see two lines of code needed so that we can eventually control the drawing frame rate:
```python
FPS = 30
fpsClock = pygame.time.Clock()
```
The first line is not pygame. It's just base python. Technically, it's the declaration of a variable named `FPS` with an initial value of 30.  By writing the name in all caps, we are signifying to ourselves that this variable is intended to be used in a *read-only* fashion. Such variables are typically called *named constants*.  Constants make your code more readable can make modifications easier by specifying related attributes in terms of named constants rather than literal values. The second line of code declares the variable `fpsClock` and assigns to it a `Clock` object.

The `Clock` object represents our first encounter with an object-oriented data type. These data types do not have literal representations like integers, floats and strings and typically have multiple attributes rather than a singular value. In this case we want an object that represents the game clock. To get one of these objects we invoke the ***constructor function*** `Clock()`.  This function sets up an ***instance*** of the Clock data type. We then assign that object to the variable `fpsClock`. We'll see this clock object get used later. For now the important thing is noticing that when data types scale up beyond simple, single-valued data with literal representations, then we'll commonly see and use *constructor functions* in place of literals.

Next up in the program are three more constant declarations.
```python
BG_HOME = './assets/background/'
PPL_HOME = './assets/people/'
MUSIC_HOME = './assets/music/'
```
These string constants are the locations of our background images, character images, and music files respectively.  These locations are specified relative to the program's *working directory*.  Programs themselves run relative to a directory, aka folder, on the computer.  When we try to load images or sound, the program will assume the files are in the working directory unless we specify otherwise. To keep our working space organized, we'll keep all our non-code files in the *assets* directory. Within that directory we'll further organize files. We don't need to do this, but it's good practice.

The next block of code setups up the game window takes us back into pygame territory.
```python
SCREEN_W = 400
SCREEN_H = 300
DISPLAYSURF = pygame.display.set_mode((SCREEN_W, SCREEN_H))
pygame.display.set_caption("My First Game")
```

We first declare the width and height we'd like our screen to be as the constants `SCREEN_W` and `SCREEN_H`. This doesn't actually set the width and height of the screen, but by declaring our intention as constants, we can refer to the names whenever needed rather than use the literals. If we change our minds later, we can change the value of the constants and then every reference to that constant is effectively adjusted. The next like does a lot of heavy lifting. Let's take it in pieces.

First we invoke the `set_mode` function from the display module and pass it the *tuple* `(SCREEN_W,SCREEN_H)`.  A tuple is just a collection of values all packed together into a singular object that can be easily unpacked. There's nothing special about tuples other than they provide a quick way to pack multiple pieces of data into a singular object. The `set_mode` function effectively sets the window to the size specified by the tuple and returns a pygame Surface object. That object represents the screen on which we'll draw all our images. The surface is assigned the name *DISPLAYSURF* using uppercase letters to indicate that we should not be attempting to reassign values to that variable. In context, the `set_mode` function looks like a constructor but it's really initializing the display window and then returning to you access to the display surface within that window. It's not a constructor, but we can safely assume that internally, it evokes a Surface constructor and returns to us that object.

The final line of the display initialization block is noteworthy because it's an example of invoking a function for effect and not in order to get some value. Here we're calling `set_caption` from the `display` module which, as you might guess, sets the caption of the display window. We don't need or want a return value from this function, we just need it to modify the window, which it does.

## *The Game Loop*

The last block of code is where all the action is happening. It's the main *game loop*. It will cause the computer to repeat, indefinitely, the following actions in the following order:
  1. Check if the user pressed the X in the upper-right corner of the window and if they did shut down the game.
  2. Update (i.e. redraw) the display surface
  3. Set the game clock to match the desired frame rate stored in `FPS`.

Let's look at the whole block then break it down into parts.
```python
while True:
    for event in pygame.event.get():
        if event.type == QUIT:
            pygame.quit()
            sys.exit()

    # your code here

    pygame.display.update()
    fpsClock.tick(FPS)

```
On the first line we see `while True:`. This is the line that causes the indefinite repetition. The `while` keyword signifies the start of a loop statement. Such statements are used to make code repeat. Specifically, any *indented* code on the lines below this line will repeat. *When you add code to this loop it must be indented to match the `for` on the second line.

Next we see the code block responsible for shutting down the game when it is time to do so.
```python
for event in pygame.event.get():
    if event.type == QUIT:
        pygame.quit()
        sys.exit()
```
We're not going to discuss this in any detail at this point. We'll interact with it a lot in future versions of our game, but for now just know that the combined effect of those four lines of codes is to end your game when the user closes the window and that you should not change them or move them.

Finally, we see the screen update `pygame.display.update()` and the clock update `fpsClock.tick(FPS)`.  Between the game quit code and the updates is the comment `# your code here`. It is at this point where you will put code to modify what gets displayed and how. In doing so you'll turn the game loop's  logic into the following:
  1. Check if the user pressed the X in the upper-right corner of the window and if they did shut down the game.
  2. Change what should get drawn.
  3. Update (i.e. redraw) the display surface
  4. Set the game clock to match the desired frame rate of `FPS`.

When run, the starter program will initialize and display a 400 by 300 window with nothing in it. That window is constantly updated, with nothing, at a rate of 30 frames per second. Your job is to replace that nothing with something and add some music to get a fun-filled animation.

# Loading, Scaling, and Preparing Images

Preparing an image for use in our game will start with a three step process: (1) load the image, (2) scale the image to a new size, (3) convert the image for fast rendering.  In the future, you might also add some transformations to step 2, but for now we'll just focus on resizing an image.

## Loading Images
One of the first things you'll want to do is load some images into memory. This process is very straight forward and accomplished using the `load` function from the image module in the fashion illustrated by the following example:
```python
BG_0 = pygame.image.load(BG_HOME + 'parallax-forest-back-trees.png')
```
The `load` function takes the *path* to your image, loads that image into a pygame Surface object, and returns that object.  That object can then be saved to a variable for later. Notice above that we've created the path to one of our background images by *concatenating* the filename with the path we previously declared as a constant.

It is typically necessary to know the width and height of an image image. For example, either you want to set the screen size to match your background or you need to scale the background up, and in both cases you'll want to know the image dimensions. We can get these object *attributes* using the Surface object **methods** `get_width` and `get_height`.

A method is a function that acts upon an object by using the `.` operator. This is different than calling functions. When using a function you pass all the needed objects to the function by listing them within the parenthesis. With methods the calling object is to the left of the `.` and the method, along with any other inputs needed, is to the right. Here we see how to get, then print, the width and height of our previously loaded image.
```python
print(BG_0.get_width(),BG_0.get_height())
```

## Resizing an Image

Scaling an image, technically a Surface, can be done using the `scale` function from the transform module. This function takes two arguments, the surface to scale and it's new dimensions. The dimensions are given as a tuple containing the width and height you want the result to have.  Here we scale `BG_0` to match a previously declared width and height, namely `SCREEN_W` and `SCREEN_H`. The resized image is returned and saved to a variable. Notice that we're reusing the name `BG_0`. Because we don't need a copy of both the original and resized image, it makes sense to replace the old image with the new.
```python
BG_0 = pygame.transform.scale(BG_0, (SCREEN_W, SCREEN_H))
```
The last thing to notice about `scale` is that you must provide the *exact* width and height of the new image. This can make things like doubling the size a bit tricky as you must first get the original width and height and then use twice those values when invoking `scale`.


## Converting an Image

Once you've got the image ready to go, we need to optimize it so that pygame can draw it as fast as possible. For this we'll use the Surface method, `convert_alpha`.  This method converts not just  RGB color values but RGBA values that include the alpha, or transparency, channel to a format that is optimized for pygame. Once again, we can just replace old `BG_0` with the converted surface as we don't need both copies.
```python
BG_0 = BG_0.convert_alpha()
```

# Drawing Images

Now that you've loaded, scaled, and converted an image, it's time to draw it! This is accomplished by using the Surface method `blit`. Blit stands for *block transfer*. As the name sort of implies, the method will transfer one block region of a surface onto another. The calling surface, the one to the right of the `.`, is the one onto which you'll transfer/draw. You then give `blit` at least two arguments. The first is the surface to be transferred/drawn and the second is the left and top coordinate (think (x,y)) where the transfer image should be placed in the receiving image.  *What's important to remember is that the location (0,0) is the upper left hand corner of a surface and coordinates go up as you move down and right.* Let's look at an example.
```python
DISPLAYSURF.blit(BG_0, (0,0))
```
Assuming that the image `BG_0` is the same size as the screen surface `DISPLAYSURF`, then the above command will effectively draw the background on the surface.  If we change `(0,0)` to different numbers, then your background image won't be lined up properly and something is likely to be cut off from view.  If either value is negative, then part of the image at the top or right is cropped off. If, in the case of two surfaces with the same size, they are not zero, then something gets cropped off on the right or the bottom.  In either case, the system will draw as much as it can into the receiving surface.

The other way to use `blit` is to draw only part of an image. For this we pass a third argument to blit. This argument is a tuple of 4 numbers representing the left coordinate, top coordinate, width, and height of the region you wish to be drawn.  This 4-tuple specifies as rectangle and we'll be working with this kind of data a lot in the future. Let's say we only want to draw to `DISPLAYSURF` the region of `BG_0` that starts at (10,50), that's 10 pixels right of the upper left corner and 50 pixels down, and has a width of 100 and height of 125. Then we'd make the following call to `blit`:
```python
DISPLAYSURF.blit(BG_0, (0,0), (10,50,100,125))
```

So far, all our examples have been drawing an image, `BG_0`, onto the screen, `DISPLAYSURF`. It's important to remember that `blit` is method for Surface objects and both our screen and our images are represented in pygame as surfaces. That means you can `blit` images onto one another as well as onto the screen.  It's your choice.  This kind of flexibility lets you construct complex scenes in a variety of ways.

# Rendering and Drawing Text

Now that we have images on the screen, we might like to put some text up as well.  For development purposes, it can be nice to see the frames per second at which our our game is currently running.  Given our starter code, we can get this number, round it to an integer, convert it to a string, and save it to the variable `curr_fps` with the following:
```python
curr_fps = str(int(fpsClock.get_fps()))
```

To make this visible in our game we must first render the string to an image/surface.  This first requires that we setup a font, size, and color for our rendered text. We can start with the following:
```python
FONT = pygame.font.SysFont('Helvetica', 18)
FONT_CLR = (100,150,100)
```
Here we use the `SysFont` function from the font module to load in 18pt Helvetica from the system. We get a pygame `Font` object as a result. We then declare a constant to hold a tuple that represents the RGB values of the color we want. If you do a Google search for *color picker*, you'll get a simple tool with which you can find the RGB values for any color you want.

Now that we've setup the font, size, and color for our text, we can use our Font object `render` method to render our string as a surface. This function acts on a Font object, takes the string to render, 0 or 1 for anti-aliasing (use 1 by default), and the RGB tuple. It returns a surface.
```python
txt = FONT.render(curr_fps, 1, FONT_CLR)
```
We now have an image of our desired text saved to the varible `txt` and can use `blit` to draw `txt` onto another surface as needed.

# Loading and Playing Music

At this point we just want a bit of background music. As a result, our needs here are very straight forward.  First we load our music:
```python
pygame.mixer.music.load(MUSIC_HOME + 'Amber Forest.mp3')
```
This will load the given music file into the game's sound mixer and place it in a special channel for music (as opposed to sound effects).  Think of `pygame.mixer` as the mixer, `music` as the music specific channel of that mixer, and `load` as a method we call on that channel.

Once the music is loaded into the channel, we just need to tell the mixer to start playing the channel using the `play` method.
```python
pygame.mixer.music.play(-1)
```
By passing `-1` to `play`, we're telling to mixer to play the music on a never ending loop. If you pass no arguments, then it will play once and stop. If you pass a positive number, then it will play for that number of seconds.

# Conclusion

You now have all the tools you need to turn variables into animations. You can find a lot more information about the functions and methods described here by looking at the official [pygame documentation](https://www.pygame.org/docs/).  At the top of that page you'll find a banner containing links to individual module documentation. Each of those pages gives full descriptions for everything provided by the module. For example, if you want to read more about `blit`, then you'd go look for it in the the `Surface` module documentation as it is a surface method. We've just barely scratched the surface of what we can do with pygame, but don't worry. We'll be expanding our pygame toolkit soon.
