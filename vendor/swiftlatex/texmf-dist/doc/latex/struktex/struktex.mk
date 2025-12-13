
#-----------------------------------------------------------------------
# Purpose: generation of the documentation of the struktex package
# Notice:  this file can be used only with dmake and the option "-B";
#          this option lets dmake interpret the leading spaces as
#          distinguishing characters for commands in the make rules.
#
# Rules:
#          - all-de:     generate all the files and the (basic) german
#                        documentation
#          - all-en:     generate all the files and the (basic) english
#                        documentation
#          - test:       format the examples
#          - history:    generate the documentation with revision
#                        history
#          - develop-de: generate the german documentation with revision
#                        history and source code
#          - develop-en: generate the english documentation with
#                        revision history and source code
#          - realclean
#          - clean
#          - clean-example
#
# Author:  Jobst Hoffmann, Fachhochschule Aachen, Standort Juelich
# Date:    2017/06/06
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
# Use following, if you only want to test the installation:
#INSTALLTEXMF=/tmp/texmf

# If texhash must run after installation, you can invoke this:
TEXHASH=texhash

######### Edit following only, if you want to change defaults!

# The directory, where to install *.cls and *.sty
CLSDIR=$(INSTALLTEXMF)/tex/latex/$(PACKAGE)

# The directory, where to install documentation
DOCDIR=$(INSTALLTEXMF)/doc/latex/$(PACKAGE)

# The directory, where to install the sources
SRCDIR=$(INSTALLTEXMF)/source/latex/$(PACKAGE)

# The directory, where to install demo-files
# If we have some, we have to add following 2 lines to install rule:
#     $(MKDIR) $(DEMODIR); \
#     $(INSTALL) $(DEMO_FILES) $(DEMODIR); \
DEMODIR=$(DOCDIR)/demo

# We need this, because the documentation needs the classes and packages
# It's not really a good solution, but it's a working solution.
TEXINPUTS := $(PWD):$(TEXINPUTS)

########################################################################
#   End of customization section
########################################################################

LATEX = latex
PDFLATEX = pdflatex
TEX = TEX

COMMON_OPTIONS = # \OnlyDescription\CodelineNumbered\PageIndex
HISTORY_OPTIONS = \RecordChanges
DEVELOPER_OPTIONS = \EnableCrossrefs\RecordChanges\AlsoImplementation\CodelineIndex

# tarring options
EXgit = --exclude .git --exclude .gitignore --exclude auto --exclude tests \
 --exclude *.tgz --exclude *.bib

# The name of the game
PACKAGE = struktex

DISTRIBUTION_FILES = ../$(PACKAGE)/$(PACKAGE).de.pdf \
../$(PACKAGE)/$(PACKAGE).en.pdf \
 ../$(PACKAGE)/$(PACKAGE).dtx \
 ../$(PACKAGE)/$(PACKAGE).ins \
 ../$(PACKAGE)/LIESMICH.md \
 ../$(PACKAGE)/README.md
PACKAGE_FILES_A = $(subst ../$(PACKAGE)/,,$(DISTRIBUTION_FILES))
PACKAGE_FILES_B = $(subst $(PACKAGE).dtx ,,$(PACKAGE_FILES_A))
PACKAGE_FILES_C = $(subst $(PACKAGE).ins ,,$(PACKAGE_FILES_B))
PACKAGE_FILES_D = $(subst LIESMICH.md,,$(PACKAGE_FILES_C))
PACKAGE_FILES = $(subst README.md,,$(PACKAGE_FILES_D))

# To generate the version number of the distribution from the source
VERSION_L := git describe --long | xargs git --no-pager show -s \
         --date=short --format=format:"$(PACKAGE) version ???? of %ad%n" |\
         sed -e "s/????/`git describe --long`/"
VERSION_S := `git describe --long | \
             sed 's+-g.*++'`

# to create the correct tar-file
define TAR_COMMANDS
echo $$@
OUT_DIR=$$(mktemp -d)
mkdir $${OUT_DIR}/struktex
cp $$@ $${OUT_DIR}/struktex
pushd $${OUT_DIR}
tar cfvz struktex.tgz struktex
popd
cp $${OUT_DIR}/struktex.tgz .
endef

export TAR_COMMANDS

## Main Targets

# strip off the comments from the package
$(PACKAGE).sty $(PACKAGE)-test-*.tex: $(PACKAGE).ins $(PACKAGE).dtx $(PACKAGE).sed
 +$(TEX) $<; \
  source $(PACKAGE).makemake; \
  make revision_no; \
  source $(PACKAGE).sed  # set version number

all-de: $(PACKAGE).de.pdf

all-en: $(PACKAGE).en.pdf

# prepare the file with git revision information
.PHONY: revision_no
revision_no: $(PACKAGE).sed

