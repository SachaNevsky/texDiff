%% 
%%  Ein Beispiel der DANTE-Edition
%%  
%%  1. Auflage
%% 
%%  Beispiel 15-02-24 auf Seite 747.
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
pickup pencircle
  scaled 0.2in yscaled 0.08 rotated 30;
u=4cm; path p; x0=x3=x4;
z1-z0=0.5in*dir 30; z2-z3=whatever*(z1-z0);
z6-z5=whatever*(z1-z0); z1-z6=1.2*(z3-z0);
rt x3=lft x2;x5=0.55[x4,x6]; y4=y6;
lft x3=bot y5=0; top y2=1in;
draw z0--z1--z2--z3--z4--z5--z6 withcolor .7white;
dotlabels.top(0,1,2,3,4,5,6);
p=(0,u)--(0,0)--(0,0.45u){up}..
  (0.15u,0.6u)..{down}(0.3u,0.45u)--(0.3u,0);
draw p shifted (0.5u,0.03u) withcolor 0.7white;
draw (1.1u,0);% der Originalstift!
endfig;
end;
