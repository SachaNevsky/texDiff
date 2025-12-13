grabbox: utilities to get an argument as a box

Copyright (C) 2018-2019 by Jonathan P. Spratte

This package may be distributed and/or modified under the conditions of the
LaTeX Project Public License (LPPL), either version 1.3c of this license or (at
your option) any later version.  The latest version of this license is in the
file

  https://www.latex-project.org/lppl.txt

The package provides

 - `\grabbox<*>[<prepre>]{<register>}[<pre>]{<mode>}[<post>]{<next>}`: grab the
   next argument as a box in `<mode>` (`\hbox`, `\vbox` or `\vtop`) and save it
   in box `<register>`. After the box is saved execute `<next>`. Inside of the
   box one can inject `<prepre>` and `<pre>` before the contents and `<post>`
   after them. If the star is not given spaces are stripped from the start and
   the end of the box.