$(PACKAGE).sed: $(PACKAGE).dtx
 printf "%b\n" "set_git_info() {" \
    > $(PACKAGE).sed; \
 printf "%b\n" "sed -i -e 's/^[ \\\\t]*%% git revision information$$/\\"  \
    >> $(PACKAGE).sed; \
 git describe --long | \
    xargs git --no-pager show -s --format=format:\
 "    \\\\@git@ \$$Date: %ci $$%%\%n" >> $(PACKAGE).sed; \
 git describe --long | cut -c 2- |\
    sed -e "s/^/      \$$Revision: /" -e "s/$$/ $$\\\\/" \
    >> $(PACKAGE).sed; \
 git describe --long | \
    xargs git --no-pager show -s --format=format:"    %%%% \$$Author: %an $$\\%n" \
    >> $(PACKAGE).sed; \
 printf "%b\n" "/' \$$1" \
    >> $(PACKAGE).sed; \
 printf "%b\n" "};" \
    >> $(PACKAGE).sed; \
 printf "%b\n" "for f in  \\\\" \
    >> $(PACKAGE).sed; \
 printf "%b\n" "$(PACKAGE).sty \\\\" \
    >> $(PACKAGE).sed; \
 printf "%b\n" "struktxf.sty \\\\" \
    >> $(PACKAGE).sed; \
 printf "%b\n" "struktxp.sty \\\\" \
    >> $(PACKAGE).sed; \
 printf "%b\n" "strukdoc.sty \\\\" \
    >> $(PACKAGE).sed; \
 printf "%b\n" "; do \\\\" \
    >> $(PACKAGE).sed; \
 printf "%b\n" "  set_git_info \$$f; done" \
    >> $(PACKAGE).sed; \

# generate the documentation
$(PACKAGE).de.pdf: $(PACKAGE).dtx $(PACKAGE).sty struktex.sed
 +$(PDFLATEX) "\AtBeginDocument{$(COMMON_OPTIONS)}\input{$<}"
 +$(PDFLATEX) "\AtBeginDocument{$(COMMON_OPTIONS)}\input{$<}"
 +mv $(<:.dtx=.pdf) $(<:.dtx=.de.pdf)

$(PACKAGE).en.pdf: $(PACKAGE).dtx $(PACKAGE).sty
 +$(PDFLATEX) "\AtBeginDocument{$(COMMON_OPTIONS)}\def\primarylanguage{english}\input{$<}"
 +$(PDFLATEX) "\AtBeginDocument{$(COMMON_OPTIONS)}\def\primarylanguage{english}\input{$<}"
 +mv $(<:.dtx=.pdf) $(<:.dtx=.en.pdf)

# generate the documentation with revision history (only german)
history: $(PACKAGE).dtx $(PACKAGE).sty
 +$(PDFLATEX) "\AtBeginDocument{$(COMMON_OPTIONS)$(HISTORY_OPTIONS)}\input{$<}"
 +$(PDFLATEX) "\AtBeginDocument{$(COMMON_OPTIONS)$(HISTORY_OPTIONS)}\input{$<}"
 +makeindex -s gind.ist                 $(PACKAGE).idx
 +makeindex -s gglo.ist -o $(PACKAGE).gls -t $(PACKAGE).glg $(PACKAGE).glo
 +$(PDFLATEX) "\AtBeginDocument{$(COMMON_OPTIONS)$(HISTORY_OPTIONS)}\input{$<}"

# generate the documentation for the developer (revision history always
# in german)
develop-de: $(PACKAGE).dtx $(PACKAGE).sty
 +$(PDFLATEX) "\AtBeginDocument{$(HISTORY_OPTIONS)$(DEVELOPER_OPTIONS)}\input{$<}"
 +$(PDFLATEX) "\AtBeginDocument{$(HISTORY_OPTIONS)$(DEVELOPER_OPTIONS)}\input{$<}"
 +makeindex -s gind.ist                 $(PACKAGE).idx
 +makeindex -s gglo.ist -o $(PACKAGE).gls -t $(PACKAGE).glg $(PACKAGE).glo
 +$(PDFLATEX) "\AtBeginDocument{$(HISTORY_OPTIONS)$(DEVELOPER_OPTIONS)}\input{$<}"
 +mv $(<:.dtx=.pdf) $(<:.dtx=.de.pdf)

