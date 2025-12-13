\documentclass{ppex}
\nonstopmode

\pagestyle{empty}
\setlength\textwidth{111.0pt}
\begin{document}
\ResetPreambleCommands
\ReadyForTheFray

.PS
cct_init
linethick=1.6
define(`dimen_',0.6)
loopwid = 0.9; loopht = 0.7
  source(left_ loopwid,AC); llabel(,V_{ac},)
  resistor(up_ loopht,5); llabel(,R,)
  inductor(right_ loopwid,W); rlabel(,L,); llabel(,iL\omega,)
  capacitor(down_ loopht,); llabel(,C,)
                    rlabel(,\displaystyle\frac{1}{iC\omega},)
.PE
\usebox{\graph}
\end{document}
