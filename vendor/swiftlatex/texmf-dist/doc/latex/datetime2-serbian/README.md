Serbian Language Module for datetime2 CTAN Package
==================================================

**Current maintainer:** Andrej Radović

**Authors:** Andrej Radović (r.andrej@gmail.com), Nicola L. C. Talbot (inactive)

**Licence:** LPPL

**Required Packages:** `datetime2`, `tracklang`

Styles
------

This module provides the following styles:

### Latin:
* serbian    - regionless style
* sr-Latn    - Serbian, Serbia
* sr-Latn-RS - Serbian, Serbia
* sr-Latn-ME - Serbian, Montenegro
* sr-Latn-BA - Serbian, Bosnia and Herzegovina

### Cyrillic
* serbianc   - regionless style
* sr-Cyrl    - Serbian, Serbia
* sr-Cyrl-RS - Serbian, Serbia
* sr-Cyrl-ME - Serbian, Montenegro
* sr-Cyrl-BA - Serbian, Bosnia and Herzegovina

Notes:
------

The regional settings still don't work, but `serbian` and `serbianc` work just
fine.
The package is still in development.

Example usage:
--------------

### Generic w/ `babel`
    \documentclass{article}
    \usepackage[serbian]{datetime2}
    \begin{document}
    \today
    \end{document}

### Generic w/ `babel`

    \documentclass[serbian]{article}
    \usepackage{babel}
    \usepackage[useregional]{datetime2}
    \begin{document}
    \today
    \end{document}

### Generic w/ `polyglossia`

    \documentclass{article}
    \usepackage{polyglossia}
    \setmainlanguage{serbian}
    \usepackage[serbian]{datetime2}
    \begin{document}
    \today
    \end{document}


Installation
------------

Extract the language definition files first:

Run LuaLaTeX over the file `datetime2-serbian.ins`:

    lualatex datetime2-serbian.ins

Move all `*.ldf` files to

    TEXMF/tex/latex/datetime2-contrib/datetime2-serbian/

 Then, you can compile the documentation yourself by executing

    lualatex datetime2-serbian.dtx
    makeindex -s ginddt2s.ist datetime2-serbian.idx
    makeindex -s gglodt2s.ist -o datetime2-serbian.gls datetime2-serbian.glo
    lualatex datetime2-serbian.dtx
    lualatex datetime2-serbian.dtx

or just use the precompiled documentation shipped with the source files.
In both cases, copy the files `datetime2-serbian.pdf` and `README.md` to
`TEXMF/doc/latex/datetime2-contrib/datetime2-serbian/`.

This material is subject to the LaTeX Project Public License.
See http://www.ctan.org/license/lppl1.3 for the details of that
license.
