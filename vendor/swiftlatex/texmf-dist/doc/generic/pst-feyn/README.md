# Package pst-feyn

pst-feyn is a set of drawing graphical elements which are used for Feynman diagrams. 
The package is based on the macros of the old package axodraw 
but uses the capabilities of PSTricks.

Save the files pst-feyn.sty|tex in a directory, which is part of your 
local TeX tree. pst-feyn.pro should be saved in ../texmf/dvips/pstricks/
Then do not forget to run texhash to update this tree.
pst-feyn needs pst-solides3d and pstricks, which should be part of your
local TeX installation, otherwise get it from a CTAN server
http://mirror.CTAN.org


Save the files

pst-feyn.sty 
pst-feyn.tex
pst-feyn.pro

in any place, where latex or any other TeX program will find it.
Do not forget to update your database, when installing this
package the first time.

If you like to get the documentation file in another format run 

latex pst-feyn-doc.tex
biber pst-feyn.doc
latex pst-feyn-doc.tex
dvips pst-feyn-doc.dvi
ps2pdf pst-feyn-doc.ps

or alteratively

xelatex pst-feyn-doc.tex
biber pst-feyn.doc
xelatex pst-feyn-doc.tex

to get a PDF file. 

%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN archives
%% in directory CTAN:/macros/latex/base/lppl.txt.

$Id: README.md 826 2018-09-27 09:21:43Z herbert $
