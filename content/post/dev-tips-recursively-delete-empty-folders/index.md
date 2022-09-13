---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Tip of the Day: Recursively Delete Empty Folders"
subtitle: ""
summary: "Stuck with many nested folders, some of which may be empty?"
authors: []
tags: ["bash", "empty", "folders", "tip"]
categories: []
date: 2020-04-21T07:57:14-04:00
lastmod: 2020-04-21T07:57:14-04:00
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
- /post/dev-tips-recursively-delete-empty-folders
---

Stuck with many nested folders, some of which may be empty?
Use the following command to quickly find and delete the empty ones:

```bash
find . -empty -type d -delete
```

- `-empty`: File is empty and is either a regular file or a directory
- `-type d`: directory
- `-delete`: Delete files; true if removal succeeded.
