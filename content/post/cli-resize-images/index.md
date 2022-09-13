+++
title = "Resize and Convert All Images in a Directory"
date = 2019-02-10T11:27:47-05:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["bash", "", "mogrify", "imagemagick"]
categories = []

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
[image]
  # Caption (optional)
  caption = ""

  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = ""
aliases = ["/post/cli-resize-images"]
+++

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
