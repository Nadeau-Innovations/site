+++
title = "Using MS Word to Check LaTeX Documents"
date = 2018-07-30T21:04:52
tags = ["bash", "check", "documents", "docx", "grammar", "microsoft", "pandoc", "phd", "", "word"]
categories = []
aliases = ["/post/using-ms-word-to-check-latex-documents"]
+++


Microsoft Word has great spelling and grammar checking.
Use [`pandoc`](https://pandoc.org/) to convert the LaTeX document to `docx` and double check your work.

<!--more-->

```bash
pandoc INPUT.tex -o OUTPUT.docx
```
