# pst-lsystem: creating images defined by a L-system:
A L-system or Lindenmayer system is a parallel rewriting system and a type of 
formal grammar. An L-system consists of an alphabet of symbols that can be used 
to make strings, a collection of production rules that expand each symbol into 
some larger string of symbols, an initial »axiom« string from which to begin construction, 
and a mechanism for translating the generated strings into geometric structures. 

Save the files pst-lsystem.sty|pro|tex in a directory, which is part of your 
local TeX tree. The pro file should go into $TEXMF/dvips/pstricks/
Then do not forget to run texhash to update this tree.

pst-lsystem needs pstricks, which should 
be part of your local TeX installation, otherwise get it from a 
CTAN server, http://mirror.ctan.org

PSTricks is PostScript Tricks, the documentation cannot be run
with pdftex, use the sequence latex->dvips->ps2pdf or
pdflatex with package auto-pst-pdf or xelatex.

%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN archives
%% in directory macros/latex/base/lppl.txt.


%% $Id: README.md 819 2018-09-26 06:40:48Z herbert $
