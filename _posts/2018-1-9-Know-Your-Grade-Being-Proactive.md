---
layout: post
title: Know Your Grade&#58; Being Proactive
description: Setting goals and predicting the future of your grade
date: 2018-01-09
categories: [Know Your Grade]
mathjax: true
---


In my [previous post](/blog/2018/01/Know-Your-Grade-Single-Maths.md) we worked up some formulas that prove useful for computing your grade on an assignment by assignment basis. In this post we'll look at how to use these weighted average calculations to set goals, think ahead, and be more proactive about your course grade.

### Be Proactive

If the question you're trying to answer is, "What's my grade?" then you're really just reacting to the past. You want to know what effect your past assignments have had on your grade. Too often I get this question following difficult assignments or when a student doesn't do so well on something. The student wants to know where they stand as a reaction to work they've already done.  They are uncertain about the state of their grade and worried. All of that uncertainty is probably not good for your mental health and, as we'll see, unnecessary.

The better question to be asking is, "What's my grade *going to be if ...*?" "What if my next exam is a letter grade higher or lower than my previous exam?" "What if I simply opt out of the next assignment, what impact will the zero have?"  You should be thinking one or more assignments ahead because that's where your time spent has a real impact on your grade. When you reframe the, "What's my grade?" question in terms of what comes next, then you're being proactive, not reactive. You're letting yourself know what impact the work you're doing right now will have on your grade.

###  What's My Grade If ...

The semester is underway. You've completed a few assignments and know that your current grade is an 87%.  You also know that the total weight of all the completed assignments is 35%<sup>1</sup>. You were just assigned a paper that's worth 10% of your final grade. You're hoping to pull your grade up by getting a solid 95% on that paper.  What you'd like to know is what your grade will be if you get that A.

You can answer this question with essentially the same tools you already have in your tool box.  First let's figure out the percentage points towards your final grade that you've earned so far and that an A on your paper would net you.  Remember, this is just weight multiplied by score.

$$
\begin{array}{ll}
0.35*0.87 = 0.3045 \\
0.10*0.95 = 0.095 \\
\end{array}
$$.

If you add the 30.45 points earned so far to the 9.5 points earned by the paper you have the points earned towards your final grade, 39.95. Because you're interested in your grade right now, we need to divide that sum by the 45 total percentage points covered by the previous work combined with the paper.

$$
\frac{0.3045 + 0.095}{0.45} \approx 0.8878
$$.

With a bit of rounding, that A paper gets you just shy of a 2 percentage point bump in your current grade, bringing you to an 88.78%.

Maybe you were expecting more? Maybe you had no expectations? I'll dedicate future posts to analysis that should hopefully leave you with a much better intuition for these kinds of situations. For now, let's reorganize this calculation a bit so that we can more closely study how one assignment will move your grade up or down.


### Accounting For One Assignment

Let's pull a formula out of what we just did. We have two weights: the weight accounted for by your current grade, $$w_0$$, and the weight of the next assignment, $$w_1$$.  On the grade side of things we have your current grade, $$g_0$$, and your assignment grade, $$g_1$$. What we're computing is your new grade, $$g_2$$, and at least implicitly the weight of your new grade, $w_2$. All weights and grades are expressed as a percent. The calculation we just did can be expressed as:    

$$
g_2 = \frac{w_0g_0 + w_1g_1}{w_0+w_1}
$$

Let's do some distributing and factoring to reorganize this calculation in order to highlight some important parts of the problem we're studying and hopefully gain a little perspective and insight. What we'd like to do is group weights together and separate them a bit from the grades.

$$
\begin{array}{rcl}
g_2 &=& \frac{w_0g_0 + w_1g_1}{w_0+w_1} \\
&=& \frac{w_0g_0}{w_0+w_1} + \frac{w_1g_1}{w_0+w_1} \\
&=& \frac{w_0}{w_0+w_1}  g_0 + \frac{w_1}{w_0+w_1}  g_1 \\
\end{array}
$$

We now have a formula that isolates the weights of your two grades with respect to your updated current grade, $$g_2$$. The weight your current grade has on your new grade is the quantity $$\frac{w_0}{w_0+w_1}$$ and the upcoming assignment's weight is the quantity $$\frac{w_1}{w_0+w_1}$$.

