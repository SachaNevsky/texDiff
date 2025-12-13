# pdfpc-movie
This package provides a `\pdfpcmovie` command for hyperlinking movies in a way compatible to the PDF Presenter Console (pdfpc), a GPL2 licensed multi-monitor PDF presentation viewer application [available on GitHub](http://pdfpc.github.io).



### Dependencies
`pdfpc-movie` depends on these packages:  
[`etoolbox`](https://ctan.org/pkg/etoolbox), [`hyperref`](https://ctan.org/pkg/hyperref) and [`pgfkeys`](https://ctan.org/pkg/pgfkeys)


### Installation
Extract the *package* file first:

  1. Run LaTeX over the file `pdfpc-movie.ins`
  2. Move the resulting `.sty` file to `TEXMF/tex/latex/pdfpc-movie/`
    
Then, you can compile the *documentation* yourself by executing

    lualatex pdfpc-movie-doc.dtx
    makeindex -s gind.ist pdfpc-movie-doc.idx
    makeindex -s gglo.ist -o pdfpc-movie-doc.gls pdfpc-movie-doc.glo
    lualatex pdfpc-movie-doc.dtx
    lualatex pdfpc-movie-doc.dtx
    

or just use the precompiled documentation shipped with the source files.  
In both cases, copy the files `pdfpc-movie-doc.pdf` and `README.md` to `TEXMF/doc/latex/pdfpc-movie/`.



### License
LPPL 1.3c or any later version (available at [http://www.latex-project.org/lppl.txt](http://www.latex-project.org/lppl.txt "Show the current version of the LPPL"))

This package is *maintained*. Current maintainer is [Sebastian Friedl](mailto:sfr682k@t-online.de).


