XQ_0_3_STY = /usr/share/texmf-dist/tex/latex/xq/xq.sty

all: xqexample.pdf bugs-0-3.pdf

tmp:
	mkdir $@

xqexample.pdf: xqexample.tex xq.sty | tmp
	pdflatex -output-directory tmp $<
	mv -f tmp/$@ $@

xq-0-3.sty:
	test -L "${XQ_0_3_STY}" -o -f "${XQ_0_3_STY}"
	ln -s "${XQ_0_3_STY}" $@

bugs-0-3.pdf: bugs-0-3.tex | tmp xq-0-3.sty
	for i in 1 2 ; do pdflatex -output-directory tmp $< || exit 1 ; done
	pdflatex -output-directory tmp $<
	mv -f tmp/$@ $@

clean:
	rm -Rf tmp
	rm -f xqexample.pdf bugs-0-3.pdf xq.zip xq-0-3.sty

dist: all
	test $$(basename $${PWD}) == xq
	rm -f xq.zip
	cd .. && zip -9 xq/xq.zip xq/{xq.sty,xq*.mf,{xqexample,bugs-0-3}.{tex,pdf},ChangeLog,README,Makefile}

.PHONY: all dist clean
