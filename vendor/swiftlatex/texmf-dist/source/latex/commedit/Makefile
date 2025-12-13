#
# Makefile for commedit package
#
# This file is in public domain
#
# $Id: Makefile,v 1.2 2012-02-25 21:06:49 boris Exp $
#

PACKAGE=commedit

SAMPLESTEX = sample.tex

SAMPLESPDF = ${SAMPLESTEX:%.tex=%.pdf} commented.pdf

all:  $(PACKAGE).pdf $(SAMPLESPDF)


%.pdf:  %.dtx   $(PACKAGE).sty
	pdflatex $<
	- bibtex $*
	pdflatex $<
	- makeindex -s gind.ist -o $*.ind $*.idx
	- makeindex -s gglo.ist -o $*.gls $*.glo
	pdflatex $<
	while ( grep -q '^LaTeX Warning: Label(s) may have changed' $*.log) \
	do pdflatex $<; done


%.pdf:  %.tex   $(PACKAGE).sty
	pdflatex $<
	- bibtex $*
	pdflatex $<
	- makeindex  -o $*.ind $*.idx
	pdflatex $<
	while ( grep -q '^LaTeX Warning: Label(s) may have changed' $*.log) \
	do pdflatex $<; done

commented.tex: sample.tex
	pdflatex $<

%.sty:   %.ins %.dtx  
	pdflatex $<



.PRECIOUS:  $(PACKAGE).cfg $(PACKAGE).sty


clean:
	$(RM)  *.sty *.log *.aux \
	*.cfg *.glo *.idx *.toc \
	*.ilg *.ind *.out *.lof \
	*.lot *.bbl *.blg *.gls \
	*.dvi *.ps *.hd commented.tex

distclean veryclean: clean
	$(RM) *.pdf

#
# Archive for the distribution. Includes typeset documentation
#
archive:  all clean
	COPYFILE_DISABLE=1 tar -C .. -czvf ../$(PACKAGE).tgz \
	--exclude '*~' --exclude '*.tgz' --exclude .git \
	--exclude .gitignore $(PACKAGE) ;\
	mv ../$(PACKAGE).tgz .;

zip:  all clean
	${MAKE} ${PACKAGE}.sty
	${RM} *.log
	cd .. && zip -r ${PACKAGE}.zip ${PACKAGE} \
	-x '*/.git' -x '*/.gitignore' \
	-x '*/.git/*' -x '*/.gitignore' \
	-x '*/*.ins'
