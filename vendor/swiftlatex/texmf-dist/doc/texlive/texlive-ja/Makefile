# $Id: Makefile 54322 2020-03-15 18:10:11Z karl $
# public domain
doc = texlive-ja
latex = uplatex
post = && dvipdfmx $(doc)
all: pdf

env = TEXINPUTS=..:; export TEXINPUTS;

pdf:
	rm -f *.aux *.toc *.lof *.lot *.xref* *.tmp *.out
	$(env) texfot $(latex) --file-line-error '\nonstopmode\def\Status{1}\input $(doc)' $(post)
	$(env) $(latex) '\nonstopmode\def\Status{1}\input $(doc)'
	$(env) $(latex) '\nonstopmode\def\Status{1}\input $(doc)'

clean:
	rm -f *.aux *.log *.blg *.toc *.out *.lot tex4ht.ps *.4*
	rm -f *.xref* *.lg *.idv *.out *.otc *.tmp tmp.*
	rm -f $(doc).dvi $(doc).ps

realclean: clean
	rm -f $(doc).pdf
	rm -f *.html *.htm $(doc).css *.gif *.jpg
