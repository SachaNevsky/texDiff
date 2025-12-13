%% 
%%  Ein Beispiel der DANTE-Edition
%%  
%%  2. Auflage
%% 
%%  Beispiel 15-02-31 auf Seite 728.
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
draw fullcircle shifted (0.5,0.6) xscaled 8cm yscaled 3.5cm
  withpen pencircle scaled 5bp withcolor red;
special(
  " /Times-Roman findfont 150 scalefont setfont " &
  " 0 10 moveto (MPost) false charpath clip stroke gsave 150 70 translate " &
  " 2 4 600 {dup 0 moveto 0 exch 0 exch 0 360 arc stroke} for grestore ");
endfig;
end;
