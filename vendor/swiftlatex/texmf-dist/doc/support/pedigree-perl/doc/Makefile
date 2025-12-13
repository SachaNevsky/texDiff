#
# Makefile for pedigree program
#
# This file is in public domain
#
# $Id: Makefile,v 2.10 2007-07-29 19:52:53 boris Exp $
#

TEXFILES = pedigree.tex

INCLUDES = \
	english.tex \
	english1.tex \
	russian.tex \
	twins.tex \
	abortions.tex \
	childlessness.tex \
	sort1.tex \
	sort2.tex \
	sort3.tex \
	badsort.tex \
	consanguinic.tex


PDFS = ${TEXFILES:%.tex=%.pdf}

all:  $(PDFS)


%.pdf:   %.ps
	ps2pdf -sAutoRotatePages=None $<

%.ps:  %.dvi
	dvips -Ppdf -o $@ $<


#
# We need to cancel the implicit rule
#
%.dvi: %.tex

%.dvi:	%.tex  $(INCLUDES)
	latex $<
	- bibtex $*
	latex $<
	latex $<
	while ( grep -q '^LaTeX Warning: Label(s) may have changed' $*.log) \
	do latex $<; done


%.tex:  ../examples/english_short.cfg  ../examples/%.csv
	cd ..; perl -I. pedigree.pl -c examples/english_short.cfg -o doc/$*.tex examples/$*.csv


english1.tex: ../examples/english1.cfg  ../examples/english.csv
	cd ..; perl -I. pedigree.pl -c examples/english1.cfg -o doc/$@ examples/english.csv

abortions.tex: ../examples/english.cfg  ../examples/abortions.csv
	cd ..; perl -I. pedigree.pl -c examples/english.cfg -o doc/$@ examples/abortions.csv


english.tex: ../examples/english.cfg  ../examples/english.csv
	cd ..; perl -I. pedigree.pl -c examples/english.cfg -o doc/$@ examples/english.csv

russian.tex: ../examples/russian.cfg  ../examples/russian.csv
	cd ..; perl -I. pedigree.pl -c examples/russian.cfg -o doc/$@ examples/russian.csv



clean:
	$(RM) *.aux *.bbl *.dvi *.log *.out *.toc *.blg *.lof *.lot *.lol pst-pdgr.tex pst-pdgr.sty

distclean: clean
	rm -f ${PDFS} $(INCLUDES)

