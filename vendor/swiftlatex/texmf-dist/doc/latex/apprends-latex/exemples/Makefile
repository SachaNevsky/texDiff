LATEX = $(wildcard police-*.tex)	\
	letter.tex scrlttr2.tex	\
	curve.tex currvita.tex	\
	slides.tex beamer-titlepage.tex	\
	$(wildcard beamer-theme-*.tex)	\
	moderncv-casual.tex moderncv-classic.tex

.SUFFIXES : .tex .pdf

.tex.pdf :
	latexmk -pdf $<

all : moderncv exemples

moderncv : moderncv-casual.tex moderncv-classic.tex

moderncv-casual.tex : moderncv.tex
	sed s/classic/casual/ moderncv.tex > moderncv-casual.tex
	touch -r moderncv.tex moderncv-casual.tex

moderncv-classic.tex : moderncv.tex
	cp -p moderncv.tex moderncv-classic.tex

exemples : $(LATEX:.tex=.pdf)

clean :
	@for e in aux log nav out snm toc ; do \
		rm -f $(LATEX:.tex=.$$e) ; \
	done

distclean : clean
	rm -f $(LATEX:.tex=.pdf)
