---
layout: post
title: Know Your Grade&#58; Setting Goals
description: Setting goals for your next assignment.
date: 2018-01-12
categories: [Know Your Grade]
mathjax: true
---


In my [previous post](/blog/2018/01/Know-Your-Grade-Single-Being-Proactive.md) we started using weighted averages determine what your grade will be given some expected grade for your next assignment. More specifically, given your current grade, $$g_0$$, the weight of your current grade towards your final grade, $$w_0$$, the expected grade on your next assignment, $$g_1$$, and the weight of that assignment on your final grade, $$w_1$$, you can compute your new grade, $$g_2$$, as follows:  

$$
g_2 = \frac{w_0}{w_0+w_1}g_0 + \frac{w_1}{w_0+w_1}g_1
$$

In this post we'll look at using this formula as a means of setting a goal for the grade on your next assignment.

### What's It Going To Take

Let's say your current grade is a 81% and the weight of that grade towards your final grade is 25 percentage points. You've got a big paper coming up that's worth 15% of your final grade.  You're hoping that it can move your current grade a fair amount and would like to use it to raise your current grade to an 85%. The question is, "What grade do you need to get on that paper in order to raise your grade from an 81% to 87%?"

Notice that this problem involves information that is accounted for by our grade formula. The catch is that the unknown isn't $$g_2$$, your new grade, but $$g_1$$, the grade of your next assignment. That's no problem really, we can simply plug in what we know and solve for the lone remaining variable, $$g_1$$,

$$
\begin{array}{rcl}
0.85 &=& \frac{0.25}{0.25+0.15}0.81 + \frac{0.15}{0.25+0.15}g_1 \\
0.85 &=& 0.625 * 0.81 + 0.375 g_1 \\
0.85 &=& 0.50625 + 0.375 g_1 \\
0.85 - 0.50625 &=& (0.50625 + 0.375 g_1) - 0.50625 \\
0.34375 &=& 0.375 g_1 \\
0.34375 * \frac{1}{0.375} &=& 0.375  g_1 * \frac{1}{0.375} \\
0.9167 &\approx& g_1
\end{array}
$$.

If you can get around a 92% on that paper, then you'll have your B. Now that you know what you need to get on that paper, you can now plan your time on that paper accordingly.   


### Setting Grade Goals

All that we've done here is turn the question around some. Rather than focus on what your grade will be, we're focusing on what grade you'd like to have and computing the grade you need to get on the next assignment in order to achieve that goal. This is even more proactive then thinking ahead to where you grade will be as you're looking more specifically at the grade you need on the work that is right in front of you.  

Let's go ahead and reformulate our equation for this task. We want to isolate $$g_1$$ and then possibly reorganize the other side of the equation for clarity and insight.  

$$
\begin{array}{rcl}
g_2 &=& \frac{w_0}{w_0+w_1}g_0 + \frac{w_1}{w_0+w_1}g_1 \\
g_2 - \frac{w_0}{w_0+w_1}g_0 &=& \frac{w_1}{w_0+w_1}g_1 \\
\frac{w_0+w_1}{w_1} \left( g_2 - \frac{w_0}{w_0+w_1}g_0 \right) &=& g_1 \\
g_1 &=& \frac{w_0+w_1}{w_1}g_2 - \frac{w_0}{w_1}g_0
\end{array}
$$.  

We now have an equation that let's you compute the grade you'd need to get on your next assignment, $$g_1$$, in order to reach a target course grade, $$g_2$$, given your current grade, $$g_0$$, and all the associated weights, $$w_0$$ and $$w_1$$.

$$ g_1 = \frac{w_0+w_1}{w_1}g_2 - \frac{w_0}{w_1}g_0 $$


#### Examples


Your current grade is a 76% and carries a weight of 45% of your final grade. The next assignment is a big exam worth 15% of your final grade. You'd like to pull your grade up to a B or B-.  What it would take for this exam to pull you up from 76% to 80%?

$$
\begin{array}{rcl}
g_1 &=& \frac{0.45+0.15}{0.15} * 0.8 - \frac{0.45}{0.15} *  0.76 \\
g_1 &=& 4 * 0.8 - 3 * 0.76 \\
g_1 &=& 3.2 - 2.28 \\
g_1 &=& 0.92
\end{array}
$$.  

