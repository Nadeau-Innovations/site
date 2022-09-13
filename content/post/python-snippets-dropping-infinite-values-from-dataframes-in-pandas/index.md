---

title: "Python Snippets: Dropping Infinite Values From Dataframes in Pandas"
subtitle: ""
summary: ""
authors: []
tags: [pandas,python,data,dataframe,datascience,ml,ai]
categories: []
date: 2020-09-09T07:24:08-04:00
lastmod: 2020-09-09T07:24:08-04:00
featured: false
draft: false

image:
  caption: ""
  focal_point: ""
  preview_only: false

projects: []
---

Infinite values can occur more often than people expect, especially for calculated data.

For example, in [a recent post]({{< ref "post/evaluating-twitter-with-plumes" >}}) I calculated the Twitter Follower-Friend ratio by dividing the `followers_count` series by the `friends_count` series.
But what happens when `friends_count` is zero?
`Inf`.

In that particular case, I wanted to drop the rows.
Here's how to do it: [^1]

[^1]: https://stackoverflow.com/a/17478495/2533247


```python
import pandas as pd
import numpy as np

# example dataframe
df = pd.DataFrame({"a": [1, 2, 3, 4], "b": [9, 0, 8, 0]})
df["c"] = df["a"] / df["b"]

df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>a</th>
      <th>b</th>
      <th>c</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>9</td>
      <td>0.111111</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>0</td>
      <td>inf</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>8</td>
      <td>0.375000</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>0</td>
      <td>inf</td>
    </tr>
  </tbody>
</table>
</div>




```python
# replace inf with NaN then dropna
df.replace([np.inf, -np.inf], np.nan).dropna(subset=["c"], how="all")
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>a</th>
      <th>b</th>
      <th>c</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>9</td>
      <td>0.111111</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>8</td>
      <td>0.375000</td>
    </tr>
  </tbody>
</table>
</div>



Mind you, this is only helpful if you want to discard rows with `inf` values.
Otherwise, `df.replace()` can be used to "fix" your values to something that makes sense for the application without discarding the row.
