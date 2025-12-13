Erewhon-Math package
====================

## Description

`Erewhon-Math.otf’ is an Utopia based OpenType mathematical font.
The mathematical symbols are borrowed or derived from Michel Bovani’s
Fourier-GUTenberg package, Latin letters and digits are borrowed from
Michael Shape’s Erewhon font.

## Contents

* Erewhon-Math.otf     OpenType Math font
* fourier-otf.sty      LaTeX style file: replaces fourier.sty for LuaTeX/XeTeX
* Erewhon-Math.pdf     Documentation in PDF format
* Erewhon-Math.ltx     Source of Erewhon-Math.pdf
* unimath-erewhon.pdf  Modified version of unimath-symbols.pdf
                       showing available Erewhon-Math symbols compared to
		       LatinModern, STIXTwo, TeXGyrePagella and DejaVu.
* unimath-erewhon.ltx  Source of unimath-symbols.pdf
* README.md            (this file)

## Installation

This package is meant to be installed automatically by TeXLive, MikTeX, etc.
Otherwise, Erewhon-Math can be installed under TEXMFHOME or TEXMFLOCAL, f.i.
Erewhon-Math.otf in directory  texmf-local/fonts/opentype/public/erewhon-math/
and
fourier-otf.sty  in directory  texmf-local/tex/latex/erewhon-math/
Documentation files and their sources can go to directory
texmf-local/doc/fonts/public/erewhon-math/
Don't forget to rebuild the file database (mktexlsr or so) if you install
under TEXMFLOCAL.
Finally, make the system font database aware of the Erewhon Math font
(fontconfig under Linux).

## License

* The font `Erewhon-Math.otf’ is licensed under the SIL Open Font License,
Version 1.1. This license is available with a FAQ at:
http://scripts.sil.org/OFL
* The other files are distributed under the terms of the LaTeX Project
Public License from CTAN archives in directory macros/latex/base/lppl.txt.
Either version 1.3 or, at your option, any later version.

## Changes

* First public version: 0.40
* v0.41: Added chars U+2AB1 to U+2AB4 (\precneq, \succneq, \preceqq, \succeqq).
         Fixed kerning between Italic/BoldItalic Latin and Greek letters
	 and their subscript.
* v0.42: Added thirty symbols U+00B0 (degree), U+01B5, U+214B, U+2232, U+2233,
         arrows U+2933 to U+2937 and some more.
         Improved kerning between roots and degrees.
	 Improved kerning between arrows accents and parenthesis.
	 Accents position above italic dans bold italic latin
	 and greek letters tuned.

---
Copyright 2019-2020  Michel Bovani, Daniel Flipo
E-mail: michel (dot) bovani (at) icloud (dot) com
        daniel (dot) flipo (at) free (dot) fr
