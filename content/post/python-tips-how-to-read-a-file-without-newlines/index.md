---
aliases:
- /post/2021/5/python-tips-how-to-read-a-file-without-newlines/
authors: []
categories: []
date: "2021-05-03T17:43:53-04:00"
draft: false
featured: false
image:
  caption: ""
  focal_point: ""
  preview_only: false
lastmod: "2021-05-03T17:43:53-04:00"
projects: []
subtitle: ""
summary: ""
tags:
- python
title: 'Python Tips: How to Read a File Without Newlines'
---

Text files are a common part of data processing.

A standard approach to reading a file is to use the [`readlines()`](https://docs.python.org/3/library/io.html?highlight=readlines#io.IOBase.readlines), but this results in a list with newline characters.

For example, given some sample text and the standard approach:

```nohighlight
Hello, World!

Lorem ipsum dolor sit amet, consectetur adipiscing elit.
Sed fermentum justo a dignissim lobortis.
Nullam dapibus risus lectus, sit amet pharetra lorem cursus rutrum.
Nunc ullamcorper purus massa, nec lobortis dui scelerisque id.
Proin eget suscipit odio.
Nulla sagittis urna eget viverra finibus.

Nullam in risus eu eros efficitur fringilla.
Proin porttitor consequat malesuada.
Quisque consectetur bibendum ligula, et molestie justo dapibus sed.
Pellentesque ultricies dignissim maximus.
Duis neque tellus, bibendum a felis ac, dignissim rhoncus turpis.
Mauris dictum a felis ut viverra. Sed eu mollis libero.
```

```python
open('text.txt').readlines()
```

Would result in:

```python
['Hello, World!\n',
 '\n',
 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n',
 'Sed fermentum justo a dignissim lobortis.\n',
 'Nullam dapibus risus lectus, sit amet pharetra lorem cursus rutrum.\n',
 'Nunc ullamcorper purus massa, nec lobortis dui scelerisque id.\n',
 'Proin eget suscipit odio.\n',
 'Nulla sagittis urna eget viverra finibus.\n',
 '\n',
 'Nullam in risus eu eros efficitur fringilla.\n',
 'Proin porttitor consequat malesuada.\n',
 'Quisque consectetur bibendum ligula, et molestie justo dapibus sed.\n',
 'Pellentesque ultricies dignissim maximus.\n',
 'Duis neque tellus, bibendum a felis ac, dignissim rhoncus turpis.\n',
 'Mauris dictum a felis ut viverra. Sed eu mollis libero.\n']
 ```

## A Better Way

Using the [`splitlines()`](https://docs.python.org/3/library/stdtypes.html#str.splitlines) command, we have a cleaner result:

```python
open('text.txt').read().splitlines()
```

Results in no newline characters (`\n`) appended to the end of lines:

```python
['Hello, World!',
 '',
 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
 'Sed fermentum justo a dignissim lobortis.',
 'Nullam dapibus risus lectus, sit amet pharetra lorem cursus rutrum.',
 'Nunc ullamcorper purus massa, nec lobortis dui scelerisque id.',
 'Proin eget suscipit odio.',
 'Nulla sagittis urna eget viverra finibus.',
 '',
 'Nullam in risus eu eros efficitur fringilla.',
 'Proin porttitor consequat malesuada.',
 'Quisque consectetur bibendum ligula, et molestie justo dapibus sed.',
 'Pellentesque ultricies dignissim maximus.',
 'Duis neque tellus, bibendum a felis ac, dignissim rhoncus turpis.',
 'Mauris dictum a felis ut viverra. Sed eu mollis libero.']
 ```