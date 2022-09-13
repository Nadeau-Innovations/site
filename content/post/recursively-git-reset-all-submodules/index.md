+++
title = "Recursively Git Reset All Submodules"
date = 2018-06-14T00:00:00
tags = ["bash", "command", "devops", "foreach", "reset", "", "state", "submodule"]
categories = []
aliases = ["/post/recursively-git-reset-all-submodules"]
+++


```bash
git submodule foreach --recursive git reset --hard
```

This command recursively resets all submodules in a git project.
This is especially useful for projects with submodules (and maybe even submodules within submodules) when you want to reset your working copy to a completely clean state.
