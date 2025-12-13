#-----------------------------------------------------------------------
# Purpose: generation of the documentation of the listings-ext package
# Notice:  this file can be used without any change only with dmake and
#          the option "-B", this option lets dmake interpret the leading
#          spaces as distinguishing characters for commands in the make
#          rules.
#          The necessary changes for the common make can be applied by
#          the script listings-ext.makemake
#
# Rules:
#          - all:            generate all the files and the basic
#                            documentation
#          - develop:        generate the documentation with revision
#          - develop-pdf:    history and source code (the latter provides
#                            a .pdf file as output)
#          - history:        generate the documentation with revision
#          - history-pdf:    history (the latter provides a .pdf file as
#                            output)
#          - examples:       format the examples
#          - install:        install the package in a standard TDS tree
#          - uninstall:      uninstall the package from a standard TDS
#                            tree
#          - clean:          clean the directory of intermediate files
#          - clean-examples:                    example and test files
#          - clean-support:                     support files
#          - realclean:                         all but the pure source
#                                               files
#          - tar-src:        create a gzipped .tar-file of the pure
#                            source files
#          - tar-dist:       create a gzipped .tar-file containing
#                            version information
#
# Author:  Jobst Hoffmann, Fachhochschule Aachen, Campus Juelich
# $Date: 2010-06-29 18:38:12 +0200 (Di, 29 Jun 2010) $
#-----------------------------------------------------------------------

# The texmf-directory, where to install new stuff (see texmf.cnf)
# If you don't know what to do, search for directory texmf at /usr.
# With teTeX and linux often one of following is used:
#INSTALLTEXMF=/usr/TeX/texmf
#INSTALLTEXMF=/usr/local/TeX/texmf
#INSTALLTEXMF=/usr/share/texmf
#INSTALLTEXMF=/usr/local/share/texmf
# user tree:
#INSTALLTEXMF=$(HOME)/texmf
# Try to use user's tree known by kpsewhich:
INSTALLTEXMF=`kpsewhich --expand-var '$$TEXMFHOME'`
# Try to use the local tree known by kpsewhich:
#INSTALLTEXMF=`kpsewhich --expand-var '$$TEXMFLOCAL'`
# But you may set INSTALLTEXMF to every directory you want.
# Use the following, if you only want to test the installation:
#INSTALLTEXMF=/tmp/texmf

# If texhash must run after installation, you can invoke this:
TEXHASH=texhash

# change this to the directory which contains the graphic files
GRAPHICPATH=.

######### Edit the following only, if you want to change defaults!

# The directory, where to install *.cls and *.sty
CLSDIR=$(INSTALLTEXMF)/tex/latex/jhf/$(PACKAGE)

# The directory, where to install documentation
DOCDIR=$(INSTALLTEXMF)/doc/latex/jhf/$(PACKAGE)

# The directory, where to install the sources
SRCDIR=$(INSTALLTEXMF)/source/latex/jhf/$(PACKAGE)

# The directory, where to install demo-files
# If we have some, we have to add following 2 lines to install rule:
#     $(MKDIR) $(DEMODIR); \
#     $(INSTALL) $(DEMO_FILES) $(DEMODIR); \
DEMODIR=$(DOCDIR)/demo

# We need this, because the documentation needs the classes and packages
# It's not really a good solution, but it's a working solution.
TEXINPUTS := $(PWD):$(TEXINPUTS)

# To generate the version number of the distribution from the source
VERSION_L := latex getversion | grep '^VERSION'
VERSION_S := `latex getversion | grep '^VERSION' | \
             sed 's+^VERSION \\(.*\\) of .*+\\1+'`
########################################################################
#   End of customization section
########################################################################

# formatting tools
BIBTEX = bibtex
DVIPS = dvips
LATEX = latex
PDFLATEX = pdflatex
TEX = tex
PS2PDF = ps2pdf

# postscript viewer
GV = gv

# tarring options
DATE = `date +%Y-%m-%d`
TAR_SRC = $(PACKAGE)_$(DATE)_source.tar.gz
EXsvn = --exclude .svn --exclude auto

# formatting options
COMMON_OPTIONS =
HISTORY_OPTIONS = \RecordChanges
DEVELOPER_OPTIONS = \AlsoImplementation\RecordChanges\CodelineIndex\EnableCrossrefs
DEVELOPER_OPTIONS_FINAL = \AlsoImplementation\CodelineIndex\DisableCrossrefs\RecordChanges

PACKAGE = listings-ext

DISTRIBUTION_FILES = $(PACKAGE).pdf $(PACKAGE).dtx \
          $(PACKAGE).ins README

.SUFFIXES:                              # Delete the default suffixes
.SUFFIXES: .dtx .dvi .ins .ps .pdf .sty # Define our suffix list

## Main Targets

# strip off the comments from the package
$(PACKAGE).sty $(PACKAGE)-test-*.tex: $(PACKAGE).ins $(PACKAGE).dtx
 +$(LATEX) $<; \
  sh $(PACKAGE).makemake

all: $(PACKAGE).dvi

