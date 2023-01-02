---
authors: []
categories: []
date: "2022-11-27T18:44:14-05:00"
draft: false
featured: false
image:
  caption: ""
  focal_point: ""
  preview_only: false
lastmod: "2022-11-27T18:44:14-05:00"
projects: []
subtitle: ""
summary: ""
tags: []
title: Compress MP4 Video Files With FFMPEG
---

Need to reduce the file size of MP4 video files?
A [few simple FFMPEG commands](https://unix.stackexchange.com/a/38380) make it easy.

Quick and straightforward video compression is advantageous as part of an ETL pipeline for preprocessing AI/ML data or reducing video file sizes for a website.

## Compression Commands

```bash
# libx265 can offer around 25–50% savings compared to H.264 video encoded with libx264
ffmpeg -i input.mp4 -vcodec libx265 output.mp4

# libx264 offers more compatibility, e.g., static site generators
ffmpeg -i input.mp4 -vcodec libx264 output.mp4
```

You can also add a [*Constant Rate Factor* (CRF) flag](https://trac.ffmpeg.org/wiki/Encode/H.264) (`-crf`) to more finely control the quality vs. size of the output.
The range of the CRF scale is exponential and accepts values between 0–51:

- 0 is lossless
- 23 is the default
- 51 is the worst quality possible

## Looping Over a Directory

Have a bunch of files that need to be compressed all at once?
Loop over a directory with the following:

```bash
for F in *.mp4; \
  do ffmpeg -i $F -vcodec libx264 temp.mp4 \
    && mv -f temp.mp4 $F; \
  done
```
