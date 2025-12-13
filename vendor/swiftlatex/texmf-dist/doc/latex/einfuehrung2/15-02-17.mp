%% 
%%  Ein Beispiel der DANTE-Edition
%%  
%%  2. Auflage
%% 
%%  Beispiel 15-02-17 auf Seite 722.
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
u:=2cm;
draw (0,0)..(u,u)..(2u,0) dashed withdots
	withpen pencircle scaled 1.5pt;
draw (0,0).. tension 1.5 ..(u,u)..(2u,0)
	dashed evenly;
draw (0,0)..tension 2..(u,u)..(2u,0);
pair A,B,C,D;
A:=(0,0);B:=(-0.5u,0.5u);C:=(2u,2u);D:=(1.5u,0);
draw A..controls B and C..D
	withpen pencircle scaled 3pt;
draw A--B--C--D dashed evenly;
draw B withpen pencircle scaled 4pt;
draw C withpen pencircle scaled 4pt;
endfig;
end;
