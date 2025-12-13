\usepackage {colortbl,hhline}
\definecolor{Blueb}{cmyk}{.40,0,0,0} \definecolor{Blued}{cmyk}{.80,0,0,0}
\arrayrulecolor{white}
\begin{tabular}{>{\columncolor{Blued}}l>{\columncolor{Blued}}r|%
                >{\columncolor{Blued}}r}
  \multicolumn{3}{>{\columncolor{Blueb}}l}{\large\textbf{Table title}}\\[2mm]
\rowcolor{white}
  \textbf{Description} & \textbf{Column 1} & \textbf{Column 2} \\[1mm]
\arrayrulecolor{black}
\rowcolor{Blueb}
  Row one   & mmmmm & mmmm \\\hhline{~--}  Row two  &  mmmm & mmm \\\hhline{~--}
  Row three & mmmmm & mmmmm\\\hhline{~--}  Row four & mmmmm & mmmm\\\hhline{~--}
\rowcolor{white} Totals   & mmmmm & mmmmm
\end{tabular}
