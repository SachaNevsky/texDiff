%% 
%%  Ein Beispiel der DANTE-Edition
%%  
%%  1. Auflage
%% 
%%  Beispiel 15-02-13 auf Seite 743.
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
u := 1.25cm;
for i=0 upto 360:
  pair P;
  P = 1u*(sind(2*i), cosd(3*i));
  fill fullcircle scaled 2mm shifted P
    withcolor white;
  draw fullcircle scaled 2mm shifted P;
endfor;
endfig;
end;
