---
layout: page
title: COMP161 - Lecture Notes - Testing & Unit Testing
permalink: /teaching/COMP161/LectureNotes/testing/
---


# On Testing and Unit Testing

Will your code operate as intended?  Is it free of bugs? How can you be confident that your code will work? You test it!  Testing is not a proof of correctness, but it is *evidence* that it should work as intended in situations that mirror your tests. If you can create a robust, wide-ranging set of tests, then you have a strong body of evidence that your code will behave as expected.

Tests are less helpful if you, or someone else, cannot reproduce them, re-run them, and ensure that the behavior of the system doesn't inadvertently change even as the underlying code is changing. They are also not particularly compelling if they are not well documented. "Trust me, bro! I tested it!" is not a strong argument for code correctness. All of this makes manual testing less appealing. Instead, you want *tests as code*. By writing tests as executable code, you can automate the evaluation and re-evaluation of your tests.

## Table of Contents

- [Goals](#goals)
- [Objectives](#objectives)
- [Unit Testing](#unit-testing)
- [Testing Patterns](#testing-patterns)
  - [Core Program Logic](#core-program-logic)
    - [Functional Behavior](#functional-behavior)
    - [Mutation Behaviors](#mutation-behaviors)
    - [Test Fixtures](#test-fixtures)
  - [System-Level Behaviors](#system-level-behaviors)
    - [Exceptions](#exceptions)
      - [`sys.exit(n)`](#sysexitn)
    - [File I/O](#file-io)
    - [Standard/Terminal Output](#standardterminal-output)
    - [Monkeypatching](#monkeypatching)
      - [Return Values](#return-values)
      - [`sys.argv` and CLI arguments](#sysargv-and-cli-arguments)
      - [`input`, `stdin`, and Terminal Input](#input-stdin-and-terminal-input)
      - [Time and `datetime`](#time-and-datetime)
- [Code Coverage](#code-coverage)
- [Glossary](#glossary)

## Goals

1. Begin to take a systemic view of testing for code correctness.
2. Understand the basic ideas of unit testing.
3. Be familiar with patterns for testing key software system behaviors in a repeatable fashion, decoupled from other parts of the system.
4. Know what code coverage is and how it applies to and is used in program testing.

## Objectives

1. Be able to write basic `pytest` unit tests for expressions.
2. Be able to write basic `pytest` unit tests for state-mutation statements.
3. Be able to write basic `pytest` fixtures to facilitate testing returned values and program data.
4. Be able to write basic `pytest` unit tests for exceptions and errors.
5. Be able to write basic `pytest` unit tests that utilize fixtures to test CLI arguments, output to `stdout` and `stderr`, and mock input to `stdin`.
6. Be able to write basic `pytest` unit tests that utilize fixtures to test file I/O using ephemeral files and directories.
7. Be able to write basic `pytest` unit tests that utilize monkeypatch to mock non-deterministic and external system behaviors.

# Unit Testing

**Unit testing** is a testing practice that attempts to test the smallest *units* of the system. Most languages have libraries and packages to support robust unit testing. Python has many, but [`pytest`](https://docs.pytest.org/en/stable/) is probably the standard.

# Testing Patterns

Units come in many shapes and sizes, and systems exhibit a wide variety of behaviors. Thankfully, we can lump a lot of them together.  Thus far you've mostly been asked to write tests about core computational logic: function return values (calculation) or variable mutation effects (memory read/write). It's time to look more holistically at the entire software system. If testing is important, then this means we need to learn to create sound, reproducible tests that interact with systems outside the bounds of your codebase.

## Core Program Logic

You're most familiar with testing the core computational logic of a program. We can more or less reduce this to two kinds of tests.

### Functional Behavior

Given a set of specific arguments, we expect a functional unit to return a certain value.  In a nutshell, you expect a specific **expression**, code that produces a value, to evaluate to a specific value. You're familiar with these kinds of tests.

```python
assert foo(args,...) == expected_value
```

The biggest challenge here is covering a good representative sample of arguments. For this you must know your problem and know your data.

Once your data get complex (nested, large, etc.), `==` can also get tricky. For example, you should never test `==` for `float` data. Instead, you test for [approximate equality](https://docs.pytest.org/en/stable/how-to/assert.html#assertions-about-approximate-equality). As your data becomes structured and nested, you have to make sure that the notion of *equal* you're expecting from your test is equivalent to what `==`, or whatever equality check you're using, is actually checking.

### Mutation Behaviors

Some functions aren't just functional but act as **state mutators**. This means they modify the state of an object rather than, or in addition to, returning an object. What you're really testing here is that a **statement**, code that produces an action, produces the desired side-effect. A great number of the new kinds of tests you'll learn about are tests that statements result in the desired action. When talking about state modifications, these tests should be familiar, but here's a template:

```python
obj = Constructor(args,....)
mutator_foo(obj,....)
assert obj == expected_obj
```

The key difference here is that we're checking that the state of our object has changed after, or as a result of, calling the mutator. All the same challenges as functional testing exist, but now we must also contend with mutation. If we want to run multiple assertions against our object, then best practice is not to reuse the same object from one test to the next. Once again, a fixture, combined with multiple tests, lets you work with a freshly made object without having to duplicate the code and effort needed to create that object.

### Test Fixtures

It can be time-consuming or difficult to construct or otherwise express a value when its type is a complex, possibly nested data structure. To ease the pain of this you can make use of [**test fixtures**](https://docs.pytest.org/en/stable/how-to/fixtures.html).  A test fixture is a defined object used to create contexts that are consistent across tests. This can mean establishing shared data or environments in which **non-deterministic** parts of the system become **deterministic** for the test. For example, you can fix the outcome of a random number generator or a function call that interacts with a system that is, for the purposes of your test, random and unpredictable. Predefined pytest fixtures are an essential part of testing behaviors beyond functional and mutation-based behaviors.


## System-Level Behaviors

Outside of the core, programs interact with the system as a whole. That includes I/O at the terminal, to files, to a network connection, and errors.

### Exceptions

Testing exceptions and error handling is about making sure that your program does what's expected even when something is wrong. Thankfully, unit testing libraries provide a means for catching and checking exceptions and errors before they cause a complete run-time crash. Pytest lets you [test that a specific exception was raised](https://docs.pytest.org/en/stable/how-to/assert.html#assertions-about-expected-exceptions) and also lets you check and test the message of the raised exception.

#### `sys.exit(n)`

If your program invokes `sys.exit()` to terminate the program, this is equivalent to raising a `SystemExit` exception. Testing for and around this equates to testing that the exception is raised.

### File I/O

Testing file I/O can be done by directly checking files. However, we don't typically want files used only for testing to pollute the project workspace and otherwise interact with actual program files.  What we want are **ephemeral** files that only exist within the confines of a run of our test. Pytest has built-in mechanisms for [using temporary directories and files](https://docs.pytest.org/en/stable/how-to/tmp_path.html) within your tests.

The `tmp_path` fixture relies on the Python [`pathlib`](https://docs.python.org/3/library/pathlib.html) library and specifically on the `Path` object. If you need a path `p` as a string, you can use `str(p)` (or `str(p.resolve())` if you need symlinks and relative segments resolved first).

### Standard/Terminal Output

Pytest provides the `capsys` fixture for [capturing and re-purposing standard I/O](https://docs.pytest.org/en/stable/how-to/capture-stdout-stderr.html).  This lets you integrate printed debugging statements into your pytests and also allows you to check for standard-out and standard-err output expected as part of a program.

### Monkeypatching

Often the behavior of a unit depends on some external resource that, for the purposes of testing, you need more control over than you otherwise would have. To get around this you can temporarily patch, or overwrite, the behavior of that resource. This is called **monkeypatching**.  Pytest has robust support for [monkeypatching](https://docs.pytest.org/en/stable/how-to/monkeypatch.html#).

#### Return Values

When you use functions from packages that pull from the web (`requests`) or generally have non-deterministic outcomes (`random`), then you can [monkeypatch the return value of those functions](https://docs.pytest.org/en/stable/how-to/monkeypatch.html#monkeypatching-functions) and create a deterministic event.

You can even [monkeypatch a whole class for returned objects](https://docs.pytest.org/en/stable/how-to/monkeypatch.html#monkeypatching-functions). In this context, we are using monkeypatching to create a **mock** of the function that produces an exact value for the purposes of testing.  If you build mocks that accurately represent that system's behavior, then you can build and maintain long-lasting, reproducible tests even when that system isn't something you can directly control.

#### `sys.argv` and CLI arguments

If you need to test a program that relies on terminal arguments, then you can use monkeypatching to [mock the terminal arguments](https://www.reddit.com/r/cs50/comments/18i6af7/comment/kdh2fn3/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button).  Doing this, you can build full system tests for CLI applications without the need for an actual user.

#### `input`, `stdin`, and Terminal Input

If your program relies on `input` or reading an input stream from `stdin`, then you can [monkeypatch `input`](https://stackoverflow.com/q/73227563/1042494) and `stdin` behaviors. This means you can test how the program reacts to user input without actually requiring a user.

#### Time and `datetime`

You can mock parts of the `datetime` package to make sure that any calls to methods like the datetime class method `datetime.now` return a time of your choosing and not the actual time. Here's a mocked `datetime` class that provides a `now` method. This can be used/modified to mock a call to `now`.

```python
class MockedDatetime:
    @classmethod
    def now(cls, tz=None):
        return datetime.datetime(2020, 9, 1, 12, 30, 15, tzinfo=tz)
```

To mock the `datetime` class, we've copied the parts of the `datetime` interface that are needed for the call `datetime.now()` and replaced them with an object that always returns a date that we've chosen for our tests.

You can use monkeypatch to apply this mock for a module that uses `datetime.now` as follows:
```python
monkeypatch.setattr(module_name, 'datetime', MockedDatetime)
```

# Code Coverage

Are you certain that all the code you wrote has been tested? Test **coverage** is a measure of how much of your code was executed by your tests.  The package [`pytest-cov`](https://pypi.org/project/pytest-cov/) can integrate coverage reports into your tests. It's easy to think that the goal is 100% coverage, but that's not always what you need or want. In general, you should have 100% coverage, or near 100% coverage, of your **critical code paths**, the code that carries out the most important, critical logic of your software.

# Glossary

| Term | Definition |
| :--- | :--- |
| **Coverage** | A measure of how much of your code was executed by your tests, often integrated using packages like `pytest-cov`. |
| **Critical Code Paths** | The code that carries out the most important, critical logic of your software, which should have near or total (100%) test coverage. |
| **Deterministic** | System behaviors or events that produce consistent, predictable, and repeatable outcomes every time under identical test conditions. |
| **Ephemeral** | Existing only within the confines of a test run; used to describe temporary files and directories that do not persist in or pollute the project workspace. |
| **Expression** | Code that evaluates to and produces a specific value. |
| **Mock** | A simulated object or replacement function created during testing to accurately represent an external system's behavior and produce exact, predetermined values. |
| **Monkeypatching** | A testing technique used to temporarily patch or overwrite the runtime behavior or return values of external resources, functions, or classes. |
| **Non-deterministic** | System behaviors or outcomes that are random, unpredictable, or depend on external resources (such as random number generators or web requests). |
| **State Mutators** | Functions or statements that modify the internal state of an object rather than, or in addition to, returning an object. |
| **Statement** | Code that produces an action or side-effect (such as mutating object state) rather than evaluating directly to a value. |
| **Test Fixtures** | Defined objects or helper functions used to create consistent contexts, shared data, or deterministic environments across tests. |
| **Unit Testing** | A testing practice that attempts to test the smallest units of a software system in an isolated and reproducible manner. |


