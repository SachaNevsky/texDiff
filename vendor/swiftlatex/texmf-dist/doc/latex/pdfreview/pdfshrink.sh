#!/bin/bash
INPUTPDF="$1"

if [ -z $1 ]; then
   echo "Usage: pdfshrink inputfile.pdf [quality [outputfile]]"
   exit 1
fi

# values for 'quality' argument:
# 
# 'prepress' is highest quality,
# 'ebook' is only 150 dpi
# 'screen' is 72dpi - looks very poor
# 'printer' and 'default' are good compromises


if [ ! -f "$INPUTPDF" ]; then
   echo "file $INPUTPDF not found"
   exit 1
fi

quality=${2-default}

if [ $quality = 'default' ]; then
    suffix="shrunk"
else
    suffix=$quality
fi

OUTPUTPDF="${3-${1%.pdf}-${suffix}}"
OUTPUTPDF="${OUTPUTPDF%.pdf}.pdf"

echo "converting $INPUTPDF to $OUTPUTPDF using quality '$quality'"

gs -sDEVICE=pdfwrite \
   -dCompatibilityLevel=1.4 \
   -dHaveTransparency=true \
   -dFastWebView=true \
   -dPrinted=false \
   -dPDFSETTINGS=/$quality \
   -dEmbedAllFonts=true \
   -dSubsetFonts=true \
   -dNOPAUSE \
   -dQUIET \
   -dBATCH \
   -sOutputFile="$OUTPUTPDF" \
   "$INPUTPDF" 2> /dev/null

chmod 644 "$OUTPUTPDF"
echo "done"
