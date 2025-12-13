%% 
%%  Ein Beispiel der DANTE-Edition
%%  
%%  2. Auflage
%% 
%%  Beispiel 15-02-11 auf Seite 720.
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
u:=1cm;
pair A,AA,B,BB,C,D;
A  :=(  0.2u, 0.05u); AA :=(0.2u,-0.05u);
B  :=(     u, 0.05u); BB :=(   u,-0.05u);
C  :=(-0.02u, 0);     D  :=(    -u, 0);
path p;
p:= B{up}..D{down}..BB{up}--AA{down}..
    C{up}..A{down}--cycle;
fill p withcolor 0.6*white;
draw p withpen pencircle scaled 1.5bp
  withcolor 0.5*red;
endfig;
end;
