# Makefile for Serbian Translation of the TeX Live documentation.

TEX = lualatex
doc = texlive-sr
source = $(doc).tex
pdf = $(doc).pdf
html = ${doc}.html

all: realclean pdf

env = TEXINPUTS=../texlive-common:../texlive-en:images:; export TEXINPUTS;

one:
	$(env) $(TEX) $(source)

pdf:
	$(env) $(TEX) $(source)
	$(env) $(TEX) $(source)
	$(env) $(TEX) $(source)

clean:
	rm -f *.aux *.log *.blg *.toc *.out *.lot tex4ht.ps *.4*
	rm -f *.xref* *.lg *.idv *.out *.otc *.tmp tmp.*
	rm -f $(doc).dvi $(doc).ps $(doc).xdv

realclean: clean
	rm -f $(doc).pdf 
	rm -f *.html *.htm $(doc).css *.gif *.jpg $(doc).tec *~
