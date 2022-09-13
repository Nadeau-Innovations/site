---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Tip of the Day: Markdown README Template With Title Image"
subtitle: ""
summary: "By using a mixture of HTML and Markdown, we can create a nice, simple `README` file that looks aesthetically pleasing to the eye."
authors: []
tags: ["alt", "badge", "felis", "ipsum", "label", "readme", "markdown"]
categories: []
date: 2020-04-20T07:31:23-04:00
lastmod: 2020-04-20T07:31:23-04:00
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
- /post/dev-tips-readme-template-with-title-image
---

By using a mixture of HTML and Markdown, we can create a nice, simple `README` file that looks aesthetically pleasing to the eye:

```markdown
<p align="center">
  <a aria-label="My Logo's Label" href="https://nicholasnadeau.me">
    <img src="my-logo.png">
  </a>

  <a aria-label="My Badge Label" href="My Badge URL">
    <img alt="" src="My Badge Image">
  </a>

  <a aria-label="My Badge Label" href="My Badge URL">
    <img alt="" src="My Badge Image">
  </a>

  <a aria-label="My Badge Label" href="My Badge URL">
    <img alt="" src="My Badge Image">
  </a>
</p>

## Introduction

Lorem ipsum dolor sit amet, consectetur adipiscing elit.
Praesent felis libero, dignissim vitae tempus vel, laoreet sed felis.
Phasellus porta mi quis ipsum iaculis lobortis. Cras faucibus ante ac massa cursus malesuada.

```

## Examples

- [`zeit/swr`](https://github.com/zeit/swr)
