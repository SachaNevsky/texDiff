%% 
%%  Ein Beispiel der DANTE-Edition
%%  
%%  2. Auflage
%% 
%%  Beispiel 15-02-28 auf Seite 726.
%% 
%%  Copyright (C) 2016 Herbert Voss
%% 
%%  It may be distributed and/or modified under the conditions
%%  of the LaTeX Project Public License, either version 1.3
%%  of this license or (at your option) any later version.
%% 
%%  See http://www.latex-project.org/lppl.txt for details.
%% 
%% 
%% ==== 
% Show page(s) 1
%% 
defaultfont:="ptmr8r";
warningcheck:=0;
% --- start of displayed preamble in the book ---

% --- end of displayed preamble in the book ---
% %
beginfig(1)
def compute_curve(suffix f)(expr xmin,xmax,xinc) =
  ( (xmin,f(xmin))
    for x=xmin+xinc step xinc until xmax: ..(x,f(x))
    endfor )
enddef;   vardef f(expr x)=x**2+1 enddef;
vardef g(expr x)=2.6-(x-1)**2 enddef; path p, q;
p:=compute_curve(f,-1,1.5,0.1) scaled 1cm;
q:=compute_curve(g,-0.5,2,0.1) scaled 1cm;
fill buildcycle(p,reverse q) withcolor red;
draw p withpen pencircle scaled 1bp;
draw q withpen pencircle scaled 1bp;
drawarrow (-1cm,0)--(2cm,0);label.rt("x",(2cm,0));
drawarrow (0,0)--(0,3cm);label.top("y",(0,3cm));
endfig;
end;
