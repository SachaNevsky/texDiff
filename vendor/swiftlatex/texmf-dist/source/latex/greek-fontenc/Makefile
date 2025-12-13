# This Makefile updates the source and documentation for the
# greek-fontenc LateX package
#
# © 2019 Günter Milde
# 
# SRCDIR (and the other variables) can be easily modified as parameters
# while calling `make', e.g.
#
#   make install SRCDIR=~/texmf/tex/latex/

# Global variables
# =================

# for installation into a users local texmf tree
DESTDIR = ~/texmf/tex/latex/greek/greek-fontenc
DOCDIR = ~/texmf/doc/latex/greek/greek-fontenc

CHDIR = cd
COPY = cp -u
SH = sh

# programs
PYLIT = pylit         # text <-> source converter for literal programming
RST2HTML = rst2html5  # text -> HTML converter, see docutils.sf.net
RUBBER = rubber -f    # wrapper around `latex`, run until references resolved
LATEX = pdflatex -interaction batchmode

# LaTeX source files
# ==================

.PHONY: all font-encodings packages

all: font-encodings packages

# font encoding definition files
font-encodings: greek-fontenc.def lgrenc.def tuenc-greek.def greek-euenc.def 

tuenc-greek.def: tuenc-greek.def.txt
	$(PYLIT) $@.txt

greek-fontenc.def: greek-fontenc.def.txt
	$(PYLIT) $@.txt

lgrenc.def: lgrenc.def.txt
	$(PYLIT) $@.txt

# LaTeX packages
packages: textalpha.sty alphabeta.sty alphabeta-tuenc.def alphabeta-lgr.def

textalpha.sty: textalpha.sty.txt
	$(PYLIT) $@.txt

alphabeta.sty: alphabeta.sty.txt
	$(PYLIT) $@.txt

alphabeta-tuenc.def: alphabeta-tuenc.def.txt
	$(PYLIT) $@.txt

alphabeta-lgr.def: alphabeta-lgr.def.txt
	$(PYLIT) $@.txt

# Experimental files
lgr2licr.lua: lgr2licr.lua.txt
	$(PYLIT) $@.txt

# Documentation
# =============

.PHONY: doc html pdf

doc: html pdf


html: README.html tuenc-greek.def.html greek-fontenc.def.html lgrenc.def.html \
     textalpha.sty.html alphabeta.sty.html \
     alphabeta-tuenc.def.html alphabeta-lgr.def.html lgr2licr.lua.html

README.html: README
	$(RST2HTML) README README.html

tuenc-greek.def.html: tuenc-greek.def
	$(PYLIT) tuenc-greek.def
	$(RST2HTML) tuenc-greek.def.txt tuenc-greek.def.html

greek-fontenc.def.html: greek-fontenc.def
	$(PYLIT) greek-fontenc.def
	$(RST2HTML) greek-fontenc.def.txt greek-fontenc.def.html

lgrenc.def.html: lgrenc.def
	$(PYLIT) lgrenc.def
	$(RST2HTML) lgrenc.def.txt lgrenc.def.html

textalpha.sty.html: textalpha.sty
	$(PYLIT) textalpha.sty
	$(RST2HTML) textalpha.sty.txt textalpha.sty.html

alphabeta.sty.html: alphabeta.sty
	$(PYLIT) alphabeta.sty
	$(RST2HTML) alphabeta.sty.txt alphabeta.sty.html

alphabeta-tuenc.def.html: alphabeta-tuenc.def
	$(PYLIT) alphabeta-tuenc.def
	$(RST2HTML) alphabeta-tuenc.def.txt alphabeta-tuenc.html

alphabeta-lgr.def.html: alphabeta-lgr.def
	$(PYLIT) alphabeta-lgr.def
	$(RST2HTML) alphabeta-lgr.def.txt alphabeta-lgr.def.html

lgr2licr.lua.html: lgr2licr.lua
	$(PYLIT) lgr2licr.lua
	$(RST2HTML) lgr2licr.lua.txt lgr2licr.lua.html

# User documentation
# ==================

pdf: alphabeta-doc.pdf diacritics.pdf tuenc-greek-doc.pdf greekhyperref.pdf \
     lgrenc-test.pdf textalpha-doc.pdf

TEXTALPHA = textalpha.sty greek-fontenc.def
ALPHABETA = $(TEXTALPHA) alphabeta.sty

lgrenc-test.pdf: lgrenc-test.tex lgrenc.def greek-fontenc.def
	$(LATEX) lgrenc-test.tex

tuenc-greek-doc.pdf: tuenc-greek-doc.tex tuenc-greek.def greek-fontenc.def
	$(RUBBER) -m xelatex tuenc-greek-doc.tex

textalpha-doc.pdf: textalpha-doc.tex lgrenc.def $(TEXTALPHA)
	$(LATEX) textalpha-doc.tex

alphabeta-doc.pdf: alphabeta-doc.tex $(ALPHABETA) lgrenc.def
	$(LATEX) alphabeta-doc.tex

alphabeta-doc-tuenc.pdf: alphabeta-doc.tex $(ALPHABETA) tuenc-greek.def
	$(RUBBER) -m xelatex alphabeta-doc.tex
	mv alphabeta-doc.pdf alphabeta-doc-tuenc.pdf

greekhyperref.pdf: greekhyperref.tex $(ALPHABETA) lgrenc.def
	$(LATEX) greekhyperref.tex

diacritics.pdf: diacritics.tex lgrenc.def greek-fontenc.def
	$(LATEX) diacritics.tex


# Installation
# ------------

install: all
	$(COPY) *.def $(DESTDIR)
	$(COPY) *.sty $(DESTDIR)

install-doc: doc
	$(COPY) README $(DOCDIR)
	$(COPY) *.def $(DOCDIR)
	$(COPY) *.sty $(DOCDIR)
	$(COPY) *.lua $(DOCDIR)
	$(COPY) *.html $(DOCDIR)
	$(COPY) *.tex $(DOCDIR)
	$(COPY) *.pdf $(DOCDIR)
	$(COPY) Makefile $(DOCDIR)

# Cleanup
# -------
 
.PHONY: clean

clean:
	rm -f *.aux *.log *.toc *~
	
