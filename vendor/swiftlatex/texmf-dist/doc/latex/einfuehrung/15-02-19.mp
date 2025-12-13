%% 
%%  Ein Beispiel der DANTE-Edition
%%  
%%  1. Auflage
%% 
%%  Beispiel 15-02-19 auf Seite 745.
%% 
%%  Copyright (C) 2011 Herbert Voss
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
u=1.75cm;  pair A,B,C,AA,BB,CC,H;
A=origin; B=(3u,0.25u); C=(1u,2u);
AA = whatever [B,C]
   = whatever[A,A+((C-B) rotated 90)];
BB = whatever [A,C]
   = whatever[B,B+((C-A) rotated 90)];
CC = whatever [A,B]
   = whatever[C,C+((B-A) rotated 90)];
H = whatever [A,AA] = whatever [B,BB];
draw A--B--C--cycle;
draw A--AA dashed evenly scaled 0.75;
draw B--BB dashed evenly scaled 0.75;
draw C--CC dashed evenly scaled 0.75;
draw H withpen pencircle scaled 4bp;
endfig;
end;
