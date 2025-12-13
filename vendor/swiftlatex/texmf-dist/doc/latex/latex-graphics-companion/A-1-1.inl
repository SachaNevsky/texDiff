
\setlength{\unitlength}{5mm}
\begin{picture}(10,10)
\put(2,2){\special{em:point 1}}
\put(5,3){\special{em:point 2}}
\put(7,5){\special{em:point 3}}
\put(4,7){\special{em:point 4}}
\put(1,4){\special{em:point 5}}
\special{em:linewidth 2pt}
{\color{blue}\special{em:line 1,2}\special{em:line 2,3}}
\special{em:line 3,4}  \special{em:line 4,5}
\special{em:line 5,1}
\color{yellow}\special{em:line 3,5,0.5pt}
\color{red}\special{em:line 4,2,3pt}
\end{picture}
