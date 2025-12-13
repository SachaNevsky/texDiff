The rgltxdoc package
===========================

Copyright (C) 2018-2019 Richard Grewe

Released under the [LaTeX Project Public License](http://www.latex-project.org/lppl/) version 1.2 or later

## Purpose

This package combines several other packages and defines additional
macros and environments for the purpose of documenting LaTeX code.
The package mainly serves the purpose of combining the preferences
used in the author's package documentations. However, others can
use the package as well. Compatibility between versions cannot be
guaranteed, however.

## Availability

The `rgltxdoc` package is on [CTAN](http://www.ctan.org/pkg/rgltxdoc),
where you can also find the [documentation](http://mirrors.ctan.org/macros/latex/contrib/rgltxdoc/rgltxdoc.pdf),
as well as on [github](https://github.com/Ri-Ga/rgltxdoc).

## Manual Installation

The `rgltxdoc` package comes with (at least) the following files
* rgltxdoc.ins
* rgltxdoc.dtx
* README.md

and possibly also with
* Makefile
* rgltxdoc.pdf (generated from rgltxdoc.dtx)
* rgltxdoc.sty (generated from rgltxdoc.dtx)

To install the `rgltxdoc` package, you additionally need
* docstrip.tex

To build the package (`rgltxdoc.sty`), run one of the following
```
    latex rgltxdoc.ins
    make package (needs Makefile)
```

Put the resulting `rgltxdoc.sty` somewhere where LaTeX can find it.
Read the documentation of your LaTeX system to find out where this
might be.

## Building Documentation

To build the documentation of the `rgltxdoc` package,
you only need the `rgltxdoc' package itself (including its dependencies).

as well as
* pdflatex

To build the documentation (`rgltxdoc.pdf`), either run
```
    make docs
```
or the following sequence of commands
```
    pdflatex rgltxdoc.dtx
    makeindex -s gind.ist -o rgltxdoc.ind rgltxdoc.idx
    makeindex -s gglo.ist -o rgltxdoc.gls rgltxdoc.glo
    pdflatex rgltxdoc.dtx
    pdflatex rgltxdoc.dtx
```

Happy TeX'ing
