%% 
%%  Ein Beispiel der DANTE-Edition
%%  
%%  1. Auflage
%% 
%%  Beispiel 15-02-30 auf Seite 750.
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
numeric n; n:=10;
path p;
p := for i=0 upto n-1:
  ((1cm+3mm*normaldeviate,0) rotated (i*360/n)) ..
endfor cycle;
for i=0 step 2mm until 3cm:
  draw fullcircle scaled i;
endfor;
clip currentpicture to p;
draw p;
endfig;
end;
