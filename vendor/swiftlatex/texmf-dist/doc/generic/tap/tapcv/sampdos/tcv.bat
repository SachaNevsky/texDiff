@echo off
:: %1 input file name
:: %2 output file name
:: %3 extra spaces added at sides of every cell
:: %4 span columns if %4=0, no spanning if %4=1
:: %5 TeX text inserted in rows containing only vertical rules
:: %6 preamble file name
:: %7 postamble file name
call tcv_ tapcv0.raw tapcv0.tex  prea1.tex post1.tex 2 0
call tcv_ tapcv1.raw tapcv1.tex  prea1.tex post1.tex 2 0
call tcv_ tapcv2.raw tapcv2.tex  prea1.tex post1.tex 2 0
call tcv_ tapcv3.raw tapcv3.tex  prea3.tex post1.tex 0 1
call tcv_ tapcv4.raw tapcv4.tex  prea1.tex post1.tex 2 0
call tcv_ tapcv5.raw tapcv5.tex  prea2.tex post2.tex 2 0 \\V{x}
call tcv_ tapcv6.raw tapcv6a.tex prea1.tex post1.tex 2 0 \\D+
call tcv_ tapcv6.raw tapcv6b.tex prea1.tex post1.tex 2 0
