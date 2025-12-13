%% 
%%  Ein Beispiel der DANTE-Edition
%%  
%%  2. Auflage
%% 
%%  Beispiel 15-02-27 auf Seite 726.
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
u=1cm; path a,b,c;
a=fullcircle scaled 2u shifted (0.5u,0);
b=a rotated (120); c=b rotated (120);
fill a withcolor blue; fill b withcolor red;
fill c withcolor green;
fill buildcycle(b,c) withcolor red+green;
fill buildcycle(c,a) withcolor green+blue;
fill buildcycle(a,b) withcolor blue+red;
fill buildcycle(a,b,c) withcolor white;
draw a; draw b; draw c;
endfig;
end;
