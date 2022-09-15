---
aliases:
- /post/regex-tips-find-nonascii-characters
- /post/2020/4/regex-tips-find-nonascii-characters/
authors: []
categories: []
date: "2020-04-03"
draft: false
featured: false
image:
  caption: ""
  focal_point: ""
  preview_only: false
lastmod: "2020-04-03T10:24:16-04:00"
projects: []
subtitle: ""
summary: ""
tags:
- abcdef
- ascii
- characters
- object
- python
- regex
- span
- tips
- x7f
title: 'Tip of the Day: Find non-ASCII Characters with Regex'
---

Search for non-ascii characters using regex: `[^\x00-\x7F]+`

<!--more-->

An example using Python:


```python
import re

valid_ascii = "abcdef"
non_ascii = "ðñò"

re.search("[^\x00-\x7F]+", valid_ascii+non_ascii)
```

```
<re.Match object; span=(52, 55), match='ðñò'>
```