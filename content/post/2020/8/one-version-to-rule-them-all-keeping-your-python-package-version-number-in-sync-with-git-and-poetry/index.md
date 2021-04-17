---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "One Version to Rule Them All: Keeping Your Python Package Version Number in Sync With Git and Poetry"
subtitle: ""
summary: ""
authors: []
tags: ["git","poetry","python","version","devops","github","ci"]
categories: []
date: 2020-08-08T14:54:23-04:00
lastmod: 2020-08-08T14:54:23-04:00
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

[`Poetry`](https://python-poetry.org/) is my current favourite packaging and dependency management tool for Python.
It combines dependency resolution, virtual environments, and packing all into one easy to use tool.
However, my one big complaint at the moment is the lack of synchronization between my package version (defined in `pyproject.toml`) and my git tags.

Before jumping straight to `poetry` plugins that add dynamic versioning (and add an extra dependency), there's a simple workaround.

## Standard Release Workflow

A typical release workflow with poetry looks something like this:

1. Use `poetry` to bump your package version

    ```bash
    poetry version patch

    >>> Bumping version from 0.1.0 to 0.1.1
    ```

1. Create a tag to define your release in git

    ```bash
    git tag 0.1.1
    git push --tags
    ```

1. Hope you used the same version number for both steps

## Synchronized Release Workflow

To avoid human errors, we can link our `poetry` version to our git tags.

1. Update `pyproject.toml` to have a generic version placeholder

    ```toml
    [tool.poetry]
    version = "0.0.0"
    ```

1. Update your release script to fetch the git version before building the package artifacts

    ```bash
    poetry version $(git describe --tags --abbrev=0)
    poetry build
    ```

With this setup, `poetry` will fetch and use the latest git tag as its version.

As an application example and shown below, the [GitHub Action](https://github.com/nnadeau/pybotics/blob/efd3428ca46beb788b6c7120331b50e65d5dc9a1/.github/workflows/publish.yml) that's used to build and publish [`pybotics`](https://github.com/nnadeau/pybotics) to [PyPI](https://pypi.org/) uses the above process to keep things simple.


```yml
name: Publish

on:
  release:
    types: [created]

jobs:
  deploy:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2
    - name: Set up Python
      uses: actions/setup-python@v2
      with:
        python-version: '3.x'
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install poetry
    - name: Build and publish
      run: |
        poetry version $(git describe --tags --abbrev=0)
        poetry build
        poetry publish --username ${{ secrets.PYPI_USERNAME }} --password ${{ secrets.PYPI_PASSWORD }}
```

Less dependencies (e.g., dynamic versioning plugins) means less things that can break.
This is especially important during the release step.
