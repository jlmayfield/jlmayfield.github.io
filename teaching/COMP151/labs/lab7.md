---
layout: page
title: COMP151 - Lab 7
permalink: /teaching/COMP151/labs/lab7
---

And now for something completely different.  We're switching gears and looking at tasks from the sound domain. What you'll learn is that the basic programming tools that allowed us to manipulate images also allow us to manipulate sound. The key differences in our sound programs will come from the ways in which sound encoding differs from image encoding.  We're dealing with samples instead of pixels. For lab this week you'll start familiarizing yourself with sound encoding and the ways in which JES and Jython let us interact with sound.


* Don't forget that at the end of each chapter contains a *Programming Summary* section that provides a quick dictionary of all of the important function and encoding names introduced thus far. When you run into problems don't forget to check the *Common Bugs* and *Debugging Tips* scattered throughout the chapters as well. If you're stuck on an error try looking at these items.
* As always switch the *driver* (person typing the code) and *navigator* (person watching, helping spot typos, etc.) on every new problem **or** every half hour, whichever comes first.
* Do all of the problems in a single python file. Put everyone's name in a comment at the top of the file. Label the start of each problem with a comment.

### To Do

You have two tasks for lab: explore the basic Jython/JES tools for working with sound data and create your own sound using the LittleBits kit. There are a limited number of kits so some of you will begin with the programming task and some of you will begin with the kits.  You should have a python document to print and turn in at the end of lab.

#### Sound in JES

Type the code for all of these tasks in a Python file such that running the file will demonstrate each task. No function definitions are needed here. You're just finding and using key sound functions that already exist in JES. If you haven't read chapter 7 yet, then you'll need to explore the chapter for examples of all the sound functionality needed.
1. Choose two sample sound files from the media set that goes with the textbook and:
    * Open and play the files. Do not use pickAFile for this. Use a setMediaPath/getMediaPath to get files.
    * Use explore on your sound. Play different parts of the sound.
    * Print the total number of samples in the files
    * Print the Sample rate of the file
    * Compute and print the time length of the file using the number of samples and sampling rate
    * Determine how many bytes are needed to encode one minute of sound at the sampling rate(s) of your files. Record your answer as a comment in your code.
2. Do problems 7.6 and 7.7.

#### Synthesis with LittleBits
In a chapter 9 we'll learn how to synthesize sound using code. The LittleBits synth kits let you create sounds using digital hardware. Your goal for today is to create your very own sound and record the LittleBits kit configuration you used to create that sound.  Remember we need to share the kits. If you're one of the first groups to go, then try not to take more than an hour.

1. If a hard-copy is not with your kit, then get the (Synthkit Booklet)[https://d2q6sbo7w75ef4.cloudfront.net/SYNTH-booklet.pdf]
2. Read about the different components in the kit. Which component(s) generate sound waves?
3. Try some of the sample configurations. Make some noise! Have fun with the kit.
4. Invent your own sound using the kit and:
    * Write down, as a comment in your python code document, how to recreate the configuration. Think of this as a kind of program for rebuilding your kit and reproducing your sound.        
    * Time permitting, trade your "code" with another group and see if you can recreate each other's kit.
    * If possible, use Audacity to record some sound from your kit and visualize it with Sound Visualizer.
