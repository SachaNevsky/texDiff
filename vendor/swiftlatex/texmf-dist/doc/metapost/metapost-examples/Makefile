METAPOST = mpost --interaction=nonstopmode

all:
	perl mp2html.pl

old_all:
	TEX=latex $(METAPOST) examples.mp

clean:
	rm -f examples.[0-9] examples.[0-9][0-9] examples.[0-9][0-9][0-9] *.mps
	rm -f examples.tex examples.ps examples.dvi examples.pdf
	rm -f *.dvi *.aux *.log *\~
	rm -f mpxerr.* *.mpx mptextmp.*
	rm -f nohup.out

cleanse: clean
	rm -f examples.[0-9].gif examples.[0-9][0-9].gif examples.[0-9][0-9][0-9].gif
	rm -f examples.[0-9].eps examples.[0-9][0-9].eps examples.[0-9][0-9][0-9].eps
	rm -f examples.[0-9].ps examples.[0-9][0-9].ps examples.[0-9][0-9][0-9].ps
	rm -f examples.[0-9].tex examples.[0-9][0-9].tex examples.[0-9][0-9][0-9].tex
	rm -f examples.html
