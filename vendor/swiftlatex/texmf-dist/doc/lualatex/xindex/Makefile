
.SUFFIXES : .tex .ltx .dvi .ps .pdf .eps

PACKAGE = xindex

MAIN = xindex-doc

LATEX = lualatex

ARCHNAME = $(MAIN)-$(shell date +%y%m%d)

ARCHFILES = $(PACKAGE).sty $(PACKAGE).tex $(PACKAGE).pro $(MAIN).tex README Changes Makefile

#TDS = ~/PSTricks/PSTricks-TDS

all : doc clean
# clean
doc: 	
	$(LATEX) --shell-escape $(MAIN)
#	if ! test -f $(MAIN).glo ; then touch $(MAIN).glo; fi
	if ! test -f $(MAIN).idx ; then touch $(MAIN).idx; fi
#	makeindex -s gglo.ist -t $(MAIN).glg -o $(MAIN).gls $(MAIN).glo
	xindex -a $(MAIN).idx
#	bibtex $(MAIN)
	$(LATEX) --shell-escape $(MAIN)
#	$(LATEX) --shell-escape $(MAIN)

clean : 
	$(RM) *.dvi *.aux *.log  *.xml xindex-?.tex xindex-??.tex *.ind *.idx *.toc *.out *.ilg

veryclean : clean
	$(RM) *.pdf 

arch :
	zip $(ARCHNAME).zip $(ARCHFILES)

tds:
	cp -u Changes     $(TDS)/doc/latex/$(PACKAGE)/
	cp -u README      $(TDS)/doc/latex/$(PACKAGE)/
	cp -u $(MAIN).pdf $(TDS)/doc/latex/$(PACKAGE)/
#
	cp -u Changes        $(TDS)/tex/latex/$(PACKAGE)/
	cp -u $(PACKAGE).sty $(TDS)/tex/latex/$(PACKAGE)/
#
	cp -u Changes     $(TDS)/source/$(PACKAGE)/
	cp -u $(MAIN).tex $(TDS)/source/$(PACKAGE)/
	cp -u $(MAIN).bib $(TDS)/source/$(PACKAGE)/
	cp -u Makefile    $(TDS)/source/$(PACKAGE)/


# EOF
