default: basic

basic: jadetex.ltx
	tex jadetex.ins

jadetex.fmt: basic
	tex -ini -progname=jadetex "&latex" jadetex.ini

pdfjadetex.fmt: basic
	pdftex -ini -progname=pdfjadetex "&pdflatex" pdfjadetex.ini

install: jadetex.fmt pdfjadetex.fmt
	(TT=$$DESTDIR/`kpsewhich -expand-var '$$TEXMFMAIN'`; \
	mkdir -p $$TT/web2c; \
	cp pdfjadetex.fmt $$TT/web2c; \
	cp jadetex.fmt $$TT/web2c; \
	mkdir -p $$TT/tex/jadetex ; \
	cp dsssl.def jadetex.ltx $$TT/tex/jadetex)

realclean: clean
	-rm jadetex.fmt pdfjadetex.fmt dsssl.def jadetex.ltx

clean:
	-rm  *.log *.aux *.idx *.pdf *.toc *.dvi *.out

test:
	openjade -t tex -d ../docbook/print/docbook.dsl test-tables.sgm

distrib:
	(cd ..; tar zcvf jadetex-$N.tar.gz jadetex/*1 jadetex/*.dtx jadetex/*.ins jadetex/*.sty jadetex/*.fd \
	jadetex/index.* jadetex/doc/install.pdf \
	jadetex/Makefile jadetex/ChangeLog jadetex/*ini)

jadetex.ltx: jadetex.dtx

