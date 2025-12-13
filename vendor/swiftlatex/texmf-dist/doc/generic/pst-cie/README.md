# CIE color space #

Save the files pst-cie.sty|tex|pro in a directory, which is part of your 
local TeX tree. The pro file should go into $TEXMF/dvips/pstricks/
Then do not forget to run texhash to update this tree.
For more information  see the documentation of your LATEX distribution 
on installing packages into your local TeX system or read the 
TeX Frequently Asked Questions:
(http://www.tex.ac.uk/cgi-bin/texfaq2html?label=instpackages).

PSTricks is PostScript Tricks, the documentation cannot be run
with pdftex, use the sequence latex->dvips->ps2pdf or xelatex.

pst-cie is a PSTricks related package to show the different
CIE color spaces: 

- Adobe, 
- CIE, 
- ColorMatch, 
- NTSC, 
- Pal-Secam,
- ProPhoto, 
- SMPTE, and 
- sRGB.
