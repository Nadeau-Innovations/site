---
title: "Social Hygiene: Pruning my Twitter Feed with Plumes"
subtitle: ""
summary: ""
authors: []
tags: [twitter,python,cli]
categories: []
date: 2020-09-08
lastmod: 2020-09-08
featured: false
draft: false

image:
  caption: ""
  focal_point: ""
  preview_only: false
---


While scrolling through my Twitter feed recently, I began to get a little annoyed at the amount of content that I was simply not interested in.
In engineering terms, my signal-to-noise ratio was way too low.

This led me to think about my social media hygene and how I don't tend to prune my tweets, people I follow, or topics of interest.

So, over a few days off, I made a tool: [`plumes`](https://github.com/nnadeau/plumes).

I designed `plumes` to be a simple Twitter CLI for day-to-day social media hygiene, allowing me to perform basic pruning operations.
My end goal was to make a cron job that would perform typical operations at a scheduled interval.

In this post, I'll be walking through my pruning process using `plumes` as I try to achieve a more reasonable level of Twitter content quality.
I have two overall goals:

1. Prune my tweets: delete old and low-value tweets
2. Prune my friends: unfollow people based on certain criteria

## Extracting Twitter Data

First, we need data.

The `plumes` CLI makes this pretty straight forward:

```bash
plumes tweets
plumes friends
```

The above commands give me all my tweets and all my friends (i.e., people I follow) as two JSON files, [`EngNadeau-tweets.json`](EngNadeau-tweets.json) and [`EngNadeau-friends.json`](EngNadeau-friends.json), respectively.

## Analyzing and Pruning Tweets

Let's take a look at my tweets.
Using the JSON output from `plumes`, we can load the data and get an idea of my tweeting habits and quality.

### Loading Data

Loading the data is a simple JSON -> DataFrame process:


```python
import json
from pathlib import Path
import pandas as pd

# nicer pandas float formatting
pd.options.display.float_format = "{:g}".format

# load data
path = Path("EngNadeau-tweets.json")
with open(path) as f:
    data = json.load(f)

# convert to pandas dataframe
df = pd.json_normalize(data).pipe(
    lambda x: x.assign(**{"created_at": pd.to_datetime(x["created_at"])})
)

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
      <th>created_at</th>
      <th>id</th>
      <th>id_str</th>
      <th>text</th>
      <th>truncated</th>
      <th>source</th>
      <th>in_reply_to_status_id</th>
      <th>in_reply_to_status_id_str</th>
      <th>in_reply_to_user_id</th>
      <th>in_reply_to_user_id_str</th>
      <th>...</th>
      <th>retweeted_status.quoted_status.place.contained_within</th>
      <th>retweeted_status.quoted_status.place.bounding_box.type</th>
      <th>retweeted_status.quoted_status.place.bounding_box.coordinates</th>
      <th>retweeted_status.quoted_status.entities.media</th>
      <th>retweeted_status.quoted_status.extended_entities.media</th>
      <th>retweeted_status.scopes.followers</th>
      <th>retweeted_status.geo.type</th>
      <th>retweeted_status.geo.coordinates</th>
      <th>retweeted_status.coordinates.type</th>
      <th>retweeted_status.coordinates.coordinates</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2020-08-20 17:50:52+00:00</td>
      <td>1296504993260896258</td>
      <td>1296504993260896258</td>
      <td>Shoutout to @thedungeoncast for their breaks’ ...</td>
      <td>False</td>
      <td>&lt;a href="http://twitter.com/download/iphone" r...</td>
      <td>nan</td>
      <td>None</td>
      <td>nan</td>
      <td>None</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2020-08-18 14:59:41+00:00</td>
      <td>1295737134972903425</td>
      <td>1295737134972903425</td>
      <td>My personal shoutout = eReader + @LibbyApp + @...</td>
      <td>False</td>
      <td>&lt;a href="http://twitter.com/download/iphone" r...</td>
      <td>nan</td>
      <td>None</td>
      <td>nan</td>
      <td>None</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2020-08-18 03:00:46+00:00</td>
      <td>1295556215351717888</td>
      <td>1295556215351717888</td>
      <td>Accidentally published their private keys http...</td>
      <td>False</td>
      <td>&lt;a href="http://twitter.com/download/iphone" r...</td>
      <td>nan</td>
      <td>None</td>
      <td>nan</td>
      <td>None</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2020-08-17 19:52:11+00:00</td>
      <td>1295448359004786694</td>
      <td>1295448359004786694</td>
      <td>This may be one of my favourite #bot features:...</td>
      <td>False</td>
      <td>&lt;a href="https://mobile.twitter.com" rel="nofo...</td>
      <td>1.29545e+18</td>
      <td>1295448001100623875</td>
      <td>8.10231e+07</td>
      <td>81023088</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2020-08-17 19:50:46+00:00</td>
      <td>1295448001100623875</td>
      <td>1295448001100623875</td>
      <td>Pybotics -&amp;gt; https://t.co/4YRC6gqOxf\nsemant...</td>
      <td>False</td>
      <td>&lt;a href="https://mobile.twitter.com" rel="nofo...</td>
      <td>1.29545e+18</td>
      <td>1295447755469594624</td>
      <td>8.10231e+07</td>
      <td>81023088</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1678</th>
      <td>2014-08-19 20:16:49+00:00</td>
      <td>501825129739845632</td>
      <td>501825129739845632</td>
      <td>RT @Brainsight: Organized a few useful Brainsi...</td>
      <td>False</td>
      <td>&lt;a href="http://twitter.com" rel="nofollow"&gt;Tw...</td>
      <td>nan</td>
      <td>None</td>
      <td>nan</td>
      <td>None</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1679</th>
      <td>2014-08-16 22:39:25+00:00</td>
      <td>500773855523504128</td>
      <td>500773855523504128</td>
      <td>Researchers create 1,000-robot swarm\nhttp://t...</td>
      <td>False</td>
      <td>&lt;a href="http://twitter.com/#!/download/ipad" ...</td>
      <td>nan</td>
      <td>None</td>
      <td>nan</td>
      <td>None</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1680</th>
      <td>2014-08-07 04:03:12+00:00</td>
      <td>497231458550177793</td>
      <td>497231458550177793</td>
      <td>Officially got my Quebec junior engineering pe...</td>
      <td>False</td>
      <td>&lt;a href="http://twitter.com/#!/download/ipad" ...</td>
      <td>nan</td>
      <td>None</td>
      <td>nan</td>
      <td>None</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1681</th>
      <td>2014-08-07 02:33:08+00:00</td>
      <td>497208793118552064</td>
      <td>497208793118552064</td>
      <td>@Brainsight @JLMorris91 #brainsight #TMS http:...</td>
      <td>False</td>
      <td>&lt;a href="http://twitter.com/#!/download/ipad" ...</td>
      <td>3.26715e+17</td>
      <td>326715209219702785</td>
      <td>5.04317e+08</td>
      <td>504317349</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1682</th>
      <td>2014-06-20 03:23:49+00:00</td>
      <td>479826930410475521</td>
      <td>479826930410475521</td>
      <td>@CAJMTL &amp;amp; @InterActionPMG, check out Face ...</td>
      <td>False</td>
      <td>&lt;a href="http://twitter.com" rel="nofollow"&gt;Tw...</td>
      <td>nan</td>
      <td>None</td>
      <td>2.55997e+09</td>
      <td>2559970724</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
<p>1683 rows × 339 columns</p>
</div>



### Exploring Data

Wow, I never thought of myself as a "tweeter", but 1600+ tweets is pretty cool.

Moreover, the data is very nicely structured, and the [`pandas.normalize_json()`](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.json_normalize.html) is wonderful at converting the semi-structured JSON data into a flat table.

Let's take a closer look as some statistics:


```python
df[["retweet_count", "favorite_count"]].describe()
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
      <th>retweet_count</th>
      <th>favorite_count</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>1683</td>
      <td>1683</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>177.448</td>
      <td>0.75817</td>
    </tr>
    <tr>
      <th>std</th>
      <td>5146.03</td>
      <td>1.75906</td>
    </tr>
    <tr>
      <th>min</th>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>max</th>
      <td>209899</td>
      <td>21</td>
    </tr>
  </tbody>
</table>
</div>



Hmmmm, I don't remember ever going viral and getting 200k+ retweets. 

Per the [Twitter API docs](https://developer.twitter.com/en/docs/twitter-api/v1/data-dictionary/overview/tweet-object), the `retweet_count` key of a Tweet object counts the source tweet's retweets, not just my personal retweets.

Let's filter out retweets to get just my personal tweets.
Since we're beginning to chain conditions, filters, transforms, etc. on our dataframe, I'll begin using [`pipes`](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.pipe.html) to keep the code clean and efficient.
(Note: I LOVE pipes).


```python
(
    df.pipe(lambda x: x[~x["retweeted"]])
    .pipe(lambda x: x[["retweet_count", "favorite_count"]])
    .describe(percentiles=[0.5, 0.9, 0.95, 0.99])
)
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
      <th>retweet_count</th>
      <th>favorite_count</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>1376</td>
      <td>1376</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>0.205669</td>
      <td>0.919331</td>
    </tr>
    <tr>
      <th>std</th>
      <td>0.732019</td>
      <td>1.89699</td>
    </tr>
    <tr>
      <th>min</th>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>90%</th>
      <td>1</td>
      <td>2</td>
    </tr>
    <tr>
      <th>95%</th>
      <td>1</td>
      <td>4</td>
    </tr>
    <tr>
      <th>99%</th>
      <td>4</td>
      <td>9</td>
    </tr>
    <tr>
      <th>max</th>
      <td>11</td>
      <td>21</td>
    </tr>
  </tbody>
</table>
</div>



Aha! That's more like it.

So I have around 1.3k personal tweets and I definitely never went viral.

### Tweets vs. Time

I wonder what this looks like over time?


```python
from matplotlib import pyplot as plt
import matplotlib as mpl

mpl.rcParams["axes.spines.right"] = False
mpl.rcParams["axes.spines.top"] = False

figsize=(10, 4)

fig, ax = plt.subplots(figsize=figsize)

(
    df.pipe(lambda x: x[~x["retweeted"]])
    .set_index("created_at")
    .resample("2Q")
    .count()
    .pipe(lambda x: x.set_index(x.index.date))
    .pipe(lambda x: x["id"])
    .plot.bar(ax=ax, rot=30)
)

fig.suptitle("Tweets Over Time")
ax.set_xlabel("Quarter")
ax.set_ylabel("Number of Tweets")
fig.tight_layout()
```


    
![png](index_files/index_10_0.png)
    


It appears that I tend to be cyclical with my tweets.
Here are some highlights I can think of:

- 2015-2016: Attended medical conferences and was tweeting to promote my company.
- 2017-2018: Attended robotics conferences and was tweeting to promote my research.
- 2019: Writing my PhD thesis and forgot about the rest of the world.

### Interactions vs. Time


```python
fig, ax = plt.subplots(figsize=figsize)

(
    df.pipe(lambda x: x[~x["retweeted"]])
    .set_index("created_at")
    .resample("2Q")
    .sum()
    .pipe(lambda x: x.set_index(x.index.date))
    .pipe(lambda x: x[["retweet_count", "favorite_count"]])
    .plot.bar(ax=ax, rot=30)
)

fig.suptitle("Interactions Over Time")
ax.set_xlabel("Quarter")
ax.set_ylabel("Number of Interactions")
ax.legend()
fig.tight_layout()
```


    
![png](index_files/index_12_0.png)
    


As expected, the number of interactions generally follows my tweeting frequency.
The more you give, the more you get.

But, I did have a stellar quarter in 2017.

### Pruning Tweets

With goal #1 in mind, let's use `plumes` to prune (i.e., delete) old tweets that aren't worth keeping around.
Judging from the previous data and plots (e.g., 99% percentile above), I'd be OK with deleting tweets that:

- Are older than 60 days
- Have less than 9 likes
- Have less than 4 retweets
- Are not self-liked by me

The command (and future cron job) will look like this:

```bash
# add --prune to switch from dry-run to deleting
plumes audit_tweets EngNadeau-tweets.json --min_likes 9 --min_likes 4 --days 60 --self_favorited False
```

This results in 1325 identified tweets that will be deleted.
Goodbye :)

## Analyzing and Pruning Friends

Next, let's take a look at my friends (i.e., people I follow).
Similar to the tweet analysis and pruning process, we'll be using the `plumes` JSON output to get an idea of my following quality.

### Loading Data

Like before, we will simply load the JSON data and convert to a DataFrame.


```python
# load data
path = Path("EngNadeau-friends.json")
with open(path) as f:
    data = json.load(f)

# convert data to pandas dataframe
df = pd.json_normalize(data).pipe(
    lambda x: x.assign(**{"created_at": pd.to_datetime(x["created_at"])})
)

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
      <th>id</th>
      <th>id_str</th>
      <th>name</th>
      <th>screen_name</th>
      <th>location</th>
      <th>description</th>
      <th>url</th>
      <th>protected</th>
      <th>followers_count</th>
      <th>friends_count</th>
      <th>...</th>
      <th>status.retweeted_status.place.id</th>
      <th>status.retweeted_status.place.url</th>
      <th>status.retweeted_status.place.place_type</th>
      <th>status.retweeted_status.place.name</th>
      <th>status.retweeted_status.place.full_name</th>
      <th>status.retweeted_status.place.country_code</th>
      <th>status.retweeted_status.place.country</th>
      <th>status.retweeted_status.place.contained_within</th>
      <th>status.retweeted_status.place.bounding_box.type</th>
      <th>status.retweeted_status.place.bounding_box.coordinates</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>86315276</td>
      <td>86315276</td>
      <td>Will Strafach</td>
      <td>chronic</td>
      <td>San Francisco, CA</td>
      <td>building great things. breaking others. | foun...</td>
      <td>https://t.co/7qRzHeZcxy</td>
      <td>False</td>
      <td>60239</td>
      <td>5265</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1</th>
      <td>15752235</td>
      <td>15752235</td>
      <td>Zack Whittaker</td>
      <td>zackwhittaker</td>
      <td>New York, NY</td>
      <td>Security editor @TechCrunch • Signal / WhatsAp...</td>
      <td>https://t.co/0I0oRqFMAy</td>
      <td>False</td>
      <td>59392</td>
      <td>998</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2</th>
      <td>776454093816594433</td>
      <td>776454093816594433</td>
      <td>Oliver Limoyo</td>
      <td>OliverLimoyo</td>
      <td></td>
      <td>PhD. candidate @UofTRobotics @VectorInst study...</td>
      <td>https://t.co/I8kDSFF4Jp</td>
      <td>False</td>
      <td>71</td>
      <td>306</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1079370278424272898</td>
      <td>1079370278424272898</td>
      <td>AppsCyborg</td>
      <td>AppsCyborg</td>
      <td>World</td>
      <td>Home of all cyborg web apps. All our apps are ...</td>
      <td>https://t.co/djpFssnWsi</td>
      <td>False</td>
      <td>825</td>
      <td>0</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>4</th>
      <td>19510090</td>
      <td>19510090</td>
      <td>Julian Togelius</td>
      <td>togelius</td>
      <td>New York City</td>
      <td>AI and games researcher.\nAssociate professor ...</td>
      <td>http://t.co/j74XjVzSps</td>
      <td>False</td>
      <td>10675</td>
      <td>983</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1408</th>
      <td>14269152</td>
      <td>14269152</td>
      <td>Anthony Ha</td>
      <td>anthonyha</td>
      <td>New York, NY</td>
      <td>Journalism for @TechCrunch, science fiction fo...</td>
      <td>https://t.co/2dWc2EzwK6</td>
      <td>False</td>
      <td>43278</td>
      <td>731</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1409</th>
      <td>2384071</td>
      <td>2384071</td>
      <td>timoreilly</td>
      <td>timoreilly</td>
      <td>Oakland, CA</td>
      <td>Founder and CEO, O'Reilly Media. Watching the ...</td>
      <td>https://t.co/HsFlR6PWvT</td>
      <td>False</td>
      <td>1766687</td>
      <td>2121</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1410</th>
      <td>22938914</td>
      <td>22938914</td>
      <td>Steve Wozniak</td>
      <td>stevewoz</td>
      <td>Los Gatos, California</td>
      <td>Engineers first! Human rights. Gadgets. Jokes ...</td>
      <td>http://t.co/gC1NnB1hgl</td>
      <td>False</td>
      <td>626501</td>
      <td>92</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1411</th>
      <td>1835411</td>
      <td>1835411</td>
      <td>Andy Ihnatko</td>
      <td>Ihnatko</td>
      <td>Sector ZZ9 Plural Z Alpha</td>
      <td>Tech contributor to @bospublicradio @WGBH, pod...</td>
      <td>http://t.co/xoCNd62Xhn</td>
      <td>False</td>
      <td>88918</td>
      <td>1916</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1412</th>
      <td>17220934</td>
      <td>17220934</td>
      <td>Al Gore</td>
      <td>algore</td>
      <td>Nashville, TN</td>
      <td></td>
      <td>https://t.co/R5WtdSm0cW</td>
      <td>False</td>
      <td>3040605</td>
      <td>38</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
<p>1413 rows × 131 columns</p>
</div>



Like the tweets data before, the users JSON data is also nicely structured.

According to this (and my Twitter profile), I follow 1.4k+ people.
I definitely don't interact with that many people, nor pay attention to them.
Let's explore the data a little more and then clean this up.

### Exploring Data

First, let's take a look at basic user statistics:


```python
df.filter(like="_count").describe()
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
      <th>followers_count</th>
      <th>friends_count</th>
      <th>listed_count</th>
      <th>favourites_count</th>
      <th>statuses_count</th>
      <th>status.retweeted_status.retweet_count</th>
      <th>status.retweeted_status.favorite_count</th>
      <th>status.retweet_count</th>
      <th>status.favorite_count</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>1413</td>
      <td>1413</td>
      <td>1413</td>
      <td>1413</td>
      <td>1413</td>
      <td>348</td>
      <td>348</td>
      <td>1413</td>
      <td>1413</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>1.26141e+06</td>
      <td>1898.8</td>
      <td>6021.76</td>
      <td>11701.3</td>
      <td>28546.4</td>
      <td>1421.52</td>
      <td>6146.5</td>
      <td>429.389</td>
      <td>490.885</td>
    </tr>
    <tr>
      <th>std</th>
      <td>5.78562e+06</td>
      <td>16325.6</td>
      <td>16785.9</td>
      <td>41353.2</td>
      <td>62321.8</td>
      <td>7092.65</td>
      <td>31651.4</td>
      <td>3723.26</td>
      <td>5379.2</td>
    </tr>
    <tr>
      <th>min</th>
      <td>71</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>6</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>9213</td>
      <td>240</td>
      <td>233</td>
      <td>704</td>
      <td>2970</td>
      <td>4</td>
      <td>11.75</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>48128</td>
      <td>630</td>
      <td>910</td>
      <td>3045</td>
      <td>8630</td>
      <td>15</td>
      <td>49.5</td>
      <td>3</td>
      <td>2</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>343911</td>
      <td>1412</td>
      <td>4251</td>
      <td>9261</td>
      <td>23789</td>
      <td>95.25</td>
      <td>434.5</td>
      <td>15</td>
      <td>18</td>
    </tr>
    <tr>
      <th>max</th>
      <td>1.21754e+08</td>
      <td>602053</td>
      <td>221282</td>
      <td>1.03488e+06</td>
      <td>654080</td>
      <td>63247</td>
      <td>367412</td>
      <td>63247</td>
      <td>164625</td>
    </tr>
  </tbody>
</table>
</div>



Above we have a lot of useful info.
From a segmentation perspective, `followers_count` followed by `statuses_count` gives the biggest variance if we wanted to classify our users into groups.

However, who are the super popular people that are outliers compared to the rest of my friends?


```python
df.sort_values(by="followers_count", ascending=False).head()
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
      <th>id</th>
      <th>id_str</th>
      <th>name</th>
      <th>screen_name</th>
      <th>location</th>
      <th>description</th>
      <th>url</th>
      <th>protected</th>
      <th>followers_count</th>
      <th>friends_count</th>
      <th>...</th>
      <th>status.retweeted_status.place.id</th>
      <th>status.retweeted_status.place.url</th>
      <th>status.retweeted_status.place.place_type</th>
      <th>status.retweeted_status.place.name</th>
      <th>status.retweeted_status.place.full_name</th>
      <th>status.retweeted_status.place.country_code</th>
      <th>status.retweeted_status.place.country</th>
      <th>status.retweeted_status.place.contained_within</th>
      <th>status.retweeted_status.place.bounding_box.type</th>
      <th>status.retweeted_status.place.bounding_box.coordinates</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1407</th>
      <td>813286</td>
      <td>813286</td>
      <td>Barack Obama</td>
      <td>BarackObama</td>
      <td>Washington, DC</td>
      <td>Dad, husband, President, citizen.</td>
      <td>https://t.co/93Y27HEnnX</td>
      <td>False</td>
      <td>121753699</td>
      <td>602053</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1000</th>
      <td>10228272</td>
      <td>10228272</td>
      <td>YouTube</td>
      <td>YouTube</td>
      <td>San Bruno, CA</td>
      <td>Black Lives Matter.</td>
      <td>https://t.co/qkVaJFk2CG</td>
      <td>False</td>
      <td>72161138</td>
      <td>1124</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1403</th>
      <td>428333</td>
      <td>428333</td>
      <td>CNN Breaking News</td>
      <td>cnnbrk</td>
      <td>Everywhere</td>
      <td>Breaking news from CNN Digital. Now 58M strong...</td>
      <td>http://t.co/HjKR4r61U5</td>
      <td>False</td>
      <td>58499326</td>
      <td>119</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1406</th>
      <td>50393960</td>
      <td>50393960</td>
      <td>Bill Gates</td>
      <td>BillGates</td>
      <td>Seattle, WA</td>
      <td>Sharing things I'm learning through my foundat...</td>
      <td>https://t.co/emd1hfqSRD</td>
      <td>False</td>
      <td>51520675</td>
      <td>228</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1323</th>
      <td>759251</td>
      <td>759251</td>
      <td>CNN</td>
      <td>CNN</td>
      <td></td>
      <td>It’s our job to #GoThere &amp; tell the most diffi...</td>
      <td>http://t.co/IaghNW8Xm2</td>
      <td>False</td>
      <td>49599588</td>
      <td>1108</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
<p>5 rows × 131 columns</p>
</div>



Oh... hello Obama.

But this also brings up another issue: who should I actually follow?

As much as I like Obama and Bill Gates, I don't actually interact with them. 
This is especially true for CNN and YouTube. 

If there is something truly worthwhile being tweeted by these people (or orgs), I'll probably hear about it from my thousand other social media sources.
What I want from Twitter is more personal content from people that provide intelligent ideas and good discussion topics. 

Let's start by exploring a user's followers vs. friends and their Twitter Follower-to-Friend (TFF ratio).


```python
fig, ax = plt.subplots(figsize=figsize)

df.plot.scatter(x="friends_count", y="followers_count", ax=ax, label="Friend")

fig.suptitle("Friends' Followers vs. Friends")
ax.set_xlabel("Number of Friends")
ax.set_ylabel("Number of Followers")
ax.set_xlim([0, df["friends_count"].quantile(q=0.9)])
ax.set_ylim([0, df["followers_count"].quantile(q=0.9)])
ax.legend()
fig.tight_layout()
```


    
![png](index_files/index_22_0.png)
    


Right away, we can see that the majority of outliers fall below a TFF ratio of 1.
Below TFF=1, people have many more followers than friends (e.g., celebrities, popular people).
Above TFF=1, you follow a lot of people, but people don't follow you back (e.g., up-and-comers, bots).

So who should I follow?
Let's look at who I've interacted with in the past.

First, I'll load the my past retweets and favourited tweets ([`EngNadeau-favorites.json`](EngNadeau-favorites.json)) data.
Second, I'll extract the users I've retweeted in the past.
Third, I'll compare these users vs. my current friends.


```python
import numpy as np

# load retweet data
path = Path("EngNadeau-tweets.json")
with open(path) as f:
    data = json.load(f)

df_retweeted = (
    pd.json_normalize(data)
    .pipe(lambda x: x.assign(**{"created_at": pd.to_datetime(x["created_at"])}))
    .pipe(lambda x: x[x["retweeted"]])
    .filter(like="retweeted_status")
    .filter(like="_count")
    .pipe(
        lambda x: x.assign(
            ratio=x["retweeted_status.user.followers_count"]
            / x["retweeted_status.user.friends_count"]
        )
    )
    .replace([np.inf, -np.inf], np.nan)
    .dropna(subset=["ratio"])
)

df_retweeted.describe()
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
      <th>retweeted_status.user.followers_count</th>
      <th>retweeted_status.user.friends_count</th>
      <th>retweeted_status.user.listed_count</th>
      <th>retweeted_status.user.favourites_count</th>
      <th>retweeted_status.user.statuses_count</th>
      <th>retweeted_status.retweet_count</th>
      <th>retweeted_status.favorite_count</th>
      <th>retweeted_status.quoted_status.user.followers_count</th>
      <th>retweeted_status.quoted_status.user.friends_count</th>
      <th>retweeted_status.quoted_status.user.listed_count</th>
      <th>retweeted_status.quoted_status.user.favourites_count</th>
      <th>retweeted_status.quoted_status.user.statuses_count</th>
      <th>retweeted_status.quoted_status.retweet_count</th>
      <th>retweeted_status.quoted_status.favorite_count</th>
      <th>ratio</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>302</td>
      <td>302</td>
      <td>302</td>
      <td>302</td>
      <td>302</td>
      <td>302</td>
      <td>302</td>
      <td>12</td>
      <td>12</td>
      <td>12</td>
      <td>12</td>
      <td>12</td>
      <td>12</td>
      <td>12</td>
      <td>302</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>681172</td>
      <td>6140.14</td>
      <td>3436.95</td>
      <td>6985.08</td>
      <td>27714.4</td>
      <td>960.606</td>
      <td>1533.55</td>
      <td>878613</td>
      <td>1547.92</td>
      <td>7723.75</td>
      <td>5401.75</td>
      <td>17302</td>
      <td>1878.67</td>
      <td>9460.33</td>
      <td>6533.61</td>
    </tr>
    <tr>
      <th>std</th>
      <td>3.61614e+06</td>
      <td>68696.8</td>
      <td>11923.9</td>
      <td>34915.9</td>
      <td>89221</td>
      <td>12127.6</td>
      <td>20802</td>
      <td>2.99208e+06</td>
      <td>1274.39</td>
      <td>25607.8</td>
      <td>4931.2</td>
      <td>33218.1</td>
      <td>6146.83</td>
      <td>32156</td>
      <td>42805.3</td>
    </tr>
    <tr>
      <th>min</th>
      <td>15</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>87</td>
      <td>1</td>
      <td>0</td>
      <td>639</td>
      <td>368</td>
      <td>33</td>
      <td>66</td>
      <td>1021</td>
      <td>0</td>
      <td>2</td>
      <td>0.0815217</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>993</td>
      <td>237.25</td>
      <td>36</td>
      <td>494.25</td>
      <td>1753</td>
      <td>1</td>
      <td>3</td>
      <td>2113</td>
      <td>675</td>
      <td>95</td>
      <td>1666.5</td>
      <td>2686.25</td>
      <td>1.75</td>
      <td>7.5</td>
      <td>0.872062</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>3265</td>
      <td>712</td>
      <td>98</td>
      <td>1583.5</td>
      <td>5369</td>
      <td>3</td>
      <td>6</td>
      <td>5747.5</td>
      <td>1026.5</td>
      <td>140.5</td>
      <td>4545</td>
      <td>5060</td>
      <td>6</td>
      <td>17.5</td>
      <td>5.70978</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>31005.2</td>
      <td>2142</td>
      <td>585.25</td>
      <td>4501.25</td>
      <td>10565.8</td>
      <td>26</td>
      <td>29</td>
      <td>14300.2</td>
      <td>2179.25</td>
      <td>581.5</td>
      <td>7356.25</td>
      <td>12165.2</td>
      <td>122.25</td>
      <td>205.75</td>
      <td>39.3201</td>
    </tr>
    <tr>
      <th>max</th>
      <td>3.81207e+07</td>
      <td>1.16459e+06</td>
      <td>112742</td>
      <td>576330</td>
      <td>959614</td>
      <td>209899</td>
      <td>360915</td>
      <td>1.03793e+07</td>
      <td>4320</td>
      <td>89027</td>
      <td>16239</td>
      <td>119010</td>
      <td>21386</td>
      <td>111562</td>
      <td>392997</td>
    </tr>
  </tbody>
</table>
</div>




```python
# load favourited tweets data
# run `plumes favorites`
path = Path("EngNadeau-favorites.json")
with open(path) as f:
    data = json.load(f)

df_favorites = (
    pd.json_normalize(data)
    .pipe(lambda x: x.assign(**{"created_at": pd.to_datetime(x["created_at"])}))
    .drop_duplicates(subset="user.screen_name")
    .filter(like="user.")
    .filter(like="_count")
    .pipe(lambda x: x.assign(ratio=x["user.followers_count"] / x["user.friends_count"]))
    .replace([np.inf, -np.inf], np.nan)
    .dropna(subset=["ratio"])
)

df_favorites.describe()
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
      <th>user.followers_count</th>
      <th>user.friends_count</th>
      <th>user.listed_count</th>
      <th>user.favourites_count</th>
      <th>user.statuses_count</th>
      <th>quoted_status.user.followers_count</th>
      <th>quoted_status.user.friends_count</th>
      <th>quoted_status.user.listed_count</th>
      <th>quoted_status.user.favourites_count</th>
      <th>quoted_status.user.statuses_count</th>
      <th>ratio</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>157</td>
      <td>157</td>
      <td>157</td>
      <td>157</td>
      <td>157</td>
      <td>13</td>
      <td>13</td>
      <td>13</td>
      <td>13</td>
      <td>13</td>
      <td>157</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>1.03861e+06</td>
      <td>8965.46</td>
      <td>3013.01</td>
      <td>15381.7</td>
      <td>25452.6</td>
      <td>52214</td>
      <td>1244.15</td>
      <td>843.308</td>
      <td>7358.92</td>
      <td>6584.38</td>
      <td>1437.58</td>
    </tr>
    <tr>
      <th>std</th>
      <td>9.96025e+06</td>
      <td>54112.1</td>
      <td>19875.2</td>
      <td>54028.6</td>
      <td>96299.1</td>
      <td>115818</td>
      <td>1362.51</td>
      <td>1763.6</td>
      <td>13425.1</td>
      <td>8800.26</td>
      <td>15243.8</td>
    </tr>
    <tr>
      <th>min</th>
      <td>15</td>
      <td>7</td>
      <td>0</td>
      <td>0</td>
      <td>27</td>
      <td>307</td>
      <td>0</td>
      <td>7</td>
      <td>0</td>
      <td>78</td>
      <td>0.05</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>887</td>
      <td>337</td>
      <td>27</td>
      <td>608</td>
      <td>1352</td>
      <td>1146</td>
      <td>91</td>
      <td>49</td>
      <td>233</td>
      <td>727</td>
      <td>1.38529</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>5110</td>
      <td>830</td>
      <td>129</td>
      <td>2734</td>
      <td>4793</td>
      <td>4030</td>
      <td>797</td>
      <td>157</td>
      <td>946</td>
      <td>4139</td>
      <td>3.74692</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>31579</td>
      <td>1968</td>
      <td>547</td>
      <td>9695</td>
      <td>13670</td>
      <td>10556</td>
      <td>1409</td>
      <td>318</td>
      <td>6045</td>
      <td>6688</td>
      <td>27.2923</td>
    </tr>
    <tr>
      <th>max</th>
      <td>1.22369e+08</td>
      <td>601499</td>
      <td>220417</td>
      <td>576678</td>
      <td>963929</td>
      <td>335806</td>
      <td>3699</td>
      <td>5953</td>
      <td>46148</td>
      <td>31104</td>
      <td>190697</td>
    </tr>
  </tbody>
</table>
</div>



So, from the above, I typically interact with pretty popular people (`retweeted_status.user.followers_count` and `user.followers_count`), but most people fall within a TFF ratio of about 1 to 30.

What does this look like plotted?


```python
fig, ax = plt.subplots(figsize=figsize)

df.plot.scatter(x="friends_count", y="followers_count", ax=ax, label="Friend")

df_retweeted.plot.scatter(
    x="retweeted_status.user.friends_count",
    y="retweeted_status.user.followers_count",
    ax=ax,
    label="Retweeted User",
    c="C1",
)

df_favorites.plot.scatter(
    x="user.friends_count", y="user.followers_count", ax=ax, label="Liked User", c="C2"
)

fig.suptitle("Users' Friends vs Followers")
ax.set_xlabel("Number of Friends")
ax.set_ylabel("Number of Followers")
ax.set_xlim([0, df["friends_count"].quantile(q=0.9)])
ax.set_ylim([0, df["followers_count"].quantile(q=0.7)])
ax.legend()
fig.tight_layout()
```


    
![png](index_files/index_27_0.png)
    


The vast majority of people I interact with are within the core grouping of less than 2k friends and 50k followers (i.e., a TFF ratio of 25).

### Pruning Friends

With goal #2 in mind, we'll use `plumes` to prune friends that I don't typically interact with.
From the previous data and plots, I'll unfriend people that:

- Haven't tweeted in the last 30 days
- Have a TFF ratio less than 1
- Have a TFF ratio more than 30

Since `plumes` assumes the conditional flags are AND boolean operations, we'll need to call the `bool_or` flag to convert the boolean algebra to OR conditions.
The command will look like this:

```bash
# add --prune to switch from dry-run to deleting
poetry run plumes audit_users EngNadeau-friends.json --min_ratio 1 --max_ratio 30 --days 30 --bool_or
```

This results in 912 identified users that will be unfriended.

My Twitter feed has never looked so good. :)
