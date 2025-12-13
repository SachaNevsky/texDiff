# `latino-sine-flexione`

Package by Victor Leve granted into public domain

## Latin without inflexions

Latino sine Flexione (or Interlingua) is a language constructed by Giuseppe Peano at the
beginning of the last century. This simplified Latin is designed to be a instrument for
international cooperation, firstly in the academic sphere.

*Note:* Another Interlingua was created a few decades after Peano's work, the one related
to the `babel-interlingua' package.

## Package content

This package provides the necessary translations to use the language within a LaTeX
document. It also imports `fontenc` in order to be able to use ligatures and quotation
marks.

Finally, it offers a text in Interlingua that can be used as fake text: Fundamento de
intelligentia. This article by H. Bijlsma was first published in *Schola et Vita* Anno I
(1926).

## Basic use

```latex
\documentclass{article}
\usepackage{latino-sine-flexione}

\begin{document}
    \section{Verbos}
    Verbo <<ama>> de pr\ae{}fatione es mirabile.
    \input{fundamento}
\end{document}
```

* * *

## Updates

### v 1.2

* Correct translation errors
* Make the first line of all paragraphs be indented
