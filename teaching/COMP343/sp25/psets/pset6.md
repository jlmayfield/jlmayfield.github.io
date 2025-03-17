---
layout: page
title: COMP343 - Problem Set 6
permalink: /teaching/COMP343/sp25/pset6/
---


Below you'll find the required reading and problems for this assignment. This assignment is based around reading a research paper and not the text. The exercises are really reading comprehension questions designed to focus your reading of the text. So, as always, check out the exercises prior to doing the reading. 

## Starter Assignment

We'll warm-up to the main event, Claude Shannon's paper, by looking at Nate Silver's take on the Deep Blue vs Kasparov match from the late 90s. First:

*   Read Nate Silver's *Rage Against the Machine*

Briefly answer the following questions, in writing, and come to class prepared to discuss them:

1.  How does Silver define and characterize a *heuristic*? 
2.  Silver discusses the three parts to a game of chess: the opening, the midgame, and the endgame. How does he characterize them? How are they handled by humans? How are they handled by AI? 
3.  According to Silver, whats the difference between tactics and strategies? How do AI and humans fare at tactical and strategic playing? 
4.  What, *exactly*, was the problem that Deep Blue was attempting to solve? Put another way, what was the overall goal of the Deep Blue research project? 


## The Main Event - Reading

We now turn to one of our disciplines earliest visionaries, [Claude Shannon](https://en.wikipedia.org/wiki/Claude_Shannon). His 1949/1950 paper on Chess programs lays out the exact foundation and framework for Deep Blue. To start:

*   Read Shannon's Paper on AI for Chess, but feel free to *skim* section 5.

### The Response 

Now respond to the following. Write down your responses and come to class prepared to discuss them. 

1. Shannon presents the idea of an *evaluation function* *f(p)*, describe it in your own words. Do we, or can we, have a complete, usable, definition for the evaluation function for chess? Why or why not? 
2. Given the evaluation function for chess, Shannon describes *two* algorithms for playing **perfect** chess. Describe them in or own words and/or in pseudo-code. 
3. How does Shannon define *strategy*? What is a *pure strategy*? What is a *mixed strategy*? Why type of strategy does Shannon seem to think makes for a better chess agent? Why?
4. In section 3, Shannon describes an approximate evaluation function. Compare and contrast this evaluation function with the evaluation function of section 1. 
5. In general, what does *quiescent* mean? What type of game state would Shannon call a quiescent state? 
5. In section 4, Shannon presents his *Type A Strategy* algorithm. Describe it in your own words and/or in pseudo-code. What are the strength and weaknesses of a Type A strategy? 
6. In section 6, Shannon discusses two more functions *g(P)* and *h(P,M)*. In your own words, describe them and their purpose. 
7. Describe, in your own words and/or pseudo-code, how to use *g(P)* and *h(P,M)* to improve upon the weaknesses of the basic Type A strategy algorithm. 
