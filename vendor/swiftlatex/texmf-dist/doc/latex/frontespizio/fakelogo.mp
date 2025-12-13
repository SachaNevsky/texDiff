%%
%% This is file `fakelogo.mp',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% frontespizio.dtx  (with options: `fakelogo')
%% 
%%  Copyright 2008-2011 Enrico Gregorio
%% 
%%  This program is provided under the terms of the
%%  LaTeX Project Public License distributed from CTAN
%%  archives in directory macros/latex/base/lppl.txt.
%% 
%%  Author: Enrico Gregorio
%%          Enrico dot Gregorio at univr dot it
%% 
%%  This work has the LPPL maintenance status "author-maintained".
%% 

prologues:=3;
outputtemplate:="%j.mps";
input boxes;
beginfig(1);
draw fullcircle scaled (2.5cm + 1pt) withcolor white;
draw fullcircle scaled 2.5cm;
draw fullcircle scaled 2.3cm;
draw thelabel(btex \vbox{\sevenrm\halign{\hfil#\hfil\cr University of\cr
      St. Anford\cr Seal\cr}} etex, origin);
endfig;
end
\endinput
%%
%% End of file `fakelogo.mp'.
