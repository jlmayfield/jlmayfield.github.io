---
layout: post
title: Know Your Grade&#58; Single Assignments - The Math
description: How one assignment factors into your course grade
date: 2018-01-05
categories: [Know Your Grade]
mathjax: true
---


In my [previous post](/blog/2018/01/Know-Your-Grade-Single) I walked you through some basic analysis that you can do to assess the impact that a single assignment can have on your course grade when the grade is calculated as a weighted average. In this post I'll translate that analysis into mathematical formulas and then we'll do a few more examples. The goal here is to practice working some real world problems down to their more abstract mathematical forms. Later on we'll use the formulas we come up with here to explore other types of grade analysis you might want to do.


### Single Assignment Weight

Recall that the weight of a single assignment is determined by its category weight and the number of assignments in that category. Put another way, we've determined that assignment weight is a function of category weight and the size of the category. We'll use $$ w_c $$ for the category weight and $$ n $$ for the number of assignments in the category, i.e. the category size.  Our dependent value is the assignment weight, which we'll represent with $$ w_a $$. To avoid confusion when dealing with multiple assignment weights we'll focus on assignment weight as a function and not a variable.  The assignment weight function takes two inputs, $$w_c$$ and $$n$$ and produces the quantity, $$\frac{w_c}{n}$$.  We can put this all together with the expression:  

$$w_a(w_c,n) = \frac{w_c}{n}$$  

Now that we have a formula for assignment weight, let's map a few examples to our formula. If you have 7 homework assignments and the weight of homework is 21%, then the weight of a single assignment is,  

$$w_a(.21,7) = \frac{.21}{7} = .03$$,    

or 3%.  If there are 5 exams and exams count as 65% of your grade then the weight of a single exam is,  

$$w_a(.65,5) = \frac{.65}{5} = .13$$,  

or 13%.


### Single Assignment Impact

We saw that given the assignment weight and score, expressed as a percent, we can determine the impact of an assignment in terms of the percentage points towards the course grade that were gained or lost on the assignment.  If we use $$ w $$ for the assignment weight and $$ s $$ for the score, then points gained is the quantity $$ ws $$.  Points lost is just the difference between the maximum, i.e. the weight, and the points gained, namely $$ w - ws $$ or $$ w(1-s) $$ if you prefer. The points gained function $$ g $$ is then expressed as:  

$$ g(w,s) = ws $$  

For the points lost function $$ l $$ we have:   

$$l(w,s) = w(1-s)$$  

While expressing points gained and lost in terms of two variables makes sense, it's worth recognizing that the weight is not something you're typically given.  You get category weights and number of assignments from the syllabus and a score when you complete an assignment. The assignment weight is a computed value. We might want another expression for points gained that's purely in terms of given values and not computed values.  This makes the function $$g$$ a function of three variable, not two:  

$$ g(w_c,n,s) = w_a(w_c,n)s $$  

Finally, we can express points lost in terms of given information as well:  

$$l(w_c,n,s) = w_a(w_c,n)(1-s)$$  

#### Examples

Say your exams are worth 55% of your grade and you have a total of 5 exams.  On the first exam you got an 88%.  You need the value of $$ g(.55,5,.88) $$ to see what the impact of this exam was on your course grade. We have,  

$$
\begin{array}{rcl}
g(.55,5,.88) &=& w_a(.55,5).88 \\
             &=& \frac{.55}{5}.88 \\
             &=& .11(.88) \\
             &=& 0968
\end{array}             
$$.  

You've gained 9.68 percentage points towards your final grade.  Conversely your loss is,  

$$
\begin{array}{rcl}
l(.55,5,.88) &=& w_a(.55,5)(1-.88) \\
&=& .11(.22) \\
&=& .0242
\end{array}
$$,  

or 2.42 percentage points.

### What's my grade?

By formulating things like assignment weight, points gained, and points lost as functions we can easily express things like the calculation of your current course grade without getting the different components mixed up. Say we have two of 6 exams completed with an exam category weight of 45% and scores of 75% and 81% respectively. Your current grade is the points earned over the total points,  

$$
\frac{g(.45,6,.75) + g(.45,6,.81)}{2w_a(.45,6)} =  \frac{.05625+.06075}{.15} = 0.78 $$.  

What if we've complete 2 of 8 homework assignments and 1 of 4 exam with homework being 16% of your total grade and exams being 48% of your grade. Your homework scores were 95% and 90% but your exam was an 85%. Then your current grade is,  

$$\frac{g(.15,8,.95)+g(.15,8,.9)+g(.48,4,.85)}{w_a(.15,8)+w_a(.15,8)+w_a(.48,4)}$$.  

There are other was of organizing the grade computation. Ways that ultimately require less total computation to be done. In a later post we'll unpack and reorganize the formula to support a different kind of analysis. Here our goal is to enable an assignment by assignment approach to the calculation of your grade and we've organized the formulas to reflect that.