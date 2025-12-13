%% 
%%  Ein Beispiel der DANTE-Edition
%%  
%%  2. Auflage
%% 
%%  Beispiel 15-02-10 auf Seite 720.
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
draw (0,0){(0,1)}..(3cm,0){(1,0)};
draw (0,20){dir 90}..(3cm,20){dir 0};
drawarrow (0,40){up}..(3cm,40){right};
draw (0,60){up}..(3cm,60){up};
draw (0,90){up}..(3cm,90){up}..cycle;
endfig;
end;
