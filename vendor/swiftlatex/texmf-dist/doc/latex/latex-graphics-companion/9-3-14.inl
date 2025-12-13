\usepackage {colortbl}
\definecolor{Bluea}{cmyk}{.20,0,0,0}
\definecolor{Blueb}{cmyk}{.40,0,0,0}
\definecolor{Bluec}{cmyk}{.60,0,0,0}
\definecolor{Blued}{cmyk}{.80,0,0,0}
\definecolor{Bluee}{cmyk}{1.0,0,0,0}
\begin{tabular}{>{\columncolor{Bluee}}l%
>{\columncolor{Bluee}}r>{\columncolor{Bluee}}r}
\multicolumn{3}{>{\columncolor{Bluee}}l}
    {\large\textbf{Table title}}\\[2mm]
\textbf{Description} & \textbf{Column 1}
             & \textbf{Column 2} \\[1mm]
\rowcolor{Bluea}Row one  & mmmmm & mmmm \\
\rowcolor{Blueb}Row two  &  mmmm &  mmm \\
\rowcolor{Bluec}Row three& mmmmm & mmmmm \\
\rowcolor{Blued}Row four & mmmmm & mmmm \\
\rowcolor{Bluee}Totals   & mmmmm & mmmmm
\end{tabular}
