---
layout: page
title: COMP240 - Conway's Game of Life in the Browser
permalink: /teaching/COMP240/sp22/projects/webgol/
---

# Due Dates

| Date | What's Due |
| :---: | :---: |
| 4/19 | Stage 0 |
| 4/26 | Checkpoint 1 |
| 5/3  | Checkpoint 2 |
| 5/7 (3pm) | Final Checkpoint |

# The Goal

Your goal is to implement a web-based version of [Conway's Game of Life](https://playgameoflife.com/) utilizing a Model, View, Controller design with vanilla HTML5, CSS, and Javascript.  Your group can and should get creative with the project, but the end result must have the following features:

1. Users click a button to start and stop the game.
2. There is a button that lets users carry out a a single evolution of the population.
3. When the game is stopped, users can click on cells to activate or deactivate them.
4. The age of the cell population should be displayed. The age is the number of evolutions that have occurred since the start of the game or since the last human intervention. This means that initially the age is 0 and it gets reset to zero if the user clicks on a cell. Otherwise, it goes up by one every time the population of cells evolves.
5. There is some kind of interesting, default set of cells active when the game first loads. Interesting can mean whatever you want it to mean.

You can and should go above and beyond the five features listed above. Some optional features you might consider are:
* A button to create a random population.
* The ability to place predefined shapes like gliders.
* The ability to scroll and zoom.

## Web-Development Environment

Our game is a simple app that does not require a *back end*. That means that the web server sends HTML+CSS+JS to the browser and the browser takes over from there. No communication with the server is required from there. An application with a back end typically involves a database or some kind of back and forth communication between the browser and the server. For example, if we wanted a chat feature or user accounts, then we'd need to store chat logs and user information in a database on the server. That information could then be requested as needed by application.

The lack of back end databases and servers makes our development environment pretty straight forward. We need at *text editor* to write and edit our HTML, CSS, and Javascript code. We need the ability to run a *small web server* on our local machine in order to serve up our pages. Finally, we need the ability to run and debug our site.  At this point you have all these things on your computer already.

1. Text-Editor (Atom, Sublime Text, Notepad++, VS Code, etc. )
2. Local Server - Python can launch simple http servers - `python3 -m http.server`
3. Running and Debugging Environment - aka A Web-Browser - (Chrome + Debugger (`ctrl-shift-j`))

When working on your project you'll work out the code in your editor, fire up a simply python web server in your site's root directory, then visit the site using your browser. While on the site you can run the debugger to view printed log output or check on Javascript errors in the browser.

## Web-Development Resources

Every project needs a go-to source for reliable references, guides, and tutorials. The **Mozilla Developer Network** or (MDN) is a good choice when it comes to web-development. They have excellent [guides](https://developer.mozilla.org/en-US/docs/Learn) and [tutorials](https://developer.mozilla.org/en-US/docs/Web/Tutorials). For this project we're particularly interested in HTML, CSS, Javascript, and how they work together on web applications.

Rather than look at web applications broadly, we'll want to start with a game-like application that uses many of the same features needed by our application. MDN has just such a [2D Game Development Tutorial](https://developer.mozilla.org/en-US/docs/Games/Tutorials/2D_Breakout_game_pure_JavaScript). It provides a wonderful starting point for the project in terms of HTML,CSS, and Javascript basics for games and game-like applications. We'll look at the MDN tutorial code as a class.

While the MDN code exposes us to the basic HTML/CSS/Javascript functionality we need, it's note organized and structured in the way we want, namely the *Model-View-Controller* architecture.  Good news! Your instructor has [refactored](https://en.wikipedia.org/wiki/Code_refactoring) the MDN code
using an MVC pattern.  That code can be found [at this repository](https://github.com/jlmayfield/brickbreakmvc). We'll be looking at this as a class as well.


## Projecting and Versioning with Agile Development Practices

This project is a choose your own adventure project. Rather than tick off pre-determined stages versions, you'll work as a group to identify your own stages and versions, divy out that work to the group members, and present that progress to the class.

The process we'll adopt comes from *agile software development*. Your team will identify a set of *program features* that you can complete in *one week*. This time increment is called a **sprint**. The goal of working in short sprints is not only to make incremental progress on your code but to refine your team's ability to identify an appropriate set of features for your sprints. In the end, its not the time that determines the features but the team's effectiveness.

Sprints proceed as follows:

1. Decide on a set of features for the current sprint.
2. Estimate time needed per feature. Distribute the feature set across the team.
3. At the end of the sprint, evaluate the features completed and the quality of your estimates. Use that evaluate to refine your feature set and estimates for the next sprint.

Clearly, feature sets are at the heart of a sprint. Good features should have two key characteristics:

1. *They Are Very Specific*: What exactly are you adding to the project? How will you test it as you progress? How will you demonstrate that it's complete?
2. *They are Small*: Are your features small and incremental? Are you building a sprint from lots of little features or just a few larger features? Lots of little features are better in the long run.

Remember, a huge part of the process is about getting better at identifying features, estimating the time needed to implement features, and organizing sprints. Refining these skills is as important development as raw, technical programming skills.

### Sprint Checkpoints

Like previous project presentations, you'll need to present project progress as well as your progress developing effective team-programming practices.  We can now frame this in terms of sprints and features. Checkpoint presentations should cover the following 5 items:

1. What was your target feature set for the current sprint?
2. How did the team plan to tackle the feature set? How did that plan contributed to shared-ownership of the project?
3. What features actually got done?
4. Evaluate your goal setting. What worked for this sprint? What didn't work? If your estimates fell short, why? If your estimates were too long, why?
5. What's your plan for the next sprint and how is it informed by lessons learned by previous sprints.

The real goal for your presentation should be to get constructive feedback on your feature sets and team-programming practices. If you got more done than you thought, then your estimation of the difficulty of your features was overly conservative. If you didn't get all your features done, then you're being overly optimistic. The goal is to understand what you're currently capable of and construct a feature set for your sprint that is realistically within reach.

### Getting Started: Stage 0

Like any iterative process, we need to initialize our sprint-based development cycle. This means getting your group repo setup on github and kick-starting the project with some kind of simple hello world like application. It doesn't need to have the full MVC structure to start, but should have the main html landing page and ideally includes a bit of CSS and Javascript. In short, you want a basic web-app that you can begin to refine. The goal of this initial site is to prove that you each have a working local development environment and that you're each able pull down your site from the group repository.

Once you have a shared repository setup and every team member has a working development environment it's time to start working sprints. Come up with a idea for getting started, a set of initial features, and get at it.  From there you can refine your program and your ability to identify feature sets that are appropriate for week-long sprints. Do not shy away from being extra-conservative as you're working you way through new languages and tools. Start small and accelerate progress once you have your footing.

### Stages 1 to n

After your initial stage 0 checkpoint, you're in full-on sprint mode and presentations should conform to the sprint checkpoint items listed above. Use checkpoints as a way to get advice and feedback on your target feature set for your next checkpoint. Throughout the whole project, you should be just as concerned with getting better at designing good sprints as you are with designing better programs.
