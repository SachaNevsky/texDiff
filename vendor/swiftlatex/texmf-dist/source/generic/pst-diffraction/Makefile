# `Makefile' for `pst-diffraction.pdf', hv, 2007/03/17

.SUFFIXES : .tex .ltx .dvi .ps .pdf .eps

PACKAGE = pst-diffraction

LATEX = latex

ARCHNAME = $(PACKAGE)-$(shell date +%y%m%d)
ARCHFILES = $(PACKAGE).sty *.tex $(PACKAGE).pro *.tex README Changes Makefile

all : DE E FR clean

DE : $(PACKAGE)-docDE.pdf
E :  $(PACKAGE)-docE.pdf
FR : $(PACKAGE)-docFR.pdf

doc : 	$(MAIN).pdf

%.pdf : %.ps
	GS_OPTIONS=-dAutoRotatePages=/None ps2pdf $<

%.ps : %.dvi
	dvips $<

%.dvi : %.tex
	$(LATEX) $<
	$(LATEX) $<
	if ! test -f $(basename $<).glo ; then touch $(basename $<).glo; fi
	if ! test -f $(basename $<).idx ; then touch $(basename $<).idx; fi
	makeindex -s gglo.ist -t $(basename $<).glg -o $(basename $<).gls \
	  $(basename $<).glo
	makeindex -t $(basename $<).ilg -o $(basename $<).ind \
	  $(basename $<).idx
	bibtex $(basename $<)
	$(LATEX) $<
	$(LATEX) $<

clean : 
	$(RM) $(addprefix $(PACKAGE)-docDE, .log .aux .glg .glo .gls .ilg .idx .ind .tmp .toc .out .blg .Roessler .bbl )
	$(RM) $(addprefix $(PACKAGE)-docDE, .dvi .ps)
	$(RM) $(addprefix $(PACKAGE)-docE, .log .aux .glg .glo .gls .ilg .idx .ind .tmp .toc .out .blg .Roessler .bbl )
	$(RM) $(addprefix $(PACKAGE)-docE, .dvi .ps)
	$(RM) $(addprefix $(PACKAGE)-docFR, .log .aux .glg .glo .gls .ilg .idx .ind .tmp .toc .out .blg .Roessler .bbl )
	$(RM) $(addprefix $(PACKAGE)-docFR, .dvi .ps)

veryclean : clean
	$(RM) $(addprefix $(PACKAGE)-docDE, .pdf .bbl .blg)
	$(RM) $(addprefix $(PACKAGE)-docE, .pdf .bbl .blg)
	$(RM) $(addprefix $(PACKAGE)-docFR, .pdf .bbl .blg)

arch :
	zip $(ARCHNAME).zip $(ARCHFILES)

# EOF
