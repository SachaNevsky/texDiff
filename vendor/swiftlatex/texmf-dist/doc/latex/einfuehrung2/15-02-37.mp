%% 
%%  Ein Beispiel der DANTE-Edition
%%  
%%  2. Auflage
%% 
%%  Beispiel 15-02-37 auf Seite 730.
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
input boxes;
% --- end of displayed preamble in the book ---
% %
beginfig(1)
def linkboxes(suffix a,b)=drawarrow a.c--b.c
   cutbefore bpath.a cutafter bpath.b; enddef;
defaultfont:="phvro8y"; defaultscale:=3;
forsuffixes a=A,B,C,D,E: boxit.a(str a); endfor;
i := 0;
forsuffixes a=D,E,A,B,C:
  a.c = 2cm*up rotated (i*72);
  i := i+1; drawunboxed(a);
endfor;
linkboxes(A,B);linkboxes(B,C);linkboxes(C,D);
linkboxes(D,E);linkboxes(E,A);
endfig;
end;
