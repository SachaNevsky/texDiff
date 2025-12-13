#!/bin/sh

if [ $# = 0 ]; then
  echo "Usage: $0 <file.pdf>"
  exit 1
fi

NAME=$(basename $1 .pdf)
PDF=$NAME.pdf
sh ./pdfcrop.sh $PDF
/bin/mv -f $NAME-crop.pdf $PDF
