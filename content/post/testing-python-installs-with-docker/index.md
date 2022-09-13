+++
title = "Testing Python Packages with Docker"
date = 2018-07-30T20:42:57
tags = ["bash", "container", "deployment", "development", "devops", "docker", "environment", "first", "management", "method", "packages", "pwd", "python", ""]
categories = []
aliases = ["/post/testing-python-installs-with-docker"]
+++


Package management is hard.
Sometimes in Python package development, your local (development) environment may behave a little differently than a deployment target.
Below is a simple method I use to replicate a clean environment and test Python package installs and tests.

<!--more-->

```bash
docker run -v `pwd`:`pwd` -w `pwd` python pip install .
docker run -v `pwd`:`pwd` -w `pwd` python python setup.py install
docker run -v `pwd`:`pwd` -w `pwd` python python setup.py test
```

First, we bind the current directory to our container (`-v`) and switch our working directory (`-w`).
Second, we run our commands.
