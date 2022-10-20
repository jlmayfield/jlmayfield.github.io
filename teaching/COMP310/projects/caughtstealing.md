---
layout: page
title: COMP 310 - Project 1 - Caught Stealing - Looking at the history of Stolen Bases in MLB
permalink: /teaching/COMP310/projects/caughtstealing/
---

The field of [sabermetrics](https://en.wikipedia.org/wiki/Sabermetrics) is all about analyzing and studying the game of baseball using statistics. It rose to general popularity throug the movie [Moneyball](https://www.imdb.com/title/tt1210166/). We've been looking at some basic statistics around the catcher's ability to stop the stolen base. Sabermatricians have already looked at the relative importance of stolen bases on the game of baseball.  In a modern context, [the stolen base is seen as too risky](https://batflipsandnerds.com/2018/11/03/analytics-and-its-effects-on-the-mlb-the-stolen-base/). As a result, [it's just not a big part of the modern game](https://athlonsports.com/mlb/whats-stolen-base).  A sabermatrician is, therefore, unlikely to spend much time looking at a catcher's impact on stopping the steal because the steal itself isn't a big part of the game.

For our project we're going to do some simple exploration and visualizations of some of the trends driving the modern take on the stolen base. It's not our goal to really answer any hard questions about the importance, or lack of importance, of the stolen base. We simply want to look back at baseball from **1901 until the 2018** and take note of the correlations the lead the sabermaticans to devalue the steal.

## Statistics of Interest

We're primarily interested in potential relationships between *Home Runs*, *Stolen Bases*, and catchers stopping the stolen base (aka *Caught Stealing*). The relationship between a successful and unsucessful steal and is pretty clear, but we came to this problem by looking at the defensive side of things so we'll include that in our project. The relationship between home runs and stolen bases is a little less clear. It is certainly the case that each home run means one or more fewer chances for someone to steal a base, but is it really the case that stealing is rare between home runs?

In addition to looking at raw counts of home runs and stolen bases, we should take a look at instances when they these events could have happened but did not. For that we need a few other statistics:
  * *Plate Appearances* When someone steps up to home plate. This is the sum of hits (H), walks (BB), intensional walks (IBB), Hit by pitch (HBP), strike outs (SO), sacrifice hits (SH), and sacrifice flys (SF).
  * *On Base Appearances* Running appearances plus the home runs: sum of hits, walks, intentional walks, and hit by pitches.
  * *Base Running Appearances* When someone gets on base and has the chance to steal.  This is the sum of all the non-home run hits (H-HR), walks, intentional walks, and hit by pitches.
  * *Attempted Steals* This is the sum of successful steals (SB) and times caught stealing (CS).

With these additional statistics we can look at a variety of interesting ratios: home runs to plate appearances, steals (successful or unsuccessful) to on base and running appearances, home runs to hits, and steals (successful or unsuccessful) to attempted steals. These ratios let us examine the rate at which our events of interest are occurring and should offer some insight as to the relative frequency, and perhaps importance, of the steal over the long history of baseball.

## Visualizations

Our primary medium exploring trends in home runs and stolen bases will be data visualizations.  Taking data from 1901 on, we might start by charting the following:

   1. A line chart showing three things: Total Home Runs, Stolen Bases, and Caught Stealing instances for the whole of MLB.
   2. Three stacked bar charts showing Total Home Runs, Stolen Bases, and Caught Stealing instances by leagues.
   3. Three box and whiskers charts showing the distribution of Home Runs, Stolen Bases and Caught Stealing instances by teams.
   4. Three box and whiskers charts showing the distribution of Home Runs, Stolen Bases and Caught Stealing instances by player.
   6. Three tables showing the all time top 20 (or top *N*) players with the most Home Runs, Stolen Bases, and Caught Stealing Instances. We can also do this by [era](https://www.billjamesonline.com/dividing_baseball_history_into_eras/).

From there we can repeat the same pattern of looks at the data but use our secondary statistics and ratios.  In class, we'll look at other potentially enlightening visuals as well.  *We'll decide as a class, and as groups, which visuals we want to pursue and consider going full on into a poster or info graphic of our results*.

## Tools

We'll be using a standard set of of python-based, data science tools for this project.

   * [Pandas](https://pandas.pydata.org/docs/) Table-based structures and your one-stop-shop for data management.
     * Pandas can load query results directly into a DataFrame.  To interface with mysql, you need [sqlalchemy](https://pythontic.com/pandas/serialization/mysql) and the [read_sql](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.read_sql.html) function.
   * [Plotly](https://plotly.com/python/) Web-ready visualizations.
   * If you want a native IDE, use [spyder](https://www.spyder-ide.org/).  If you want web-based notebooks, use [jupyter](https://jupyter.org/).

Most of our data can be computed and collected directly through SQL queries.  You might also explore using some of pandas built in computation and analysis features to process data after the queries.  One thing you'll definitely need to do is get Pandas to properly convert yearIDs (which are strings in our DB), to dates in order to ensure proper ordering in our time-base graphics.
