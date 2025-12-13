\usepackage {colortbl}
\newcommand{\panel}[1]{\multicolumn{1}
 {|>{\columncolor[cmyk]{.40,0,0,0}}r}{#1}}
\begin{tabular}{l|r|r}
\multicolumn{1}{l|}
   {\large\textbf{Table title}}\\[2mm]
\textbf{Description} & \textbf{Column 1}
             & \textbf{Column 2} \\[1mm]\hline
Row one  & \panel{mmmmm} & \panel{mmmm} \\\hline
Row two  &  \panel{mmmm} &  \panel{mmm} \\\hline
Row three& \panel{mmmmm} & \panel{mmmmm}\\\hline
Row four & \panel{mmmmm} & \panel{mmmm} \\\hline
Totals   & mmmmm & mmmmm
\end{tabular}