# generate the documentation
$(PACKAGE).dvi: $(PACKAGE).dtx $(PACKAGE).sty
 +rm -f *.ind *.gls
 +$(LATEX) "\AtBeginDocument{$(COMMON_OPTIONS)}\input{$<}"
 +$(BIBTEX) $(PACKAGE)
 +$(LATEX) "\AtBeginDocument{$(COMMON_OPTIONS)}\input{$<}"
 +$(LATEX) "\AtBeginDocument{$(COMMON_OPTIONS)}\input{$<}"

# generate the documentation with revision history
history: $(PACKAGE).dtx $(PACKAGE).sty
 +$(LATEX) "\AtBeginDocument{$(COMMON_OPTIONS)$(HISTORY_OPTIONS)}\input{$<}"
 +$(BIBTEX) $(PACKAGE)
 +$(LATEX) "\AtBeginDocument{$(COMMON_OPTIONS)$(HISTORY_OPTIONS)}\input{$<}"
 +makeindex -s gind.ist                 $(PACKAGE).idx
 +makeindex -s gglo.ist -o $(PACKAGE).gls -t $(PACKAGE).glg $(PACKAGE).glo
 +$(LATEX) "\AtBeginDocument{$(COMMON_OPTIONS)$(HISTORY_OPTIONS)}\input{$<}"

# generate the documentation for the developer
develop: $(PACKAGE).dtx $(PACKAGE).sty
 +$(LATEX) "\AtBeginDocument{$(DEVELOPER_OPTIONS)}\input{$<}"
 +$(BIBTEX) $(PACKAGE)
 +$(LATEX) "\AtBeginDocument{$(DEVELOPER_OPTIONS)}\input{$<}"
 +makeindex -s gind.ist                 $(PACKAGE).idx
 +makeindex -s gglo.ist -o $(PACKAGE).gls -t $(PACKAGE).glg $(PACKAGE).glo
 +$(LATEX) "\AtBeginDocument{$(DEVELOPER_OPTIONS_FINAL)}\input{$<}"

develop-pdf: develop
 +$(DVIPS) $(PACKAGE).dvi; \
  $(PS2PDF) $(PACKAGE).ps; \
  rm $(PACKAGE).ps

history-pdf: history
 +$(DVIPS) $(PACKAGE).dvi; \
  $(PS2PDF) $(PACKAGE).ps; \
  rm $(PACKAGE).ps

# implicit rule for generating the .pdf files
%.pdf: %.dvi
 +$(DVIPS) $<; \
  $(PS2PDF) $(<:.dvi=.ps); \
  rm  $(<:.dvi=.ps)

# format the example/test files
examples:
 sh listings-ext.sh -c -o *.java; \
 for i in $(PACKAGE)*test*.tex; do \
     f=$${i%.tex}; \
     $(LATEX) "\nofiles\input{$$f}"; \
     $(DVIPS) -o $$f.ps $$f.dvi; \
     $(PS2PDF) $$f.ps; \
     rm $$f.dvi $$f.ps; \
 done

install: $(PACKAGE).dtx $(PACKAGE).pdf
 [ -d $(CLSDIR) ] || mkdir -p $(CLSDIR)
 [ -d $(DOCDIR) ] || mkdir -p $(DOCDIR)
 [ -d $(SRCDIR) ] || mkdir -p $(SRCDIR)
 cp $(PACKAGE).sty      $(CLSDIR)
 cp $(PACKAGE).pdf      $(DOCDIR)
 cp $(PACKAGE).ins      $(SRCDIR)
 cp $(PACKAGE).dtx      $(SRCDIR)
 cp $(PACKAGE)_{exmpl,test}_*   $(SRCDIR)
 cp README              $(SRCDIR)
 cp THIS-IS-VERSION-$(VERSION)  $(SRCDIR)

uninstall:
 rm -f  $(CLSDIR)/$(PACKAGE).sty
 rm -fr $(DOCDIR)
 rm -fr $(SRCDIR)

## Clean Targets
clean:
 -rm -f *.aux *.dvi *.hd *.lof *.log *.lot *.tmp *.toc
 -rm -f *.idx *.ilg *.ind *.glg *.glo *.gls   *.out
 -rm -f *.bbl *.blg *.bm *.brf *.hd
 -rm -f *.pdf *.ps
 -rm -f *.rel *.thm

clean-examples:
 -rm -f $(PACKAGE)_test* $(PACKAGE)_exmpl*

clean-support:
 -rm -f *.el *.sh
 -rm -f *.mk *.makemake

realclean:  clean clean-examples clean-support
 -rm -f *~ *.bib *.cfg *.sty *.tex
 -rm -f Makefile

### create packed files
tar-src:
 $(MAKE) realclean
 @cd ..; tar $(EXsvn) -czvf $(PACKAGE)/$(TAR_SRC) $(PACKAGE)

tar-dist: $(DISTRIBUTION_FILES)
 +rm -f THIS_IS_VERSION_* *.tgz; \
  $(VERSION_L) > THIS_IS_VERSION_$(VERSION_S); \
  tar cfvz $(PACKAGE)-$(VERSION_S).tgz $^ THIS_IS_VERSION_*; \
  rm getversion.log
