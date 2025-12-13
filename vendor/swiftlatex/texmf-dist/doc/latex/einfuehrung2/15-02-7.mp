%% 
%%  Ein Beispiel der DANTE-Edition
%%  
%%  2. Auflage
%% 
%%  Beispiel 15-02-7 auf Seite 719.
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
draw (0,10mm){up} .. (1cm, 11mm) .. (2cm,10mm){down};
draw (0,0){up}   ... (1cm, 1mm) ... (2cm,0){down};
endfig;
end;
