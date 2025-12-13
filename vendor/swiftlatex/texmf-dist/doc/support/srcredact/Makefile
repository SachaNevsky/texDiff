PACKAGE=srcredact
WD = $(shell pwd)
CURRDIR = $(notdir ${WD})


TEXFILES = srcredact.tex

PODS = srcredact.pod

MAN1 = ${PODS:%.pod=%.1}

SAMPLEPDFS = \
	twain1-default.pdf twain1-uppercase.pdf twain1-nobonds.pdf \
	twain2-default.pdf twain2-uppercase.pdf twain2-nobonds.pdf 

DOCS = ${TEXFILES:%.tex=%.pdf} ${MAN1} ${SAMPLEPDFS}



SCRIPTS = srcredact.pl



all:  ${DOCS}
	perl -c ${SCRIPTS}
	chmod a+x ${SCRIPTS}

%.pdf:  %.tex srcredact-man.tex
	pdflatex $<
	- for file in *.aux; do bibtex $$file; done
	pdflatex $<
	while ( grep -q '^LaTeX Warning: Label(s) may have changed' $*.log || \
	grep -q '^Package pdfscreen Warning: TOC file not available' $*.log ||\
	grep -q '^Package natbib Warning: Citation(s) may have changed' $*.log)\
	do pdflatex $*; done

srcredact-man.tex: srcredact.pod
	pod2latex -out $@ -h1level 2 $<

%.1:  %.pod 
	pod2man -c "Text tools" -r "1.0" $< >$@

twain1-%.tex: twain1.tex srcredact.pl
	perl srcredact.pl -e $* twain1.tex > $@

twain2-%.tex: twain2.tex srcredact.pl
	perl srcredact.pl -e $* twain2.tex > $@

twain2.tex: twain1.tex twain-edited.tex
	perl srcredact.pl -u nobonds twain1.tex twain-edited.tex > $@

clean:
	$(RM) *.aux *.bbl *.dvi *.log *.out *.toc *.blg *.lof *.lot *.zip \
	*.ps  *.tgz depend  *.4* *.css *.idv *.lg *.xref *~ *.tmp \
	srcredact-man.tex 


.PRECIOUS: \
	twain1-uppercase.tex twain1-default.tex twain1-nobonds.tex \
	twain2-uppercase.tex twain2-default.tex twain2-nobonds.tex \
	twain2.tex

distclean: clean
	$(RM) ${DOCS} *.1 twain1-* twain2*

archive:  all clean
	cd ..; \
	tar -czvf $(PACKAGE).tgz  --exclude 'debug*' \
	--exclude '*~' --exclude '*.tgz' --exclude '*.zip'  \
	--exclude CVS $(CURRDIR); \
	mv $(PACKAGE).tgz $(CURRDIR); \
	cd $(CURRDIR)


zip:  all clean
	cd ..; \
	zip -r  $(PACKAGE).zip $(CURRDIR) \
	-x 'debug*' -x '*~' -x '*.tgz' -x '*.zip' -x CVS -x '*/CVS/*'; \
	mv $(PACKAGE).zip $(CURRDIR); \
	cd $(CURRDIR)
