SCREEN = amsldoc-vi
PRINT  = amsldoc-print-vi

amsldoc: screen print

screen: 
	pdflatex $(SCREEN)
	pdflatex $(SCREEN)
	pdflatex $(SCREEN)
	thumbpdf $(SCREEN).pdf
	pdflatex $(SCREEN)

print:
	pdflatex $(PRINT)
	pdflatex $(PRINT)
	pdflatex $(PRINT)

quick:
	pdflatex $(SCREEN) 

tar:
	mkdir -p amsldoc-vi/src
	cp -pv {$(SCREEN),$(PRINT)}.pdf README.txt TODO amsldoc-vi
	cp -pv *.tex Makefile amsldoc-vi/src
	tar -cjf amsldoc-vi.tar.bz2 amsldoc-vi

clean:
	rm -fv *.log *.idx *.aux *.dvi *.bbl *.blg *.toc *.idx *.tps \
	*.ps *.ilg *.tcp *~ *.ind *.out *.tpt

cleanall: clean
	rm -fv *.pdf *~ amsldoc-vi.tar.bz2
