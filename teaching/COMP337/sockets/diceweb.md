---
layout: page
title: COMP337 - Web Application Assignment - Dice API
permalink: /teaching/COMP337/sockets/diceweb/
---

# Dice Rolling as a Service

For this assignment you'll write a simple web api that allows users to get the result of multiple dice roll via HTTP requests.  All requests are sent as a GET request. There is a single endpoint: */roll*. This endpoint allows three parameters: *n* for the number of dice, *d* for the number of sides per dice, and *m* for the number of times to repeat the roll. The default values are 1, 6, and 1, respectively, such that a single roll of a six sided die is carried out. Here are a few examples:

| Request | Result |
| -- | -- |
| /roll | A single six sided dice |
| /roll?n=2 | Two six sided dice, rolled 1 time. |
| /roll?n=2&m=3 | Two six sided dice, rolled 3 times |
| /roll?m=4&n=3&d=20 | Three twenty sided dice, rolled 4 times |  

## Requests

As the examples above show, users can send some or all of the parameters with their request and are not required to send them in a particular order. Requests must only be made as HTTP GET requests and should include the header *Accept: text/csv* as the server returns the results as comma separated values.  For the courious, there is a complete list of media types at [https://www.iana.org/assignments/media-types/media-types.xhtml](https://www.iana.org/assignments/media-types/media-types.xhtml).  

## Responses

The server returns the results of the roll(s) as comma separated values where each row contains a single instance of a multi-dice roll. For example, rolling four, six-sided die, five times in a row (i.e. n=4,d=5, and m=5) would produce five rows of four numbers between 1 and 6 with each number separated by a comma and each row terminated by a newline. The server will include the header *Content-Type: text/csv* and respond with code 200.

##  Requirements

Write your server using the socket library for networking. Your server should issue an [appropriate response code](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status) for any kind of request other than GET or GETs made with erroneous URLs. Don't go overboard on catching different errors, but you must have at least two: one for bad request types and one for bad GETs. Above and beyond those two is up to you.

Networking must be done with the socket library. You may use any other library you wish for the actual work of the server. You might look at [urllib.parse](https://docs.python.org/3/library/urllib.parse.html#module-urllib.parse) for breaking down the client requests. The built in python [radnom](https://docs.python.org/3/library/random.html) module has everything you'd need for the dice results but you should serious consider [numpy.random](https://docs.scipy.org/doc/numpy-1.14.0/reference/routines.random.html) as it's well suited for generated sets of random numbers and not just one number at a time.  

In addition to writing your server code, you need to produce a simple python script, using the requests module, to test your service. It should run the examples given above as tests cases, have a test for each erroneous [request type](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods), and have some tests for malformed GET requests.
