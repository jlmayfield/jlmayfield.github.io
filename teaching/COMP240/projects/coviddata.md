---
layout: page
title: COMP240 - Exploratory Data Analysis and Visualization of Covid-19 Data
permalink: /teaching/COMP240/projects/coviddata/
---

Your second project is one of data science. You'll be using python
libraries to assist in the exploration and visualization of a large data set. The
challenge here is less about developing a large, complex set of code and more
about managing a large, real-world data set. The python tools well help with this,
but you must also develop strategies for testing and developing your analysis
and visualization code with small samples of the data while also organizing
code into a pipeline of discrete parts.

Working with small samples of your data allows for the verification and validation
of your work on data that you yourself can fit in your brain.  This ensures that
the things you do with very large datasets produce valid results. Building
data pipelines lets you check that the data maintains its integrity from beginning
to end.

# Timeline

Here you'll find the calendar of key dates.  Below that is a description of each
stage along with some pointers for carrying out the tasks involved in that stage.

| Due Date |  Stage Checkpoint |
| :--: | :--: |
| 2/17 | Stage 0 |
| 2/24 | Stage 1-2 |
| 3/1  | Stage 2-3 |
| 3/3  | Stage 3-4 |
| 3/17  | Stage 4 |
| 3/24  | Stage 5 |

## The Data

