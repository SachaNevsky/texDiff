#
# Wlodek Bzyl, <matwb@univ.gda.pl>
#
# 13.VI.2004

examples = catcode.tex list.tex tilde.tex tilde2.tex

logfiles = $(examples:%.tex=%.log)
dvifiles = $(examples:%.tex=%.dvi)
psfiles = $(examples:%.tex=%.ps)
pdffiles = $(examples:%.tex=%.pdf)

.SUFFIXES:
.SUFFIXES: .pdf .ps .dvi .tex

%.pdf : %.ps
	ps2pdf $<

%.ps : %.dvi
	dvips $< -o

%.dvi : %.tex
	tex -fmt utf8mex $<
#	utf8mex $<

clean :
	rm -f *~ \#* $(logfiles) $(dvifiles) $(psfiles) $(pdffiles)
