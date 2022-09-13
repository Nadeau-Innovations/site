+++
title = "Convert Images in a Directory"
date = 2018-06-14T00:00:00
tags = ["images", "bash", "", "loop", "formats", "imagemagick"]
categories = []
aliases = ["/post/convert-images-in-a-directory"]
+++

A simple bash for-loop for convert many images at once.

<!--more-->

```bash
for i in *.png ; do convert "$i" "${i%.*}.jpg" ; done
```
- `convert`: convert between image formats using ImageMagick
