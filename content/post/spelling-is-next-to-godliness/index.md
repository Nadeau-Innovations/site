+++
title = "Spelling Is Next to Godliness"
date = 2018-08-07T13:12:00
tags = ["bash", "bin", "change", "codebase", "correction", "devops", "examples", "godliness", "grammar", "humans", "issue", "keras", "libraries", "localization", "maintainer", "misspell", "next", "notion", "numpy", "overwrite", "package", "phd", "reader", "repository", "requests", "", "rush", "science", "tensorflow"]
categories = []
aliases = ["/post/spelling-is-next-to-godliness"]
+++


Spelling and grammar are very important. However, when in a rush, we tend to neglect these important aspects.
Search engines and humans readers usually don't appreciate content that includes spelling or grammatical errors.

<!--more-->

This notion also applies to your code repository...

As such, let's automatically spell check and fix our codebase with [`misspell`](https://github.com/client9/misspell)!

## Spell Check
```bash
cd my-code-repository/
~/bin/misspell -w .
git commit -am "fixed spelling"
```
- `-w`: Overwrite file with corrections

**Note**:
Be careful with overzealous fixes!
You should review the changes before pushing, as:

- 3rd-party libraries often have many issues
- Localization files may be incorrectly flagged
- The package maintainer might not appreciate such a large commit

## Examples Pull Requests
- [Tensorflow](https://github.com/tensorflow/tensorflow/pull/18806)
- [Keras](https://github.com/keras-team/keras/pull/10016)
- [NumPy](https://github.com/numpy/numpy/pull/10958)
- [Scikit-learn](https://github.com/scikit-learn/scikit-learn/pull/11017)
