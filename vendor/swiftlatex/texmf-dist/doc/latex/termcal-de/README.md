# termcal-de
This package rovides a German localisation to the `termcal` LaTeX package written by Bill Mitchell  

**Required Packages:**   
`termcal`, `pgfkeys`, `pgfopts`, `datetime2` and `datetime2-german`

**Licence:**   
LPPL 1.3c or any later version (available at [http://www.latex-project.org/lppl.txt](http://www.latex-project.org/lppl.txt "Show the current version of the LPPL"))   

This package is maintained.  
Current maintainer is Sebastian Friedl.


## Installation

Extract *package* files:

    latex termcal-de.ins

Move the resulting `.sty` file to `TEXMF/tex/latex/termcal-de/`

Then, you can compile the *documentation* yourself by executing

    lualatex termcal-de-doc.dtx
    makeindex -s gind.ist termcal-de-doc.idx
    makeindex -s gglo.ist -o termcal-de-doc.gls termcal-de-doc.glo
    lualatex termcal-de-doc.dtx
    lualatex termcal-de-doc.dtx
    
or just use the precompiled documentation shipped with the source files.
In both cases, copy the files `termcal-de-doc.pdf` and `README.md` to
`TEXMF/doc/latex/termcal-de/`
