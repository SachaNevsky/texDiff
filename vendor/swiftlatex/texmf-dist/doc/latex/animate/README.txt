===================================
 The animate Package

 https://gitlab.com/agrahn/animate

 (C) 2007--\today Alexander Grahn
===================================


1. Description
==============

This package provides an interface to create portable, JavaScript driven PDF
and SVG animations from sets of (vector) graphics or rasterized image files
or from inline (vector) graphics, such as LaTeX-picture, PSTricks or pgf/TikZ
generated pictures, or just from typeset text.

It supports the usual PDF making workflows, i. e.  pdfLaTeX, LaTeX -> dvips
-> ps2pdf (Ghostscript)/Distiller, (Xe)LaTeX -> (x)dvipdfmx, LuaLaTeX, and
LaTeX -> dvisvgm for SVG.

The resulting PDF with animations can be viewed in Acrobat Reader (except
on mobile devices), in PDF-XChange and in Foxit Reader. Animated SVG are
self-contained files that can be embedded into HTML using the `<object>` tag or
opened directly in a Web browser, such as Firefox or Chromium.

Note, this file only gives a summary of usage and available package and
command options. Please refer to the documentation `animate.pdf' for details
and examples.

 * Keywords: include portable PDF animation SVG animation animated PDF animated
             SVG dvisvgm html TeX4ht web animating embed animated graphics
             LaTeX pdfLaTeX LuaLaTeX PSTricks pgf TikZ LaTeX-picture MetaPost
             inline graphics vector graphics animated GIF LaTeX dvips ps2pdf
             dvipdfmx XeLaTeX JavaScript Acrobat Reader PDF-XChange Foxit Reader
             Firefox Chrome Chromium


2. Usage
========

\usepackage[<package options>]{animate}

 * Package options: width=<h-size>, height=<v-size>, totalheight=<v-size>,
                    keepaspectratio, scale=<factor>, nomouse,
                    hiresbb,pagebox,interpolate,
                    autopause, autoplay, autoresume,
                    controls[=all | none | ...],
                    controlsaligned=left[+<indent>] | center | right[+<indent>],
                    final, draft,
                    buttonsize=<size>,
                    buttonbg=<colour>, buttonfg=<colour>, buttonalpha=<opacity>,
                    loop, palindrome, step,
                    poster[=first | <num> | last | none],
                    alttext=none | {<alternative description>},
                    method=icon | widget | ocg,
                    dvipdfmx, dvisvgm, xetex,
                    type=[<file ext>],
                    export


\animategraphics[<options>]{<frame rate>}{<file basename>}{<first>}{<last>}

\begin{animateinline}[<options>]{<frame rate>}
    ... typeset material ...
\newframe[<frame rate>]
    ... typeset material ...
\newframe*[<frame rate>]
    ... typeset material ...
\newframe
\multiframe{<number of frames>}{[<variables>]}{
    ... repeated (parameterized) material ...
}
\end{animateinline}

 * Command options: width=<h-size>, height=<v-size>, totalheight=<v-size>,
                    keepaspectratio, scale=<factor>, nomouse,
                    hiresbb,pagebox,interpolate,
                    autopause, autoplay, autoresume, final, draft,
                    controls[=all | none | ...],
                    buttonsize=<size>,
                    buttonbg=<colour>, buttonfg=<colour>, buttonalpha=<opacity>,
                    loop, palindrome, step, measure,
                    poster[=first | <num> | last | none],
                    alttext=none | {<alternative description>},
                    begin={<begin text>}, end={<end text>},
                    timeline=<timeline file>,
                    method=icon | widget | ocg,
                    every=<number>, bb=<llx> <lly> <urx> <ury>,
                    viewport=<llx> <lly> <urx> <ury>,
                    trim=<left> <bottom> <right> <top>,
                    label=<label text>, type=[<file ext>]


3. Requirements
===============

Recent versions of
 * Ghostscript or Adobe Distiller
 * dvipdfmx
 * dvisvgm
 * Acrobat Reader, PDF-XChange, Foxit Reader
 * Blink-based (Chromium, Chrome, Opera, ...) web browsers or Firefox


4. Installation
===============

Unzip the file `animate.tds.zip' into the local TDS root directory which can
be found by running

  kpsewhich -var-value TEXMFLOCAL

on the command line.

After installation, update the filename database by running `texhash' on the
command line.

TeXLive and MiKTeX users should run the package manager for installation.


                         * * *

This material is subject to the LaTeX Project Public License. See

  http://mirrors.ctan.org/macros/latex/base/lppl.txt

for the details of that license.
