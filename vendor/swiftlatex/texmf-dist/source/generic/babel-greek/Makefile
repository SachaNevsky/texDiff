# This Makefile updates the source and documentation for the
# babel-greek LateX package
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
DESTDIR = ~/texmf/tex/latex/greek/babel-greek
DOCDIR = ~/texmf/doc/latex/greek/babel-greek

CHDIR = cd
COPY = cp -u
SH = sh

# programs
PYLIT = pylit         # text <-> source converter for literal programming
RST2HTML = rst2html5  # text -> HTML converter, see docutils.sf.net
RUBBER = rubber -f    # wrapper around `latex`, run until references resolved
LATEX = pdflatex -interaction batchmode # suppress logging to terminal

# LaTeX source files
# ==================

.PHONY: all

all: greek.ldf athnum.sty grmath.sty

greek.ldf: babel-greek.dtx
	tex babel-greek.ins

athnum.sty: athnum.dtx
	tex babel-greek.ins

grmath.sty: athnum.dtx
	tex babel-greek.ins

# Documentation
# =============

.PHONY: doc html pdf

doc: html pdf

html: README.html

README.html: README
	$(RST2HTML) README README.html


pdf: babel-greek.pdf athnum.pdf grmath.pdf usage.pdf\
     test-greek.pdf test-unicode-greek.pdf test-unicode-lgr.pdf

babel-greek.pdf: babel-greek.dtx
	$(RUBBER) --pdf babel-greek.dtx

athnum.pdf: athnum.dtx
	$(RUBBER) --pdf athnum.dtx

grmath.pdf: grmath.dtx
	$(RUBBER) --pdf grmath.dtx

usage.pdf: usage.tex greek.ldf
	$(RUBBER) --pdf usage.tex

test-greek.pdf: test-greek.tex greek.ldf
	$(RUBBER) --pdf test-greek.tex

test-unicode-greek.pdf: test-unicode-greek.tex greek.ldf
	$(RUBBER) -m xelatex test-unicode-greek.tex

test-unicode-lgr.pdf: test-unicode-lgr.tex greek.ldf
	$(RUBBER) -m xelatex test-unicode-lgr.tex


# Installation
# =============

install: all
	$(COPY) *.ldf $(DESTDIR)
	#$(COPY) *.sty $(DESTDIR)

install-doc: doc
	$(COPY) README $(DOCDIR)
	$(COPY) *.html $(DOCDIR)
	$(COPY) *.dtx $(DOCDIR)
	$(COPY) *.ins $(DOCDIR)
	$(COPY) *.tex $(DOCDIR)
	$(COPY) *.pdf $(DOCDIR)
	$(COPY) Makefile $(DOCDIR)

# Cleanup
# =======

.PHONY: clean

clean:
	rm -f *.aux *.log *.toc *~
