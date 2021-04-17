---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Tip of the Day: Combining Iterables in Python Through Round Robin"
subtitle: ""
summary: ""
authors: []
tags: ["contestant", "cycle", "iterables", "nexts", "participant", "portion", "python", "robin", "roundrobin"]
categories: []
date: 2020-04-03T07:03:06-04:00
lastmod: 2020-04-03T07:03:06-04:00
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ""
  focal_point: ""
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
aliases:
- /post/python-tips-round-robin
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
