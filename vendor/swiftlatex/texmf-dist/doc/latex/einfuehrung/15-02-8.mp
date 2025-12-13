%% 
%%  Ein Beispiel der DANTE-Edition
%%  
%%  1. Auflage
%% 
%%  Beispiel 15-02-8 auf Seite 741.
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
pair A, B, C;
A:=(0,0); B:=(2cm,0); C:=(0,2cm);
draw A--B--C--cycle;
draw 1/2[A,B]--C;
draw 1/2[B,C]--A;
draw 1/2[C,A]--B;
draw 1/3 A + 1/3 B + 1/3 C
  withpen pencircle scaled 4bp;
endfig;
end;
