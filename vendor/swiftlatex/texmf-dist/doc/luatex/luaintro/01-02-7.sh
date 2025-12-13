#!/bin/sh
#
# Ein Beispiel der DANTE-Edition
#
#
# Copyright (C) 2014 Herbert Voss
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
cat << _EndOfFile_ > $TeXfile.tex
1 .Zeile\par
\directlua name{\jobname: \the\inputlineno}{
  a=3
  b=4
  c="c"
  tex.sprint(a^2+b^2 .. "=" .. c^2)}\par
2. Zeile
\bye
_EndOfFile_

luatex --interaction=batchmode $TeXfile
grep -A4 error $TeXfile.log >$TeXfile.txt
#CODEend