Our main source of data comes from [usafacts.org](https://usafacts.org/visualizations/coronavirus-covid-19-spread-map/). They collect total confirmed covid cases and deaths for every county in the United States and update it daily. Data begins at the start of the pandemic, late March 2020, and is updated daily. With about 3006 counties in the US and nearly two years, or 730 days, worth or case and death reporting we are looking at **several million data points**.

The data is provided in *comma separated values* format spread across three files.
1. [Confirmed Covid Cases](https://static.usafacts.org/public/data/covid-19/covid_confirmed_usafacts.csv) - This file has one row of data for each county in the US. Included in this row are several pieces of key identifying information: County Name, State Name, County FIPS, and State FIPS. FIPS is short for *Federal Information Processing Standard* and are codes that effectively assign unique numerical IDs to states and counties in the US.  After these identifying data are the total confirmed cases reported by date.
2. [Confirmed Covid Deaths](https://static.usafacts.org/public/data/covid-19/covid_deaths_usafacts.csv) - This file has the same format as the confirmed cases file but contains covid-related death totals rather than covid cases.
3. [County Populations](https://static.usafacts.org/public/data/covid-19/covid_county_population_usafacts.csv) - This file contains the population for each of the counties in the previous two files. These population counts are important for doing fair comparisons of the number of cases and deaths between counties as they let us normalize counts to a fixed population size.

## The Grand Goal

Like in all projects, we'll work in small, incremental steps towards some larger goal. What will be different in this project is that each step will itself yield an interesting and important look at our massive data set. They will help us and others to understand what this data has to teach us and will enrich what we see in the end.

Our grand goal is an animated visualization. Each frame of the animation should display the top ten (or top *n*) hot-spot counties for cases and deaths in each state for a given week (or some fixed length of time). The overall animation will let us see hot spots and how they may or may not have changed over the course of this pandemic.

As we work through step goals, we'll take note of how the analysis and visualization for that step goal helps inform what must be done to create our grand goal visualization.

## Project Stages

We now get to the task of breaking this project down into step goals.  I'll be feeding your step goals that
let you work your way into the more involved features of our python libraries and build your way up to what
will be needed for the grand goal. Notice how steps accomplish at least these two things: explore a new way to work with the data and a new way to visualize the data.

### Stage 0

Before we can get to work we need to gather our tools. You need to get Anaconda installed and then use it to install the libraries *pandas*, *plotly*, and the IDE *spyder*.  Any libraries needed to make these things work will be installed by anaconda. Verify your installation by using *spyder* to type and run some example code from the tutorials for *pandas* and *plotly*. In particular, you should work through the [10 minutes to pandas](https://pandas.pydata.org/pandas-docs/stable/user_guide/10min.html) guide.

In addition to getting your Python environment setup, you should get a Github repo going. Once you're in teams, choose someone to start a repo on github, then invite the team as collaborators. Invite the instructor as a read only collaborator while you're at it. For this project you're starting from a clean slate. You'll want to consider setting up a [gitignore](https://github.com/github/gitignore) file. This helps ensure that only your code and necessary files are tracked by the repo.

### Stage 1 - Data Wrangling & Simple Area Plots

While usafacts.org provides the basic data that we'll need, it doesn't give it to us in a shape that is well suited to our task.  We need to wrangle it into shape. *Pandas* is designed with column-based data in mind and the columns are all wrong in our *csv* file. Here's why. Our first visualization will be the daily totals displayed over time for a single county That's date on the x-axis and total cases or deaths on the y-axis.  This is much, much easier if we have all those values in a single column. That's means we need date as a row value, not a column value. Our desired DataFrame should havethe following columns: *date, county name, state name, county FIPS, state FIPS, total cases/deaths*. You think of this as having one row per county per day. While not strictly necessary at this point, this format lets you combine both the death reports and case reports.  In the combined format, a single row gives you both the total deaths and total cases on a given day for a single county. While this format might seem unwieldy, you'll quickly find that it's well suited to *pandas* strengths.

Reshaping a DataFrame is a pretty common task with Pandas. Several functions make it relatively easy. First you often need rethink and reset your index using `reset_index` and `set_index`. In our case, we actually want the index to be a [multi-index](https://pandas.pydata.org/pandas-docs/stable/user_guide/advanced.html) comprised of all four of those identifying columns. Once we've re-indexed the data we can use `stack` to convert columns (the dates) into rows. This process leaves you with a [Series](https://pandas.pydata.org/pandas-docs/stable/user_guide/dsintro.html#series), not a frame. Good thing there is `to_frame` that converts a series to a DataFrame.  Before we convert the Series to a Frame, you can go ahead and name the Series (probably something like *total_cases* or *total_deaths*). This name becomes the column name in the new DataFrame constructed by `to_frame`. You have other ways to rename columns, but naming the series before it becomes a frame column can avoid confusion. Once you have your frame you can use `reset_index` to flatten out the Multi-Index to our desired format. A multi-index makes a lot of sense here, but we can get started without it and just use a good old-fashioned numerically indexed, flat table of data. Before we get to exploring and visualizing the data, it's import to convert all of those date values in the date row into proper [datetime](https://pandas.pydata.org/docs/reference/api/pandas.to_datetime.html) data. Date and times are messy for computers and getting used to Pandas datetime data will help us avoid the numerous pitfalls of properly handling date and time data. Finally, you might need to `rename` a column. All of this is discussed somewhere in [10 Minutes to Pandas](https://pandas.pydata.org/docs/user_guide/10min.html) and if you look-up all the functions I just mentioned in the [API](https://pandas.pydata.org/docs/reference/index.html), then you'll find more examples as well.

Once you've reshaped your data you can get started by selecting all the data for a specific county. Pandas offers incredibly powerful ways to select portions of your frames. They are all discussed [in the guide to indexing](https://pandas.pydata.org/docs/user_guide/indexing.html). Of particular interest to your needs is [Boolean Indexing](https://pandas.pydata.org/docs/user_guide/indexing.html#boolean-indexing). You might also look at selecting a small range of dates for a specific county. A range that you can kind of keep in your head or at least fit on the screen. This small sample can be checked against original data and ensure you're not corrupting the data somehow.

Now that you can select data for a single county, you should go ahead and plot it as an [Area Graph](https://plotly.com/python/filled-area-plots/) using plotly. Take some time to play around with the style of the graph. Make sure axes are labeled. Give it a title. Make it look good.  For whatever county you choose, do both a plot of total cases and total deaths. It might be worth writing a function that lets you specify a county (maybe by fips) and will then produce case and death total graphics for that county. Such a function would let you quickly explore many different counties.

At this point we've established a 4-stage pipeline:
1. Read csv file into DataFrame
2. Wrangle the data DataFrame to the desired shape/format
3. Select all values for desired county resulting in a single county data frame
4. Plot totals of selected data as Area Graph.

It's important that you can run and verify each part of the pipeline independently of the others.  If necessary, *create mock-ups of dataframes that should result from early pipeline stages so that you can work on tasks in the later stages*. This approach lets you maintain independent parts to your code and thereby lets you work incrementally and spread the coding out over a team.

### Stage 2 - Grouping

The next step is to explore [grouping](https://pandas.pydata.org/pandas-docs/stable/user_guide/groupby.html). This feature of pandas lets us quickly and easily group related data and compute new data based on those groupings.  You are to pursue two groupings:

1. **Group by date** By grouping the data by date and adding all the totals we should get the total cases for the whole US.
2. **Group by state** Grouping by the state (FIPS or Name) then date we should get daily totals for each state.

You should definitely make use of small, hand-picked samples of your data to verify that your groupings are specified correctly and working. Use your wrangled data from Stage 1 as the basis for your groupings, then produce area plots for the total cases in the US and total cases for one or more states. If you're feeling adventurous, do multiple states in a single plot using [subplots](https://plotly.com/python/subplots/). The really adventurous might try putting a state and several counties from that state in a single plot, or the whole US and a few states.  Such a plot lets you look at how smaller regions compare to the larger area around them, be it a counties within a state or states within the US.

Your pipeline for this stage is more or less the same as the previous stage:
1. Read csv file into DataFrame
2. Wrangle the data DataFrame to the desired shape/format
3. Select and Group as needed then compute new group totals
4. Plot totals of group(s) as Area Graph.


### Stage 3 - Deriving New Data

It's time to start digging deeper and computing some new data. For stage 3 we'll be computing *new cases per day*. To warm-up, select a single county and then use [`diff`](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.diff.html) on the totals. The number of new cases in a given day is just the total cases reported on that day minus the total from the prior day. That's what `diff` gives us.

We'd really like to have new cases per day for every single county. To get this you can first recreate your multidindex and then compute the diff of the totals. Once this is done, add that new series back to the DataFrame as a new column. You can then reset the index to flatten out your data.

Visualizing new cases per day doesn't make sense as an area plot. It's not cumulative data. A better plot is the [bar chart](https://plotly.com/python/bar-charts/). If you've computed the new case per day for every county in the US, then you can once again use grouping to get new cases for the whole US and for individual states. If you're feeling so inclined, try plotting the new cases/deaths per day along side the total cases using subplots.

We're now expanding our pipeline a bit:
1. Read csv file into DataFrame
2. Wrangle the data DataFrame to the desired shape/format
3. Expand data with daily case/death counts
4. Select target are and/or group data to get daily numbers for plot.
5. Plot daily numbers as bar graph.

At this point you might notice a general pattern to the pipeline: (1) get data (2) wrangle and prep data (3) extract relevant data (4) visualize.

### Stage 4 - Trends and Smoothing

The number of new cases in a single day is subject to variability that is more about when testing is available than it is about the overall spread of the virus. If you want to smooth out this variability and get a better look at the overall trend, then you turn to [windowing operations](https://pandas.pydata.org/pandas-docs/stable/user_guide/window.html) and the 7-day and 14-day average in particular. Once again, this data is good to have for every county. Use the same general strategy you used in stage 3 to get 7 and 14 day averages and add them to your data frame. At this point we can start to combine visuals by adding a [line chart](https://plotly.com/python/line-charts/) of the 7 and/or 14 day average to your bar chart of the daily new case numbers.

With stage 4 complete you should have chosen an *area of interest* that includes multiple counties and be able to produce the following set of graphics:

1. Total Cases for each county in your area of interest, each state involved in your area of interest, and the whole United States.
2. New cases per day with 7 and 14 day average trend lines for each county in your area of interest, each state involved in your area of interest, and the whole United States.

Each of these graphics should have a clear title and a well labeled x and y axis. New case graphics should also have a legend that allows the view to determine what the bars and lines represent. Because these graphics are very similar and differ mostly in the source of data, you are encouraged to write functions to produce the graphic for a given data set, then use that one function to produce the graphics for each part of your area of interest.

### Stage 5 - Cases per 100,000

To compare data from two different counties with different sized populations we must first *normalize* the values.  A simple example of normalization comes from assignment and course grading.  Let's say you have one exam with a total of 50 possible points and another with 70. On the first exam you get 45 points and on the second you get 50.  On which exam did you do better? To determine this we calculate the score as percentage of the total or on a 0 to 1 scale by dividing points earned by possible points.  On the first exam you had a score of 0.9 but on the second you had a score of roughly .714.  The first exam was better despite the fact that fewer points were earned.

The COVID data providies a similar challange.  How should we compare 100 cases in a county of 20,000 people to 200 cases in a population of 200,000?  The answer is to normalize the data by first computing the per-capita rate by dividing cases by population. In general this gives you a small number less than one. This number would take some practice to interpret, and rather than report it directly, we rescale the case count to a standard population size by multiplying the per capita rate by the desired population size. This results in a number that we can interpret as, *"number of cases you'd expect to see in a population of 100000 with the same case rate as our target area"*. The rescaled size used throughout the pandemic is 100,000 people.

We now have a formula for normalizing case and death statistics on a per 100000 people basis. Where $cases$ is the case count (or death count) for a given area (county or state) and $population$ is the population of that area.

$$
\frac{cases}{population}\times100000
$$

Using this formula we can now compare data across state and county lines. By applying it to cumulative totals we can see which area had seen more of an effect from COVID by a given date, relative to their population size. By applying it to daily numbers we can see the same on a day to day basis. You should now:
1. Compute new and total cases per 100,000 for each county in your area of interest. Add this to your data frame.
2. Graph these new stats using [plotly subplots](https://plotly.com/python/subplots/) with shared X and Y axis values. Be sure to put subtitles on each individual plot so that the viewer knows which plot belongs to which county.

### Stage 6 - Maps

*Coming Soon*: Visualizing cases per 100,000 data on a [Choropleth Map](https://plotly.com/python/choropleth-maps/) for state and county totals.

### Stage 7 - Animations

*Coming Later*: Adding [Animations](https://plotly.com/python/animations/) to the maps to show new cases per day, week, or month. 
