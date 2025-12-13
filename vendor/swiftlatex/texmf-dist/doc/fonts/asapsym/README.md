# asapsym: convenience macros for the ASAP symbol font

> asapsym v1.0 2016/03/20   
> Copyright (C) 2016 Paul D. Gessler (<pdgessler@gmail.com>)   

The **asapsym** package provides convenience macros for using the symbols
contained in the included *ASAP Symbol* font. The font is part of the
[ASAP family](http://www.omnibus-type.com/fonts/asap.php) of fonts. The font is
designed by [Omnibus-Type](http://www.omnibus-type.com/index.php) and released
under the [SIL Open Font License (OFL)](http://scripts.sil.org/OFL), version 1.1.

Macros are provided for each of the symbols provided by the font. Consult the
package documentation for full details.

## Package information

### **asapsym** CTAN package

Author:
	Paul D. Gessler (<pdgessler@gmail.com>)   
License:
	[The LaTeX Project Public License, version 1.3c](http://www.latex-project.org/lppl.txt)   
URL:
	<http://www.github.com/pdgessler/asapsym>   

### ASAP Symbol font

Author:
	Omnibus-Type   
License:
	[SIL Open Font License, version 1.1](http://scripts.sil.org/OFL_web)   
URL:
	<http://www.omnibus-type.com/fonts/asap-symbol.php>   

## Engine support

The font is distributed in OpenType format, and makes extensive use of OpenType
features. Therefore, at this time, only XeTeX and LuaTeX are supported. An error
message is issued if an OTF-capable engine is not detected.

## Format support

To use the macros in LaTeX, load the `asapsym` package:

    \usepackage{asapsym}

To use the macros in Plain TeX, `\input` the `asapsym.code.tex` file:

    \input asapsym.code.tex

Both `asapsym.sty` and `asapsym.code.tex` are wrappers around the main generic
macro definitions in `asapsym-generic.tex`.

## Dependencies

When using LaTeX, the [**fontspec** package](http://www.ctan.org/pkg/fontspec)
is used for loading the OpenType font and selecting features.

When using Plain TeX with the LuaTeX engine, `luaotfload.sty` is used for
loading the OpenType font and selecting features using the same syntax used
natively by XeTeX.

## Installation

The files distributed to CTAN are:

- `asapsym.dtx` (the documented sources)
- `asapsym.ins` (the installer file)
- `asapsym.pdf` (the typeset documentation)
- `README.md` (the file you are reading now)
- `Asap-Symbol.otf` (the OpenType font, released under SIL OFL, version 1.1)

Executing the command `latex asapsym.ins` will generate the following package
files from the `asapsym.dtx` file:

- `asapsym.code.tex` (the Plain TeX wrapper file)
- `asapsym.sty` (the LaTeX package wrapper)
- `asapsym-generic.tex` (the generic macro definitions)

These three files must be in a directory searched by TeX. A suggested layout for
the complete distribution is:

    doc/
      generic/
        asapsym/
          asapsym.pdf
          README.md
    fonts/
      opentype/
        omnibus-type/
          asap/
            Asap-Symbol.otf
    source/
      generic/
        asapsym/
          asapsym.dtx
          asapsym.ins
    tex/
      generic/
        asapsym/
          asapsym-generic.tex
      latex/
        asapsym/
          asapsym.sty
      plain/
        asapsym/
          asapysm.code.tex

To produce the documentation locally, use the following sequence of commands:

    lualatex asapsym.dtx
    makeindex -s gglo.ist -o asapsym.gls asapsym.glo
    makeindex -s gind.ist -o asapsym.ind asapsym.idx
    lualatex asapsym.dtx
