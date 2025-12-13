.SUFFIXES: .ps .dvi .tex .pdf .gz .eps

.dvi.ps :
	dvips -K -t letter $*
	gv $@

.tex.ps :
	make $*.dvi
	make $*.ps

.tex.pdf :
	pdflatex $*
	- while  ( fgrep -s Rerun $*.log ) ; do \
	pdflatex $* ; \
	done

.tex.dvi :
	- until ( latex $* ) ; do \
	continue ; \
	done
	- while  ( fgrep -s 'No file $*' $*.log ) ; do \
	latex $* ; \
	done
	- while  ( fgrep -s Rerun $*.log ) ; do \
	latex $* ; \
	done

all: xampl.pdf
	acroread -geometry 700x1000 $<

xampl.pdf: xampl.bbl
	pdflatex xampl
	- while  ( fgrep -s Rerun $*.log ) ; do \
	pdflatex xampl ; \
	done

xampl.bbl: xampl.tex mybib.bib
	# latex xampl
	pdflatex xampl
	bibtex -terse xampl

xampl.ps: xampl.dvi xampl.bbl

clean:
	rm *.bbl *.blg *.dvi *.aux *.log xampl.ps
