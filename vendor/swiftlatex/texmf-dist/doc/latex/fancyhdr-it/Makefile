SHELL = /bin/sh

OUTPUTS = itfancyhdr.dvi itfancyhdr.ps itfancyhdr.pdf

FILES = $(OUTPUTS) itfancyhdr.tex README

all: 	itfancyhdr.dvi itfancyhdr.ps itfancyhdr.pdf

itfancyhdr.dvi:
	@mkdir texbuild
	export TEXINPUTS=`pwd .`: ; cd texbuild ;\
	latex itfancyhdr ; latex itfancyhdr ; latex itfancyhdr ;\
	/usr/bin/makeindex itfancyhdr ; latex itfancyhdr ; mv itfancyhdr.dvi ..
	rm -Rf texbuild

itfancyhdr.ps: itfancyhdr.dvi
	dvips -ta4 -oitfancyhdr.ps itfancyhdr.dvi

itfancyhdr.pdf:
	@mkdir pdfbuild
	export TEXINPUTS=`pwd .`: ; cd pdfbuild ;\
	pdflatex itfancyhdr ; pdflatex itfancyhdr ; pdflatex itfancyhdr ;\
	/usr/bin/makeindex itfancyhdr ;  pdflatex itfancyhdr ;\
	thumbpdf itfancyhdr ; pdflatex itfancyhdr ; mv itfancyhdr.pdf .. 		
	rm -Rf pdfbuild

ctan: 	all
	zip itfancyhdr.zip $(FILES)

clean:
	rm -f $(OUTPUTS)
    