%% 
%%  Ein Beispiel der DANTE-Edition
%%  
%%  2. Auflage
%% 
%%  Beispiel 15-02-22 auf Seite 724.
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
u:=3cm;  pair A,B,C,D;
A=(0,0); B=(u,0); C=(u,u); D=(0,u);
transform T;
A transformed T = 1/6[A,B];
B transformed T = 1/6[B,C];
C transformed T = 1/6[C,D];
path p; p = A--B--C--D--cycle;
for i=0 upto 150:
  draw p; p:= p transformed T;
endfor;
endfig;
end;