In general, the two weights seen here will always sum to 1. If it's not clear why from the formula, then notice that the two grades account for 100% of the the work you've done so far split into the work you already did and the next thing you're going to do. What you see is just a simple weighted average of two grades. Your final course grade works exactly the same way, just with many more grades and their accompanying weights.

Now go back to our earlier example. What was the weight of your current grade? It was $$\frac{0.35}{0.45} \approx 0.7778$$. The weight of your paper is then $$\frac{0.1}{0.45} \approx 0.2222$$.  The fact that your previous work carries over 3 times the weight of the paper explains why the paper didn't move your grade up all that much despite being a solid A.

#### Examples

Let's say you're short time and don't think that paper will be your best work.  You'd like to know what happens to your grade if you get something like a 70%.  Don't guess, do the arithmetic and know for sure. Recall that your current grade is an 87%, the weight of your current grade on your post-paper grade is 77.78%, and the weight of your paper on your post-paper grade is the remaining 22.22%.

$$
0.7778*0.87 + 0.2222*0.70 = 0.676686 + 0.15554 = 0.832226
$$.

If you get that C-, then your grade drops a few percentage points but you're still in the B range with about an 83%. The good news is that the 87% you've banked up still carries more weight than the C- you're expecting to get.

What if your paper were worth 35% of your final grade and your current grade only accounted for 10% of your final grade? Now the tables are turned and the weights are flipped. Let's keep the 87% for our current grade and see what happens with that A paper as well as that C- paper.  

$$
\begin{array}{rcl}
0.2222*0.87 + 0.7778*0.95 &=&  0.932224 \\
0.2222*0.87 + 0.7778*0.70 &=&  0.737774 \\
\end{array}
$$.

The C- paper drops you down to a low C where the A paper brings you up to a low A.

Your final grade is destined to be more like the grade with the higher weight. With this in mind, consider that oh so stressful time at the end of the semester.  If that final exam or final paper is 20% of your grade or less, then you're not going to move your final grade by a ton with that one assignment alone. It could be the difference between a C and C+. It isn't going to cause you to fail the class unless you were already close to failing. Perhaps those last assignments don't merit quite the level of stress you're feeling about them?  

One last example before we go. Let's say you completely opt out of that paper. Remember you're sitting on an 87% with a weight of 35 and the paper has a weight of 10. Let's see what a 0 on the paper does to your grade.

$$
0.7778*0.87 + 0.2222*0 = 0.676686  
$$.

After doing nothing for that paper you've dropped from a solid B to a solid D. That's a big shift in your grade. The kinds of smaller shifts we saw earlier happen when you're actually engaged in doing the work and making efforts to do at least passable work.  Notice that even the lowest possible passing grade of a 60%  keeps you in the B- range:

$$
0.7778*0.87 + 0.2222*0.6 = 0.676686  + 0.13332 = 0.810006
$$.  

Doing nothing for an assignment does a lot to your grade. Don't do nothing. Turn in something for every assignment you're given. Worse than the effect doing nothing has on your grade is the fact that you learn nothing from nothing. If you at least attempt the assignment, you have the opportunity to learn. That's why you're in school. You're here to learn, not to get grades. My hope is that  removing the uncertainty from your grade will allow you to focus on the learning.


### Recap

We are going to be working with the formula we came up with in this post for a bit so let's write it out and review the parts just one more time.  

$$
g_2 = \frac{w_0}{w_0+w_1}g_0 + \frac{w_1}{w_0+w_1}g_1
$$

This formula let's you compute what your new grade, $$g_2$$, might be given your current grade, $$g_0$$, the weight of your current grade towards your final grade, $$w_0$$, the expected grade on your next assignment, $$g_1$$, and the weight of that assignment on your final grade, $$w_1$$.  We've written it this way to not only isolate the grades but the relative weights of your current grade and next assignment grade with respect to your new grade, namely $$\frac{w_0}{w_0+w_1}$$ and $$\frac{w_1}{w_0+w_1}$$. In my next post we'll use this formula to help us set targets for our next assignment grade.



[1] If you need help finding these see the [previous](/blog/2018/01/Know-Your-Grade-Single.md) [posts](/blog/2018/01/Know-Your-Grade-Single-Maths.md) in the "Know Your Grade" series.
