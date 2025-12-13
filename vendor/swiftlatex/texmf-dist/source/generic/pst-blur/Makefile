
# `Makefile' for `pst-fill.pdf', RN, 2005/10/07

.SUFFIXES : .tex .ltx .dvi .ps .pdf .eps

PACKAGE = pst-blur

LATEX = latex

ARCHNAME = $(PACKAGE)-$(shell date +%y%m%d)

ARCHFILES = $(PACKAGE).dtx $(PACKAGE).ins Makefile

all : sty doc 
sty : 
	tex $(PACKAGE).ins

doc : $(PACKAGE).pdf

$(PACKAGE).pdf : $(PACKAGE).ps
	GS_OPTIONS=-dAutoRotatePages=/None ps2pdf $<

$(PACKAGE).ps : $(PACKAGE).dvi
	dvips $<

$(PACKAGE).dvi : $(PACKAGE).dtx
	$(LATEX) $<
	if ! test -f $(basename $<).glo ; then touch $(basename $<).glo; fi
	if ! test -f $(basename $<).idx ; then touch $(basename $<).idx; fi
	makeindex -s gglo.ist -t $(basename $<).glg -o $(basename $<).gls \
	  $(basename $<).glo
	makeindex -s gind.ist -t $(basename $<).ilg -o $(basename $<).ind \
	  $(basename $<).idx
	$(LATEX) $<

clean : 
	$(RM) $(addprefix $(PACKAGE), .log .aux .glg .glo .gls .ilg .idx .ind)
	$(RM) $(addprefix $(PACKAGE), .dvi .ps)

veryclean : clean
	$(RM) $(PACKAGE).pdf

arch :
	zip $(ARCHNAME).zip $(ARCHFILES)

# EOF
