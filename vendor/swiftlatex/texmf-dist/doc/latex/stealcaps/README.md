# The `stealcaps` package

This package enables you to borrow small capitals
from another font than the main document font.
For that simply load the package and specify the replacement font
vie the key-value-option 'from', i.e.

    \usepackage[from=<font name>]{stealcaps}.

In case you use pdfLaTeX the font name has to be NFSS compliant.
With XeLaTeX or LuaLaTeX, correpsondingly,
it has to be `fontspec` compliant.

Package dependencies: `pgfopts`, `iftex`, `fontspec`.

This is version 1.0 of the package.

Copyright (C) 2018 by Ruben Giannotti

---

This work may be distributed and/or modified under the
conditions of the LaTeX Project Public License, either
version 1.3c of this license or (at your option) any
later version. The latest version of this license is in
  http://www.latex-project.org/lppl.txt
and version 1.3 or later is part of all distributions
of LaTeX version 2005/12/01 or later.

This work has the LPPL maintenance status `maintained'.

The Current Maintainer of this work is Ruben Giannotti.

This work consists of the files
   stealcaps.dtx,
   stealcaps.ins
and the derived file stealcaps.sty.

To install the package

 1. run `latex stealcaps.ins`
 2. move 'stealcaps.sty' to locations where LaTeX will find it
