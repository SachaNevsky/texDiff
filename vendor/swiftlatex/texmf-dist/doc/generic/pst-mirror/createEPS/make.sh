latex xa.tex && rm -f xa.log xa.aux
dvips -E xa.dvi -o xa.eps
pstoedit -dt -xscale "-1" -xshift -150 -f ps xa.eps xb.eps
scripts/filtre.pl 1 xb.eps
pstoedit -f ps xb.eps xc.eps
scripts/filtre.pl 2 xc.eps
./test.sh
#latex xxx && dvips xxx && ps2pdf xxx.ps
rm -f *.ps *.dvi