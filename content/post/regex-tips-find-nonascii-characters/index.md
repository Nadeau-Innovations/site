---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Tip of the Day: Find non-ASCII Characters with Regex"
subtitle: ""
summary: ""
authors: []
tags: ["abcdef", "ascii", "characters", "object", "python", "regex", "span", "tips", "x7f"]
categories: []
date: 2020-04-03
lastmod: 2020-04-03T10:24:16-04:00
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
- /post/regex-tips-find-nonascii-characters
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
