---
aliases:
- /post/2021/5/python-tips-how-to-stop-my-pandas-data-table-from-being-truncated-when-printed/
authors: []
categories: []
date: "2021-05-03T18:23:04-04:00"
draft: false
featured: false
image:
  caption: ""
  focal_point: ""
  preview_only: false
lastmod: "2021-05-03T18:23:04-04:00"
projects: []
subtitle: ""
summary: ""
tags:
- python
title: 'Python Tips: How to Stop a Pandas Data Table From Being Truncated When Printed'
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