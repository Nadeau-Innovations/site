---
aliases:
- /post/2021/9/pdf-hero-how-to-extract-emails-with-python/
authors: []
categories: []
date: "2021-09-11T10:23:30-04:00"
draft: false
featured: false
image:
  caption: ""
  focal_point: ""
  preview_only: false
lastmod: "2021-09-11T10:23:30-04:00"
projects: []
subtitle: ""
summary: ""
tags: []
title: 'PDF Hero: How to Extract Emails with Python'
---

This article stems from a request from my partner: "Could you write a script that gets me all the emails from all the PDFs in a network drive?"
Reluctantly, I agreed.

For context, my partner works for McGill University and her department doesn't have a proper database or Database Management System (DBMS) for managing their documents.
They use a classic "filesystem database", i.e., store everything in a network drive organized by nested subfolders.
Ideally, fetching the data should have been a simple SQL query, but instead, everything was locked away in PDFs scattered across folders.

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
- Merge the data into a table
- Clean the data

**Load**

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

## Let's Code

Now we can start making the Python script.
The following sections will dive into the details and thought process behind the script.
Each of the code snippets focus on a single piece of logic.

For this project, I used some global "configuration" variables at the top of my script (they'll be uppercase).
Typically, for larger projects I'd use the awesome [`Dynaconf`](https://www.dynaconf.com/) package for configuration management, but for simplicity, a few globals is all this script really needed.

As a side note, if I were to build this for something more maintainable and permanent, then I'd probably have used [Luigi](https://github.com/spotify/luigi) or even [Apache Airflow](https://airflow.apache.org/).
These frameworks are much more robust and would allow for batch processing of data on a continuous basis.

### Logging

Before we begin with the data processing stuff, I'm a fanatic for setting up some basic logging.
Don't take shortcuts and use the `print()` statement.

Here's a basic helper function that you'll find at the top of many of my scripts:

```python
import logging

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

### Extract

The **extract** stage of the process is the most complicated.
Not only do we need to find the PDFs, we also need to develop different approaches to finding emails within each PDF.

#### Searching for PDFs

The first step is to find all the PDFs.
For this I'll be using one of my favourite built-in modules: [`pathlib`](https://docs.python.org/3/library/pathlib.html).

```python
from pathlib import Path

ROOT_DIR = r"\\PATH\TO\NETWORK\DRIVE"
ROOT_DIR = Path(ROOT_DIR)

glob_pattern = "*.pdf"
pdf_paths = ROOT_DIR.rglob(glob_pattern)
```

The above snippet uses the `rglob()` function to recursively search for a given pattern (i.e., PDF files) starting from the root directory.
For efficiency, `rglob()` returns a generator (not a list), so the paths haven't been evaluated yet, and thus will cost little compute time.
This prevents this step from being a major blocker due to the shear number of PDF files.

Also note that I used a [raw string (i.e., raw literal)](https://docs.python.org/3/reference/lexical_analysis.html?highlight=raw%20string#string-and-bytes-literals) since [Windows UNC network paths use double backslashes](https://stackoverflow.com/a/59720546).

#### Looking Inside PDFs

Now that we have access to all the PDF paths, it's time to create the logic behind parsing the PDFs.
The straightforward-but-inefficient way would be to simple iterate through a `for loop`, e.g.:

```python
for path in pdf_paths:
  # do stuff to each PDF
```

But this single process would be slow due to the number of files.
We're also not taking advantage of the multiple cores of our CPU.

Instead, we'll use the built-in `multiprocessing` library to spawn multiple Python processes that will each handle a chunk of the PDFs:

```python
from multiprocessing import Pool

with Pool() as p:
    extracted_data = p.map(parse_pdf, pdf_paths)
```

Here we leverage the simplicity of the `map()` function in the context of a process `Pool`.
With no arguments, the `Pool()` instantiation operation creates a pool of workers given the maximum amount of cores available on your machine.

We are also using the [multiprocessing `map()` function](https://docs.python.org/3/library/multiprocessing.html#multiprocessing.pool.Pool.map), a parallel equivalent of the standard `map()` function.
In this case, the `parse_pdf()` function will be applied to each element in `pdf_paths` and return a collection of all the individual returned values.

Now we define `parse_pdf()`:

```python
import PyPDF2


def parse_pdf(path: Path) -> dict:
    LOGGER.info(f"Parsing {path.relative_to(ROOT_DIR)}")

    # prepare data to be returned
    data = {
        "person": path.parent.name,
        "category": str(path.relative_to(ROOT_DIR).parts[0]),
        "file": path.name,
        "path": str(path.relative_to(ROOT_DIR)),
    }

    # get email separately due to possible errors
    try:
        data["email"] = extract_email(path)
    except PyPDF2.utils.PdfReadError as e:
        # typically due to PDF being encrypted/locked
        logger.error(f"Failed to open {path.name}: {e}")
    except Exception as e:
        # don't want misc errors crashing the entire script
        # better to have a few blank emails
        logger.error(f"Failed to parse {path.name}: {e}")

    return data
```

This is where things start to get interesting.
`parse_pdf()` has one purpose: get and prepare the data for each PDF.
For simplicity, I'm using a dictionary structure to collect the data I want from each PDF.
We start with some basic metadata that's useful to have and then mine the emails in a separate step.

For mining PDFs, there are a lot of Python packages in the ecosystem, but I've had the most success with [`PyPDF2`](https://github.com/mstamy2/PyPDF2).
While it isn't the most straightforward package to use, it gets the job done.

Note that the email mining step is wrapped in a try-catch block.
It is important to catch any PDF parsing errors, else the whole script will crash and everything will need to be rerun.
A more complex approach would have been to cache the results, avoiding the need to rerun successful parsings.

#### Mining Emails

We're into the details now.

```python
from typing import Optional
import re


def validate_email_string(text: str) -> Optional[str]:
    # humans don't always follow instructions
    # this can cause problems with text and fields
    # be super strict when getting emails
    email_regex = re.compile(r"[a-z]+.\w+@specific.domain.com")
    results = re.findall(email_regex, text)

    if results:
        return results[0]


def get_email_from_form(reader: PyPDF2.PdfFileReader) -> Optional[str]:
    # some PDFs had the emails in form fields
    try:
        fields = reader.getFormTextFields()
        for field_key, field_text in fields.items():
            if "email" in field_key.lower():
                email = validate_email_string(field_text)
                if email:
                    return email
    except TypeError:
        # no fields were found
        pass


def get_email_from_pages(reader: PyPDF2.PdfFileReader) -> Optional[str]:
    # some PDFs had the email elsewhere in the document
    # need to iterate through the pages
    for page in reader.pages:
        text = page.extractText()
        email = validate_email_string(text)

        if email:
            return email


def extract_email(path: Path) -> Optional[str]:
    # PDFs are binary
    # need to use the "read binary" (`rb`) flag
    with open(path, "rb") as pdf:
        reader = PyPDF2.PdfFileReader(pdf, strict=False)

        # check if email is in form fields
        email = get_email_from_form(reader)

        # if not in form fields, check text
        if not email:
            email = get_email_from_pages(reader)

        if email:
            logger.info(f"Email found in {path.relative_to(ROOT_DIR)}: {email}")
            return email
```

Starting from the bottom of the code block, we have `extract_email()`, the primary logic for email extraction.
This function simply opens a PDF with `PyPDF2` and attempts to find the email in either form fields (preferred) or the whole text.

One of the advantages of `PyPDF2` is seen in `get_email_from_form()`: we can easily get access to form field data.
Simply iterating through the dictionary of fields lets us check for keys and values that match our needs.
Otherwise, `get_email_from_pages()` is the less-preferred brute force approach: parse ALL the text for an email.

Both approaches rely on `validate_email_string()` which is used to validate and extract exactly the email we want, because humans are bad.
They will make mistakes when inputting text.
They will add unneeded punctuation, whitespace, extra emails, or all sorts of other problems when given the freedom to fill in fields.

Fortunately, it was known that all the emails we'd be looking for followed a specific format:

```
<first name>.<last name>[optional number]@specific.domain.com
```

So we will use the built-in regular expression matching (`re`, aka regex) library to find *exactly* the email string we want.
Fortunately, we have online tools (e.g., [Regexr](https://regexr.com/)) that can help us figure out what regex pattern to use.

### Transform

Given the previous sections, we have everything we need to find PDFs, search through each one, and extract exact emails.
Worst case scenario, the PDF doesn't yield an email, so the process will just continue and have a blank email value.
In all my testing, less than 1% of the thousands of PDFs failed to find something.

The **transform** stage of this adventure starts with the resulting `extracted_data` container.
This object contains all the resulting structures/dictionaries of data representing a record of each PDF.

At this point, we'll use one of the most important tools in data science: `pandas`.

```python
import pandas as pd

df = pd.DataFrame(extracted_data)
```

That's really it.
`pandas` simply transforms our list of dictionaries into a DataFrame object that's ready for manipulation.

### Load

As a final step, my partner wanted a spreadsheet for Excel, so we'll simply export the DataFrame to CSV and call it a day.

```python
df.to_csv("my-output-file.csv")
```