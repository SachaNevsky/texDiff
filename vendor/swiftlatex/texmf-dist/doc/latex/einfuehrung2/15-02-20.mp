%% 
%%  Ein Beispiel der DANTE-Edition
%%  
%%  2. Auflage
%% 
%%  Beispiel 15-02-20 auf Seite 723.
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
vardef zeichneWinkelhalbierende(expr A,B,C,S) =
  save AA; pair AA; (AA-A)=whatever*((A-C)
     rotated 1/2(angle(B-A)-angle(C-A)));
  AA=whatever[B,C];
  draw A--AA dashed evenly; S=AA;
enddef;
u:=2cm; pair A,AA,B,BB,C,CC,M,SS;
A=(0,1u); B=(3u,0.5u); C=(u,2.5u);
draw A--B--C--cycle;
zeichneWinkelhalbierende(A,B,C,AA);
zeichneWinkelhalbierende(B,C,A,BB);
zeichneWinkelhalbierende(C,A,B,CC);
M=whatever[A,AA]; M=whatever[B,BB];
SS=whatever[A,B]=whatever[M,M+((B-A) rotated 90)];
draw fullcircle scaled 2 length(SS-M)
  shifted M withpen pencircle scaled 2bp;
endfig;
end;
