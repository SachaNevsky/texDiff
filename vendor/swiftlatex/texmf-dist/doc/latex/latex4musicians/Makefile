# Makefile for latex4musicians.tex

VERSION  = 1.0.1
DATE     = 2019-01-17
NAME     = latex4musicians
MANUAL   = $(NAME).pdf
TEXFILES = $(NAME).tex params.tex

FIGURES = abctab.pdf bravura.pdf chordii.pdf chords.pdf gchords.pdf \
  gcschemes.pdf gdiagram.pdf glyphs.pdf glyphs_ls.pdf gtablature.pdf \
  gtrcrd.pdf guitar.pdf guitartabs.pdf jingle.pdf kyrie.pdf \
  leadsheets.pdf lilyglyphs.pdf lilytab.pdf musicography.pdf \
  musixguit.pdf songbook.pdf songs.pdf songs_g.pdf sample-abc.pdf \
  sample-abc-all.pdf sample-all.pdf sample-latexmtx.pdf \
  sample-lyluatex.pdf sample-lilybook.pdf sample-mtx.pdf \
  sample-pmw.pdf sample-mtex.pdf sample-mlatex.pdf \
  sample-songbook.pdf sheet.pdf verses-chords.pdf

$(MANUAL): $(TEXFILES) $(FIGURES) jingle.midi
	pdflatex $(NAME).tex; \
	pdflatex $(NAME).tex; \
	pdflatex $(NAME).tex

clean:
	/bin/rm -Rf *aux *.dep *.lo? *.out *.toc *log \
	*.ps *dvi *mx1 *.ps *.eps out-* *.mx1 *.gtex snippet* \
	*.count *.texi *xml Tmp/ tmp-ly/; \
	cd Figures; /bin/rm -Rf *aux *.dep *.lo? *.out *.toc *log \
	*.ps *dvi *mx1 *.ps *.eps out-* *.mx1 *.gtex snippet* \
	*.count *.texi *xml *pdf

OTHER = fellow.pdf happyb.pdf julia.pdf scale.pdf twinkle.pdf

cleanpdf:
	/bin/rm -f $(FIGURES) $(OTHER)

abctab.pdf: Figures/abctab.abc
	abc2xml.py -f Figures/abctab.abc > abctab.xml; \
	musescore abctab.xml -o abctab.pdf; 
	/bin/sh crop.sh abctab.pdf
bravura.pdf: Figures/bravura.tex
	/bin/sh ./pdfx.sh bravura.tex
chordii.pdf: Figures/chordii.cho
	chordii -a Figures/chordii.cho > chordii.ps; \
	ps2pdf chordii.ps; \
	/bin/sh crop.sh chordii.pdf
chords.pdf: Figures/chords.tex
	/bin/sh ./pdfl.sh chords.tex
gchords.pdf: Figures/gchords.tex
	/bin/sh ./pdfl.sh gchords.tex
gcschemes.pdf: Figures/gcschemes.tex
	/bin/sh ./pdfl.sh gcschemes.tex
gdiagram.pdf: Figures/gdiagram.tex
	/bin/sh ./pdfl.sh gdiagram.tex
glyphs.pdf: Figures/glyphs.tex
	/bin/sh ./pdfx.sh glyphs.tex
glyphs_ls.pdf: Figures/glyphs_ls.tex
	/bin/sh ./pdfx.sh glyphs_ls.tex
gtablature.pdf: Figures/gtablature.ly
	lilypond Figures/gtablature.ly ; \
	/bin/sh crop.sh gtablature.pdf
gtrcrd.pdf: Figures/gtrcrd.tex
	/bin/sh ./pdfl.sh gtrcrd.tex
guitar.pdf: Figures/guitar.tex
	/bin/sh ./pdfl.sh guitar.tex
guitartabs.pdf: Figures/guitartabs.tex
	/bin/sh ./pdfl.sh guitartabs.tex
jingle.pdf: Figures/./jingle.ly
	lilypond Figures/jingle.ly ; \
	/bin/sh crop.sh jingle.pdf
kyrie.pdf: Figures/kyrie.tex
	cd Figures; \
	lualatex kyrie.tex; \
	/bin/mv kyrie.pdf .. ; \
	cd .. \;
	/bin/sh crop.sh kyrie.pdf
leadsheets.pdf: Figures/leadsheets.tex
	/bin/sh ./pdfl.sh leadsheets.tex
