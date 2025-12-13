%% 
%%  Ein Beispiel der DANTE-Edition
%%  
%%  2. Auflage
%% 
%%  Beispiel 15-02-29 auf Seite 727.
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
u=8mm;
vardef project(expr x,y,z)=x*(-1,-1)+y*(1,0)+z*(0,1) enddef;
vardef f(expr x,y)=sind((x/u)**2 *180 +(y/u)**2 *180)*u/2 enddef;
numeric m,M,inc,farbe;
m:=-2u; M:=2u; inc:=.1u;
for i=m step inc until M:
 for j=m step inc until M:
  path p;
  p=project(i,j,f(i,j))--project(i,j+inc,f(i,j+inc))--
    project(i+inc,j+inc,f(i+inc,j+inc))--project(i+inc,j,f(i+inc,j))--cycle;
  dfdx := (f(i,j) - f(i+inc,j))/inc;  dfdy := (f(i,j) - f(i,j+inc))/inc;
  farbe := 1/sqrt( dfdx**2 + dfdy**2 + 1); fill p withcolor farbe*(red+green);
 endfor;
endfor;
endfig;
end;
