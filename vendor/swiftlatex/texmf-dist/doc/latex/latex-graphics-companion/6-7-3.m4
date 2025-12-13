\documentclass{ppex}
\nonstopmode

\pagestyle{empty}
\setlength\textwidth{111.0pt}
\begin{document}
\ResetPreambleCommands
\ReadyForTheFray

.PS
cct_init

gridsize = 0.1
define(`grid',`(gridsize*`$1',gridsize*`$2')')

  source(left_ from grid(7,0) to grid(0,0),V); llabel(,V,)
  resistor(up_ from grid(0,0) to grid(0,5),4); llabel(,R,)
  inductor(right_ from grid(0,5) to grid(7,5),W); llabel(,L,)
  capacitor(down_ from grid(7,5) to grid(7,0)); llabel(,C,)
.PE
\usebox{\graph}
\end{document}
