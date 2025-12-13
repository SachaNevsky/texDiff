\usepackage {colortbl}
\newcommand\panel[1]{\multicolumn{1}%
             {>{\columncolor{magenta}}#1}}
\begin{tabular}{lrr}
  \large\textbf{Table title}\\[2mm]
  \textbf{Description}
          & \textbf{Column 1}
             & \textbf{Column 2}\\[1mm]
  Row one & mmmmm & mmmm \\
  Row two &  mmmm & mmm  \\
  \panel{l}{Row three}
          & \panel{r}{mmmmm}
             & \panel{r}{mmmmm} \\
  Row four& mmmmm & mmmm  \\ \cline{2-3}
  Totals  & mmmmm & mmmmm
\end{tabular}
