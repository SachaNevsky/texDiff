#!/bin/sh
#
# Ein Beispiel der DANTE-Edition
#
#
# Copyright (C) 2013 Herbert Voss
#
# It may be distributed and/or modified under the conditions
# of the LaTeX Project Public License, either version 1.3
# of this license or (at your option) any later version.
#
# See http://www.latex-project.org/lppl.txt for details.
#
#
#CODEbegin
TeXfile=`basename $0 .sh`
cp data/viznodelist.lua .
cat << _EndOfFile_ > $TeXfile.tex
\setbox0\hbox{abc1}
\directlua{require("viznodelist")
           viznodelist.nodelist_visualize(0,"./$TeXfile.gv")}
\box0
\bye
_EndOfFile_

luatex --interaction=batchmode --draftmode $TeXfile
dot -Tpng $TeXfile.gv -o $TeXfile.png
#CODEend
