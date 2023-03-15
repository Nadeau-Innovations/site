---
authors: []
categories: []
date: "2023-01-30"
draft: false
featured: false
image:
  caption: ""
  focal_point: ""
  preview_only: false
lastmod: "2023-01-20T13:25:15-05:00"
projects: []
subtitle: ""
summary: ""
tags:
- python
- poetry
- package management
- dependency management
- versioning
title: 'Pinning Package Versions with Poetry: A Short Guide to Optimizing Python Development
  and Projects'
---

The [Poetry package manager](https://python-poetry.org/) for [Python](https://www.python.org/) is a powerful tool for managing dependencies and versions of packages. One of the key features of Poetry is its ability to pin package versions, which allows for easy dependency management. This blog post will explore how to use Poetry to select a package version and provide examples to help you get started.

{{< toc >}}

## Installing Poetry

You'll need to have Poetry installed on your system to get started. You can install Poetry by running the following command:

```sh
curl -sSL https://install.python-poetry.org | python3 -
```

## Creating a New Project

Once Poetry is installed, you can create a new project by running the following command:

```sh
poetry new my-project
```

This will create a new directory called `my-project` with a basic file structure for a Python project. Inside the `my-project` directory, you'll find a file called `pyproject.toml` which is used to manage your project's dependencies.

## Adding a Package to Your Project

To add a package to your project, you can use the `add` command. For example, to add the `requests` package, you can run the following command:

```sh
poetry add requests
```

This will add the `requests` package to your project and update the `pyproject.toml` file with the package name and version.

## Installing Dependencies with Pinned Versions

One of the main benefits of Poetry is its ability to specify the package version you want to use. For example, if you're going to use version `2.24.0` of the `requests` package, you can run the following command:

```sh
poetry add requests==2.24.0
```

This will add the specific version of the `requests` package to your project and update the `pyproject.toml` file with the package name and version.
Poetry also allows you to specify a range of versions for a package. For example,

```sh
poetry add "requests>=2.24,<3.0"
```

This will add any version of requests package that is greater than or equal to `2.24` and less than `3.0`.

## Installing Dependencies with SemVer-Compatible Versions

Poetry [also includes various special version identifiers](https://python-poetry.org/docs/dependency-specification) that you can use to specify a package version.
The caret operator (`^`) is one of the most commonly used special version identifiers and allows for [SemVer-compatible updates](https://semver.org/). For example,

```sh
poetry add "requests^2.24"
```

## Updating Packages to Newer Versions

If you want to update a package to a newer version, you can use the `update` command. For example, to update the `requests` package to the latest version, you can run the following command:

```sh
poetry update requests
```

Poetry also allows you to specify multiple packages and versions in one command. For example,

```sh
poetry add requests==2.24.0 numpy==1.19.3 pandas==1.1.3
```

## Listing Installed Packages

You can also list the currently installed packages and their versions by running the following command:

```sh
poetry show
```

Poetry is a powerful package manager for Python that allows you to manage dependencies and versioning of packages easily. By using Poetry, you can easily specify the package version you want to use and update packages to newer versions as needed. This makes it easy to maintain and develop projects that have multiple dependencies and requirements and makes it easy to share your projects with others.
