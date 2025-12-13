\documentclass{ppex}
\nonstopmode

\pagestyle{empty}
\setlength\textwidth{135.0pt}
\begin{document}
\ResetPreambleCommands
\ReadyForTheFray

.PS
cct_init
define(`dimen_',0.6)
loopwid = 0.9; loopht = 0.7
  source(left_ loopwid); llabel(-,v_s,+)
  resistor(up_ loopht); llabel(,R,); b_current(i)
  inductor(right_ loopwid,L); rlabel(,L,)
  capacitor(down_ loopht,C); llabel(+,v_C,-); rlabel(,C,)
.PE
\usebox{\graph}
\end{document}
