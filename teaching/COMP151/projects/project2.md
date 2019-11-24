---
layout: page
title: COMP151 - Project 2 - Let's Make Music Everyday!
permalink: /teaching/COMP151/projects/project2
---

For your final project you'll program a bit of music taking some inspiration from early video game systems and the Little Bits synthesizer kit. Below you'll find descriptions of each version of the project, details about key ideas in computer music, and finally the details about grades and due dates.


### Project Versioning

Larger pieces of software are developed in increments, or versions.  Each version produces a working piece of software that builds upon the previous step but that also stands on its own merits.  Initial versions of the software often only complete some of the desired tasks and in some cases does so in a simplified way.  New versions of the software are often completed by adding additional code but sometimes existing code must be refactored and partially-rewritten to incorporate some new features into the program.  For your project you must following the versioning laid out below. To reinforce the importance of versioning, your grade is largely dependent on your ability to successfully carry out the given plan.

#### Version 0

The first version of the program has two main goals: setup proper program structure and carryout at at least one of the desired music production tasks. It's really just meant to get you started on the right foot without having to wade into too many of the program details. The finished product should:

* Have a well defined main function that coordinates the following functionality:
    * Create 8 beats of music at 200 bpm using the following 8 note sequence: A3, C4, E4, G4, A4, G4, E4, C4. Each note should last for half a beat and occur at the beginning of each beat. You can choose whichever wave form and amplitude you'd like. Feel free to mix and match if you want.   
    * Open the result to explore/play the music.


A complete version 0 program will, when run, pop up the explore window showing you the wave. There should be a clear visual difference between each note due to the difference in frequencies. In some of the resources below you'll find a link and some discussion about note names and the frequency of specific notes.

#### Version 0.5

In this version you'll create a *voice* and modify the result of version 0 to play the same note pattern using that voice. A voice is just a basic wave that is modified in some way in order to produce a new and different waveform. For musical voices we will want to design a function that works in the same way as a wave generator: you provide frequency, amplitude, and duration and it returns a wave with more or less those characteristics.  These voice functions act as the programming equivalent of putting together a little bits synthesizer to create some kind of synth instrument. The basic wave generators from lab act as the oscillators. They give you a wave. In this version of the program you'll you'll begin to develop and deploy other functions to modify and combine those waves.


* Design a function called *mixer* that works as described in the effects section below.
* Use *mixer* as the basis for a function called *voice1* that produces a mixture of at least two waves. Try things like combining different wave-forms of the same frequency or mixing in small amounts of a different frequencies to the main frequency. You can even try mixing noise in with a note to see what happens. Have fun with it. Play around. Find some dope sounds.
* Modify your program so that it plays the same music but does so with the output of *voice1* rather than a basic waveform.

#### Version 0.75

New version. New sound effect. A new voice.  

* Write a function called *envelope* that implements the envelope effect described in the effects section below.
* Design a second voice function called *voice2*. Between *voice1* and *voice2* you must use *mixer* and *envelope* at least once each. That's once in total not once per voice. You may use them more if you'd like.
* Modify your program so that *voice2* is used to produce an A2 on every other beat for 8 beats. That's the first, third, fifth, and seventh beat. The 8 beat sequence produced by *voice1* should stay the same excepting for any extra effects added to the sound produced by voice1. Finally, use mixer to combine the two 8 beat song parts to produce a two part song.

#### Version 1.0

Add one more voice.

* Design a third function called *voice3*. This third voice can be whatever you want it to be. If you want a more rhythmic, drum-like voice, then feel free to leave out the frequency input and design something that works like the white noise generator.
* Modify your program to add a part for *voice3*. Do whatever you want. The only requirement is that it includes at least 4 distinct moments of sound, i.e. four drum hits, four notes, etc. Mix the third part in with the existing two using *mixer*.
* Make it so your program saves this sound to a .wav file on the hard drive.

