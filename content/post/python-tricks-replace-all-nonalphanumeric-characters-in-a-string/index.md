---
aliases:
- /post/2020/11/python-tricks-replace-all-nonalphanumeric-characters-in-a-string/
authors: []
categories: []
date: 2020-11-07T09:53:15-b05:00
draft: false
featured: false
image:
  caption: ""
  focal_point: ""
  preview_only: false
lastmod: "2020-11-07T09:53:15-05:00"
projects: []
subtitle: ""
summary: ""
tags:
- ""
- string
- data
- filter
- ""
- performance
- python
- regex
- str
- temperature
title: 'Python Tricks: Replace All Non-alphanumeric Characters in a String'
---

I have a confession to make: I'm a stickler for filenames.
I wholeheartedly believe that all filenames and paths should be [`kebab case`](https://en.wiktionary.org/wiki/kebab_case) or [`snake case`](https://en.wikipedia.org/wiki/Snake_case).
Spaces, capitalization, and non-alphanumeric characters drive me nuts.

My obsession comes from my years of jumping back and forth between Linux (programming, servers), Windows ([CAD](https://www.solidworks.com/)), and MacOS (personal laptop), where each system has different *de facto* filename standards.
As such, I eventually converged towards simple and draconian filenames to ensure easy data scraping when I needed to make automation.

Now, I understand there are times when this level of rigidity doesn't fully make sense.
One example is in mechanical engineering when working with a [PDM system](https://en.wikipedia.org/wiki/Product_data_management) (and non-developer stakeholders).
Common practice is to have your filenames as `<SKU> - <Part Name>.<Extension>` (e.g., `ABC123 - Big Bolt.sldprt`). 
Yes, there are spaces, but as long as the schema is enforced, the database will still be easily machine parsable.

If we extend this line of thought from filenames to a generalized "path" or "resource location" (e.g., URLs, data column headings, data labels), strict and consistent schemas are import, as the devil in the details.

And non-alphanumeric characters are evil.
They just causes headaches for everyone.

## Sanitize All Strings

String validation and sanitization ensures that a string meets a set of criteria (validation) or modifies it to conform to a schema (sanitization).
As discussed above, there are plenty of important situations where incoming strings (e.g., data labels, paths, filenames) may not conform to a standard and behave unexpectedly.
As previously discussed in the [temperature and humidity data analysis post]({{< ref "post/python-for-hardware-engineers-analyzing-temperature-sensor-data" >}}), the `Extract` and `Transform` steps of an [ETL workflow](https://en.wikipedia.org/wiki/Extract,_transform,_load) typically applies some data cleaning.
Stripping non-alphanumeric characters is a simple and useful step for many data processing applications.

As seen in [our previous post]({{< ref "post/python-for-hardware-engineers-analyzing-temperature-sensor-data" >}}), the data logger tried to be fancy and used the (evil) degree symbol (`°C`) and the percent sign (`%RH`) for the temperature and humidity column headers, respectively.
Unfortunately, this is not uncommon, and while Excel parses these strings normally, we can't always guarantee how different systems or programs will react.
For example in LaTeX, the percent sign is the special character for comments, and thus needs to be escaped (`\%`) else you'll have a bad day.

So let's take a look at how to efficiently clean strings in Python.
Given an ugly string:


```python
ugly_string = "Temperature [°C]"
```

We have three choices: two [Pythonic ways](https://www.python.org/dev/peps/pep-0020/) and one [overkill way](https://en.wikipedia.org/wiki/Regular_expression).
Let's also assume that we want to keep whitespace characters.

### Pythonic Cleaning: List Comprehension

A non-optimized, but explicit and easy to read approach is to simply use [list comprehension](https://docs.python.org/3/tutorial/datastructures.html#list-comprehensions) to strip a string of non-alphanumeric characters.
In Python, [a `str` object is a type of sequence](https://docs.python.org/3/library/stdtypes.html#text-sequence-type-str), which is why list comprehension methods work.
We'll use the built-in [`isalnum()`](https://docs.python.org/3/library/stdtypes.html#str.isalnum) to check for alphanumeric characters and [`isspace()`](https://docs.python.org/3/library/stdtypes.html#str.isspace) to check for whitespace.


```python
# list comprehension that filters out bad characters
clean_string = [s for s in ugly_string if s.isalnum() or s.isspace()]

# rejoin intermediate list into a string
clean_string = "".join(clean_string)

clean_string
```




    'Temperature C'



### Pythonic Cleaning: Filter

A second explicit approach is to use the [built-in `filter()` function](https://docs.python.org/3/library/functions.html#filter) to filter out non-compliant characters.
This is a fun function that's useful in a variety of scenarios, especially when combined with [lambda functions](https://docs.python.org/3/tutorial/controlflow.html#lambda-expressions).

The `filter()` function is quite simple: it takes a function that returns `bool` and an iterable.
For each element of the iterable, the given function returns `True` or `False`.
Only elements that return `True` are kept.


```python
# use filter to keep just alphanumeric characters
filter(str.isalnum, ugly_string)

# or use filter to return alphanumeric and whitespace
clean_string = filter(lambda x: x.isalnum() or x.isspace(), ugly_string)

# filter returns a generator, so we need to re-join the string
clean_string = "".join(clean_string)

clean_string
```




    'Temperature C'



### Overkill Cleaning: Regex

Our final approach is to use [Regular Expressions (regex)](https://en.wikipedia.org/wiki/Regular_expression).
Regex is truly powerful and can be used in a variety of situations and across all programming languages.
Even though it has a relatively difficult learning curve, it's definitely something that most developers and engineers should try understand and get familiar with.

However in my humble opinion, depending on the context, it's overkill.

The problem with regex is that it's too powerful and too flexible.
The Pythonic approaches shown above are easy to read, easy to debug, and easy to understand their scope.
Regex requires the developer [to test the expression](https://regexr.com/) (unless you're some kind of regex wizard) and check for corners cases.
While this post's example is quite trivial, not all scenarios will be as forgiving.

The core component of this approach is the regex pattern.
For this example, we'll be using `"[^0-9a-zA-Z\s]+"`.
As explained by a [regex testing website](https://regexr.com/), this pattern includes the following elements:

- `[^...]`: Negated set that matches any character NOT in the set
- `0-9`: Matches numeric characters in the given range
- `a-z`: Matches lowercase alphabetic characters in the given range
- `A-Z`: Matches uppercase alphabetic characters in the given range
- `\s`: Matches any whitespace character
- `+`: Matches one or more of the previous element (i.e., the negated set)


```python
# import the built-in regex library
import re

# define our regex expression
pattern = "[^0-9a-zA-Z\s]+"

# perform a regex substitution to clean the string
clean_string = re.sub(pattern, "", ugly_string)

clean_string
```




    'Temperature C'



## Performance

But Nicholas!
I don't care about readability; I just care about optimized performance!

Well, let's take a look.
As shown below, I've consolidated the three approaches into small functions for performance testing.
I'll also be using a very long [*Lorem Ipsum* (lipsum)](https://www.lipsum.com/) string to test the performance, so as to not have biased results from short text.
The filters will strip period, commas, and other punctuation from the lipsum text.
This string should be longer than any URL, data column header, filename, or other data label that would be sanitized in an engineering context.


```python
def clean_list_comprehension(s: str) -> str:
    return "".join([x for x in s if x.isalnum() or x.isspace()])


def clean_filter(s: str) -> str:
    return "".join(filter(lambda x: x.isalnum() or x.isspace(), s))


def clean_regex(s: str, pattern: str = "[^0-9a-zA-Z\s]+") -> str:
    return re.sub(pattern, "", s)


very_long_string = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam porttitor venenatis dictum. Sed nec eros leo. Donec eget velit diam. In vitae auctor quam. Aenean quam dolor, euismod quis varius non, elementum in enim. Fusce tincidunt, lorem et egestas sagittis, nunc neque finibus justo, id faucibus risus elit non enim. Integer vitae sagittis mauris, ut egestas quam. Vivamus ut dolor sodales, dignissim sapien in, vulputate sem. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque justo nisl, iaculis ac nisl vel, maximus finibus urna. Pellentesque aliquam orci in ultrices bibendum. Donec eu dui finibus, commodo ex at, tempor mauris. Praesent eu quam venenatis, lacinia ex lobortis, finibus eros. Morbi pharetra interdum magna, rhoncus dignissim mauris consectetur quis."
```

Using the [built-in Jupyter magic command `timeit`](https://ipython.readthedocs.io/en/stable/interactive/magics.html#magic-timeit), we can validate the performance of each method:


```python
%timeit clean_list_comprehension(very_long_string)
```

    49.4 µs ± 285 ns per loop (mean ± std. dev. of 7 runs, 10000 loops each)



```python
%timeit clean_filter(very_long_string)
```

    76.7 µs ± 1.69 µs per loop (mean ± std. dev. of 7 runs, 10000 loops each)



```python
%timeit clean_regex(very_long_string)
```

    16.5 µs ± 325 ns per loop (mean ± std. dev. of 7 runs, 100000 loops each)


So while it appears that the regex approach is technically the winner, the Pythonic methods are close enough.
Readability is more important than (very) minor performance optimizations.
