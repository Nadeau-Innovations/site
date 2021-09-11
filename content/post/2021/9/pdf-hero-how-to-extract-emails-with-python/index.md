---
# Documentation: https://wowchemy.com/docs/managing-content/

title: "PDF Hero: How to Extract Emails with Python"
subtitle: ""
summary: ""
authors: []
tags: []
categories: []
date: 2021-09-11T10:23:30-04:00
lastmod: 2021-09-11T10:23:30-04:00
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
---

This article stems from a request from my partner: "Could you write a script that gets me all the emails from all the PDFs in a network drive?"
Reluctantly, I agreed.

For context, my partner works for McGill University and her department doesn't have a proper database or Database Management System (DBMS) for managing their documents.
They use a classic "filesystem database", i.e., store everything in a network drive organized by nested subfolders.
Ideally, fetching emails should have been a simple SQL query, but instead, everything was locked away in PDFs scattered across folders.

For obvious reasons, I can't share any potentially sensitive information.
However, my development approach and thinking process is generic enough to be helpful across many applications and contexts.

## The Situation

My partner wanted a list of emails associated with people extracted from PDF documents in a network drive.
Pretty simple request, right?

The network drive was their "database" and was somewhat organized like this:

```
network_drive
├── category_1
│   ├── person_1
│   │   └── document.pdf
│   │   └── document2.pdf
│   │   └── document3.pdf
│   └── person_2
│       └── document.pdf
│       └── document2.pdf
├── category_2
│   ├── person_3
│   │   └── document.pdf
│   └── person_4
│       └── document.pdf
├── category_3
└── category_n
```

The drive root contained a set of subdirectories for each category a person belonged to.
Each category directory contained a subdirectory per person.
Each person directory contained documents associated with that person.
Somewhere in these documents, there may be an email associated with the person of that directory.

Not so bad.
But due to humans being in the loop, file naming was inconsistent, which was annoying.

This is a classic [Extract, Transform, and Load (ETL)](https://en.wikipedia.org/wiki/Extract,_transform,_load) problem.
The high-level steps to approach this problem are:

**Extract**

- Find all PDFs
- Mine each PDF for emails

**Transform**

- Structure the data
- Clean the data

**Load**

- Merge the data into a table
- Export to CSV

## Investigate

From the previous ETL overview, we can quickly see that, if we do it right, a lot of the process can be parallelized.
This is important, finding, opening, mining, and extracting data from PDFs is not necessarily a quick process, especially if we have a lot of them.

And there were a lot of PDFs.

Before starting to build the ETL script, I always poke around and investigate to better understand what I'm dealing with.
How many PDFs were there?

```bash
find . -iname "*.pdf" | wc -l
```

The above terminal command is (probably) the quickest way to find out how many PDFs I had to deal with:

- `find` is a Unix-like operating system command that locates files based on some specified criteria and prints the pathname of each matched object
- `.` denotes that we want to start the `find` command from our current directory
- `-iname "*.pdf"` is our search criteria; we want to find any PDF and are case insensitive
- `|` (or pipe) connects the output of one command (e.g., `find`) and feeds it into another command (e.g., `wc`)
- `wc` is the "word count" command and with the `-l` flag, it only counts lines

So as a whole, the above command finds all the PDF paths (one path per line) and feeds it into the word count command that counts how many lines (paths) there are.

I found that there were nearly six thousand PDFs to parse.
This wasn't going to be a quick script.

## Logging

Now we can start making the Python script.
But before we begin with the data processing stuff, I'm a fanatic for setting up some basic logging.
Don't take shortcuts and use the `print()` statement.

Here's a basic helper function that you'll find at the top of many of my scripts:

```python
def _get_logger(name: str, level: str = "INFO"):
    # get named logger and set level
    logger = logging.getLogger(name)
    logger.setLevel(level=level)

    # set output channel and formatting
    ch = logging.StreamHandler()
    formatter = logging.Formatter("%(asctime)s - %(levelname)s - %(message)s")
    ch.setFormatter(formatter)
    logger.addHandler(ch)

    return logger


LOGGER = _get_logger(__name__)
```

This lets us get a consistent, robust, and proper logger to use throughout our script.
So instead of using `print()`, we'll use `LOGGER.info()` for the most part.

## Extract

The first step is to find all the PDFs.
For this I'll be using one of my favourite built-in modules: [`pathlib`](https://docs.python.org/3/library/pathlib.html).
I'll also set some global "configuration" variables at the top of my script.
Typically, for larger projects I'd use the awesome [`Dynaconf`](https://www.dynaconf.com/) package for configuration management, but a few globals is all this script really needs.

First, the globals:

```python
from pathlib import Path
import re

ROOT_DIR = r"\\PATH\TO\NETWORK\DRIVE"
ROOT_DIR = Path(ROOT_DIR)

GLOB_PATTERN = "*.pdf"
EMAIL_REGEX = re.compile(r"[\w.+-]+@[\w-]+\.[\w.-]+")
```



def get_pdf_paths(root_dir:Path):
  paths = list(subdir.rglob(PDF_GLOB_PATTERN))

EMAIL_DOMAIN = "@specificdomain.com"
