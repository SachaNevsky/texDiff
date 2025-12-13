echo converting %1 to %2
gawk -f../tapcv.awk -vEXPROW=%5 -vNOSPAN=%6 -vINSROW=%7 %1 > tmp.tmp
copy /b %3 + tmp.tmp + %4 %2 > nul
del tmp.tmp
