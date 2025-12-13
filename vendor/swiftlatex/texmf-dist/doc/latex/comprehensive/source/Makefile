#############################################
# Build the Comprehensive LaTeX Symbol List #
# By Scott Pakin <scott+clsl@pakin.org>     #
#############################################

# Define TARGETS as a list of all of the files we intend to generate.
# TARGETS is categorized into TARGETS_SOURCE and TARGETS_DIST.
# TARGETS_DIST comprise the prebuilt distribution of the Comprehensive
# LaTeX Symbol List.  TARGETS_SOURCE are needed primarily to build
# TARGETS_DIST, although they are also distributed (in a "source"
# subdirectory).
TARGETS = $(TARGETS_SOURCE) $(TARGETS_DIST)
TARGETS_DIST = symbols-letter.pdf symbols-a4.pdf \
	       rawtables-letter.pdf rawtables-a4.pdf \
	       SYMLIST README
TARGETS_SOURCE = lightbulb.eps lightbulb10.pfb lightbulb.map

# There are a few files that we didn't generate but that need to be
# distributed.
EXTRADIST = symbols.tex lightbulb10.mf lightbulb.mf \
	    symbols.ist fakego.sty unicode2eps.pe fakeold-arrows.sty \
	    makefakeMnSymbol teubner-subset.sty fakemusixtex.sty \
	    fakearevmath.sty fakedozenal.sty fakelatexsym.sty \
	    makefakefdsymbol makefakeboisik fakearcs.sty fakeallrunes.sty \
	    makefakestix makefakestarfont makerawtables \
	    Makefile

# All formats of the symbol list depend upon the following files.
COMMONDEPS = symbols.tex symbols.ist fakeMnSymbol.sty teubner-subset.sty \
	     fakemusixtex.sty fakeknitting.sty fakefdsymbol.sty \
	     fakeboisik.sty fakestix.sty fakearcs.sty fakeold-arrows.sty \
	     fakearevmath.sty fakedozenal.sty fakelatexsym.sty \
	     fakestarfont.sty nonlatex versatim.tex junicode lilyglyphs \
	     fakeallrunes.sty \
	     $(TARGETS_SOURCE)

# The following non-LaTeX files will be copied to the current
# directory if they exist so LaTeX can find them.
NONLATEX = hands.mf greenpoint.mf nkarta.mf astrosym.mf WebOMintsGD.pfb \
	   moonphase.mf dancers.mf smfpr10.mf umranda.mf umrandb.mf \
	   cryst.mf dice3d.mf magic.mf fselch10.mf Junicode.ttf msym10.tfm \
	   knot1.mf knot2.mf knot3.mf knot4.mf knot5.mf knot6.mf knot7.mf

# We need FontForge (or the older PfaEdit) to generate lightbulb10.pfb.
FONTFORGE = fontforge

# Specify how much process parallelism we should employ in xargs invocations.
PARXARGS = 8

# The following should be overwritten in a recursive call to Make.
SIZE = letter
EXT = pdf

# I've had some trouble using sh as the shell.  bash seems to work, though.
SHELL = /bin/bash

###########################################################################

# Build all specified formats in all specified paper sizes.
all: $(TARGETS_DIST)

.PHONY: all symbols nonlatex dist clean mostlyclean

###########################################################################

