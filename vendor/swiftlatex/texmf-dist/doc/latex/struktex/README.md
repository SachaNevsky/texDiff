StrukTeX - Drawing of Nassi-Shneidermann Structured Box Charts
==============================================================

The LaTeX package `StrukTeX` provides macros for the generation of
Nassi-Shneidermann structured box charts.

The package consists of six files:
* `README.md`            - this file
* `LIESMICH.dm`          - this file in an german version
* `struktex.dtx`         - the source code of the package with
                           an integrated bilingual documentation
* `struktex.ins`         - the installation script


Installation
------------

With
    tex struktex.ins
several additional files are created:

* `struktex.sty`         - the actual package
* `struktex.el`          - a style file for use with AUCTeX

* `strukdoc.sty`        \
* `struktxf.sty`        |
* `struktxp.sty`        |
* `struktex-test-0.nss` |- Files for formatting the
* `struktex-test-1.tex` |  documentation
* `struktex-test-2.tex` |
* `struktex-test-3.tex` |
* `struktex-test-4.tex` /

* `struktex.makemake`    - script for creating a `Makefile` file
                           from the file
* `struktex.mk`

With
    pdflatex "\def\primarylanguage{english}\input{struktex.dtx}"
    makeindex -s gind.ist struktex.idx
    pdflatex "\def\primarylanguage{english}\input{struktex.dtx}"
    pdflatex "\def\primarylanguage{english}\input{struktex.dtx}"
the formatted English-language documentation is generated.

Finally, the files `struktex.sty`, `struktxf.sty`, `struktxp.sty`,
`struktex.el` (emacs-AUCTeX-support) as well as
`struktex.pdf` have to be copied into the usual directories.

For the formatting of the documentation, besides the mentioned files
the following packages are required:
 * `color`
 * `hyperref`
 * `ifthen`
 * `nameref`
 * `pict2e` (empfohlen) oder `curves` oder `emlines`
 * `url`

Further information can be found in the documentation.

I take notes for mistakes as well as suggestions for the further
Development gladly under j.hoffmann | at | fh-aachen.de.

This material issubject to the LaTeX Project Public License.
See http://www.ctan.org/tex-archive/help/Catalogue/licenses.lppl.html
To details of this license.
