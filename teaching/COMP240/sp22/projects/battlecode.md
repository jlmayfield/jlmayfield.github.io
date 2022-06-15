---
layout: page
title: COMP240 - Battlecode 2022
permalink: /teaching/COMP240/sp22/projects/battlecode/
---

For our first project we'll be taking a crack at [Battlecode](https://battlecode.org/), specifically the [2022 Variation](https://play.battlecode.org/home). Battlecode is an annual programming tournament hosted by MIT. Teams program software bots to compete 1-on-1 against other teams. Each year a new game is developed. We'll be doing our own little tournament locally.


## Getting Started

To get going you'll need to setup a working development environment and a GitHub repository through which your team can collaborate

0. **Development Environment:** One of the trickiest parts of doing a BattleCode project can be getting the development environment setup. The code is done in Java and requires the much aged Java 8.  Follow along with the [gettting started](https://play.battlecode.org/getting-started) instructions on the BattleCode site and have patience with yourself as you get moving. Find your classmates that are running the same OS as you and work through bugs with them. When it comes time to setup your Battlecode repository, you should go ahead and fork the class repo sent via email rather than use the scaffold linked in the getting started guide.
1. **Team Repo:**  Once everyone on your team has a working development environment, *pick one team member's fork of the class repo to act as the team repo* and *invite the remaining team members as collaborators with at least Write level access*.

At this point everyone on the team should be able to make local copies of the team repo and you're ready to start developing your bot.

## Projecting with Battlecode

The key to your success and continued sanity is to make small, incremental changes. In the context of this game, that means starting with the given example bot and repeating the following process:

1. Create a new bot that is based on an existing bot but includes some changes or improvements.
2. Play your new bot against one or more old bots in order to test your design.
3. Based on your tests, identify a new change or improvement to make. Go back to step 1.

You really cannot think too small with each successive change. Have a vision for how that change will help your team win, but don't worry if each individual change is just a tiny step towards that goal.

### MIT Battlecode 2022 Lecture Videos

At MIT, Battlecode is run as course. It begins with a series of lectures designed for people new to Battlecode but with some prior programming experience.  In short, you! The lectures are posted on YouTube. You are encouraged to check them out and at least use them as resource. If you follow all of these lectures, you'll end up incrementally developing a pretty solid, all around bot. You can also cherry pick parts as desired.

[Intro: 2022 Game Overview](https://youtu.be/lJ6ScXxWoxI?t=925)<br>
[Lecture 2: Setup Help](https://youtu.be/mV49N2h9vQo?t=372)<br>
[Lecture 2: Intro to Java](https://youtu.be/mV49N2h9vQo?t=1504)<br>
[Lecture 2: Getting Started with Bots](https://youtu.be/mV49N2h9vQo?t=4003)<br>
[**Lecture 3: More Bot Work**](https://youtu.be/2HieGUMXNn8?t=361)<br>
[Lecture 4: Path Finding](https://youtu.be/skIEPSSEaQE?t=387)<br>
[Lecture 5: Paths & Obstacle Avoidance (Bug Algorithm)](https://youtu.be/_om92yU6Ozk?t=325)<br>
[Lecture 6: Communication](https://youtu.be/iOwvQjVZThk?t=536)<br>
[Lecture 7: Advanced Pathing & Communication](https://youtu.be/lZ033P-jsgE?t=357)<br>
[Lecture 8: Advanced Topics](https://youtu.be/h9fgwLUMaj8?t=300)<br>

# Project Deadlines

Below is the calendar for daily goals and activities as well as important due dates. Checkpoint requirements can be found after the calendar.

| Date | | Goal or Task |
| :-----: | :------: | :---: |
| 1/20 | | Form teams. Setup communications plan. Setup team repo. <br> Explore game rules. Look at Code. Set Goals for Checkpoint 1|
| 1/25 | | Group time in class. |
| 1/26 | | **Submit a PR for Checkpoint 1** |
| 1/27 | | **Checkpoint Presentation 1** |
| 2/3  | | **Checkpoint Presentation 2**
| 2/10  | | **Final Checkpoint** |


### Checkpoint & Presentation 1

For your first checkpoint you must present one or more new bots. These bots should represent incremental changes to the example bot. They need not do anything earth shattering but should do something new or different. Your team has a couple options for how to proceed: work together to implement one or more bots or work individually on bots. *You should seriously consider following along with and implementing one or more changes discussed in the MIT lectures.* Regardless of how you choose to work, you must work towards and demonstrate shared knowledge and understanding of your changes. *This means planning for and taking the time to discuss changes such that every team member has a working knowledge of all the changes.*

Presentation day (1/27) will proceed as follows:
1. A small tournament between the example bot and your checkpoint 1 bots.
2. Group Presentations consisting of: ( a ) *What's New & Why:* A brief, non-technical presentation of the bot and your goal for the bot, ( b ) *How You Did It* A short technical presentation of key code changes, ( c ) *Team Practices* A break down of how your team functioned, what went well, and what improvements you might make to your team collaborative practices, and ( d ) *What's next* What do you have in mind for your next checkpoint?

Group presentations should consist of a short slide presentation. Every member of the group must talk.

### Checkpoint & Presentation 2

The second checkpoint basically mirrors the first.  Your team should present one or more new bots and give the same style of presentation described above.

### Final Presentation

For the last presentation you should present a single, final bot. The presentation will also be a bit more all encompassing as it should reflect back on the sum total of your team's work and not just the work completed since the last checkpoint. Here's what you need to talk about
1. *Overall bot Strategy* At a high-level, what is your bot trying to do? What strategies and tactics did you set out to implement?
2. *Technical Presentation* Highlight parts of the code that are critical to implementing your overall strategy and core tactics and discuss how they do what they do.
3. *Team Practices* Discuss how your team worked together as well as how and why your practices may have evolved from the start of the project. This discussion should include team strengths and team weaknesses, neither of these should be pinned to a specific team member.
4. *Next Time* You'll have a new team on your next project. Discuss what practices you plan to bring to that team and what kinds of pitfalls you might have encountered on this project that you'll do your best to steer the next team away from.
