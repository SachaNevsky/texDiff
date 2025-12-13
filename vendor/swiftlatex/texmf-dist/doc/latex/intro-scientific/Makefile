TEXFILES=scidoc.tex

scidoc.pdf: scidoc.tex
	pdflatex scidoc
	pdflatex scidoc
	pdflatex scidoc

all: scidoc.pdf

read: scidoc.pdf
	acroread scidoc.pdf

clean:
	rm -f *.aux *.toc *.log *.out

veryclean: clean
	rm -f scidoc.pdf
