\usepackage {colortbl}
\definecolor{Blueb}{cmyk}{.40,0,0,0}
\definecolor{Blued}{cmyk}{.80,0,0,0}
\definecolor{Bluee}{cmyk}{1.0,0,0,0}
\arrayrulecolor{black}
\setlength\arrayrulewidth{1mm}
\begin{tabular}{llrrl}
\rowcolor{Blueb}
 \qquad&\multicolumn{3}{>{\columncolor{Blueb}}l}
       {\large\textbf{Table title}}&\qquad\\[2mm]
 \rowcolor{Blued}& \textbf{Description}
                 & \textbf{Column 1}
                 & \textbf{Column 2}& \\[2mm]
\hline
 \rowcolor{Blued}& Row one  & mmmmm & mmmm &\\
 \rowcolor{Blued}& Row two  &  mmmm & mmm  &\\
 \rowcolor{Blued}& Row three& mmmmm & mmmmm&\\
 \rowcolor{Blued}& Row four & mmmmm & mmmm &\\
\cline{2-3}
 \rowcolor{Bluee}& Totals & mmmmm & mmmmm&\\[2mm]
\end{tabular}
