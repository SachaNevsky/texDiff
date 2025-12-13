Basque Language Module for datetime2 Package
Version: 1.2a

Authors: Nicola L. C. Talbot (inactive)
         Zunbeltz Izaola
	 
Licence: LPPL

Required Packages: datetime2, tracklang

This module is maintained by Zunbeltz Izaola.
If you find any bug or you have any suggestion contact to zunbeltz@gmail.com

Example usage:

\documentclass{article}
\usepackage[basque]{datetime2}
\begin{document}
\today
\end{document}

\documentclass[basque]{article}
\usepackage{babel}
\usepackage[useregional]{datetime2}
\begin{document}
\today
\end{document}

\documentclass{article}
\usepackage{polyglossia}
\setmainlanguage{basque}
\usepackage[basque]{datetime2}
\begin{document}
\today
\end{document}

INSTALLATION
============

latex datetime2-basque.ins

Move all *.ldf files to
TEXMF/tex/latex/datetime2-contrib/datetime2-basque/

Documentation:

pdflatex datetime2-basque.dtx
makeindex -s gind.ist datetime2-basque.idx
makeindex -s gglo.ist -o datetime2-basque.gls datetime2-basque.glo
pdflatex datetime2-basque.dtx
pdflatex datetime2-basque.dtx

Move datetime2-basque.pdf and README to
TEXMF/doc/latex/datetime2-contrib/datetime2-basque/

This material is subject to the LaTeX Project Public License.
See http://www.ctan.org/license/lppl1.3 for the details of that
license.

