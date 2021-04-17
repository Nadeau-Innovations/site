+++
title = "Stop LaTeX Floats and Figures from Appearing in References Section"
date = 2018-06-25T22:13:30
tags = ["document", "figure", "phd", "placein", "printbibliography", "refernces", "", "usepackage"]
categories = []
summary = " "
aliases = ["/post/stop-latex-floats-and-figures-from-appearing-in-references-section"]
+++


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
