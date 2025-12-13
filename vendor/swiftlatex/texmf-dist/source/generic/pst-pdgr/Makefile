#
# Makefile for pst-pdgr package
#
# This file is in public domain
#
# $Id: Makefile,v 2.2 2017/11/20 21:27:26 boris Exp $
#

PACKAGE=pst-pdgr

all:  $(PACKAGE).pdf

%.pdf:   %.ps
	ps2pdf -sAutoRotatePages=None $<

%.ps:  %.dvi
	dvips -Ppdf -o $@ $<

%.dvi:  %.dtx   $(PACKAGE).sty $(PACKAGE).tex
	latex $<
	- bibtex $*
	latex $<
	- makeindex -s gind.ist -o $*.ind $*.idx
	- makeindex -s gglo.ist -o $*.gls $*.glo
	latex $<
	while ( grep -q '^LaTeX Warning: Label(s) may have changed' $*.log) \
	do latex $<; done


%.sty:   %.ins %.dtx  
	latex $<


%.tex:   %.ins %.dtx  
	latex $<

.PRECIOUS:  $(PACKAGE).cfg $(PACKAGE).tex $(PACKAGE).sty


clean:
	$(RM) $(PACKAGE).tex $(PACKAGE).sty $(PACKAGE).log $(PACKAGE).aux \
	$(PACKAGE).cfg $(PACKAGE).glo $(PACKAGE).idx $(PACKAGE).toc \
	$(PACKAGE).ilg $(PACKAGE).ind $(PACKAGE).out $(PACKAGE).lof \
	$(PACKAGE).lot $(PACKAGE).bbl $(PACKAGE).blg $(PACKAGE).gls \
	$(PACKAGE).dvi $(PACKAGE).ps

distclean: clean
	$(RM) $(PACKAGE).pdf

#
# Archive for the distribution. Includes typeset documentation
#
archive:  all clean
	COPYFILE_DISABLE=1 tar -C .. -czvf ../pst-pdgr.tgz --exclude '*~' --exclude '*.tgz' --exclude '*.zip'  --exclude CVS --exclude '.git*' -s/latex/pst-pdgr/ latex; mv ../pst-pdgr.tgz .
