PACKAGE = bestpapers

TEX = bestpapers-guide.tex

PDF = ${TEX:%.tex=%.pdf}

all:  ${PDF}

%.pdf:  %.tex bestpapers.bst tex.bib
	pdflatex $*
	- bibtex tex
	- bibtex typography
	pdflatex $*
	pdflatex $*
	while ( grep -q 'may have changed' $*.log) \
	do pdflatex $<; done

clean:
	$(RM)  *.log *.aux \
	*.cfg *.glo *.idx *.toc \
	*.ilg *.ind *.out *.lof \
	*.lot *.bbl *.blg *.gls \
	*.dvi *.ps *.thm *.tgz *.zip

distclean: clean
	$(RM) $(PDF)

archive: all clean
	cd ..; \
	tar -czvf $(PACKAGE)/$(PACKAGE).tgz --exclude '*~' --exclude '*.tgz' --exclude '*.zip'  --exclude CVS $(PACKAGE); \
	cd $(PACKAGE)

zip: all clean
	cd ..; $(RM) $(PACKAGE).zip; \
	zip -r  $(PACKAGE).zip $(PACKAGE)/* -x '*~' -x '*.tgz' -x '*.zip' -x '*CVS*'