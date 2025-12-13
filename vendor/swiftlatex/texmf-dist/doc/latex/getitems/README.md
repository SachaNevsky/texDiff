==============================================================================

The `getitems' package v1.0
Copyright (C) 2016 Anders Hendrickson (anders.hendrickson@snc.edu)

This package provides a \gatheritems command to parse a list of data separated 
by \item tokens.  This makes it easier to define custom environments which 
structure their data in the same way that itemize or enumerate do.

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
getitems.dtx
getitems.ins
  and the derived file:
getitems.sty

  The distribution consists of the files:
README (this file)
getitems.dtx
getitems.ins
getitems.pdf (the user manual)

----------------------------------------------------------------- 

    To install the package:
- run: latex getitems.ins (which will generate getitems.sty)
- Move getitems.sty to a location where LaTeX will find it (typically
  in a local texmf tree at tex/latex/getitems) and refresh the 
  file database. See the FAQ on CTAN at help/uk-tex-faq or
  http://www.tug.ac.uk/faq for more information on this.
    To process the user manual
- run: pdflatex getitems.dtx
- run: pdflatex getitems.dtx
