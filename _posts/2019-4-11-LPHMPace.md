---
layout: post
title: Pacing and the 55th Lincoln Presidential Half-Marathon
description:
date: 2019-04-11
categories: [Data Science]
mathjax: true
---

I was very happy with my time on my first half-marathon but one goal I didn't quite reach was running [negative splits](https://en.wikipedia.org/wiki/Negative_split), i.e. running the last half of the race faster than the first half. I'm new to racing but everything I've read about pacing strategies says that negative splits are the way to go. My plan going into the race was to start with the 1:55 group then after the 10K mark start trying to catch the 1:50 group. I did OK at this and had the 1:50 pacer in my sights for most of the back half of the race until I hit the hills in the last few miles. As it turns out my average pace for the first 10K (6.1 miles) of the race was about 8:25 minutes per mi and on the last 7 miles I ran an average of about 8:31. That is not a total melt down so I'll take it.

After looking at the [demographics and finish times](https://jlmayfield.github.io/blog/2019/04/LPHM) for the race I wanted to see how the field did with their pacing.  I was particularly interested in seeing how the pacing of the top finishers compared to the rest of the field. If faster means better, then were the better runners running negative splits more often than everyone else?   

### Measuring Pace

The race data set includes both a 10K split time and the final time.  Four people didn't have 10K times (maybe they missed the sensor?) but for everyone else I was able to calculate their average pace on for the first 10K as well as their time and average pace for the last 7 miles.  From here on I'll refer to the first 10K as the front half and the last 7 miles as the back half. To explore questions about negative splits I took the difference between their pace on the back and their pace on the front. I'll refer to this value as the split difference.  

A split differences is measured in minutes. My split difference was about 0.1 minutes which means my pace on the front half was about one tenth of a minute, or 6 seconds, faster than my pace on the back half. Runners with a -1.5 split difference ran a negative split where their back half pace was a minute and half faster than their front half pace. So as you look at the results below remember split differences like 2.25 aren't two minutes and 25 seconds but 2 and a quarter minutes or 2 minutes and 15 seconds.

### Split Differences by Age Groups

Let's start back in with a demographics break down and look at a box plot of the split difference by each age group.

<img src="/images/groupsplitsbox.svg" alt="Age Group Splits"
	title="Age Group Splits" />

The first thing to notice here is that *positive splits were the norm.*  The interquartile range for each age group was positive. A total of *976 runners* ran a positive split. I blame the hills at the end. On the other hand, most of the runners seemed to have kept the back half pace to within a minute of the front half pace. That's not too bad. You're going to run positive splits you'd want your slow down to be as near zero as possible.  An extra minute per mile might be a bit more than you'd like, I think, but I don't know if it qualifies as a complete melt down.  We also see some pretty big outliers in pretty much every age group. Several runners had split differences of of plus or minus three minutes or more.  My guess is that we're seeing people that, by choice or necessity, mixed in some miles of walking. 	


### Split Differences by Final Time and Position

The big question I wanted to explore with this analysis was, "How do the split differences of the faster runners compare to the rest of the field?" To look at this I did a plot of both final time and final position in the race vs split difference. In these plots each point is a runner.  Points are color coded based on their split differences with green being near zero, blue being in the negative, and red in the positive. I also added a line at the zero mark and a least squares linear regression line. Let's look at the time vs split difference plot first.  I find it more telling.

<img src="/images/splitpacedifftime.svg" alt="Splits by Time"
	title="Splits by Time" />

Once again, we can see a lot of positive splits. Recall that the average finishing time was near 2:24, or 144 minutes. It certainly appears that by that point, most of the runners that managed a negative split had finished the race. In fact, 237 of the 352 recorded negative splits finished the race before the average finishing time mark. It definitely seems like the people that really controlled their pace and managed to eek out negative splits were, for the most part, in the front of the pack.  This is not as clear when you look at split differences versus finishing place.

<img src="/images/splitpacediffplace.svg" alt="Splits by Place"
	title="Splits by Place" />

When the finishers are evenly placed we see some evidence of more negative splits in the top half of the placers, but we also see what we saw in the age group box plots, runners of all speeds were running both positive and negative splits. Experienced racers that plan for and achieve negative splits run all kinds of speeds. The presence of light, blue-green dots across the field reflects this fact. Still, in both of the plots we see an overall trend that the tendency to run positive splits increased as you get further into the field.  My guess is that this due to the higher occurrence of people that combined running and walking combined some tendency for the faster runners to be more consistent about pacing and more likely to run a negative split. The data doesn't tell us about the experience or frequency of walking so we can't really say for sure. 
