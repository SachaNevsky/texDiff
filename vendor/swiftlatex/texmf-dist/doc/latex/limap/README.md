
# _limap_: A package for typesetting Information Maps

The Information Mapping® method provides a methodology for structuring
and presenting information. It claims to be useful for readers who are
more concerned about finding the right information than reading the
document as a whole. Thus short, highly structured, and context free
pieces of information are used.

_limap_ provides a LaTeX style and a LaTeX class. The style contains
definitions to typeset maps and blocks according to the Information
Mapping® method. The class provides all definitions to typeset a whole
document.


## Samples

A few sample files are provided which contain dummy documents typeset
with limap. They are contained in the sub-directory _samples_. You can
have a look at the documentation of _limap_ itself to see another
example.


## Installation

Most probably _limap_ is already included in your TeX distribution.
Thus consult the documentation of your TeX distribution first to
install or update this package.

You can install the package manually. Apply the following steps:

- Run LaTeX on `limap.ins`

```
    latex limap.ins
```

- Move the files `limap.cls` and `limap.sty` into a directory read by
  LaTeX.

- Run LaTeX and makeindex on `limap.dtx` to produce the documentation

```
    latex limap.dtx
    makeindex -s gind.ist limap
    makeindex -s gglo.ist -o limap.gls limap.glo
    latex limap.dtx
```


## CTAN Download

_limap_ can be obtained from the CTAN archives:

* https://www.ctan.org/tex-archive/macros/latex/contrib/gene/limap

or via the _limap_ home page

* http://www.gerd-neugebauer.de/software/TeX/limap

or via the source repository at Sourceforge for the most recent
development version

* https://sourceforge.net/p/gene-tex-lib/svn/HEAD/tree/limap


## Licenses

The sources and derived files of limap are distributed under the LaTeX
Project Public License version 1.3c.

The samples in the directory _samples_ are in the Public Domian
 (Creative Commons CC0 1.0 Universal))

The documentation is distributed under the Creative Commons
Attributation-Share Alike 4.0 License (CC BY-SA 4.0). 

----------------------------------------------------------------------
Enjoy it!

[Gerd Neugebauer](mailto:gene@gerd-neugebauer.de)

