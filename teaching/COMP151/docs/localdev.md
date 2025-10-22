---
layout: page
title: COMP151 - Setting Up A Local Virtual Environment for Testing
permalink: /teaching/comp151/docs/localdev/
---
# Running Your Development Tools Locally

When you submit your code through Github, several code quality checks are run automatically. Most notably [pytest unit-tests](https://docs.pytest.org/en/stable/) and and the [pylint linter](https://pypi.org/project/pylint/) are run to check your code for correctness and adherence to good style. Eventually, we'll include the [mypy type-checker](https://github.com/python/mypy) in our quality checks as well. You can certainly go through this whole course relying on Github to run these checks, bit it's also possible, and often faster, to run them locally on your laptop.  To do this you'll need to install several key python packages. This, in turn, introduces you to the wild world of potential dependency problems and python virtual environments.

# Packages and Dependencies

Python comes with a lot of batteries included. You certainly can program whatever you want with just the base language you get when you install python, but your life and your projects will be much improved if you make good use of [packages](https://pypi.org/).

A **package** is a collection of python code dedicated to a particular purpose and not included in base python. The [pygame package](https://www.pygame.org/news) provides definitions helpful for building games. The [pandas package](https://pandas.pydata.org/) is an integral part of most python-based data science projects. There are **a lot** of packages out there.

To use a package you must first install them to your system. This really just means put them somewhere where python knows to find them.  It's easy to get this wrong so Python has a tool ready-made for this purpose: [pip](https://pypi.org/project/pip/). Pip can handle the download and the installation. It will also download and install any package that is required by the package you want. Such packages are called **dependencies**.  Your program is dependent on the packages you explicitly make use of and those packages are likely dependent on other packages.

The problem with dependencies is that they are all developed and maintained by different teams of programmers working on different schedules. Here's some potential problems that can arise with dependencies:

* If the package changes, breaks something you're using, and you update the package, then your program could stop working.
* If python changes and the package does not, then your program could break.
* If you develop your project for one version of python or the package and your teammate uses different versions, then you two could see different bugs or behavior out of the program.
* If you deliver a project to users and they're using different versions of dependencies (or python) than you, then your code might not work for them.
* If your dependency has a security flaw, then your program has that security flaw.
* You can be working on multiple projects each of which might require different versions of the same dependency.

You're not guaranteed to run into any of these problems with your dependencies, but if you do not have a plan for managing your project dependencies, then you're relying on hope to keep your project safe from these problems.

# Environments

One standard way of ensuring that a python project is running with specific dependencies, and possibly even a specific version of python, is to create a **[virtual environment](https://docs.python.org/3/library/venv.html)** specifically for that project.  In this context **an environment is made up of python and the packages being used by your code**. By default, you use whatever is installed on your computer. A *virtual environment* let's you specify and control an environment that is separate from that global environment. It is not uncommon for python developers to run every python project/program in its own virtual environment.

Environments are very well supported by base python and [VS Code](https://code.visualstudio.com/docs/python/environments). To create a virtual environment for your project do the following:

1. Hit Ctrl-Shift P (or Cmd-Shift P on Mac) to bring up the command pallet.
2. Enter/Select *Python: Select Interpreter*. Then choose *+ Create Virtual Environment*.
3. Choose the option *Venv Creates a .venv virtual environment in the current workspace*.
4. When prompted select a Python Interpreter (The Global option should be fine. You may only have one option on your system.)
5. If prompted to install dependencies and an option for *requirements.txt* is listed, then choose that option. Otherwise you can just hit *OK* with none selected and handle the dependencies later.

There should now be a folder in your project named .venv. It contains everything python needs for your virtual environment and VS Code will use it whenever it executes your python code. Don't mess with it.

### A Note On Installing Dependencies

Your assignments always come with a file named *requirements.txt*. Go check one out on a past assignment. It's essentially a list of the dependencies that your project requires.  This file is used by Github to build a clean environment for testing.  You can use it to setup more or less the same environment as the one used on Github.  If you selected that file in step 5 above, then this setup has already been done. If you did not select it on step 5, then you can open a terminal in VS code and run the following command:
```
pip install -r requirements.txt
```
This tells the python package manager *pip* to install the packages listed in the file *requirements.txt*. Many, many python projects include a *requirements.txt* file to help developers setup a proper environment for working on that code.

## Loading Your Environment

If you used the steps above, then VS Code should *always* load the environment you created when running code within that project. You'll only need to repeat the setup steps for a new project.  If for some reason you think VS Code did not automatically load your virtual environment, then you can do it manually by running the following command at a terminal.
```
source .venv/bin/activate
```
This command assumes that a virtual environment (the .venv folder) exists in the current directory. It then runs a script named *activate* which loads the virtual environment. If you launch a new VS Code terminal and see something similar to that command at the top of the new terminal, then that's VS Code loading your environment for the terminal session.

# Running Tests

Your environment now includes the packages needed to run tests and run the linter.  This means you can now run the exact commands run on GitHub. All of the following commands are run at the VS Code terminal. Use the *Terminal* menu to launch a new terminal if you need to.

### Tests

To run tests with a coverage report that includes the line numbers for uncovered code, use the following command template:
```
pytest -vv --cov=MODULE1,MODULE2,... --cov-report term-missing TESTFILENAME
```
Here *MODULE1* and *MODULE2* are the names of the modules, or *.py files* that contain the code for which you want a coverage report. List as many files as you need, separated by commas. *TESTFILENAME* is the name of the file containing the tests. Lets say we have tests in `yourtests.py` and the functions you're testing were in `yourmod.py`. Then you'd run the following command

```
pytest -vv --cov=yourmod --cov-report term-missing yourtests.py
```

If you don't need or want to see a coverage report than you can simply do:
```
pytest -vv yourtests.py
```

For even less output on failed tests, run
```
pytest yourtests.py
```

### Linting

For basic linting we use the following:

```
pylint FILETOBELINTED
```

The key here is to lint your code and not necessarily your tests. So, if my code is in a file named `mycode.py`, then I'd run:

```
pylint mycode.py
```

### Type Checks

To run the type checker `mypy`, use the following:

```
mypy --strict FILETOCHECK
```

Again, if your code is in `mycode.py`, then you check that code with,

```
mypy --strict mycode.py
```