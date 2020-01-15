---
layout: page
title: COMP240 - Tufte's Visualization of MLB Game Data
permalink: /teaching/COMP240/projects/tufteMLB
---

For this project you'll explore the world of data visualization by creating graphics that depict the results of one or more seasons of baseball for a user specified set of teams. 

## The What

[Edward Tufte](https://www.edwardtufte.com/tufte/) is a statistician that is highly regarded for his work on visualization design. In his 2006 book *Beautiful Evidence* he provides and discusses a series of graphics that depict the results of a season of major league baseball. Your task is to create a python module that allows for user-specified collections of these graphics to be created and presented as a poster.

Graphics like the one seen on page 55 of *Beautiful Evidence* display the game data for a fixed set of teams for a single season. We'll refer to them as our data paragraphs. A poster is then acts as a consist data document by combining several related paragraphs along with the appropriate labels, captions, and titles. Your module should allow for the following posters:

* *Tufte's Original Graphic*: A paragraph is a single division for one season and poster displays each division in MLB for a single season. Users should simply provide the year and get back the poster for the season taking place in that year.
* *Team Retrospective*: Here we're concerned with the performance of a single team over time. A paragraph consists of a sequence of years, maybe five to ten. The poster itself then covers a wider range of years.  Users provide a team, a sequential range of years, and possibly a paragraph size. For example, I might like to see history of the Cardinals from 1980 to 2019 with each decade grouped into a single graphic.  
* *Road to the Series*: In this graphic we want to see the season of each of the teams that played in the world series for some sequence of years. Each paragraph consists of the season data for the two teams that played in the world series in a particular year. The poster then consists of this paragraph for each year in the sequence. Users simply provide the range of years in question and the script will do the rest.
* *Generalized Graphic*: We can, more or less, generalize all of the above visualizations by allowing the user to provide an arbitrary set of teams, a sequence of years, and possibly a paragraph size. Paragraphs then consist of the season data, possibly for multiple years, for the given set of teams. For example, I could ask to see the data on the Cardinals and the Cubs from 1980 to 2019 with each paragraph spanning a decade.


## The How


The [Retrosheet game logs data set](https://www.retrosheet.org/gamelogs/index.html) contains game-level data for every baseball game ever played. A cleaned up version of that data can be found on the [Chadwick Bureau Github Site](https://github.com/chadwickbureau/retrosheet) along with a host of other data and tools for the statistical analysis of Baseball. Luckily for you, the retrosheet data has been preloaded into a [MySQL](https://dev.mysql.com/doc/refman/8.0/en/) relational database on the department sever and you'll be given accounts that allow you to access this database from any campus network connection.

You'll be using [Python](https://www.python.org/doc/) to do your programming. I highly recommend the [Spyder IDE](https://www.spyder-ide.org/) as your development environment. The [SQLAlchemy](https://www.sqlalchemy.org/library.html) library lets you interface with the database from within a python script. The data you extract from the database should be stored as [Pandas] dataframes(https://pandas.pydata.org/pandas-docs/stable/). Pandas is a powerful data analysis framework that provides important data structures, algorithms, and visualization tools for python.  Finally, you should make use of the Python Linter [pylint](https://pylint.readthedocs.io/en/latest/) to ensure that you write stylistically sound python code.

Most if not all of the python libraries and software you'll need for this work can be obtained and managed through [Anaconda](https://docs.anaconda.com/anaconda/) and the [conda](https://docs.conda.io/projects/conda/en/latest/user-guide/index.html) package manager.  To avoid dependency problems, you and your group will want to setup and work with [environments](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html) using conda. Your source code will be tracked using the [git](https://git-scm.com/doc) version control system with [GitHub](https://help.github.com/en/github) acting as your project management site and shared repository host.  
