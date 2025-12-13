#!/bin/sh
#
# Ein Beispiel der DANTE-Edition
#
## Beispiel 12-04-1 auf Seite 600.
#
# Copyright (C) 2016 Herbert Voss
#
# It may be distributed and/or modified under the conditions
# of the LaTeX Project Public License, either version 1.3
# of this license or (at your option) any later version.
#
# See http://www.latex-project.org/lppl.txt for details.
#
# Running otfinfo on Linux
#START

#STOP
#
#CODE->
otfinfo -i `kpsewhich ComicNeue_Regular.otf`
#<-CODE
