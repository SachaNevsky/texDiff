\usepackage {pstcol}
\definecolor{pink}{rgb}{1, .75, .8}
\begin{pspicture}(-3,-2.2)(3,2.2)
\psset{linestyle=none}
\newcommand{\curly}[1]{{\fontfamily{pzc}%
 \fontsize{17}{17}\itshape#1}}
\pstextpath[c]{\psarcn(0,0){2}{180}{0}}
 {\curly{The Unseen University}}
\pstextpath[c]{\psarc(0,0){2}{180}{0}}
 {\curly{Ankh-Morpork,Discworld}}
\pscircle[fillstyle=gradient,
 gradangle=45,gradbegin=pink,
 gradend=yellow](0,0){1.7}
\rput[B](0,0){{\Large\itshape\bfseries
 Rincewind, Arch Chancellor}}
\end{pspicture}
