\usepackage {graphics,pspicture}
% Zero height rule of width of one quad
\newcommand{\IR}[1]{\rule{1em}{0pt}%
  \makebox[0cm][c]{\rotatebox{45}{\ #1}}}
\begin{tabular}{rrr}
\IR{Column 1} & \IR{Column 2}
              & \IR{Column 3} \\\hline
1& 2& 3 \\ 4& 5& 6 \\ 7& 8& 9 \\\hline
\end{tabular}
