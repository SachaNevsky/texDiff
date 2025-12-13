help:
	@echo "This is the makefile for the knowledge package"
	@echo "- all: produces knowledge.pdf knowledge.sty knowledge-code.pdf README.md"
	@echo "- clean"
	@echo "- knowledge.zip: a minimalistic install"
	@echo "- ctan: creates the knowledge-ctan.zip file tailored for CTAN"
	@echo "- sources: creates knowledge-sources-complete.zip"
	@echo "- publish: personal use"

all: knowledge.sty knowledge.pdf knowledge-code.pdf README.md

knowledge.sty: knowledge-code.dtx knowledge-utils.dtx knowledge-configuration.dtx knowledge.ins
	latex knowledge.ins

README.md: knowledge-code.dtx knowledge.ins
	latex knowledge.ins

clean:
	rm -f *.aux *.glo *.idx *.aux *.synctex.gz *.out *.toc *.kaux *.diagnose *.log
	rm -f *.bbl *.out *.bbl *.ind *.ilg *.idx
	rm -f knowledge.sty
	rm -f knowledge-code.pdf
	rm -f knowledge.pdf knowledge-utils.pdf knowledge-configuration.pdf knowledge-example.pdf
	rm -f knowledge-sources-complete.zip knowledge.zip
	rm -f knowledge-ctan.zip
	rm -f README.md
	make -CRegression clean


ctan: knowledge-ctan.zip

knowledge.pdf: knowledge.tex knowledge.sty
	pdflatex knowledge.tex
	pdflatex knowledge.tex
	pdflatex knowledge.tex

knowledge-code.pdf: knowledge-code.dtx knowledge.tex knowledge.sty
	pdflatex knowledge-code.dtx
	pdflatex knowledge-code.dtx
	pdflatex knowledge-code.dtx



knowledge.aux: knowledge.dtx knowledge.sty
	pdflatex knowledge.dtx

sources: clean knowledge-ctan.zip knowledge-sources-complete.zip

knowledge-sources-complete.zip: clean
	\rm -f knowledge-sources-complete.zip
	zip knowledge-sources-complete.zip *.* makefile Regression/*
	cp  knowledge-sources-complete.zip ../knowledge-sources-complete-`date +%y-%m-%d_%H:%M`.zip

knowledge-ctan.zip: knowledge.pdf knowledge.sty knowledge.ins README.md makefile
	rm -f knowledge-ctan.zip
	rm -rf knowledge
	mkdir knowledge
	cp knowledge.pdf knowledge/
	cp knowledge.tex knowledge/
	cp knowledge-code.dtx knowledge-utils.dtx knowledge-configuration.dtx knowledge/
	cp makefile knowledge.ins knowledge-example.tex README.md knowledge/
	zip knowledge-ctan.zip knowledge/*
	rm -rf knowledge


knowledge.zip: knowledge.pdf knowledge.sty knowledge-example.tex README.md
	rm -f knowledge.zip
	zip knowledge.zip knowledge.pdf knowledge.sty knowledge.example.tex

publish: knowledge.zip knowledge-ctan.zip
	cp knowledge.pdf ~/Travail/Web/public_html/Knowledge/
	cp knowledge.zip ~/Travail/Web/public_html/Knowledge/knowledge--lastversion.zip
	cp knowledge.zip ~/Travail/Web/public_html/Knowledge/knowledge-`date +%Y-%m-%d`.zip
	cp knowledge-ctan.zip ~/Travail/Web/public_html/Knowledge/knowledge-sources-`date +%Y-%m-%d`.zip


