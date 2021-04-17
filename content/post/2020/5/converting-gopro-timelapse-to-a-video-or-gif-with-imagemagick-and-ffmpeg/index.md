---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Converting GoPro Timelapse Images to a Video with Imagemagick and ffmpeg"
subtitle: ""
summary: ""
authors: []
tags: ["imagemagick", "gif", "gopro", "ffmpeg", "video", "timelapse","bash","youtube"]
categories: []
date: 2020-05-19T13:47:35-04:00
lastmod: 2020-05-19T13:47:35-04:00
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
- /post/converting-gopro-timelapse-to-a-video-or-gif-with-imagemagick-and-ffmpeg
---

Recently, a crane was built in front of where I live and I wanted to capture a timelapse of the construction process.
It's been a while since I've made a timelapse with my GoPro and I wanted to document a workflow for future use.
Here's the finished result:

{{< youtube W2rYwjqRfV4 >}}

## Cropping for Aspect Ratio

GoPro images are `4000x3000px`.
The standard aspect ratio for [YouTube on a computer](https://support.google.com/youtube/answer/6375112) is `16:9`.
Let's crop the images to them `16:9`, giving us a size of `4000x2250px`.
In the terminal, navigate to your images folder and [run the following](https://www.imagemagick.org/discourse-server/viewtopic.php?t=17844):

```bash
# create a dir for the cropped images
mkdir out

# find all images, iterate through, and crop
for F in $(find img -iname "*.jpg"); do convert $F -crop 4000x2250+0+375 out/$(basename $F); done
```

The above command assumes that the GoPro images are in the `img` directory.
The crop position assumes a centred `16:9` frame.
Note that the XY offset for the cropping can be modified using the `-crop WxH+X_OFFSET+Y_OFFSET` term above.

## Rename Files to Sequential Numbers

In the next step, we'll merge the images into a video using `ffmpeg`.
However, we need the files to be sequentially numbered without gaps.
An example GoPro image filename looks like this: `G0011626.JPG`, `G0011627.JPG`, etc.
While they already have their own numbering convention, there are two problems:

1. Numbering does not start at an index of `i=1`.
2. There may be gaps in the numbering if images are deleted or edited out.

Instead, we can assume that the alphanumerical order is true (i.e., sort by filename).
Navigate to the images directory and [run the following](https://stackoverflow.com/questions/18686832/rename-all-files-in-folder-to-numbered-list-1-jpg-2-jpg):

```bash
ls | cat -n | while read n f; do mv "$f" "$n.jpg"; done
```

- `ls`: lists the files
- `cat -n`: adds line numbers
- `while loop`: reads the resulting numbered list of files line by line
- `n`: line number
- `f`: filename
- `mv`: performs the rename

## Convert to a Video

Using `ffmpeg`, we can convert the cropped and sequentially numbered images to a video.
If a GIF is your desired end result, it's a lot more efficient (in terms of both memory, size, and speed) to start with a high-quality video and then convert to GIF, rather than going directly to GIF from a series of images.
From the root directory, [run the following](https://askubuntu.com/questions/610903/how-can-i-create-a-video-file-from-a-set-of-jpg-images):

```bash
ffmpeg -framerate 30 -i out/%d.JPG -c:v libx264 -profile:v high -crf 20 -pix_fmt yuv420p output.mp4
```
