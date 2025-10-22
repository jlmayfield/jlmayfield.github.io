---
layout: page
title: COMP151 - Pytest Basics
permalink: /teaching/comp151/docs/pytest/
---
# Basic Testing with Pytest

The vast majority of the testing we'll do in this class falls into one of two categories:

1. Is the return value of this function equivalent to this
2. Is the current value stored in this variable equal to this

Such tests are very well supported by [pytest](https://docs.pytest.org/en/stable/). Here you'll see a few quick examples that should help you as you get started writing tests.

## Tests vs. `assert`

A pytest *test* is a series of python `assert` statements grouped into a function. The `assert` statement is part of base python. When we write `assert foo`, we're effecting telling python "foo is a statement of fact".  If we're wrong, python will tell us by rasing an error. If we're right, python does nothing. A pytest test will fail if any one of the assertions within that test fail. Our testing practice typically amounts to specifying a collection of assertions that, when all true, tells us our function should work as expected.

### Basic `assert` pattern

When our assertion boils down to "my function actually returns what is expected" or "this variable actually equals what we expect it to", then our assertions follow this patter:

```python
assert ACTUAL == EXPECTED
```

For example, if we wanted to test the `+` or the `*` operator, then we might write the following assertions:
```python
assert 2+2 == 4
assert 2*2 == 4
assert 2*3 == 6
assert 2+3 == 5
```

### Basic test pattern

A test is just a function whose name begins with `test`.  Such functions are discovered and executed by `pytest` when we run tests. We typically test more than one function and should do so in separate tests. So, we need to differentiate their tests by giving them unique names. Absent some good reason not to do so, you should just put `_FUNCTIONNAME` after the `test` as follows:

```python
def test_FUNCTIONNAME():
    #assertions here
```

For example, if the function I want to test is named `foo`, then I'd define my test as follows:

```python
def test_foo():
    ...
```

# Testing with `int` and `str` data

When testing with `int` and `str` data, we can stick to the basic patterns above. The python `==` operator will do a strict comparison equality. Just remember that *strings are case-sensitive*, i.e. "hello" and "Hello" are not the same string.

Here's an example of what a test for a function named `foo` might look like if `foo` takes as an argument one `int` and returns one `int`.

```python
def test_foo():
    assert foo(0) == 1
    assert foo(2) == 4
    assert foo(10) == 1024
```

# Testing with `float` data

Floating point numbers are subject to rounding errors. This makes testing for strict equality problematic as often we get results that are "close enough". For example, maybe you expected 0.0 but your function returned 0.0000000000001.  That's probably OK and you probably want the test to pass. To allow for this `pytest` provides a function named [`approx`](https://docs.pytest.org/en/latest/reference/reference.html#pytest.approx) that we can apply to our expected value to communicate "the actual is an approximate of the expected value".

For example, let's say we expect our function `foo` to return something more or less like 1.0, then we can assert the following:
```python
assert foo(2.45) == pytest.approx(1.0)
```

If you need to use `approx`, then you must `import pytest` in your testing file.