If you achieve a 92% on your upcoming exam you'll bump your grade to the 80% cutoff needed for a B-. How about a nice solid 85%? What would it take to reach that target? We can reuse some of our previous work and just substitute the 85% for the 80%.

$$
\begin{array}{rcl}
g_1 &=& 4 * 0.85 - 2.28 \\
g_1 &=& 3.2 - 2.28 \\
g_1 &=& 1.12
\end{array}
$$.  

It's going to take a 112% on that exam.  That's going to require some extra credit on top of a stellar academic performance.  More likely than not, you simply cannot get that grade.  Does this mean you cannot get a B in the class? No. It just means you cannot get a B by way of the next exam. In a future post we'll look at using this same kind of analysis to look at and set goals for your grade on a scale that ranges past one assignment. For now, just remember that we're looking at what's right in front of you, the next assignment. In the case of this example, you've learned that if you get at least a 92% on the exam, then you'll be in the B- to B range and out of the C range but that nothing higher than a B is possible at this point.

What if the work you've completed has you sitting at a comfortable 96% and the weight of that work is 65% of your final grade. You have a paper due and it's worth 10% of your grade.  Life is life right now and you're pretty sure you aren't going to be performing up to your usual standard on the paper. You're stressed about your grade because 10% seems like a lot. It's a whole letter grade after all! You don't want to lose that A you've worked so hard for. You figure that if you can keep your grade at or above a 91% then you can either recover later or at least end with an A- and be satisfied. So, how low can you go on this paper and still have that A- when it's all said and done? Let's do the math.

$$
\begin{array}{rcl}
g_1 &=& \frac{0.65+0.1}{0.1} * 0.1 - \frac{0.65}{0.1} * 0.6 \\
g_1 &=& 7.5 * 0.1 - 6.5 * 0.6 \\
g_1 &=& 6.825 - 6.24 \\
g_1 &=& 0.585
\end{array}
$$.  

You need a 58.5% on your paper. You can get a low D- and it will only cause your grade to drop to a 91% for the class. That means any passing grade will keep you in the grade range you want to be in. Breathe a sigh of relief. Don't let the uncertainty about your grade add to your stress. In this case, the hard work you put in to be at a 96% this far into the course out weighs whatever happens on that paper.


### Setting Goals, Managing Expectations, and Reducing Stress

I find the last example above to be the most compelling. It speaks to the main reason that students come to ask me about their grade. They're worried, uncertain, and starting to stress out.  In many cases I tell them what that calculation tells them. Their grade isn't going to instantly tank because of that one bad exam or one bad paper.  This happens at all levels. Sometimes the student needs or wants to pass with a C. Other times they're trying to maintain an A. The goals are different but the stress is the same. You do not need to exist in this state of uncertainty about your grade.  As we saw here, a few quick calculations can tell you what grade you need to achieve in order to maintain the overall grade you're shooting for.

If you know the grade you need to achieve to meet your goals *before* submitting the assignment, then you can plan your time spent on that assignment accordingly. If you're like the student in our example, then you'll learn that all you need to do is get a passing grade on that paper to maintain the grade range you're shooting for. That's a huge load off your back. It lets you effectively forget the grade and just write the paper. You might even do better on the paper knowing that at some level the grade doesn't matter.

If you know the grade you need to achieve to meet your goals *before* getting the graded assignment back, then you will know right away where you sit when you finally do get it back. You'll know if you're on track. You'll know if you're not. If you're not, then you can use the time you would have spent asking your professor, "What's my grade?" asking them, "What should I work on for next time?".  

We even saw that in some cases you'll learn that you simply cannot pull the grade up as much as you would like on the merits of a single assignment. In this case, you're forced to set realistic expectations for yourself because you've learned that it's going to take multiple assignments to get you where you want to be. This requires longer term planning and time management.   

Doing the math on your grade is doing yourself a favor. It removes a great deal of uncertainty from your life as a student and it helps you make and set realistic and achievable goals.  Do the math.
