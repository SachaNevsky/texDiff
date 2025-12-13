#!/bin/sh

# dat2tex: converts tabular data to a tabular environment

if [ $# != 1 ]; then
  echo "Usage: $0 <datafile>"
  exit 1
fi

# is this a cvs file?
grep ";" $1 > /dev/null
if [ $? = 0 ]; then
  AWK="awk -F;"
else
  AWK=awk
fi

# ok awk, make my day
$AWK '{if (1 == FNR) { \
        printf "\\begin\{tabular\}\{"; \
        for (i = 1; i <= NF; i++) {printf "l"}; \
        printf "\}\n"
      }
      for (i = 1; i < NF; i++) \
        {printf $i" & "} printf $NF" \\\\ \n"} \
      END {printf "\\end\{tabular\}\n"}' $1

# end of dat2tex
