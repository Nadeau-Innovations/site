---
# Documentation: https://wowchemy.com/docs/managing-content/

title: "Python Tips: How to Stop a Pandas Data Table From Being Truncated When Printed"
subtitle: ""
summary: ""
authors: []
tags: [python]
categories: []
date: 2021-05-03T18:23:04-04:00
lastmod: 2021-05-03T18:23:04-04:00
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
---

I love `pandas`.
It's one of the most important tools for data processing, but sometimes it can be tricky to remember how to adjust settings on the fly.
Sometimes, I just want to see **all** my data, but `pandas` truncates the view:

```python
import pandas as pd

pd.read_csv('https://raw.githubusercontent.com/mwaskom/seaborn-data/master/iris.csv')
```

```
     sepal_length  ...    species
0             5.1  ...     setosa
1             4.9  ...     setosa
2             4.7  ...     setosa
3             4.6  ...     setosa
4             5.0  ...     setosa
..            ...  ...        ...
145           6.7  ...  virginica
146           6.3  ...  virginica
147           6.5  ...  virginica
148           6.2  ...  virginica
149           5.9  ...  virginica

[150 rows x 5 columns]
```

With a couple extra lines, we can tell `pandas` not to truncate:

```python
pd.set_option('display.max_rows', 999)
pd.set_option('display.max_columns', 999)
pd.set_option('display.width', 999)
```

Where `999` is an arbitrarily large number...
