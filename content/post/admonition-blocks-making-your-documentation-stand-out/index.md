---
aliases:
- /post/admonition-blocks-making-your-documentation-stand-out
- /post/2018/8/admonition-blocks-making-your-documentation-stand-out/
categories: []
date: "2018-08-04 15:23:50"
tags:
- documentation
- admonition
- awesomebox
- alertmessage
- usepackage
- latex
- xelatex
title: 'Admonition Blocks: Making Your Documentation Stand Out'
---

Documentation doesn't always have to be boring.
Admonition blocks draw the reader's attention to important notes and warnings that may not directly fit as part of the flow of the text.

<!--more-->

As I often prefer to write long-form reports and documentation in LaTeX, [`awesomebox`](https://ctan.org/tex-archive/graphics/awesomebox) and [`alertmessage`](https://www.ctan.org/pkg/alertmessage) are my go-to packages for admonition blocks.
Several simple examples may be found below.

```latex
% !TEX program = xelatex
\documentclass{article}

% dummy text for examples
\usepackage{lipsum}

% admonition blocks around text to inform/alert readers
\usepackage{awesomebox}
% or without using xelatex
\usepackage{alertmessage}

\begin{document}

% awesomebox
\tipbox{\lipsum[2]}
\notebox{\lipsum[3]}
\warningbox{\lipsum[4]}
\cautionbox{\lipsum[5]}
\importantbox{\lipsum[5]}

% alertmessage
\alertinfo{\lipsum[2]}
\alertsuccess{\lipsum[2]}
\alertwarning{\lipsum[2]}
\alerterror{\lipsum[2]}

\end{document}
```