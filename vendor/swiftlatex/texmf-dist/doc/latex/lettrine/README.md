The Lettrine bundle
===================

Description
-----------

This package is meant for typesetting dropped capitals in LaTeX documents.

Documentation
-------------

Have a look at one of the PDF files, demo-fr.pdf (in French),
demo-de.pdf (in German) or demo-lua.pdf in the doc directory,
to see how different layouts for dropped capitals can be achieved.
You can also play with the source files demo-*.tex.

Have a look at lettrine.pdf in the doc directory, if you are interested
in the complete documentation and code.

If you wish, you can customize lettrine.cfg according to your needs.

License
-------

Released under the LaTeX Project Public License v1.3 or later
See http://www.latex-project.org/lppl.txt
for the details of that license.

Installation
------------

This bundle is included in most TeX distributions, but if you need
to install it by yourself
1. run lualatex on lettrine.dtx to get the documentation (lettrine.pdf),
2. run luatex on lettrine.ins to strip the comments and create
   lettrine.sty and lettrine.cfg
3. run luatex on contrib.dtx to produce the *.cfl files.

Files lettrine.sty, lettrine.cfg, lettrine-*.sty and *.cfl go to to
a directory searched by TeX, typically $TEXMF/tex/latex/lettrine.

Files README, demo*, *.pdf go to a doc directory, typically
$TEXMF/doc/latex/lettrine.

Files *.dtx, *.ins go to a source directory, typically
$TEXMF/source/latex/lettrine

--
Copyright 1999--2020 Daniel Flipo
E-mail: daniel (dot) flipo (at) free (dot) fr
