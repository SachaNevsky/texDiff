README.txt

The primary goal for uhrzeit.sty is to facilitate
formats of times and ranges of times as formerly used
in Germany.

Copyright 2016 Olaf Meltzer

Dokumentation in deutscher Sprache liegt als uhrzeit-doc.pdf bei.
Sie wurde aus uhrzeit-doc.tex unter Verwendung von uhrzeit.sty mit
pdfLaTeX erzeugt.

Manual input of times and ranges of times
as formerly used in Germany:

  Macro                   Output
  -----------------------------------------
  \uhr{5}{07}             5^07 Uhr
  \vonbis{5}{07}{13}{45}  5^07 -- 13^45 Uhr


Print the actual time:

  Macro    Output     Applicability
  ----------------------------------------------
  \dtd      5.07      (not commonly used)
  \dtc     05:07      (international)
  \uhri     5.07 Uhr  (Duden, 22. Aufl., S. 110)
  \uhrii   05:07 Uhr  (DIN 5008)
  \uhriii   5^07 Uhr  (formerly in common use)
  \uhriv   05^07 Uhr  (even formerly not commonly used)


Licence

This work may be distributed and/or modified under the
conditions of the LaTeX Project Public License, either version 1.3
of this license or (at your option) any later version.
The latest version of this license is in
         http://www.latex-project.org/lppl.txt
and version 1.3 or later is part of all distributions of LaTeX
version 2005/12/01 or later.

This work has the LPPL maintenance status `maintained'.
 
The Current Maintainer of this work is Olaf Meltzer.

This work consists of this README.txt, the files
uhrzeit.sty, uhrzeit-doc.tex, and the derived file uhrzeit-doc.pdf.

Author: Olaf Meltzer <olaf.meltzer@gmx.de>
         
        The style uses some ideas, published by
        Leif Albers and Andreas Matthias
        in de.comp.text.tex

