---
aliases:
- /post/stop-latex-floats-and-figures-from-appearing-in-references-section
categories: []
date: 2018-06-25T22:13:30
summary: ' '
tags:
- document
- figure
- phd
- placein
- printbibliography
- refernces
- ""
- usepackage
title: Stop LaTeX Floats and Figures from Appearing in References Section
---


```latex
% \FloatBarrier for stopping floats in REFERNCES section
\usepackage{placeins}

...
...
...

\FloatBarrier
\printbibliography
\end{document}
```
