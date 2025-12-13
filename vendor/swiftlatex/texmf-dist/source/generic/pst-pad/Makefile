MAIN = pst-pad
MAINDOCEN = pst-pad-doc
MAINDOCDE = pst-pad-docDE

all: \
	Makefile \
	$(MAINDOCEN).pdf \
	$(MAINDOCDE).pdf

$(MAINDOCEN).pdf: \
	showexpl.cfg \
	pst-pad-doc-header.tex \
	$(MAINDOCEN).tex \
	$(MAIN).tex \
	$(MAIN).sty 
		latex $(MAINDOCEN).tex
		latex $(MAINDOCEN).tex
		dvips $(MAINDOCEN)
		ps2pdf $(MAINDOCEN).ps

$(MAINDOCDE).pdf: \
	showexpl.cfg \
	pst-pad-doc-header.tex \
	$(MAINDOCDE).tex \
	$(MAIN).tex \
	$(MAIN).sty 
		latex $(MAINDOCDE).tex
		latex $(MAINDOCDE).tex
		dvips $(MAINDOCDE)
		ps2pdf $(MAINDOCDE).ps

.PHONY: publish
publish: \
		all
		zip $(MAIN).zip \
		Makefile README CHANGES pst-pad-doc-header.tex \
		$(MAIN).tex $(MAIN).sty \
		showexpl.cfg \
		$(MAINDOCEN).tex $(MAINDOCEN).pdf \
		$(MAINDOCDE).tex $(MAINDOCDE).pdf

.PHONY: clean
clean:
		rm *~ *.aux *.backup *.bbl *.blg *.brf *.cb *.changes \
		*.dvi *.idx *.ilg *.ind *.inx *.lof *.log *.lot *.lox \
		*.out *.ps *.pdf *.rel *.tmp *.toc *.xcp *.zip
