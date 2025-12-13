#!/bin/sh
#
# Ein Beispiel der DANTE-Edition
#
#
# Copyright (C) 2013 Herbert Voss
#
# It may be distributed and/or modified under the conditions
# of the LaTeX Project Public License, either version 1.3
# of this license or (at your option) any later version.
#
# See http://www.latex-project.org/lppl.txt for details.
#
%
cat <<End_Of_File > 02-01-3-type1.tex
\documentclass{article}
\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage{lmodern}
\begin{document}
Das ältere Mädchen wollte wie üblich
eine \textbf{Crème Brûlée} zum Frühstück,
aber nicht ganz so \textit{süß}. $\alpha$
\end{document}
End_Of_File
pdflatex 02-01-3-type1.tex > /dev/null

#
#CODEbegin
pdffonts 02-01-3-type1.pdf
#CODEend
