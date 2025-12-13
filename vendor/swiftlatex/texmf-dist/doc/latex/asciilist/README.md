The asciilist Package
=====================

Copyright (C) 2014-2018 Richard Grewe

Released under the [LaTeX Project Public License](http://www.latex-project.org/lppl/) version 1.2 or later

## Purpose

This package provides the environments `AsciiList` and `AsciiDocList`,
which enable quickly typesetting nested lists in LaTeX without having to
type individual item macros or opening/closing list environments.
The package provides auxiliary functionality for loading such lists from
files and provides macros for configuring the use of the list
environments and the appearance of the typeset results.

## Availability

The `asciilist` package is on [CTAN](http://www.ctan.org/pkg/asciilist),
where you can also find the [documentation](http://mirrors.ctan.org/macros/latex/contrib/asciilist/asciilist.pdf),
as well as on [github](https://github.com/Ri-Ga/asciilist).
Since November 2015, `asciilist` is part of TeX Live (package `texlive-latex-extra`) and
is included in [MiKTeX](http://miktex.org/packages/asciilist).

## Manual Installation

The `asciilist` package comes with (at least) the following files
* asciilist.ins
* asciilist.dtx
* README.md

and possibly also with
* Makefile
* asciilist.pdf (generated from asciilist.dtx)
* asciilist.sty (generated from asciilist.dtx)

To install the `asciilist` package, you additionally need
* docstrip.tex

To build the package (`asciilist.sty`), run one of the following
```
    latex asciilist.ins
    make package (needs Makefile)
```

Put the resulting `asciilist.sty` somewhere where LaTeX can find it.
Read the documentation of your LaTeX system to find out where this
might be.

## Building Documentation

To build the documentation of the `asciilist` package, you additionally
need
* ltxdoc.cls
* idxlayout.sty
* xcolor.sty
* showexpl.sty
* paralist.sty
* trimspaces.sty
* etoolbox.sty
* hypdoc.sty
* makeindex
* pdflatex

To build the documentation (`asciilist.pdf`), either run
```
    make docs
```
or the following sequence of commands
```
    pdflatex asciilist.dtx
    makeindex -s gind.ist -o asciilist.ind asciilist.idx
    makeindex -s gglo.ist -o asciilist.gls asciilist.glo
    pdflatex asciilist.dtx
    pdflatex asciilist.dtx
```

Happy TeX'ing
