\documentclass{ppex}
\nonstopmode

\pagestyle{empty}

\begin{document}
\ResetPreambleCommands
\ReadyForTheFray

.PS
cct_init

define(`loop',`[
  source(left_ elen_); llabel(,V,)
  resistor(up_ dimen_); llabel(,R,)
  inductor(right_ elen_); llabel(,L,)
  capacitor(down_ dimen_); llabel(,C,)
  ]')

for linewid = 0.5 to 1 by  *1.3 do { loop; move right }
.PE
\usebox{\graph}
\end{document}
