---
layout: page
title: From *Loop Forever* to *Loop Until*
permalink: /teaching/comp151/game/gamev1-loopcontrol
---

Thus far, we've relied on the following game loop:

```python
while True:
  for event in pygame.event.get():
       if event.type == pygame.QUIT:
           pygame.quit()
           sys.exit()
  # Compute one game frame
```

Let's take a look at how, exactly, this loop functions and how we can start to exert a bit more control over it. The loop statement itself is this:

```python
while True:
  # code here
```

The `while` statement will repeat all the indented code under it, called the **loop body**, to repeat so long as the expression that follows it evalutes to `True`. By explicitly using the `True` value, we have created an *infinite loop*, a loop that repeats the body code forever.  This particular loop has a mechanism that will abruptly terminate the infinite repetition by closing the entire program, namely the code to detect a `QUIT` event and react accordingly.

```python
for event in pygame.event.get():
     if event.type == pygame.QUIT:
         pygame.quit()
         sys.exit()
```

So far, this kind of loop has served us well. It's simple and effective.  Going forward, it's too limited by the fact that we're only able to terminate the loop by terminating the entire program.

Consider the following common situations in games:

  1. The player transitions between an animation (like our version 0) and the game. Both require a game loop but each has a different set of goals, mechanics, and player controls.
  2. The game has multiple levels. Levels can have different controls, images, and rules.

In both these cases it's much easier to handle the programming details by using multiple, distinct game loops. For example, if your game has five levels, then you're much better off thinking in terms of (at least) five game loops: one per level. For this to work we need to move from a *repeat forever* loop to a *repeat until* loop.

## The Sentinel Variable Loop

A sentinel is someone or something that keeps watch.  A classic pattern used in programming is to create a boolean-value variable to act as a sentinel for a loop. For example, if we want a loop whose semantics are *repeat until the level is over*, then our sentinel variable could hold `True` so long as the level is not over, and then be set to `False` whenever the level is finished. Such a loop might look like this:

```python
levelNotOver = True
while levelNotOver:
  # compute frame
  # assign False to levelNotOver whenever
  #  if the level should end for any reason
```

The sentinel loop is incredibly flexible as it lets you separate any loop-ending conditions from the loop itself. That is, rather than do some boolean computation in the `while` statement, we simply create a boolean variable, set it to `True` to force the loop to happen at least once, then make setting the variable to `False` as part of the loop body. This relatively small change to our loop solves all the problems we have with our game.

  * Want to loop an animation until the player presses a key? No problem! Set the sentinel variable to `False` when the player presses the desired key!
  * Want to end a level if the player runs out of hit points? No Problem! Set the sentinel variable to `False` when their hit points reach zero!
  * Want to end a level after a set amount of time? No Problem! Use the pygame clock to count time then set the sentinel value to `False` when enough time has passed!

As your loop terminating conditions get more complex, you'll need to think carefully about where and how to build ending mechanics into your loop, but so long as you set the sentinel to `False`, your loop will terminate once the current body code is done executing.

## Inverted Sentinels

Sometimes you find it easier to think and name things in terms of the loop ending condition and not the loop continuation condition. For example, *repeat until level is over* versus *repeat while level is not over*.  For sentinel variables, this means using `True` to signal the termination of a loop and `False` to signal the continuation of a loop. This is the opposite of what the `while` statement requires. The good news is that we have the boolean `not` operator.

```python
levelOver = False
while not levelOver:
  #  compute frame
  # set levelOver to True when loop should terminate
```

The `not` operator flips a `True` to a `False` and a `False` to a `True`. In the above loop, we use it as part of the `while` statement in order to invert our *stop when* sentinel value into a `continue when` value. The only downside of this approach is that every repetition of your loop requires computing the `not`. Generally, speaking, you don't need to worry about that kind of cost. If you find that your game is running slowly or inefficiently, then odds are it is due to some other part of your code and not the extra cost incurred by inverting your sentinel. So, if you find inverted loops easier to work with, then use them don't worry about the possible performance problem until you actually notice you have a performance problem in your code.
