---
categories: []
date: "2019-02-10T15:07:03-05:00"
draft: false
image:
  aliases:
  - /post/profiling-python-code
  caption: ""
  focal_point: ""
tags:
- bash
- cprofile
- cumtime
- ncalls
- percall
- pyprof2calltree
- python
- snakeviz
- tottime
title: Profiling Python Code
---

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
