+++
title = "Great Looking LaTeX Tables"
date = 2018-06-25T22:13:30
tags = ["data", "document", "midrule", "numbers", "precision", "resizebox", "tables", "toprule", "usepackage"]
categories = []
aliases = ["/post/great-looking-latex-tables"]
+++

- No colour
- No vertical gridlines
- No fills
- No borders
- No bolding
- Left align text
- Right align numbers
- Align titles with data
- Resize columns to data
- Use consistent precision

<!--more-->

```latex
\documentclass{article}

% \toprule, \midrule, \multicolumn
\usepackage{booktabs}

% unit formatting
\usepackage[per-mode=symbol]{siunitx}

\begin{document}
\begin{table}

% use consistent precision
\sisetup{round-mode=places,round-precision=2}

% center table in text
\centering

% make a good descriptive caption
\caption{My caption.}

% labels must come after captions
\label{table:my-table}

% resize boxes help fit tables inside 2-column formats
% \resizebox{\columnwidth}{!}{%

% text is left aligned
% numbers are right aligned
\begin{tabular}{lr}

\toprule
Text & Numbers \\
\midrule
first & \num{123.456} \\
second & \num{0.9876543} \\
third & \num{98765.4321} \\
\bottomrule
\end{tabular}

% close resizebox
% }

\end{table}
\end{document}
```
