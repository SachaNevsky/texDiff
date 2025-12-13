%% 
%%  Ein Beispiel der DANTE-Edition
%%  
%%  2. Auflage
%% 
%%  Beispiel 15-02-14 auf Seite 721.
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
u := 1.25cm;
for i=0 step 0.5 until 360:
  pair P;
  farbe := i/360;
  P = 1u*(sind(3*i), cosd(2*i));
  fill fullcircle scaled 2mm shifted P
    withcolor white;
  draw fullcircle scaled 2mm shifted P
    withcolor
      if farbe>0.5: (2*(1-farbe)) [red, blue]
      else:    (1-2farbe) [blue, red]
      fi;
endfor;
endfig;
end;
