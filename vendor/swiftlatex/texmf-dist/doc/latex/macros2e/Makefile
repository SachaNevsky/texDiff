.PHONY: doc clean

all: doc

doc: macros2e.pdf

macros2e.pdf: macros2e.tex
	pdflatex macros2e
	pdflatex macros2e
	pdflatex macros2e

clean:
	${RM} macros2e.pdf macros2e.aux macros2e.log macros2e.toc macros2e.out