#### Version 2.0

Now let's do something a bit more than 8 beats. You have two options and they are both discussed in detail [here](/teaching/COMP151/projects/project2songs). This first option is to program a specific song. The second options is to do a different song that meets a few basic constraints. If you want to do something other than the given song and you're not sure if it meets the requirements, just ask.

### Resources on Music and Audio Synthesis

#### From Notes to Frequencies

Western music, and the music you'll be programming, is based on a clear 12 note pattern that repeats itself over and over at higher and higher pitches. This repetition produces a standard set of notes from which all music is written.  You can find their names and the wave frequencies that go with them here: [Note Names to Wave Frequency](https://pages.mtu.edu/~suits/notefreqs.html).  At the top of the chart is C0, a very low note. The 12 note pattern starting at C0 continues down the chart to B0 and then begins the pattern again at C1.  We tend to like notes around C4 and place this note in the middle of a piano or keyboard. For this reason it's called *middle C*.    

#### Scales, Intervals, and Resonant Tones

The difference between C0 and C1, or any note and the next higher numbered form of that note, is called an *octave*. The numbers you see on note names are their octave numbers. From a frequency perspective, moving up an octave means to double the frequency. For example, notice A0 is 27.5, A1 is 55.0, A2 is 110.0, A3 is 220.0, and so on. There is also a set of fixed multiples between a note and the other 11 notes within the octave. Here you see an octave starting on C.

| Note | Frequency (Ratio) | Frequency (Decimal) |
| :---: | :---: |:---: |
|C| f | f |
|C#| (256/243)f | 1.053f |
|D| (9/8)f | 1.125f |
|D#| (32/27)f | 1.185f |
|E|(81/64)f | 1.266f |
|F| (4/3)f | 1.333f |
|F#| (729/512)f | 1.424f |
|G|(3/2)f | 1.5f |
|G# | (128/81)f | 1.58f |
|A| (27/16)f | 1.687f |
|A#| (16/9)f | 1.778f |
|B| (243/128)f | 1.898f |
|C| 2f | 2f |

While the chart above starts on C, it actually doesn't matter where you start. If you start at a G and call its frequency f, then the 12 note sequence up to the next G follows this same pattern of multiples as moving from C to C.

Where this becomes useful is in mixing in related notes to a target dominant tone of a voice. Let's say your voice is meant to produce some note with frequency *f* (maybe 440). You might mix in just a little bit the fourth (5 steps up) or fifth above that note (6 steps up). You just take your dominant frequency *f* and multiply by (4/3) and/or (3/2) to get the right note for you mix. These notes tend to be very resonant with your dominant frequency and work well in combination with that note. On our C-based chart this is the equivalent of mixing F and G with C.

#### Sound Effects

You'll be implementing program versions of little bit synth kit components. Below you'll find descriptions of each component as a function acting on and with sound data.

##### Mixer

The mixer takes two audio signals and combines them in amounts based on how you set the input knobs. We can think of this as a function that takes two sound objects and two numbers between 0 and 1 and returns a mixture of those sounds based on the values of the numbers. We can think of the numbers as volume settings. If you use the number 1, then you're asking for 100% of the original sound. Using 0 then means using none of the original sound. In this way we can not only control the proportion of each sound in the result but the overall volume as well. Finally, this mixer should have no problem mixing sounds of differing lengths. The result should be as long as the longest sound. If your first sound is two seconds and the second is one second, then the result is two seconds where the first second is a mix of the two sounds and the last second is just the last second of the first sound.

Let's explore some examples.  Suppose you have two sounds: *s1* and *s2*.  Doing something like *mixer(s1,1,s2,1)* would mix them together in equal parts and at 100% of their original volume. On the other hand doing *mixer(s1,.5,s2,.5)* cuts the volume by half on each sound but then mixes them together.  By keeping the numbers the same we can keep the mix balanced but cut back the volume to avoid clipping that is likely to occur if the original amplitude of *s1* and *s1* was already pretty high.

