---
layout: page
title: COMP151 - Project 2 Prep Lab
permalink: /teaching/COMP151/labs/project2prep
---

This lab is all about gearing up for your second project by starting to put together the basic pieces of synthesized music. You've been given a file that contains functions for generating five types of sound waves: silence, sine, white noise, square, and triangle. Each function lets you specify duration in seconds. The sine, square, and triangle functions also let you set amplitude and frequency. The white noise function let's you specify amplitude and duration. In short, you can use them to generate notes and sounds for a given time duration. From there can begin to build up full voices and songs by combining and blending them with other sounds. In this lab you'll learn to use these wave forms, add another wave form, the sawtooth wave, to the library, and start building musical and rhythmic phrases.


* Don't forget that at the end of each chapter contains a *Programming Summary* section that provides a quick dictionary of all of the important function and encoding names introduced thus far. When you run into problems don't forget to check the *Common Bugs* and *Debugging Tips* scattered throughout the chapters as well. If you're stuck on an error try looking at these items.
* As always switch the *driver* (person typing the code) and *navigator* (person watching, helping spot typos, etc.) on every new problem **or** every half hour, whichever comes first.
* Do all of the problems in a single python file. Put everyone's name in a comment at the top of the file. Label the start of each problem with a comment.

### TODO

1. Take a few moments to generate, play, and explore a few different sounds with each of the available waves. Get used to their sounds, their differences, and be certain you know how to use them.

2. In the code for square waves and triangle waves you see an expression like a = (a+1)%b. This is used to track the number of samples that have been produced in order to properly "turn around" in the middle of the cycle. It's an alternative approach to what you see in the book and worth a closer look. First things first, remember that the % operator computes the remainder. For example, 5 % 2 is 1 because 5 has a remainder of 1 when divided by 2. Now, let's just say that a starts with a value of 0 and b is 4. Write down what happens if you do a = (a+1)%b 7 times?  Then, describe how this kind of pattern works in the context of the triangle and square wave functions, i.e. how does doing this let you properly track loop cycles and turn around points.

3. Write a function that takes frequency, amplitude, and duration (in secs) as its inputs and returns a sawtooth wave with those properties. It should work just line the sine, square, and triangle functions but produce a different wave form. A sawtooth waves begins its cycle at half it's maximum amplitude and then steadily decreases down to the negative of the half the maximum amplitude by the end of the cycle. In other words, it starts at a positive value then steadily decreases down a full amplitude into the negative by the end of its cycle. When you repeat the cycle it starts back right at the top. This sudden change from minimum to maximum followed by a steady decline to the minimum again creates the characteristic sawtooth pattern.

4. Music can be broken down into beats. The speed, or tempo, of music is often measured in beats per minute (bpm) with slower tempos occurring at 70 bpm, moderate tempos around 110 bpm, and fast tempos around 140 bmp. We want to use our wave generators to produce beats of sound so we need to know how to go from bpm to seconds. First, figure out the duration, in seconds, of one beat of music if the tempo is 120 bpm and again if the tempo is 70 bpm. Now, write a python function named *secondsPerBeat* that takes in a bpm value and returns the number of seconds per beat. Be certain your function returns a floating point number and not an integer. Check your function against the values you computed for 120 bpm and 70 bpm.

5. We'll typically want to construct a single beat out of a combination of silence and sound. For example, a drum-like sound might come from repeating a pattern of one half a beat of noise following by a half a beat of silence. More rhythmic patters often come from putting sound in the later part of a beat rather than the beginning. Finally, we'll need to combine beats into full phrases of music. We could think in terms of concatenating sound, i.e. just gluing short sounds together end to end, but it will be more efficient if we instead think in terms of copying sound into silence. As a bonus, we can use the general copy function shown in program 106 to get this done! Now, copy program 106 from the text to your program but modify it so that the starting location for copy is given as a floating point specification of seconds rather than a sample number. For example, passing 1.5 in for start means start copying 1.5 seconds into the target sound.

6. Use your new copy function to construct the 16 beat percussion pattern described below at a tempo of 120 bpm. Our "instrument" generates a quarter of a beat of white noise each time we play it. Our rhythmic pattern begins by repeating the following 4 beat pattern three times: Play the instrument once at the start of the first beat and again halfway through the first beat, and then for the next three beats play it once at the the half way point of the beat. Like this:

  |Beat | 1 | | 2 | | 3 | | 4 | |
| :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: |
|Sound | x | x | | x| | x| | x|

  Finally, we end by starting that same pattern but leaving out the final three sounds, i.e. play the instrument on the first beat and half-beat then wait for three beats of silence. Like this:  

  |Beat | 1 | | 2 | | 3 | | 4 | |
  | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: |
  |Sound | x | x | | | | | | |

7. Play around! Make new percussive beats and/or start making melodic phrases using the other wave forms at different frequencies. Just pick a tempo and work by mixing sound and silence in half, quarter, or even sixteenth beat increments.  Create at least four beats of sound and *save that to a wav file*. Maybe go for something like the starting bass line from "Another One Bites the Dust" by Queen using triangle waves? Don't worry about musicality or something that sounds good if music isn't your thing. Just make something pattern oriented that includes a mix of sound and silence and you're good to go.

When you're done, print and turn in your code and email your wav file from number 6 to the instructor.
