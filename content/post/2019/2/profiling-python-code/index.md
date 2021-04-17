+++
title = "Profiling Python Code"
date = 2019-02-10T15:07:03-05:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["bash", "cprofile", "cumtime", "ncalls", "percall", "pyprof2calltree", "python", "snakeviz", "tottime"]
categories = []

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
[image]
  # Caption (optional)
  caption = ""

  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = ""
aliases = ["/post/profiling-python-code"]
+++

Figure out the bottlenecks in your Python scripts.

<!--more-->

## Run Your Code with `cProfile`

```bash
python -m cProfile -o my_output.cprof my_script.py
```

## Visualize Your Code's Execution

```bash
# visualize with pyprof2calltree
pip install pyprof2calltree
pyprof2calltree -k -i my_output.cprof

# visualize with pyprof2calltree
pip install snakeviz
snakeviz my_output.cprof
```

- `ncalls`: number of calls,
- `tottime`: total time spent in the given function (excluding time made in calls to sub-functions)
- `percall`: quotient of tottime divided by ncalls
- `cumtime`: total time spent in this and all subfunctions
- `percall`: quotient of cumtime divided by primitive calls
