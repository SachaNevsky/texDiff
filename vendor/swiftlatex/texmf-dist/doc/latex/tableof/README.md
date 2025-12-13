Abstract
========

- Package: tableof (Tables of tagged contents)
- Version: 1.4b (2018/10/02)
- License: LPPL 1.3c
- Copyright (C) 2012-2018 Jean-Francois Burnol <jfbu at free dot fr>

The commands `\toftagstart`, `\toftagstop`, `\toftagthis`, `\tofuntagthis`
are used to tag chapters, sections or any other sectioning units destined
to end up in the table(s) of contents. Then:

    \nexttocwithtags{req. 1, req. 2, ... }{excl. 1, excl. 2, ... }
    \tableofcontents % or equivalent command
	  
specifies which tags are to be required and which ones are to be
excluded from the typeset TOC.

For documents with classes where `\tableofcontents` is only single-use,
the package provides:

    \tableoftaggedcontents{req. 1, req. 2, ... }{excl. 1, excl. 2, ... }

which does not have this restriction.


Installation
============

For extracting the style file:

    latex tableof.dtx

Files `tableof.sty`, `tableof.ins` and `tableoftest.tex` are generated on
the first latex run. Move `tableof.sty` to a suitable location within the
TeX installation:

    tableof.sty -> <TDS>/tex/latex/tableof/

To produce the documentation:

    latex tableof.dtx (a second time)
    dvipdfmx tableof.dvi

`tableof.ins` is for TeX distributions expecting it.

`tableoftest.tex` is an example of use of the package commands. Run
latex twice on it to see examples of tagged tables of contents.


Change History
==============

* v1.4b (2018/10/02) fix to bug when a document ended with `\clearpage`
  before the `\end{document}`. `tableof` now requires `atveryend` package.

* v1.4a (2015/03/10) changes for enhanced compatibility with `etoc`.

* v1.4  (2015/02/20) under the hood code improvements.

* v1.3  (2015/02/11) comma separated lists of tags now allow spaces.

* v1.2  (2013/03/04) added command `\tableoftaggedcontents`.

* v1.1  (2012/12/13) added command `\nexttocwithtags`.

* v1.0  (2012/12/06) first release.


License
=======

    This Work may be distributed and/or modified under the
    conditions of the LaTeX Project Public License,
    version 1.3c.  This version of this license is in
	
<http://www.latex-project.org/lppl/lppl-1-3c.txt>

    The Author of this Work is:
        Jean-Francois Burnol <jfbu at free dot fr> 

