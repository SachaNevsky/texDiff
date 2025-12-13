The pst-rputover package Authors: Martin J. Osborne, Thomas Söll

`pst-rputover' is a PSTricks package that allows you to place text over objects without obscuring background colors
Based partially on the answer of Werner at
http://tex.stackexchange.com/questions/353748/is-there-a-variant-of-rput-in-pstricks-that-preserves-background-fill-colors

Dated: 2017/06/29 Version 1.0

pst-rputover contains the following:

1) pst-rputover.sty
2) pst-rputover.tex

- rputover
- coverable
- pclineover
- pcarrowC

Save the files pst-rputover.sty|tex in a directory, which is part of your 
local TeX tree.
Then do not forget to run texhash to update this tree.
For more information  see the documentation of your LATEX distribution 
on installing packages into your local TeX system or read the 
TeX Frequently Asked Questions:
(http://www.tex.ac.uk/cgi-bin/texfaq2html?label=instpackages).

pst-rputover needs pst-node, pstricks-xkey and pstricks, which should 
be part of your local TeX installation, otherwise get it from a 
CTAN server, http://mirror.ctan.org

PSTricks is PostScript Tricks, the documentation cannot be run
with pdftex, use the sequence latex->dvips->ps2pdf or latex->dvips->distiller.

T. Söll
