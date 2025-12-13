%% 
%%  Ein Beispiel der DANTE-Edition
%%  
%%  2. Auflage
%% 
%%  Beispiel 15-02-15 auf Seite 721.
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
u=2cm;
draw (0,u)         {right} ..tension 2 ..
     (u*dir -150){dir 120} ..tension 2 ..
     (u*dir -30 ){dir -120}..tension 2 ..
  cycle;
draw (0,u)         {right} ..tension 4 ..
     (u*dir -150){dir 120} ..tension 4 ..
     (u*dir -30 ){dir -120}..tension 4 ..
  cycle dashed evenly withcolor blue;
endfig;
end;
