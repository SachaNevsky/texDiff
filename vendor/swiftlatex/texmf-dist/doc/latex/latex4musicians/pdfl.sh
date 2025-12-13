#!/bin/sh

if [ $# = 0 ]; then
  echo "Usage: $0 <file.tex>"
  exit 1
fi

NAME=$(basename $1 .tex)
PDF=$NAME.pdf
pdflatex Figures/$NAME.tex
pdfcrop $PDF
/bin/mv -f $NAME-crop.pdf $PDF
