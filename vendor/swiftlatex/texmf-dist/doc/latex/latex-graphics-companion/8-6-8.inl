\input {bridge.tex}
\newcommand\bid[5]{\hand{#1}{#2}{#3}{#4}%
          \qquad   \begin{tabular}[t]{ll}%
                     self & partner \\ #5%
                   \end{tabular}}
\bid{Q J 10 5}{A 10 9 6 3}{A 5 2}{3}
 { & 1\club \\ 1\heart & 1\spade \\
   4\spade }
