# textualicomma
Use the textual comma character as decimal separator in math mode.  

**`textualicomma` is based on the [`icomma`](https://ctan.org/pkg/icomma) package and intended as a solution for situations where the text comma character discerns from the math comma character**, e. g. when fonts whithout math support are involved.  
Escaping to text mode every time a comma is used in math mode might slow down the compilation of huge documents.  
Please check, whether [`icomma`](https://ctan.org/pkg/icomma) already satisfies your needs.  



### Installation
Extract the *package* file first:

  1. Run LaTeX over the file `textualicomma.ins`
  2. Move the resulting `.sty` file to `TEXMF/tex/latex/textualicomma/`

Then, you can compile the *documentation* yourself by executing

    lualatex textualicomma-doc.dtx
    makeindex -s gind.ist textualicomma-doc.idx
    makeindex -s gglo.ist -o textualicomma-doc.gls textualicomma-doc.glo
    lualatex textualicomma-doc.dtx
    lualatex textualicomma-doc.dtx
    

or just use the precompiled documentation shipped with the source files.  
In both cases, copy the files `textualicomma-doc.pdf` and `README.md` to `TEXMF/doc/latex/textualicomma/`.



### License
This work, consisting of the files `textualicomma.dtx`, `textualicomma.ins`, `textualicomma-doc.dtx` and the derived file `textualicomma.sty`, is licensed under the LPPL, Version 1.3c (or, at your option, any later version)  
Current maintainer of the work is Sebastian Friedl.