# Define generic rules for building pdf/dvi/ps in letter/a4 size.
symbols: $(COMMONDEPS)
	# Pass 1: Produce an initial build of the document.
	$(LATEX) -jobname symbols-$(SIZE)-$(EXT) '\PassOptionsToClass{$(SIZE)paper}{article}\input symbols'
	# Pass 2a: Build a second time to produce a final page layout (one hopes).
	$(LATEX) -jobname symbols-$(SIZE)-$(EXT) '\PassOptionsToClass{$(SIZE)paper}{article}\input symbols'
	# Pass 2b: Create an index based on the current layout.  We do some
	# preprocessing of the .idx file to improve the sorting order.
	perl -ne 's/\{(\d+)\}=/sprintf " {%03d}=", $$1/ge; s/\(\\(\S+)\s*\)/\(\\$$1\)/; print' < symbols-$(SIZE)-$(EXT).idx > symbols-$(SIZE)-$(EXT).tmp
	mv symbols-$(SIZE)-$(EXT).tmp symbols-$(SIZE)-$(EXT).idx
	makeindex -s symbols.ist symbols-$(SIZE)-$(EXT)
	# Pass 3a: Build the document with the newly generated index.
	$(LATEX) -jobname symbols-$(SIZE)-$(EXT) '\PassOptionsToClass{$(SIZE)paper}{article}\input symbols'
	# Pass 3b: Get a final symbol count, and put it in the .aux file.
	# Also, patch the hyperlink bookmarks since we can't do that from
	# within the document.
	totalsymbols=`fgrep -c '\item \verb' symbols-$(SIZE)-$(EXT).ind` ; \
	  ( fgrep -v prevtotalsymbols symbols-$(SIZE)-$(EXT).aux > symbols-$(SIZE)-$(EXT).pts ; \
	    echo "\\gdef\\prevtotalsymbols{$$totalsymbols}" ; \
	    echo "\\gdef\\approxcount{}" ) >> symbols-$(SIZE)-$(EXT).pts ; \
	  mv symbols-$(SIZE)-$(EXT).pts symbols-$(SIZE)-$(EXT).aux
	if [ -e symbols-$(SIZE)-$(EXT).out ] ; then \
	  cat symbols-$(SIZE)-$(EXT).out | \
	    perl -ne 's/\[[^\]]*\](?=\w)//g; print' > symbols-$(SIZE)-$(EXT).tmp ; \
	  mv symbols-$(SIZE)-$(EXT).tmp symbols-$(SIZE)-$(EXT).out ; \
	fi
	# Pass 4: Build the final document using the final symbol count
	# and with the table of contents and PDF bookmarks correctly
	# reflecting the index pages.  We don't use our custom latex
	# format here because it interferes with cmap.sty.
	$(LATEX) -jobname symbols-$(SIZE)-$(EXT) '\PassOptionsToClass{$(SIZE)paper}{article}\input symbols'
	mv symbols-$(SIZE)-$(EXT).$(EXT) symbols-$(SIZE).$(EXT)
	-@(grep --color -E "^.*multiply.defined.*" symbols-$(SIZE)-$(EXT).log ; true)
	-@(grep --color -E "^.*undefined.*" symbols-$(SIZE)-$(EXT).log | grep -v U/stmry/b/n ; true)

###########################################################################

# Define specific rules for building different formats and sizes.
symbols-a4.pdf symbols-a4-pdf.log symbols-a4-pdf.ind: $(COMMONDEPS)
	$(MAKE) $(MAKEFLAGS) SIZE=a4 LATEX=pdflatex EXT=pdf symbols

symbols-letter.pdf symbols-letter-pdf.log symbols-letter-pdf.ind: $(COMMONDEPS)
	$(MAKE) $(MAKEFLAGS) SIZE=letter LATEX=pdflatex EXT=pdf symbols

symbols-a4.dvi symbols-a4-dvi.log symbols-a4-dvi.ind: $(COMMONDEPS)
	$(MAKE) $(MAKEFLAGS) SIZE=a4 LATEX=latex EXT=dvi symbols

symbols-letter.dvi symbols-letter-dvi.log symbols-letter-dvi.ind: $(COMMONDEPS)
	$(MAKE) $(MAKEFLAGS) SIZE=letter LATEX=latex EXT=dvi symbols

symbols-letter.ps: symbols-letter.dvi
	dvips -t letter -Pamz -Pcmz -j0 -o symbols-letter.ps symbols-letter.dvi

symbols-a4.ps: symbols-a4.dvi
	dvips -t a4 -Pamz -Pcmz -j0 -o symbols-a4.ps symbols-a4.dvi


rawtables-letter.tex rawtables.list testfont.pdf testfont.log: makerawtables $(COMMONDEPS)
	perl makerawtables --paper=letter

rawtables-letter.pdf: rawtables-letter.tex
	pdftex rawtables-letter.tex

rawtables-a4.tex rawtables.list testfont.pdf testfont.log: makerawtables $(COMMONDEPS)
	perl makerawtables --paper=a4

rawtables-a4.pdf: rawtables-a4.tex
	pdftex rawtables-a4.tex

###########################################################################

# Define rules to produce a lightbulb proof figure.
mfplain.mem:
	mpost -ini '\input mfplain; dump'

lightbulb.eps: lightbulb10.mf lightbulb.mf mfplain.mem
	mpost -mem=mfplain '\mode:=proof; prologues:=2; labelfont cmr17; input lightbulb10'
	mv lightbulb10.65 lightbulb.eps

