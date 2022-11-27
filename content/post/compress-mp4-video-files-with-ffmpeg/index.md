---
# Documentation: https://wowchemy.com/docs/managing-content/

title: "Compress MP4 Video Files With FFMPEG"
subtitle: ""
summary: ""
authors: []
tags: []
categories: []
date: 2022-11-27T18:44:14-05:00
lastmod: 2022-11-27T18:44:14-05:00
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

Need to reduce the file size of MP4 video files?
A [few simple FFMPEG commands](https://unix.stackexchange.com/a/38380) make it easy.

This is especially useful as part of an ETL pipeline for preprocessing AI/ML data or to reduce the file size of videos for a website.

## Compression Commands

```bash
# libx265 can offer around 25–50% savings compared to H.264 video encoded with libx264
ffmpeg -i input.mp4 -vcodec libx265 -crf 28 output.mp4

# libx264 offers more compatibility, e.g., static site generators
ffmpeg -i input.mp4 -vcodec libx264 -crf 20 output.mp4
```

## Looping Over a Directory

Have a bunch of files that need to be compressed all at once?
Loop over a directory with the following:

```bash
for F in *.mp4; \
  do ffmpeg -i $F -vcodec libx264 -crf 24 temp.mp4 \
    && mv -f temp.mp4 $F; \
  done
```
