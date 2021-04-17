+++
title = "Count the Number of Words in a LaTeX Document"
date = 2018-06-14T00:00:00
tags = ["bash", "byte", "character", "command", "count", "log", "number", "output", "record", "", "word","latex"]
categories = []
aliases = ["/post/count-the-number-of-words-in-a-latex-document"]
+++


```bash
detex my-document.tex | wc -w
```

- `detex`: a filter to strip TeX commands from a .tex file
- `wc`: word, line, character, and byte count
    - `-w`: The number of words in each input file is written to the standard output
