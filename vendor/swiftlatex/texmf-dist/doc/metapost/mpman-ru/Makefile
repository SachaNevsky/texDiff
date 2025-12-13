# Makefile for MetaPost documentation.  Public domain.

pdflatex = pdflatex
mpost = TEX=tex mpost

all: mpman-ru.pdf 

mpman-ru.pdf: mpman-ru.tex mpman-ru.bbl manfig-ru.mp 
	$(mpost) manfig-ru
	$(pdflatex) mpman-ru
	$(pdflatex) mpman-ru
	$(pdflatex) mpman-ru
	makeindex -s mpman.ist mpman-ru
	cp mpman-ru.ind mpman-ru.ind.src
	awk -f idx1.awk mpman-ru.ind.src | awk -f idx2.awk | sort | awk -f idx3.awk >mpman-ru.ind
	awk -f extract-bm.awk mpman-ru.tex >mpman-ru.out.raw
	iconv -f koi8-r -t utf-8 mpman-ru.out.raw > mpman-ru.out.utf8
	awk -f bm-to-utf16be.awk mpman-ru.out.utf8 > mpman-ru.out
	$(pdflatex) mpman-ru

clean distclean:
	rm -f *.aux *.blg *.dvi *.log *.mpx *.mps *.[0-9] *.[0-9][0-9] *.[0-9][0-9][0-9]
	rm -f *.idx *.ilg *.ind *.toc *.utf8 *.raw *.src *.out
