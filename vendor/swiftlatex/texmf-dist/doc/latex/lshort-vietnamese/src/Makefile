# Copyright Reinhard Kotucha and Nguyen Tan Khoa
# License: LPPL version 1.3 or newer


default: print screen

screen:
	pdflatex lshort-vi.tex
	pdflatex lshort-vi.tex
	pdflatex lshort-vi.tex
	makeindex lshort-vi.idx
	pdflatex lshort-vi.tex
	thumbpdf lshort-vi.pdf
	pdflatex lshort-vi.tex

print:
	pdflatex lshort-print-vi.tex
	pdflatex lshort-print-vi.tex
	pdflatex lshort-print-vi.tex
	makeindex lshort-print-vi.idx
	pdflatex lshort-print-vi.tex

clean:
	rm -vf *.{aux,lo?,out,idx,toc,exa,ilg,ind,tpt}

distclean: clean
	rm *.pdf

ctan: screen print clean
	cp -pf README.txt ..
	mv *.pdf ..
	(cd ../.. && tar -czvf vietnamese.tar.gz vietnamese)


####

USER=reinhard-k@shells.sourceforge.net
DIR=home/groups/v/vn/vntex/htdocs/doc/lshort-vi

LSHORTDIR="$(USER):/$(DIR)"

vntex:
	cd .. && scp -pr * $(LSHORTDIR)