# Generate a FontForge script that makes the LightBulb10 PostScript
# names mixed case.
lightbulb10.pe:
	echo 'Open($$1);' > $@
	echo 'LB = "LightBulb";' >> $@
	echo 'SetFontNames(LB+"10", LB, LB+"10");' >> $@
	echo 'Generate("lightbulb10.pfb");' >> $@

# Define a rule to produce a Type 1 version of the LightBulb10 font.
lightbulb10.pfb: lightbulb10.mf lightbulb10.pe
	mftrace -V -fpfb --simplify lightbulb10
	$(FONTFORGE) -script lightbulb10.pe lightbulb10.pfb

# Define a rule to produce a LightBulb font-mapping file.
lightbulb.map:
	echo "lightbulb10 LightBulb10 <lightbulb10.pfb" > lightbulb.map

###########################################################################

# If we have MnSymbol.sty, generate a faked version that does not
# declare any new math alphabets.
fakeMnSymbol.sty: makefakeMnSymbol
	if [ "`kpsewhich MnSymbol.sty`" ] ; then \
	  ./makefakeMnSymbol `kpsewhich MnSymbol.sty` > $@ ; \
	else \
	  ./makefakeMnSymbol /dev/null > $@ ; \
	fi

# If we have fdsymbol.sty, generate a faked version that does not
# declare any new math alphabets.
fakefdsymbol.sty: makefakefdsymbol
	if [ "`kpsewhich fdsymbol.sty`" ] ; then \
	  ./makefakefdsymbol `kpsewhich fdsymbol.sty` > $@ ; \
	else \
	  ./makefakefdsymbol /dev/null > $@ ; \
	fi

# If we have boisik.sty, generate a faked version that does not
# declare any new math alphabets.
fakeboisik.sty: makefakeboisik
	if [ "`kpsewhich boisik.sty`" ] ; then \
	  ./makefakeboisik `kpsewhich boisik.sty` > $@ ; \
	else \
	  ./makefakeboisik /dev/null > $@ ; \
	fi

# If we have Junicode.ttf, extract the versicle and response
# characters as graphical images.  This enables the font to work in
# any TeX engine and without any helper .tfm or .enc files.
junicode: unicode2eps.pe
	test -e junicode || mkdir junicode
	if [ "`kpsewhich Junicode.ttf`" ] ; then \
	  cd junicode ; \
	  $(FONTFORGE) -script ../unicode2eps.pe `kpsewhich Junicode.ttf` 0x2123 0x211F ; \
	  ls *.eps | xargs -P$(PARXARGS) -t -i epstopdf '{}' ; \
	  true ; \
	fi

# If we have knitting.sty, generate a truncated version that excludes
# some catcode trickery which breaks mylatex.ltx.
fakeknitting.sty:
	echo "% This is a truncated version of knitting.sty for use only" > $@
	echo "% with the Comprehensive LaTeX Symbol List." >> $@
	echo "" >> $@
	if [ "`kpsewhich knitting.sty`" ] ; then \
	  cat `kpsewhich knitting.sty` | sed '/Standard chart commands/,$$d' >> $@ ; \
	fi

# If we have stix.sty, generate a faked version that does not
# declare any new math alphabets.
fakestix.sty: makefakestix
	if [ "`kpsewhich stix.sty`" ] ; then \
	  ./makefakestix `kpsewhich stix.sty` > $@ ; \
	else \
	  ./makefakestix /dev/null > $@ ; \
	fi

# If we have starfont.sty, generate a faked version that does not
# declare any new math alphabets.
fakestarfont.sty: makefakestarfont
	if [ "`kpsewhich starfont.sty`" ] ; then \
	  ./makefakestarfont `kpsewhich starfont.sty` > $@ ; \
	else \
	  ./makefakestarfont /dev/null > $@ ; \
	fi

# The apl package's versatim.tex messes up TeX's category codes.
# Hence, we override that file with a do-nothing version.
versatim.tex:
	echo "% Do-nothing replacement for the apl package's versatim.tex" > $@
	echo "\\endinput" >> $@

