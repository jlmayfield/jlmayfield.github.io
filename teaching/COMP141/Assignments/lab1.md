---
layout: page
title: COMP141 - Lab 1 & Homework 1 - Network Investigations
permalink: /teaching/COMP141/Assignments/01_networks_and_routes/
---

# Lab 1 & Homework 1

In this assignment you will:

1. Investigate key details of your network connection using tools on the web and your terminal.
2. Investigate routes from your computer to computers across the globe using tools on the web and the terminal.

Details about the ideas and activities carried out in this lab are discussed in the first set of [lecture notes](https://jlmayfield.github.io/teaching/COMP141/LectureNotes/01_networks_where_am_i/). Refer back to them before turning to the web or AI.

Most of the problems/tasks below have questions that accompany them and/or things to record. *Answers and recorded details should be written or typed and submitted to the instructor*. While not required, this is an excellent time to start learning [Markdown](https://www.markdownguide.org/getting-started/). [https://www.jotbird.com/app](https://www.jotbird.com/app) will let you write and view markdown, then download your document in Markdown or PDF format.  If you go this route for this lab, then submit the markdown.

# Part 1 - Lab - Your Network Connection

The first set of tasks involves exploring your personal network configurations.

1. Use [ifconfig.me](https://ifconfig.me/) to find your IP address. Record it. Compare it to some classmates in lab.  Are there other interesting or surprising bits of information you get from the results? Are you on a public or private network?

2. Use [https://search.arin.net/rdap/](https://search.arin.net/rdap/) and [https://ipgeolocation.io/what-is-my-ip](https://ipgeolocation.io/what-is-my-ip) or  [https://whatismyipaddress.com/](https://whatismyipaddress.com/) to search for your IP. Do the sites offer the same information? Do they disagree on anything? Are there other interesting or surprising bits of information you get from the results?

3. Use your computer's terminal to query ifconfig.me for your IP. Do you get the same thing as the website?

4. Use your terminal to [get the IP](https://jlmayfield.github.io/teaching/COMP141/LectureNotes/01_networks_where_am_i/#finding-your-ip-addresses) assigned to your network interface(s). What's your IP address in this context? Are you on a public or private network? If you're on a private network and had classmates that reported the same IP as you in step (1), then what IP addresses are they getting from this task?  Collect and record 2-3 other IP addresses from classmates.

5. Use your terminal to get the [IP address of your gateway](https://jlmayfield.github.io/teaching/COMP141/LectureNotes/01_networks_where_am_i/#identifying-your-routergateway) router.  Record that IP address. How does it compare to your IP address?

6. Use your terminal to [get your subnet mask and network broadcast address](https://jlmayfield.github.io/teaching/COMP141/LectureNotes/01_networks_where_am_i/#investigating-your-network-address). Record both.

7. Finally, use your terminal to [determine the IP address and, if given, FQDN of your nameserver](https://jlmayfield.github.io/teaching/COMP141/LectureNotes/01_networks_where_am_i/#whos-in-charge-of-resolving-names).  Record it.

# Part 2 - Lab - Domain Names and Web-Resource Investigation

We now turn our attention to the names of the internet and use domain name registration information to investigate a resource and its provider.

8. Our book is at [https://www.linuxcommand.org/tlcl.php](https://www.linuxcommand.org/tlcl.php). What is the top-level domain for this URL? Second-level domain? Are there any sub-domains? If so, what are they?  Is there a path specifier? If so, what is it? Is there a query string? If so, what is it?

9. Use [https://lookup.icann.org/en](https://lookup.icann.org/en) to lookup the second-level domain. What kind of information can you find out about the domain? Anything stand out?  Record the FQDN and/or IP of any provided nameservers.

10. Look up (on ICANN or another site) the second-level domain for the nameserver from the previous step. Record the FQDN for its nameservers. Now record and look up the second-level domain for those nameservers for that domain. Finally, do some general web searching to learn about these organizations. What do they seem to do? Anything else interesting?

11. Use your terminal to [query DNS for the IP address](https://jlmayfield.github.io/teaching/COMP141/LectureNotes/01_networks_where_am_i/#using-dns-at-the-terminal) for your textbook. (*Hint*: Only query the FQDN). Record the IP. Use [*ARIN*](https://search.arin.net/rdap/) and other web tools to look up this IP. What notable things did you learn? Is the name you queried a canonical name? If not, what's the canonical name of the text site?

12. Use your terminal to [query DNS for the nameservers](https://jlmayfield.github.io/teaching/COMP141/LectureNotes/01_networks_where_am_i/#using-dns-at-the-terminal) for the textbook's second-level domain.  How does the result compare to the nameservers reported by ICANN? What's the IP for the authoritative nameserver? Check out that IP address with ARIN  web-based lookups. Does it introduce any new organizations? If so, who are they?

13. Use your domain sleuthing skills to find out some things about the organization attached to the second-level domain of the canonical name of your textbook. Who are they and, in general, what do they do?

# Part 3 - Homework - Routes

1. [Run a traceroute](https://jlmayfield.github.io/teaching/COMP141/LectureNotes/01_networks_where_am_i/#following-data-across-the-web) to your textbook's webserver. It will not complete. How can you tell this is the case?

2. Where (IP/FQDN) does it appear to end? Use [https://ipgeolocation.io/what-is-my-ip](https://ipgeolocation.io/what-is-my-ip) to get location and associated company information. Where on the globe was it when communication stopped?

3. Now, trace forwards or backwards through the trace and see if you can get a rough picture of the path of the route and whose networks handle it. Make a record of that path, noting each network/organization that handles it, and where they appear to be located geographically. You don't necessarily need one record per hop; just focus on the high-level, network logic, not the low-level hop logic. *I recommend recording this as a table.*

4. Fun time.  Check out [http://www.traceroute.org/](http://www.traceroute.org/) and [https://atlas.ripe.net/anchors/map](https://atlas.ripe.net/anchors/map) to find locations across the globe that *should* play nice with traceroute and should return packet to you.  Only use locations/destinations that will return the final packet. Pick 2-3 global locations, do a trace, and investigate the path of your packet as done in the previous task. As a *bonus* (experience bonus, not points), repeat your traces at different times of day. See if routes and RTTs change with the sleeping habits of the globe.

5. Do a basic IP/network investigation (like part 1) from different locations on or off campus and see how your IP/Network changes.  Can you identify distinct sub-networks on campus? Can you map out different routers/gateways in a location?


6. (Optional) Roll-your-own experiment with traceroute.  Use it to investigate some corner of the internet. Draw some conclusions and more importantly, find more curiosities to investigate. Document what you did.