If instead we did *mixer(s1,1,s2,.5)* then we'd mix the full volume of s1 with s2 at half volume. This lets us keep s1 as a dominant wave and use s2 to spice it up, or color it, a bit. This kind of mixing is also important if we want to mix more than two sounds in equal proportions. Let's say we also have sound *s3* and would like to mix it equally with *s1* and *s2*. We can first do  *temp = *mixer(s1,0.5,s2,0.5)* to get an equal mix of *s1* and *s2*. If we then did *mixer(temp,0.5,s3,0.5)* we'd end up with too much of the temp sound because we've effectively cut *s1* and *s2* in half again. What we need to do is *mixer(temp,0.667,s3,0.333)* to account for the fact that two thirds of the components are mixed in *temp* and only one third in *s3*. A similar kind of scaling would need to occur to mix in a fourth signal in equal proportion to three equally mixed signals.  For this project you're welcome to find sounds and mixes that you like through trial and error and now worry about the overall proportions. If, however, you find that you have too much or too little of a sound in a mix containing more than two sounds, then keep this discussion in mind.


#### Envelope

Natural sounds do not typically start at one amplitude and stay at that amplitude for as long as you'd like them to. This is, however, the kind of sound our wave generators produce. A naturally occurring sound typically has a volume *envelope* where the volume grows to a peak and then shrinks back to nothing. The growth phase is called the *attack*. The shrinking phase is called the *decay*. A basic envelope effects lets you set the length of attack and decay.

Your *envelope* function should take a sound object, an attack length in seconds, and a decay length in seconds. It should then increase the amplitude of the sound from 0% to 100% for the duration of the attack phase and then decrease from 100% back to 0% for the duration of the decay phase. The catch here is that the input sound does not need to be as long as the sum of the attack and decay time. Imagine banging a gong. It has a short attack and a long decay. If you hit it once it and leave it alone you'll hear a loud tone that slowly decays to nothing. If you hit it again before it stops ringing, then you are effectively stopping the old envelope mid decay and starting a new envelope. Your *envelope* function should support this kind of musical sound by computing as much of the envelope as fits the given sound. Suppose your envelope has an attack of 0.25 seconds and a decay of 1 second. If the given sound is 0.5 seconds, then you get all of the attack phase and only 0.25 seconds of decay. If the given sound is 2 seconds you get the full envelope including 0.75 seconds of silence created at the end of the sound.

### Grades and Dates

We'll dedicate two lab periods and some class time to this project. Use that time wisely. The final grade for the project is determined by how many versions you complete and the quality of the code you submit.

#### Important Dates

| Date | Event |
| :----: | :-----: |
| 11/25 | Lab time to begin project |
| 11/26 | Lab time to begin project |
| 12/2 | Lab time to continue project |
| 12/3 | Lab time to continue project |
| 12/4 | **Project Due** |

Projects should be submitted by 11:59 midnight on Wednesday, a.k.a midnight Thursday. *Email to me a copy of your code and, where applicable, the sound file produced by your code.*

#### Grades
Your grade is determined based on the highest version number you complete (see the chart below) and the overall quality of the work submitted.  

| Version | Grade |
| :-----: | :---: |
| 0 | D  |
| 0.5 | C |
| 0.75 | C+ |
| 1.0 | B |
| 2.0 | A |

Quality is measured by the cleanliness and clarity of the code and the appropriate use of sub-functions that exhibit reusable design. The versions determine the range in which you grade will fall and the quality of your code will determine where your grade lands within that range.  For example, let's say you've finished version 0.75 and your code is neatly presented and well designed. Your grade starts at a C+ due to the version that you're presenting and could go up as high as a low B- based on the quality. Conversely, if your code is all crammed into a single function and your variables are poorly named, then your grade could go down as low as a high C due to poor quality.
