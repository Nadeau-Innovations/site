---
aliases:
- /post/dev-tips-recursively-delete-empty-folders
- /post/2020/4/dev-tips-recursively-delete-empty-folders/
authors: []
categories: []
date: "2020-04-21T07:57:14-04:00"
draft: false
featured: false
image:
  caption: ""
  focal_point: ""
  preview_only: false
lastmod: "2020-04-21T07:57:14-04:00"
projects: []
subtitle: ""
summary: Stuck with many nested folders, some of which may be empty?
tags:
- bash
- empty
- folders
- tip
title: 'Tip of the Day: Recursively Delete Empty Folders'
---

Stuck with many nested folders, some of which may be empty?
Use the following command to quickly find and delete the empty ones:

```bash
find . -empty -type d -delete
```

- `-empty`: File is empty and is either a regular file or a directory
- `-type d`: directory
- `-delete`: Delete files; true if removal succeeded.