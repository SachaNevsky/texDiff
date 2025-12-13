smalltest: datetime2-basque-small-test.pdf
longtest: datetime2-basque-test.pdf 
test: smalltest longtest
doc: datetime2-basque.pdf
archive: datetime2-basque.zip

datetime2-basque-test.pdf: datetime2-basque.ldf datetime2-basque-test.tex
		pdflatex datetime2-basque-test.tex

datetime2-basque-small-test.pdf: datetime2-basque.ldf datetime2-basque-small-test.tex
		pdflatex datetime2-basque-small-test.tex

datetime2-basque.ldf: datetime2-basque.dtx datetime2-basque.ins
	pdflatex datetime2-basque.ins

datetime2-basque.pdf: datetime2-basque.dtx
	pdflatex datetime2-basque.dtx
	makeindex -s gind.ist datetime2-basque.idx
	makeindex -s gglo.ist -o datetime2-basque.gls datetime2-basque.glo
	pdflatex datetime2-basque.dtx
	pdflatex datetime2-basque.dtx

datetime2-basque.zip: datetime2-basque.dtx datetime2-basque.ins
	git archive --format=zip --prefix=datetime2-basque/ -o datetime2-basque.zip master
