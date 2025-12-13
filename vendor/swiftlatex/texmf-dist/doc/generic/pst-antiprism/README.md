Save the files pst-antiprism.sty|tex in a directory, which is part of your 
local TeX tree. pst-antiprism.pro should be saved in ../texmf/dvips/pstricks/
Then do not forget to run texhash to update this tree.
pst-antiprism needs pst-solides3d and pstricks, which should be part of your
local TeX installation, otherwise get it from a CTAN server
http://mirror.CTAN.org


Save the files

pst-antiprism.sty 
pst-antiprism.tex
pst-antiprism.pro

in any place, where latex or any other TeX program will find it.
Do not forget to update your database, when installing this
package the first time.

If you like to get the documentation file in another format run 

latex pst-antiprism-doc.tex
biber pst-antiprism.doc
latex pst-antiprism-doc.tex
dvips pst-antiprism-doc.dvi

to get a PostScript file. But pay attention, that the pst-antiprism
files are saved in the above mentioned way, before you run
latex on the documentation file.

%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN archives
%% in directory CTAN:/macros/latex/base/lppl.txt.

$Id: README.md 730 2018-02-13 17:50:37Z herbert $
