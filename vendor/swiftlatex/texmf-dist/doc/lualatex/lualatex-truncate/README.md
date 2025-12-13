# lualatex-truncate
This package provides a wrapper for the [`truncate` package](https://ctan.org/pkg/truncate) package,
which fixes issues related to LuaTeX's hyphenation algorithm.


### Dependencies
`lualatex-truncate` depends on these packages:  
`iftex`, `letltxmacro` and `truncate`


### Installation
Extract the *package* file first:

  1. Run LaTeX over the file `lualatex-truncate.ins`
  2. Move the resulting `.sty` file to `TEXMF/tex/lualatex/lualatex-truncate/`
    
Then, you can compile the *documentation* yourself by executing

    lualatex lualatex-truncate-doc.dtx
    makeindex -s gind.ist lualatex-truncate-doc.idx
    makeindex -s gglo.ist -o lualatex-truncate-doc.gls lualatex-truncate-doc.glo
    lualatex lualatex-truncate-doc.dtx
    lualatex lualatex-truncate-doc.dtx
    

or just use the precompiled documentation shipped with the source files.  
In both cases, copy the files `lualatex-truncate-doc.pdf` and `README.md` to `TEXMF/doc/lualatex/lualatex-truncate/`.



### License
LPPL 1.3c or any later version (available at [http://www.latex-project.org/lppl.txt](http://www.latex-project.org/lppl.txt "Show the current version of the LPPL"))

This package is *maintained*. Current maintainer is [Sebastian Friedl](mailto:sfr682k@t-online.de).


