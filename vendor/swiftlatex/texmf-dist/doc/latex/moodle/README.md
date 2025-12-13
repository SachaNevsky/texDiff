==============================================================================

The `moodle' package v0.5
Copyright (C) 2016 Anders Hendrickson (anders.hendrickson@snc.edu)

This package allows dramatic highlighting of words and phrases
by painting shapes around them.  It is chiefly intended for
use in Beamer presentations, but it can be used in other
document classes as well.

Changes:
- 2016/01/11 Initial version

==============================================================================

This work may be distributed and/or modified under the
conditions of the LaTeX Project Public License, either version 1.3
of this license or (at your option) any later version.
The latest version of this license is in
   http://www.latex-project.org/lppl.txt
and version 1.3 or later is part of all distributions of LaTeX
version 2005/12/01 or later.


==============================================================================

  This work consists of the files:
README (this file)
moodle.dtx
moodle.ins
  and the derived file:
moodle.sty

  The distribution consists of the files:
README (this file)
moodle.dtx
moodle.ins
moodle.pdf (the user manual)

----------------------------------------------------------------- 

    To install the package:
- run: latex moodle.ins (which will generate moodle.sty)
- Move moodle.sty to a location where LaTeX will find it (typically
  in a local texmf tree at tex/latex/moodle) and refresh the 
  file database. See the FAQ on CTAN at help/uk-tex-faq or
  http://www.tug.ac.uk/faq for more information on this.
    To process the user manual
- run: pdflatex moodle.dtx
- run: pdflatex moodle.dtx
