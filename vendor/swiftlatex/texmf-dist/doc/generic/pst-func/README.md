# pst-func: plotting special mathematical functions#

- psBezier
- Chebyshev polynomials
- psPolynomial (with derivations)
- psBernstein (with envelope option)
- psFourier
- psBessel
- psSi and pssi (integral sin)
- psCi and \psci (integral cosin)
- psIntegral
- psCumIntegral
- psConv
- psGauss
- psPoisson
- psBinomial
- psBinomialN
- psFDist for F-distribution
- psGammaDist
- psChiIIDist
- psTDist for Student's t-distribution
- psBetaDist for Beta distribution
- psWeibull for Weibull distribution 
- psLame (Lamé Curve - a superellipse)
- psThomae (popcorn function)
- psWeierstrass (original and modified)
- psplotImp (plotting implicit defined functions)
- psVolume (rotating f(x) around the x-axis)
- psPrintValue

%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN archives
%% in directory macros/latex/base/lppl.txt.

Save the files pst-func.sty|pro|tex in a directory, which is part of your 
local TeX tree. The pro file should go into $TEXMF/dvips/pstricks/
Then do not forget to run texhash to update this tree.

pst-func needs pst-plot (pstricks-add) and pstricks, which should 
be part of your local TeX installation, otherwise get it from a 
CTAN server, http://mirror.ctan.org

PSTricks is PostScript Tricks, the documentation cannot be run
with pdftex, use the sequence latex->dvips->ps2pdf or
pdflatex with package auto-pst-pdf or xelatex.

%% $Id: README 897 2014-03-21 08:06:41Z herbert $