# If we have the Emmentaler music fonts, convert each glyph to a
# graphical image, which we place in our lilyglyphs subdirectory.
# With a few command redefinitions, this enables us to use lilyglyphs
# without requiring XeLaTeX or LuaLaTeX.
lilyglyphs: extract-by-name.pe
	test -e lilyglyphs || mkdir lilyglyphs
	if [ "`kpsewhich emmentaler-16.otf`" ] ; then \
	  cd lilyglyphs ; \
	  $(FONTFORGE) -script ../extract-by-name.pe `kpsewhich emmentaler-16.otf` ; \
	  mv accidentals.sharp.slashslashslash.stemst.eps accidentals.sharp.slashslashslash.stemstem.eps ; \
	  mv accidentals.sharp.slashslash.stemstemste.eps accidentals.sharp.slashslash.stemstemstem.eps ; \
	  ls *.eps | xargs -P$(PARXARGS) -t -i epstopdf '{}' ; \
	  rm -f lilyglyphs_logo.pdf ; \
	  ln -s -f `texdoc -l -I lilyglyphs_logo.pdf | awk 'NR==1 {print $$2}'` . ; \
	fi

# Generate a FontForge script that extracts all symbols from a font
# into named, (rather than numbered, as does unicode2eps.pe) EPS
# files.
extract-by-name.pe:
	echo 'Open($$1)' > $@
	echo 'Select(0x0000, 0xFFFF)' >> $@
	echo 'Export("%n.eps")' >> $@

###########################################################################

nonlatex:
	for fname in $(NONLATEX) ; do \
	  $(RM) $$fname ; \
	  fullfname=`kpsewhich $$fname` ; \
	  if [ "$$fullfname" ] ; then \
	    ln -s -f $$fullfname . ; \
	  fi \
	done

###########################################################################

# The index is needed to produce a list of symbols.  We arbitrarily
# use the symbols-letter-pdf.ind version of the index.
symbols.ind: symbols-letter-pdf.ind
	cp symbols-letter-pdf.ind symbols.ind

# Create a list of all symbols.
SYMLIST: symbols.ind
	cat symbols.ind | perl -ne 's/.*\\verb\+([^+]+)\+.*/$$1/g && print' | sort -u > SYMLIST

# Create a README file.
README: makeREADME symbols-letter-pdf.log symbols.ind
	./makeREADME symbols-letter-pdf.log symbols.ind > README

# Prepare to timestamp the distributed symbols.tex file.
TODAY = $(shell date +'%d %B %Y')
NOW = $(shell date +'%T %Z')

# Create a .tar.gz file.
comprehensive.tar.gz: $(TARGETS) $(EXTRADIST)
	$(RM) -r comprehensive
	mkdir comprehensive
	mkdir comprehensive/source
	install -m 664 $(TARGETS_DIST) comprehensive
	install -m 664 $(TARGETS_SOURCE) $(EXTRADIST) comprehensive/source
	cat symbols.tex | \
	  perl -ne 's/(date\s*=\s*)\"[^\"]*\"/$$1\"$(TODAY)\"/; print' | \
	  perl -ne 's/(time\s*=\s*)\"[^\"]*\"/$$1\"$(NOW)\"/; print' | \
	  checksum > comprehensive/source/symbols.tex
	for fakes in MnSymbol fdsymbol boisik stix starfont ; do \
	  chmod 755 comprehensive/source/makefake$$fakes ; \
	done
	chmod 755 comprehensive/source/makerawtables
	chmod 664 comprehensive/source/symbols.tex
	tar -czf comprehensive.tar.gz comprehensive
	$(RM) -r comprehensive

dist: comprehensive.tar.gz

# Clean up our mess.
clean:
	$(RM) -r comprehensive
	$(RM) $(TARGETS)
	$(RM) symbols-*-*.{aux,dep,dvi,fmt,idx,ilg,inc,ind,log,out,pts,toc}
	$(RM) symbols.{aux,dep,dvi,fmt,idx,ilg,inc,ind,log,out,pts,toc}
	$(RM) symbols.pdf
	$(RM) $(NONLATEX)
	for fname in $(NONLATEX) ; do \
	  $(RM) `basename $$fname .mf`.*pk ; \
	  $(RM) `basename $$fname .mf`.tfm ; \
	done
	$(RM) comprehensive.tar.gz
	$(RM) -r junicode lilyglyphs
	$(RM) fakeMnSymbol.sty fakefdsymbol.sty fakeknitting.sty
	$(RM) fakeboisik.sty fakestix.sty fakestarfont.sty
	$(RM) versatim.tex extract-by-name.pe
	$(RM) mfplain.{log,mem}
	$(RM) lightbulb10*pk lightbulb10.{tfm,log,pe,afm}
	$(RM) lightbulb-eps-converted-to.pdf
	$(RM) rawtables-*.{log,tex,pdf} rawtables.list testfont.{log,pdf}
