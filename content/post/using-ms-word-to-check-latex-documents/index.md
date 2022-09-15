---
aliases:
- /post/using-ms-word-to-check-latex-documents
- /post/2018/7/using-ms-word-to-check-latex-documents/
categories: []
date: "2018-07-30 21:04:52"
tags:
- bash
- check
- documents
- docx
- grammar
- microsoft
- pandoc
- phd
- ""
- word
title: Using MS Word to Check LaTeX Documents
---

Microsoft Word has great spelling and grammar checking.
Use [`pandoc`](https://pandoc.org/) to convert the LaTeX document to `docx` and double check your work.

<!--more-->

```bash
pandoc INPUT.tex -o OUTPUT.docx
```