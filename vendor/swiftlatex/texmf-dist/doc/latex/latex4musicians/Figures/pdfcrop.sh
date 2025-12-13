#!/bin/sh

# pdfcrop.sh
# Guido Gonzato, PhD. GPL 2 or later.

MYSELF=$(basename $0)

if [ $# -eq 0 ] ; then
  printf "Usage: ${MYSELF} <file.pdf>\n"
  printf "This script uses 'gs' to crop a one-page pdf file.\n\n"
  exit 1
fi

# GhostScript for Windows must be installed in C:\Gs
# GS=/c/gs/gs9.26/bin/gswin64c.exe
# GNU/Linux and others:
GS=/usr/bin/gs

INPUT=$1
PDF=$(basename $1 .pdf)
OUTPUT=$PDF-crop.pdf
GSOPTS="-q -sDEVICE=bbox -dBATCH -dNOPAUSE"

# find out the bounding box
$GS $GSOPTS $INPUT 2>&1 | grep "%%B" > $PDF.bbox

# read bbox coordinates in variables
read tmp X1 Y1 X2 Y2 < $PDF.bbox

# write the output, cropped to bbox
$GS -q -o $OUTPUT \
  -sDEVICE=pdfwrite \
  -c "[ /CropBox [$X1 $Y1 $X2 $Y2] /PAGES pdfmark" \
  -f $INPUT

/bin/rm -f $PDF.bbox

echo "$INPUT cropped to $OUTPUT"
