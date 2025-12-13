
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
verbatimtex
\documentclass{article}
\usepackage{times,amsmath}
\begin{document}
etex;
picture p; path q;
p:=thelabel(btex \Large
\begin{minipage}{4in}
\begin{gather}
\iint\limits_A f(x,y)\,dx\,dy\qquad
\iiint\limits_A f(x,y,z)\,dx\,dy\,dz\\
\iiiint\limits_A f(w,x,y,z)\,dw\,dx\,dy\,dz
\qquad\idotsint\limits_A f(x_1,\dots,x_k)
\end{gather}
\end{minipage}
etex,(0,0));
q:=fullcircle scaled 2.5in;
fill q withcolor black;
clip p to q;
draw p rotated (90) withcolor white;
endfig;
end;
