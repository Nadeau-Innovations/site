---
aliases:
- /post/2019/2/cli-resize-images/
categories: []
date: "2019-02-10T11:27:47-05:00"
draft: false
image:
  aliases:
  - /post/cli-resize-images
  caption: ""
  focal_point: ""
tags:
- bash
- ""
- mogrify
- imagemagick
title: Resize and Convert All Images in a Directory
---

`mogrify` is part of the ImageMagick suite of tools.
It's simple, powerful, and easy to use.

<!--more-->

## Specific Size

```bash
mogrify -resize WxH *.jpg
```

- `W`: width
- `H`: height
- You may leave one of the above variables blank to keep the same aspect ratio

## Relative Size

```bash
mogrify -resize 50% *.jpg
```

## Convert

```bash
# convert png to jpg
mogrify -format jpg *.png
```