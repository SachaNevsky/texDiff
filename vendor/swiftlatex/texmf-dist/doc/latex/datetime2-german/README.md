# datetime2-german
German Language Module for `datetime2` Package  

Authors: Nicola L. C. Talbot (inactive), Sebastian Friedl  

Licence: LPPL 1.3c  

Required Packages: `datetime2`, `tracklang`  

This module is maintained.  
Current maintainer is Sebastian Friedl.  


## Installation

`latex datetime2-german.ins`

Move all `*.ldf` files to `TEXMF/tex/latex/datetime2-contrib/datetime2-german/`

Documentation:  

    lualatex datetime2-german-doc.dtx
    makeindex -s gind.ist datetime2-german-doc.idx
    makeindex -s gglo.ist -o datetime2-german-doc.gls datetime2-german-doc.glo
    lualatex datetime2-german-doc.dtx
    lualatex datetime2-german-doc.dtx

Move `datetime2-german-doc.pdf` and `README.md` to `TEXMF/doc/latex/datetime2-contrib/datetime2-german/`

This material is subject to the LaTeX Project Public License. See [http://www.latex-project.org/lppl.txt](http://www.latex-project.org/lppl.txt "Show the current version of the LPPL") or `LICENSE.txt` for the details of that license.
