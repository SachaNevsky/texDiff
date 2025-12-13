%% 
%%  Ein Beispiel der DANTE-Edition
%%  
%%  2. Auflage
%% 
%%  Beispiel 15-02-9 auf Seite 720.
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
draw origin--(3cm,0) dashed evenly;
drawarrow (0,15)--(3cm,15) dashed withdots
  withpen pencircle scaled 3bp
  withcolor red;
draw (0,30)--(3cm,30) dashed evenly scaled 2;
drawdblarrow (0,45)--(3cm,45) dashed
  dashpattern(on 2bp off 3bp);
draw (0,60)--(3cm,60) dashed
  dashpattern(on 6bp off 5bp on 10bp off 4bp);
endfig;
end;
