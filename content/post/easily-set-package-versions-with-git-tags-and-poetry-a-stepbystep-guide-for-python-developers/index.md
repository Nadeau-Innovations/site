---
authors: []
categories: []
date: "2023-01-23"
draft: false
featured: false
image:
  caption: ""
  focal_point: ""
  preview_only: false
lastmod: "2023-01-20T12:34:01-05:00"
projects: []
subtitle: ""
summary: ""
tags: []
title: 'Easily Set Package Versions With Git Tags and Poetry: A Step-by-step Guide
  for Python Developers'
---

Git tags can be a helpful way to set the version of a package when using the Poetry package manager for Python. Using Git tags, you can easily track the different versions of your package and ensure that the correct version is being used in your project.

In this blog post, we'll explore how to use Git tags with Poetry to set the version of a package and provide examples to help you get started.

To get started, you'll need to have both Poetry and Git installed on your system. Linux, macOS, and Windows (WSL) users [can install Poetry](https://python-poetry.org/docs/#installation) by running the following command:

```sh
curl -sSL https://install.python-poetry.org | python3 -
```

Once Poetry is installed, you can create a new project by running the following command:

```sh
poetry new my-project
```

This will create a new directory called `my-project` with a basic file structure for a Python project.

To set a version for your package, you can use Poetry's `version` command. For example, to set the version of your package to `1.0.0`, you can run the following command:

```sh
poetry version 1.0.0
git tag 1.0.0
```

This will update the version number in the `pyproject.toml` file and create a new Git tag with the version number.

Once you've set the version of your package, you can use Git tags to manage the different versions of your package. For example, you can use the `git tag` command to list all of the tags in your repository:

```sh
git tag
```

Use the `git checkout` command to switch between different versions of your package. For example, to switch to version `1.0.0` of your package, you can run the following command:

```sh
git checkout 1.0.0
```

Push your tags to a remote repository by running the following command:

```sh
git push --tags
```

Git tags are a powerful way to manage the different versions of your package when using the Poetry package manager for Python. By setting the version of your package with Poetry and using Git tags to manage the different versions, you can ensure that the correct version of your package is being used in your project. This makes it easy to maintain and develop projects that have multiple dependencies and requirements and makes it easy to share your projects with others.
