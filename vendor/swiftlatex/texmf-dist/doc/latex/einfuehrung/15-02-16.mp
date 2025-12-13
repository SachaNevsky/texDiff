%% 
%%  Ein Beispiel der DANTE-Edition
%%  
%%  1. Auflage
%% 
%%  Beispiel 15-02-16 auf Seite 744.
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
u=1cm; pair A,B,C,D;
A=(0,0); B=(0,1u); C=(1u,0); D=(1u,1u);
draw A..B..C..D withcolor red
  withpen pencircle scaled 2pt;
draw A{curl 1}..B..C..{curl 1}D dashed evenly;
draw A{curl 2}..B..C..{curl 2}D
  dashed dashpattern(on 3mm off 3mm);
draw A{curl 4}..B..C..{curl 4}D
  dashed dashpattern(on 5mm off 2mm);
endfig;
end;
