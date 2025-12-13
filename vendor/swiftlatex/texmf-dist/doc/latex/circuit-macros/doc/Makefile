# The installed library directory, change this if necessary:
LIBDIR = ..

DOC = Circuit_macros
DOCSRC = Circuit_macros.tex body.tex defines.tex

PICTEX = \
  AmpTable.tex Antennas.tex Audio.tex Axes.tex \
  Buffer.tex BigResistor.tex Bip.tex \
  CctTable.tex Composite.tex ConfigA.tex ConfigB.tex ConfigC.tex Conn.tex \
  Corners.tex Contact.tex Contacts.tex \
  Dac.tex Darlington.tex Demultiplexer.tex Diodes.tex \
  Emarrows.tex FF.tex FlipFlop.tex \
  Flowdiag.tex Fuses.tex Grounds.tex \
  Headers.tex HybridPi.tex Jack.tex \
  Logic.tex Loop.tex Multiplexer.tex NPDT.tex NLG.tex Nport.tex \
  Oblique.tex Opamp.tex Opto.tex \
  ParSeries.tex Pconn.tex Potentiometers.tex Relay.tex relaycoil.tex \
  Series.tex ShiftR.tex Sinus.tex Sources.tex Switches.tex \
  Taps.tex Tgate.tex Thermal.tex Tline.tex Ttree.tex \
  Variable.tex Xform.tex Windings.tex Workflow.tex \
  bitr.tex bi_trans.tex \
  bistable.tex currents.tex eboxdims.tex fbfilter.tex fet.tex \
  lrarrows.tex mplex.tex oax.tex \
  quick.tex stringdims.tex thyristor.tex ujt.tex woodchips.tex

VERBATIM = BigResistor2.verb eboxdims.verb
BOXDIMS = Antennas.tex bi_trans.tex ConfigA.tex ConfigB.tex ConfigC.tex \
  Corners.tex \
  Dac.tex eboxdims.tex FlipFlop.tex \
  Opamp.tex ParSeries.tex Sinus.tex stringdims.tex Ttree.tex \
  Windings.tex woodchips.tex
# BOXDIMS = $(PICTEX)

LATEX = latex
M4 = m4 -I $(LIBDIR)
# If M4PATH has been set:
M4 = m4

# For gpic
MODE = gpic
PIC = gpic -t
PRE =
POST = ;printf '\\centerline{\\box\\graph}\n'
PST =

# For dpic; comment these to stick with gpic.
MODE = pstricks
PIC = dpic -p
# PIC = $$HOME/dpic/test/dpic -p
# PIC = $$HOME/dpic/p2c/ftp/dpic -p
PRE =
POST =
#POST = ;printf '}%%'
PST = ;printf '\\usepackage{pstricks}\n' >> heading.tex
# PST = ;printf '\\usepackage{tikz}\n' >> heading.tex

SFX = dvi

M4LIBS = $(MODE).m4
.SUFFIXES: .tex .m4
.m4.tex: $*.m4
	touch $(DOC).dim
	$(M4) $(M4LIBS) $(DOC).dim $*.m4 > $*.pic
	($(PRE) $(PIC) $*.pic $(POST)) > $*.tex

$(DOC).pdf:
	touch mode.tex
	-if grep -q tikz mode.tex ; then true ; else \
           make clean ; printf "\\usepackage{tikz}\n" > mode.tex ; fi
	make MODE=pgf PIC="dpic -g" LATEX=pdflatex SFX=pdf \
         POST="; printf '\\\\vspace*{-0.5\\\\baselineskip}\\n'" \
         $(DOC).pdf
	optpdf $(DOC).pdf
	chmod 644 $(DOC).pdf
	
$(DOC).ps:
	printf "\n $(DOC).ps:\n\n"
	make MODE=pstricks PIC="dpic -p" LATEX=latex SFX=dvi POST="" $(DOC).dvi
	dvips -t letter $(DOC) -o

$(DOC).$(SFX): mode.tex citations $(PICTEX)
	@printf "\n $(DOC).SFX=$(DOC).$(SFX):\n\n"
	$(LATEX) $(DOC) ; bibtex $(DOC)
    -@if grep -s "Warning: Reference " $(DOC).log ; then \
           @printf "\n Warning:\n\n" ; \
           $(LATEX) $(DOC) ; bibtex $(DOC) ; \
         elif test ! -f $(DOC).$(SFX) ; then\
           @printf "\n No file $(DOC).$(SFX)\n\n" ; \
           $(LATEX) $(DOC) ; bibtex $(DOC) ; fi

citations: mode.tex $(DOC).bbl $(PICTEX)
	@printf "\n citations:\n\n"
	$(LATEX) $(DOC) ; bibtex $(DOC)
	touch citations

$(DOC).bbl: $(DOC).bib $(DOC).aux
	bibtex $(DOC)

$(DOC).aux: mode.tex $(DOCSRC) heading.tex $(VERBATIM) $(PICTEX)
	@printf "\n $(DOC).aux:\n\n"
	$(LATEX) $(DOC) ; bibtex $(DOC)
	rm -f $(BOXDIMS)
	make $(BOXDIMS)

mode.tex:
	-if test "$(MODE)" = "pstricks" ; then \
	printf "\\usepackage{pstricks}\n" > mode.tex ; else \
	printf "\\usepackage{tikz}\n" > mode.tex ; fi

heading.tex:
	printf '\\documentclass{article}\n' > heading.tex
	printf '\\usepackage{verbatim,url}\n' >> heading.tex
	printf '\\usepackage{multicol}\n' >> heading.tex
	printf '\\usepackage{amssymb,boxdims}\n' >> heading.tex $(PST)

oax.tex tran.tex bitr.tex: oax.m4
	$(M4) $(M4LIBS) $*.m4 > $*.pic
	$(PIC) $*.pic > $*.tex

pics: $(PICTEX)

BigResistor2.verb: BigResistor.m4
	( printf '\\begin{verbatim}\n'; \
           sed -n '/thinlines/,/PE/p' BigResistor.m4 ;\
    printf '\\end{verbatim}\n' ) > BigResistor2.verb

eboxdims.verb: eboxdims.m4
	( printf '\\begin{verbatim}\n' ; \
           sed -e '/thinlines/,$$d' eboxdims.m4 ; \
    printf '.PE\n\\end{verbatim}\n' ) > eboxdims.verb

ex08.m4: ../examples/ex08.m4
	cp ../examples/ex08.m4 ex08.m4

clobber: clean
	rm -f *.dvi Circuit_macros.pdf

clean:
	rm -f *.bbl *.log *.aux *.blg *.toc citations *.verb ex08.m4
	rm -f *.pic $(PICTEX) heading.tex *.dim *.uu Circuit_macros.ps
	rm -f mode.tex Circuit_macros.out *.upa *.upb *.brf Circuit_macros.dvi
