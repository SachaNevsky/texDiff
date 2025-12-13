# $Id: Makefile 234 2015-12-10 11:20:02Z herbert $

# `Makefile' for `pst-labo.pdf'

.SUFFIXES : .tex .ltx .dvi .ps .pdf .eps  

PACKAGE = pst-labo
MAIN = $(PACKAGE)-doc
LANGUAGES = DE EN FR
#PRO = $(PACKAGE).pro
PRO = 


empty=
space=$(empty) $(empty)
DOC_SOURCES = $(addprefix $(PACKAGE)-doc,$(LANGUAGES)$(space))
DOC_SOURCES := $(addsuffix .tex, $(DOC_SOURCES))
DOCS = $(DOC_SOURCES:.tex=.pdf)

TDS = ~/PSTricks/PSTricks-TDS

LATEX  = latex 
PDFLATEX  = latex 
OPTIONS= --Iext=.png --Iscale=0.5 --DPI=150 --noImages
DVIPS = dvips
PS2PDF = ps2pdf 

ARCHNAME = $(PACKAGE)-$(shell date +%Y%m%d)

ARCHFILES = $(PACKAGE).sty $(PACKAGE).tex $(PACKAGE).pro $(DOC_SOURCES) \
  README Changes Makefile

all : $(DOCS) clean ctan tds

%.pdf : %.tex 
	$(LATEX) $(basename $<) $(OPTIONS)
#	makeindex -s gglo.ist -t $(basename $<).glg -o $(basename $<).gls $(basename $<).glo
	makeindex -s pst-doc.ist -t $(basename $<).ilg -o $(basename $<).ind $(basename $<).idx
	bibtex $(basename $<)
	$(PDFLATEX) $(basename $<)
	$(PDFLATEX) $(basename $<)
	$(DVIPS) $(basename $<)
	$(PS2PDF)  $(basename $<).ps

clean :
	$(RM) $(foreach i,$(DOC_SOURCES:.tex=),$(addprefix $i, \
          .log .aux .glg .glo .gls .ilg .idx .ind .tmp .toc .out .blg .bbl .dvi .xcp .ps))

veryclean : clean
	$(RM) $(foreach i,$(DOC_SOURCES:.tex=),$(addprefix $i, .pdf ))

arch :
	zip $(ARCHNAME).zip $(ARCHFILES)

ifneq ($(strip $(PRO)),)
installPRO : 
	@echo "Installiere PRO-Dateien ($(PRO))..."
	cp -u Changes        $(TDS)/dvips/$(PACKAGE)/
	cp -u $(PACKAGE).pro $(TDS)/dvips/$(PACKAGE)/
	cp -u $(PACKAGE).pro ~/Links/dvips-local/
else
installPRO : 
	@:
endif

tds : installPRO
	@echo "Installiere TeX-Zeug..."
	cp -u Changes     $(TDS)/doc/generic/$(PACKAGE)/
	cp -u README      $(TDS)/doc/generic/$(PACKAGE)/
	cp -u *.pdf $(TDS)/doc/generic/$(PACKAGE)/
#
	cp -u Changes        $(TDS)/tex/latex/$(PACKAGE)/
	cp -u $(PACKAGE).sty $(TDS)/tex/latex/$(PACKAGE)/
#
	cp -u Changes        $(TDS)/tex/generic/$(PACKAGE)/
	cp -u $(PACKAGE).tex $(TDS)/tex/generic/$(PACKAGE)/
#
	cp -u Changes     $(TDS)/source/$(PACKAGE)/
	cp -u *-doc??.tex $(TDS)/source/$(PACKAGE)/
	cp -u $(PACKAGE)8* $(TDS)/source/$(PACKAGE)/
	cp -u $(MAIN).bib $(TDS)/source/$(PACKAGE)/
	cp -u Makefile    $(TDS)/source/$(PACKAGE)/

ctan:
	rm -f .ctan/$(PACKAGE)/latex/*
	cp -u *.sty .ctan/$(PACKAGE)/latex/
#	cp -u *.cfg .ctan/$(PACKAGE)/latex/
	rm -f .ctan/$(PACKAGE)/tex/*
	cp -u $(PACKAGE).tex .ctan/$(PACKAGE)/tex/
	cp -u $(PACKAGE)Obj.tex .ctan/$(PACKAGE)/tex/
#	cp -u *.pro .ctan/$(PACKAGE)/dvips/
	rm -f .ctan/$(PACKAGE)/doc/*
	cp -u $(PACKAGE)-doc.bib .ctan/$(PACKAGE)/doc/
	cp -u $(PACKAGE)-doc??.* .ctan/$(PACKAGE)/doc/
	cp -u Makefile .ctan/$(PACKAGE)/doc/
	cp -u $(PACKAGE)8* .ctan/$(PACKAGE)/doc/
#	rm -fr .ctan/$(PACKAGE)/.svn
	cp -u Changes     .ctan/$(PACKAGE)/
	cp -u README      .ctan/$(PACKAGE)/
	chmod -R a+r .ctan/$(PACKAGE)

debug :
	@echo $(DOC_SOURCES)

# EOF
