---
layout: post
title: Know Your Grade&#58; A Worked Example
description: Putting the past few posts together
date: 2018-01-13
categories: [Know Your Grade]
mathjax: true
---


For the [last](/blog/2018/01/Know-Your-Grade-Single.md) [few](/blog/2018/01/Know-Your-Grade-Single-Maths.md) [blog](/blog/2018/01/Know-Your-Grade-Single-Being-Proactive.md) [posts](/blog/2018/01/Know-Your-Grade-Goals.md) I've been working through the ins and outs of computing your own weighted average grade and the calculations you might use to set some goals. In this post we'll put it all together with an example.

### So It's Time for an Exam

The semester is underway. You've completed and gotten back grades for two homework assignments and a short writing assignment. The homeworks both went fine. On the first you got a 95% and on the second you got an 88%. The writing wasn't as good. You got a 73% for that assignment. The first exam is coming up and you're not sure what your grade is but are hoping to get things into the B+/A- range after this exam.  Let's see if that's doable.


#### Your Current Grade

First things first. What's your current grade? Checking the syllabus tells you that homework assignments count for 30% of your grade and that there are 10 total homework assignments throughout the semester. You also see that the short writing assignments also count for 30% of your grade but that there are only 5 of those.  

Let's first compute the total weight of all these assignments using the function $$ w_a $$,  

$$w_a(w_c,n) = \frac{w_c}{n}$$  

where $$w_c$$ and $$n$$ are the category weight and size, respectively. The homeworks both have the same weight of 3% as seen here,  

$$
w_a(0.30,10) = \frac{0.30}{10} = 0.03
$$.

The paper category has the same weight but half the number of assignments so it's not surprising that the weight of that assignment is double that of a single homework assignment,

$$
w_a(0.30,5) = \frac{0.30}{5} = 0.06
$$.

This brings the total weight of your three completed assignments to 12%, half covered by the two homeworks and the other half by the paper.

How many of those 12 percentage points have you earned? Recall that the points gained function was defined as,  

$$g(w_c,n,s) = w_a(w_c,n)s $$  

where $$w_c$$ and $$n$$ are still the category weight and size and $$s$$ is the assignment score. We already know the per assignment weight, so we don't need to recompute that part. Instead we can just multiply the weights by the scores.

$$
\begin{array}{rcl}
g(0.3,10,0.95) &=& 0.03 * 0.95  = 0.0285\\
g(0.3,10,0.88) &=& 0.03 * 0.88  = 0.0264\\
g(0.3,10,0.73) &=& 0.06 * 0.73  = 0.0438
\end{array}
$$.  

You've earned a total of 9.87 of the 12 points possible so far giving you a current grade of 82%.

#### The Exam

You now know that you an 82.25% for the first 12% of the course.  The upcoming exam is the first of 5 exams and exams account for 40% of your grade for the semester. This means the weight of a single exam is 8%.   

A 90% is right in the middle of where you'd like to be in the course so we'll see what exam grade would get you to that target.  We came up with the following formula for this kind of question,

$$ g_1 = \frac{w_0+w_1}{w_1}g_2 - \frac{w_0}{w_1}g_0 $$  

The grades in question are indexed by the order in which you earned them. This makes $$g_0$$ your current grade, $$g_1$$ the exam grade, and $$g_2$$ the grade you'd like in the course after taking the exam. The weights are equivalently indexed. Nothing left to do but arithmetic.

$$
\begin{array}{rcl}
g_1 &=& \frac{0.12+0.08}{0.08} * 0.9 - \frac{0.12}{0.08} * 0.8225 \\
g_1 &=& 2.5 * 0.9 - 1.5 * 0.8225 \\
g_1 &=& 2.25 - 1.23375 \\
g_1 &=& 1.01625
\end{array}
$$.  

You need just short of 102% to bring your grade in the course up to a 90%.  It doesn't look like that A- is in reach just yet.  That probably means the B+ is going to require a pretty solid A as well. Let's go ahead and check. Most of the previous calculation is the same so we'll just adjust for a new target of 88%

$$
\begin{array}{rcl}
g_1 &=&2.5 * 0.88 - 1.23375 \\
g_1 &=& 2.2 - 1.23375 \\
g_1 &=& 0.96625
\end{array}
$$.  

To bring your grade up to an 88% requires a 96% on the exam.  

You're starting to think that a 96% or above might not be doable. On the other hand, you figure you could probably get a B or B+ on the exam.  Let's just see what happens if you get an 87%. For this calculation we'll go back to the weighted average from which we teased out our goal setting formula,  

$$
g_2 = \frac{w_0}{w_0+w_1}g_0 + \frac{w_1}{w_0+w_1}g_1
$$  

All the variables in this formula are the same as before so we can just get to it.

$$
\begin{array}{rcl}
g_2 &=& \frac{0.12}{0.2} * 0.8225 + \frac{0.08}{0.2} * 0.87 \\
g_2 &=& 0.6 * 0.8225 + 0.4 * 0.87 \\
g_2 &=& 0.4935 + 0.348 \\
g_2 &=& 0.8415 \\
\end{array}
$$.  

An 87% on the exam will pull your grade up nearly 2% to 84.15%.  That's progress in the right direction at least.

### Getting There In The End

You took your exam. The results are in and you got an 87% after all. As you already know, your grade is now an 84.15% and 20% of the course is in the books. You've still got your eye on that B+/A- and you're wondering what it will take to get there in the end. Turns out you can answer this question with the mathematical tools you already have in your toolbox. Let's see how.

Pretend that your next assignment accounts for the remaining 80% of your course grade. What do you need to get on that one assignment to get a 90% for the course?  

$$
\begin{array}{rcl}
g_1 &=& \frac{0.2+0.8}{0.8} * .9 - \frac{0.2}{0.8} * 0.8415 \\
g_1 &=& 1.25 * 0.9 - 0.25 * 0.8415 \\
g_1 &=& 1.125 - 0.210375 \\
g_1 &=& 0.914625 \\
\end{array}
$$.  

That single assignment would need to be just over a 91% to get your grade up to a 90% for the semester. That's great, but you have many assignments ahead of you, not just one. Another way of interpreting this result is that *the average score of the remainder of your assignments needs to be just above 91%* in order to finish the semester with a 90%.  

There's nothing that says you cannot use an average for $$g_1$$ in the same way that you use one for $$g_0$$.  It just changes how you interpret the result.  In future posts we'll look at these more longer ranging questions and more ways that you can use weighted average calculations to shed some light on your grades and even you GPA.
