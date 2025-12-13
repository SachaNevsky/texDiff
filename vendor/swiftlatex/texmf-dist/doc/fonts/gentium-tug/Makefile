# This file is part of the Gentium package for TeX.
# It is licensed under the Expat License, see doc//README for details.

env = TEXMFHOME=../../.. 
gentium.pdf: gentium.tex
	$(env) pdflatex '\nonstopmode\pdfsuppresswarningdupmap=1\pdfmapfile{+gentium-type1.map}\input $<'
# read the map file for running out of the development tree,
# without having the package installed, necessarily.

dist: clean
	cd ../../../source/fonts/gentium-tug \
	&& ./make-zip-4CTAN.sh -l

clean:
	rm -f *.aux *.log *.out *.toc
