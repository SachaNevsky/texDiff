----------------------------------------------------------------

Ukrainian Language Module for datetime2 Package

Author: Nicola L. C. Talbot (inactive)
Current maintainer: Sergiy M. Ponomarenko <sergiy.ponomarenko@gmail.com>.

Licence: LPPL

Required Packages: tracklang

1. INSTALLATION

xelatex datetime2-ukrainian.ins

Move all *.ldf files to
TEXMF/tex/latex/datetime2-ukrainian/

2. USAGE

2.1.1 PDFLATeX, LaTeX

    \documentclass{article}
    \usepackage[ukrainian]{datetime2}
    \begin{document}
        \today
    \end{document}

    \documentclass[ukrainian]{article}
    \usepackage{babel}
    \usepackage[useregional]{datetime2}
    \begin{document}
        \today
    \end{document}

2.1.2 Lua(Xe)LaTeX

    \documentclass{article}
    \usepackage{polyglossia}
    \setmainlanguage{ukrainian}
    \usepackage[ukrainian]{datetime2}
    \begin{document}
       \today
    \end{document}

3. DOCUMENTATION

See datetime2-ukrainian.pdf for more information.

This material is subject to the LaTeX Project Public License.
See http://www.ctan.org/license/lppl1.3 for the details of that license.

----------------------------------------------------------------

