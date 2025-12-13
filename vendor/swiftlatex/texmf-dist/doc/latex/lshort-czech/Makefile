SHELL = /bin/sh
VERS = 4.27

# Define some variables
#LATEX=latex
#DVIPS=dvips
#MAKEINDEX=makeindex
PDFLATEX=pdflatex
FILE=lshort-cs
PACKAGE=lshort-czech
TOFILE=$(PACKAGE)-$(VERS).src+build.tar.gz

#OTHER = README CHANGES
FILES = README CHANGES MANIFEST Makefile \
	src/biblio.tex src/math.tex src/things.tex src/contrib.tex \
	src/lshort.sty src/mylayout.sty src/title.tex src/custom.tex \
	src/overview.tex src/typeset.tex src/fancyhea.sty src/lssym.tex \
	src/spec.tex src/lshort-base.tex src/graphic.tex \
	src/$(FILE).tex src/$(FILE)-a5.tex 

all: fast

fast: $(FILES)
	-mkdir pdfbuild
	(T1FONTS=.:`pwd`/eurofont: && \
	export T1FONTS && \
	TEXINPUTS=.:`pwd`/src:`pwd`/euro:${TEXINPUTS:-:} && \
	export TEXINPUTS && \
	cd pdfbuild && \
	$(PDFLATEX) $(FILE) && \
	#$(MAKEINDEX) -s ../src/lshort.ist $(FILE).idx && \
	mv $(FILE).pdf .. && \
	echo -n )

final: $(FILES) 
	-mkdir pdfbuild
	cp src/$(FILE).ind pdfbuild/ 
	(T1FONTS=.:`pwd`/eurofont: && \
	export T1FONTS && \
	TEXINPUTS=.:`pwd`/src:`pwd`/euro:${TEXINPUTS:-:} && \
	export TEXINPUTS && \
	cd pdfbuild && \
	#$(PDFLATEX) $(FILE) && \
	#  old approach: $(MAKEINDEX) -s ../src/lshort.ist $(FILE) && \
	#  External work needed here as xindy isn't working on my computer; \
	#  that's known problem with different CLISP versions, though I haven't solved that. \
	#  cp1250 or latin2 \
	#texindy -M latex -L czech -C latin2 -o temp.ind $(FILE).idx \
		#cat temp.ind | sed " \
		#s/lettergroupDefault{default}/lettergroup{Symboly}/; \
		#s/lettergroup{\xC8}/lettergroup{\\\\v{C}}/; \
		#s/lettergroup{\xD8}/lettergroup{\\\\v{R}}/; \
		#s/lettergroup{\x8A}/lettergroup{\\\\v{S}}/; \
		#">$(FILE).ind && \
	#rm -f temp.ind && \
	$(PDFLATEX) $(FILE) && \
	$(PDFLATEX) $(FILE) && \
	thumbpdf --resolution 10 $(FILE).pdf && \
	$(PDFLATEX) $(FILE) && \
	mv $(FILE).pdf .. && \
	echo -n )
	#tar:	$(FILES)
	#rm -f $(PACKAGE)-$(VERS)
	ln -s . $(PACKAGE)-$(VERS)
	tar -zcvf $(TOFILE) `awk '{print "$(PACKAGE)-$(VERS)/"$$1}' MANIFEST`
	rm -f $(PACKAGE)-$(VERS)

extra:
	rm -f src/$(FILE).ind

clear: 
	# Dear Pavel, use "make clean" instead of "make clear" here!

clean:
	rm -f pdfbuild/*
	-rmdir pdfbuild
	rm -f $(FILE).pdf
	rm -f $(TOFILE)
	rm -f texput.log
	rm -f $(PACKAGE)-$(VERS)