lilytab.pdf: Figures/lilytab.ly
	lilypond Figures/lilytab.ly; \
	/bin/sh crop.sh lilytab.pdf
lilyglyphs.pdf: Figures/lilyglyphs.tex
	/bin/sh ./pdfx.sh lilyglyphs.tex
musicography.pdf: Figures/musicography.tex
	/bin/sh ./pdfl.sh musicography.tex
musixguit.pdf: Figures/musixguit.tex
	/bin/sh ./pdfl.sh musixguit.tex
songbook.pdf: Figures/songbook.tex
	/bin/sh ./pdfl.sh songbook.tex
songs.pdf: Figures/songs.tex
	/bin/sh ./pdfl.sh songs.tex
songs_g.pdf: Figures/songs_g.tex
	/bin/sh ./pdfl.sh songs_g.tex
sample-abc.pdf: Figures/sample-abc.tex
	cd Figures; \
	pdflatex --shell-escape sample-abc.tex ; \
	/bin/mv sample-abc.pdf .. ; \
	cd .. ; \
	/bin/sh crop.sh sample-abc.pdf
sample-abc-all.pdf: Figures/sample-abc-all.tex
	pdflatex --shell-escape Figures/sample-abc-all.tex ; \
	/bin/sh crop.sh sample-abc-all.pdf
sample-all.pdf: Figures/sample-all.tex
	cd Figures; \
	pdflatex -shell-escape sample-all.tex ; \
	/bin/mv sample-all.pdf .. ; \
	cd .. \;
	/bin/sh crop.sh sample-all.pdf
sample-latexmtx.pdf: Figures/sample-latexmtx.ltx
	cd Figures; \
	musixtex sample-mtx scale sample-latexmtx.ltx; \
	/bin/mv sample-latexmtx.pdf .. ; \
	cd .. ; \
	/bin/sh crop.sh sample-latexmtx.pdf
sample-lilybook.pdf: Figures/sample-lilybook.lytex
	lilypond-book -f latex -o ./Tmp/ \
	--lily-output-dir=./Tmp Figures/sample-lilybook.lytex; \
	cd ./Tmp; pdflatex sample-lilybook.tex; \
	/bin/cp ../*sh . ; /bin/sh ./crop.sh sample-lilybook.pdf; \
	/bin/mv -f sample-lilybook.pdf ..
sample-lyluatex.pdf: Figures/sample-lyluatex.tex
	lualatex --shell-escape Figures/sample-lyluatex.tex; \
	/bin/sh crop.sh sample-lyluatex.pdf
sample-mtx.pdf: Figures/sample-mtx.mtx
	cd Figures; \
	musixtex sample-mtx.mtx; \
	/bin/mv sample-mtx.pdf .. ; \
	cd .. ; \
	/bin/sh crop.sh sample-mtx.pdf
sample-musixtex-tab.pdf: Figures/sample-musixtex-tab.tex
	cd Figures; tex sample-musixtex-tab.tex; \
	dvips sample-musixtex-tab.dvi; ps2pdf sample-musixtex-tab.ps; \
	/bin/sh ../crop.sh sample-musixtex-tab.pdf; \
	/bin/mv -f sample-musixtex-tab.pdf ..
sample-mtex.pdf: Figures/sample-mtex.tex
	cd Figures; tex sample-mtex.tex; \
	dvips sample-mtex.dvi; ps2pdf sample-mtex.ps; \
	/bin/sh ../crop.sh sample-mtex.pdf; \
	/bin/mv -f sample-mtex.pdf ..
sample-mlatex.pdf: Figures/sample-mlatex.tex
	/bin/sh ./pdfl.sh sample-mlatex.tex
sample-pmw.pdf: Figures/sample-pmw.pmw
	pmw -includefont Figures/sample-pmw.pmw; \
	ps2pdf Figures/sample-pmw.ps ; \
	/bin/mv Figures/sample-pmw-pdf; \
	/bin/sh crop.sh sample-pmw.pdf
sample-songbook.pdf: Figures/sample-songbook.tex
	cd Figures; \
	make -f Makefile.sb; \
	/bin/mv sample-songbook.pdf ..
sheet.pdf: Figures/./sheet.abc
	abcm2ps -c -O= Figures/sheet.abc;
	ps2pdf sheet.ps; \
	/bin/sh crop.sh sheet.pdf
verses-chords.pdf: Figures/verses-chords.tex
	/bin/sh ./pdfl.sh verses-chords.tex


# End of Makefile
