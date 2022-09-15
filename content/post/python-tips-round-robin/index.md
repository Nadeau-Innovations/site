---
aliases:
- /post/python-tips-round-robin
- /post/2020/4/python-tips-round-robin/
authors: []
categories: []
date: "2020-04-03T07:03:06-04:00"
draft: false
featured: false
image:
  caption: ""
  focal_point: ""
  preview_only: false
lastmod: "2020-04-03T07:03:06-04:00"
projects: []
subtitle: ""
summary: ""
tags:
- contestant
- cycle
- iterables
- nexts
- participant
- portion
- python
- robin
- roundrobin
title: 'Tip of the Day: Combining Iterables in Python Through Round Robin'
---

A round-robin tournament is a competition in which each contestant meets all other contestants in turn. In a single round-robin schedule, each participant plays every other participant once.

As a combination algorithm, it takes iterables and selects one item from each in equal portions and in circular order, handling all iterables without priority.

```python
from itertools import cycle, islice


def roundrobin(*iterables):
    """Takes iterables and selects one item from each in equal portions and in circular order.

    https://docs.python.org/3.1/library/itertools.html#recipes

    >>> list(roundrobin("ABC", [1,2,3], (4,5)))
    ['A', 1, 4, 'B', 2, 5, 'C', 3]
    """
    pending = len(iterables)
    nexts = cycle(iter(it).__next__ for it in iterables)
    while pending:
        try:
            for next in nexts:
                yield next()
        except StopIteration:
            pending -= 1
            nexts = cycle(islice(nexts, pending))
```