develop-en: $(PACKAGE).dtx $(PACKAGE).sty
 +$(PDFLATEX) "\AtBeginDocument{$(COMMON_OPTIONS)$(DEVELOPER_OPTIONS)}\def\primarylanguage{english}\input{$<}"
 +$(PDFLATEX) "\AtBeginDocument{$(COMMON_OPTIONS)$(DEVELOPER_OPTIONS)}\def\primarylanguage{english}\input{$<}"
 +makeindex -s gind.ist                 $(PACKAGE).idx
 +makeindex -s gglo.ist -o $(PACKAGE).gls -t $(PACKAGE).glg $(PACKAGE).glo
 +$(PDFLATEX) "\AtBeginDocument{$(COMMON_OPTIONS)$(DEVELOPER_OPTIONS)}\def\primarylanguage{english}\input{$<}"
 +mv $(<:.dtx=.pdf) $(<:.dtx=.en.pdf)

# format the example/test files
test:
 for i in `seq 1 3`; do \
     f=$(PACKAGE)-test-$$i; \
     echo file: $$f; \
     $(PDFLATEX) $$f; \
 done

install: $(PACKAGE).dtx $(PACKAGE).dvi
 [ -d $(CLSDIR) ] || mkdir -p $(CLSDIR)
 [ -d $(DOCDIR) ] || mkdir -p $(DOCDIR)
 [ -d $(SRCDIR) ] || mkdir -p $(SRCDIR)
 cp $(PACKAGE).sty      $(CLSDIR)
 cp $(PACKAGE).dvi      $(DOCDIR)
 cp $(PACKAGE).ins      $(SRCDIR)
 cp $(PACKAGE).dtx      $(SRCDIR)
 cp $(PACKAGE)-test-*.tex   $(SRCDIR)
 cp LIESMICH        $(SRCDIR)
 cp README          $(SRCDIR)
 cp THIS-IS-VERSION-$(VERSION)  $(SRCDIR)

uninstall:
 rm -f  $(CLSDIR)/$(PACKAGE).sty
 rm -fr $(DOCDIR)
 rm -fr $(SRCDIR)

dist: $(PACKAGE).de.pdf $(PACKAGE).en.pdf  $(PACKAGE).dtx  $(PACKAGE).ins \
LIESMICH.md README.md
 + echo "$$TAR_COMMANDS" > ./tar_commands; \
 rm -f THIS_IS_VERSION_*; \
 $(VERSION_L) > THIS_IS_VERSION_$(VERSION_S); \
 sh  ./tar_commands $^; \
 mv ./struktex.tgz ./struktex-$(VERSION_S).tgz
 rm ./tar_commands

tds-zip:  $(PACKAGE_FILES)
 + rm -f THIS_IS_VERSION_* *.zip; \
 $(VERSION_L) | sed -e "s/??????????/$(VERSION_S)/" > THIS_IS_VERSION_$(VERSION_S); \
 DOC_FILES="LIESMICH.md README.md THIS_IS_* $(PACKAGE).??.pdf"; \
 MAKE_FILES="$(PACKAGE).m*"; \
 SRC_FILES="$(PACKAGE).dtx $(PACKAGE).ins"; \
 STY_FILES="struk*.sty"; \
 TEST_FILES="./$(PACKAGE)-test*"; \
 SUPPORT_FILES="./$(PACKAGE).el"; \
 if [[ -d /tmp/texmf ]]; then \
   rm -rf /tmp/texmf; \
 fi; \
 if [[ -f $(PACKAGE)-TDS.zip ]]; then \
   rm $(PACKAGE)-TDS.zip; \
 fi; \
 mkdir -p /tmp/texmf/doc/latex/$(PACKAGE); \
 mkdir -p /tmp/texmf/source/latex/$(PACKAGE); \
 mkdir -p /tmp/texmf/tex/latex/$(PACKAGE); \
 cp -a $${DOC_FILES} /tmp/texmf/doc/latex/$(PACKAGE); \
 cp -a $${MAKE_FILES} /tmp/texmf/doc/latex/$(PACKAGE); \
 cp -a $${SRC_FILES} /tmp/texmf/source/latex/$(PACKAGE); \
 cp -a $${STY_FILES} /tmp/texmf/tex/latex/$(PACKAGE); \
 cp -a $${TEST_FILES} /tmp/texmf/doc/latex/$(PACKAGE); \
 cp -a $${SUPPORT_FILES} /tmp/texmf/doc/latex/$(PACKAGE); \
 VERSION_SHORT="xxx"; \
 pushd /tmp/texmf; \
 zip -r /tmp/$(PACKAGE)-TDS.zip .; \
 popd; \
 mv /tmp/$(PACKAGE)-TDS.zip ./$(PACKAGE)-TDS-$(VERSION_S).zip

clean:
 -rm -f *.log *.aux *.brf *.idx *.ilg *.ind
 -rm -f *.glg *.glo *.gls *.lof *.lot *.out *.toc *.tmp *~
 -rm *.mk *.makemake

realclean:  clean
 -rm -f *.sty *.cls *.pdf
 -rm -f *-test-* Makefile

clean-test:
 rm $(PACKAGE)-test-*.* # this $-sign is needed for font-locking in XEmacs only
