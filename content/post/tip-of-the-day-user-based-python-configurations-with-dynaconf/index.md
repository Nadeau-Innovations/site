---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Tip of the Day: User-based Settings Configuration for Python With Dynaconf"
subtitle: ""
summary: ""
authors: []
tags: ["app", "cli", "configuration", "dynaconf", "package", "python", "settings"]
categories: []
date: 2020-05-06T13:14:48-04:00
lastmod: 2020-05-06T13:14:48-04:00
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
aliases:
- /post/tip-of-the-day-user-based-python-configurations-with-dynaconf
---

Configurations vary substantially across deployments, but code does (should) not change.
An important approach to configuration management is to use config files.

[`dynaconf`](https://github.com/rochacbruno/dynaconf) is one of my favourite packages for achieving this in Python.
However, setting up user-based configurations (as opposed to app-based) can be a little tricky.
A typical example would be a CLI app that can be installed for multiple users or across different machines.

## Problem

As per [this GitHub issue](https://github.com/rochacbruno/dynaconf/issues/74), `dynaconf`, by default, loads settings based on the "present working directory" (`pwd`).
Thus, if you have a CLI app that's installed (e.g., `pip install mypackage` or `pip install -e .`), the settings will be properly loaded only if the CLI commands are run in the directory with with `dynaconf` settings files (e.g., `settings.toml`).
This does not bode well if we want to store our settings in a user's home directory (e.g., `~/.mypackage.toml`), similar to how `.zshrc`, `.bashrc`, and `.profile` are stored.

## Loading a User-config File

Given a typical Python package, e.g., `mypackage`:

```bash
.
├── mypackage
│   ├── __init__.py
│   ├── foo.py
│   ├── bar.py
├── README.md
├── requirements.txt
└── setup.py
```

We can set up the `__init__.py` file like so:

```python
from pathlib import Path

from dynaconf import LazySettings  # type: ignore

ENVVAR_PREFIX_FOR_DYNACONF = "MYPACKAGE"
ENV_SWITCHER_FOR_DYNACONF = f"{ENVVAR_PREFIX_FOR_DYNACONF}_ENV"
ENVVAR_FOR_DYNACONF = f"{ENVVAR_PREFIX_FOR_DYNACONF}_SETTINGS"
DYNACONF_SETTINGS_FILE = Path.home() / ".mypackage.toml"
settings = LazySettings(
    ENV_SWITCHER_FOR_DYNACONF=ENV_SWITCHER_FOR_DYNACONF,
    ENVVAR_FOR_DYNACONF=ENVVAR_FOR_DYNACONF,
    ENVVAR_PREFIX_FOR_DYNACONF=ENVVAR_PREFIX_FOR_DYNACONF,
    SETTINGS_FILE_FOR_DYNACONF=DYNACONF_SETTINGS_FILE,
)
```

Then, in `foo.py` and `bar.py`, we can load settings like so:

```python
from mypackage import settings

# settings work like typical dynaconf settings, e.g.:
user = settings.USERNAME
email = settings.EMAIL
password = settings.PASSWORD
```

Using this example, the settings are actually loaded from `~/.mypackage.toml`, allowing the user to define their settings as they see fit.
