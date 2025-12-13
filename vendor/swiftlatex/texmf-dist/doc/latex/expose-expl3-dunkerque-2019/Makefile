# Time-stamp: <2019-08-29 11:09:56 administrateur>
# Création: 2019-08-08T10:10:07+0200
# ---------------------------------------------------------------
# Makefile pour latexmk et la suite par Y. Henel
#
# !!! règle "zip" à revoir, fichier bib etc. pas à la bonne place
# 
# ---------------------------------------------------------------
SHELL:=/bin/bash
# ---------------------------------------------------------------

AXLRTEX:=aux,toc
PRDTTEX:=ltx
PRDTVERBATIM:=vrb
TEXLOG:=log
AXLRINDEX:=idx,ind
INDEXLOG:=ilg
AXLRHYPERREF:=out,nav
AXLRGLOSSARIES:=xdy,glo,gls
GLOSSARIESLOG:=glg
AXLRBIBLATEX:=run.xml,bbl,bcf
BIBLATEXLOG:=blg
LATEXMKAUX:=fdb_latexmk,fls
AXLR=$(AXLRTEX),$(AXLRINDEX),$(AXLRHYPERREF),$(AXLRGLOSSARIES),$(AXLRBIBLATEX),$(AUTRESAXLR)
PRDTAUX=$(PRDTTEX),$(PRDTVERBATIM)
FICHIERSLOG=$(TEXLOG),$(INDEXLOG),$(GLOSSARIESLOG),$(BIBLATEXLOG),$(AUTRESLOG)

# ---------------------------------------------------------------

NOM:=dun19expl3
NOMCOMP:= $(NOM)
VERSION:=1.0
SUJET:=expl3

PRES:=$(NOMCOMP)

SOURCE:=$(PRES).tex

SRCAUX:=$(wildcard *.tex)

BIBLIODIR=bibliographie
BIBLIO:=$(wildcard $(BIBLIODIR)/*.bib)

CODESDIR=codes
CODES:=$(wildcard $(CODESDIR)/*.tex)

GLOSAIRESDIR=glosaires
GLOSAIRES:=$(wildcard $(GLOSAIRESDIR)/*.tex)

SOURCES:= \
	Makefile\
	latexmkrc\
	$(SOURCE)\
	$(SRCAUX)\
	$(BIBLIO)\
	$(CODES)\
	$(GLOSAIRES)\


PRDT:= $(subst .tex,.pdf,$(SOURCE))

AUTRESAXLR:=klo,kls

AUTRESLOG:=klg

# ---------------------------------------------------------------
# règles
# astuce avec TEXINPUT tirée du Makefile de la doc de pgf

TEXINPUTS := ./extensions:$(TEXINPUTS)

%.pdf: %.tex 
	TEXINPUTS="$(TEXINPUTS)" latexmk -pdf -bibtex $<
# ---------------------------------------------------------------

doc: $(PRDT)
$(PRDT): $(SOURCES)
# ---------------------------------------------------------------

.PHONY: refaire

refaire:
	TEXINPUTS="$(TEXINPUTS)" latexmk -gg -pdf -bibtex $(SOURCE)
# ---------------------------------------------------------------

.PHONY: almostclean

almostclean:
	@rm -f *~
	@rm -f *.{$(AXLR)}
# ---------------------------------------------------------------

.PHONY: clean

clean: almostclean
	@rm -f *.{$(PRDTAUX)}
# ---------------------------------------------------------------

.PHONY: veryclean

veryclean: clean
	@rm -f *.{$(FICHIERSLOG),$(LATEXMKAUX)}
# ---------------------------------------------------------------

.PHONY: distclean

distclean: veryclean
	@rm -f $(PRDT)
# ---------------------------------------------------------------

.PHONY: prepazip

REPERT:= ./$(NOMCOMP)

prepazip: doc veryclean
	@rm -rf $(REPERT)
	@mkdir -p $(REPERT)/SRC
	@mkdir -p $(REPERT)/DOC
	@cp $(SOURCES) $(REPERT)/SRC
	@cp $(PRDT) $(REPERT)/DOC
# ---------------------------------------------------------------

.PHONY: zip

zip:	prepazip
	@rm -f $(NOMCOMP).zip
	@zip -r $(NOMCOMP) $(REPERT)
	@rm -rf $(REPERT)

# ---------------------------------------------------------------
# version allégée, avec BASH ;
# utilisation d'un fichier inclus 2019-08-08
# ---------------------------------------------------------------

