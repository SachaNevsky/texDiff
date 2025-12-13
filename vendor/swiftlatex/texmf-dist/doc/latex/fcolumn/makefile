.SUFFIXES: .pdf .glo .gls .ind .idx .dtx .sty .ins

.ins.sty:
	pdflatex $*.ins

.dtx.glo:
	pdflatex $*.dtx

.dtx.idx:
	pdflatex $*.dtx

.glo.gls:
	makeindex -s gglo.ist -o fcolumn.gls fcolumn.glo

.idx.ind:
	makeindex -s gind.ist -o fcolumn.ind fcolumn.idx

.dtx.pdf:
	pdflatex $*.dtx

all: fcolumn.pdf

install: 
	tex fcolumn.ins

dist: fcolumn.dtx fcolumn.ins fcolumn.sty fcolumn.pdf README makefile
	mkdir fcolumn; cp fcolumn.dtx fcolumn; cp fcolumn.ins fcolumn; \
 cp fcolumn.sty fcolumn; cp fcolumn.pdf fcolumn; cp README fcolumn; \
 cp makefile fcolumn; tar -czf fcolumn.tgz fcolumn; rm -r fcolumn

fcolumn.pdf: fcolumn.dtx fcolumn.gls fcolumn.ind fcolumn.sty
fcolumn.idx: fcolumn.dtx
fcolumn.ind: fcolumn.idx
fcolumn.glo: fcolumn.dtx
fcolumn.gls: fcolumn.glo

.PHONY: clean
clean:
	-rm fcolumn.pdf fcolumn.sty fcolumn.log fcolumn.glo fcolumn.gls \
     fcolumn.ind fcolumn.idx fcolumn.aux fcolumn.ilg
