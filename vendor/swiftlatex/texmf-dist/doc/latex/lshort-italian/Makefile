#	pstops "4:0L@0.8(22.5cm,-0.6cm)+1L@0.8(22.5cm,13.3cm),2L@0.8(22.5cm,-0.6cm)+3L@0.8(22.5cm,13.3cm)" \
#
#	Questo file serve per creare la distribuzione di itlshort.
#	Viene copiato col nome di Makefile all'interno della directory
#	itlshort dal Makefile di installazione
#
#	$Id: Makefile,v 1.5 2001/02/04 15:52:54 guild Exp $
#
SHELL = /bin/sh
VERS = 3.16

OTHER = README CHANGES
FILES = src/biblio.tex src/kees.fig src/math.tex src/things.tex src/contrib.tex src/lshort.sty src/mylayout.sty src/title.tex \
	src/custom.tex src/itlshort.tex src/overview.tex src/typeset.tex src/fancyheadings.sty src/lssym.tex src/spec.tex \
	src/ndt.tex

all: itlshort.dvi itlshort.ps itlshort-book.ps itlshort.pdf


itlshort.dvi: $(FILES)
	@mkdir texbuild
	(TEXINPUTS=`pwd`/src:$(TEXINPUTS);export TEXINPUTS; cd texbuild;\
	latex itlshort; latex itlshort; makeindex itlshort;\
	latex itlshort; latex itlshort; latex itlshort; mv itlshort.dvi ..)

itlshort.ps: itlshort.dvi
	dvips -Pcmz -oitlshort.ps itlshort.dvi
	rm texbuild/*

itlshort-book.ps: itlshort.ps
	psbook itlshort.ps out.ps 
	pstops "4:0L@0.8(22.76cm,-0.6cm)+1L@0.8(22.76cm,13.45cm),3R@0.8(-1.38cm,16.25cm)+2R@0.8(-1.38cm,30.3cm)" \
			out.ps itlshort-book.ps
	rm out.ps


itlshort.pdf: $(FILES)
	@mkdir pdfbuild
	(TEXINPUTS=`pwd`/src:$(TEXINPUTS);export TEXINPUTS; cd pdfbuild;\
	pdflatex itlshort; pdflatex itlshort;\
	makeindex itlshort;pdflatex itlshort; pdflatex itlshort;thumbpdf itlshort.pdf; pdflatex itlshort;pdflatex itlshort;mv itlshort.pdf ..)
	rm pdfbuild/*

src/title.tex: Makefile
	perl fixdate.pl $(VERS) < src/title.tex > src/title.tex2 && mv src/title.tex2 src/title.tex

dist:	
	ln -s . itlshort-$(VERS)
	# gtar -zcvf lshort-$(VERS).src.tar.gz `awk -e '{print "lshort-$(VERS)/"$$1}' MANIFEST`
	tar -zcvf itlshort-$(VERS).src.tar.gz `awk '{print "itlshort-$(VERS)/"$$1}' MANIFEST`
	rm itlshort-$(VERS)
	#cp itlshort-$(VERS).src.tar.gz CHANGES README itlshort-book.ps itlshort.dvi itlshort.pdf itlshort.ps $(HOME)/public_html/itlshort/ 



clean:
	rm -rf texbuild pdfbuild

