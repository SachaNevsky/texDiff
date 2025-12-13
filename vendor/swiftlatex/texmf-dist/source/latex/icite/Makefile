NAME  = icite
SHELL = bash
PWD   = $(shell pwd)
VERS  = $(shell ltxfileinfo -v $(NAME).dtx|sed -e 's/^v//')
LOCAL = $(shell kpsewhich --var-value TEXMFLOCAL)
UTREE = $(shell kpsewhich --var-value TEXMFHOME)
CMP = lualatex-dev

exts := md bib ins dtx html
texsamples := $(basename $(wildcard $(PWD)/samples/*.tex))
findopts := $(foreach ext,$(exts),-or -iname "*.$(ext)")


# Look into this later
# $(if $(wildcard $(PWD)/TMP/$(notdir $1).bcf),biber $(PWD)/TMP/$(notdir $1),)

define dosamples
	$(CMP) --output-dir=$(PWD)/TMP --shell-escape $1 >/dev/null
	$(CMP) --output-dir=$(PWD)/TMP --shell-escape $1 >/dev/null
	if [ -f $(PWD)/TMP/$(notdir $1)-primary.idx ]; \
	then texindy -M $(PWD)/TMP/$(notdir $1).xdy $(PWD)/TMP/$(notdir $1)-primary.idx >/dev/null; fi
	if [ -f $(PWD)/TMP/$(notdir $1).bcf ]; then biber $(PWD)/TMP/$(notdir $1) >/dev/null; fi
	$(CMP) --output-dir=$(PWD)/TMP --shell-escape $1 >/dev/null
	$(CMP) --output-dir=$(PWD)/TMP --shell-escape $1 >/dev/null
endef

sty: clean
	$(CMP) $(NAME).ins

all:	clean sty $(NAME).pdf
#	test -e README.md || exit 0

$(NAME).pdf: clean sty $(NAME).dtx
	@ echo "Make documentation..."
	$(CMP) --shell-escape --recorder --interaction=batchmode $(NAME).dtx >/dev/null
	biber $(NAME) >/dev/null
	$(CMP) --shell-escape --recorder --interaction=batchmode $(NAME).dtx >/dev/null
	if [ -f $(NAME).glo ]; then makeindex -q -s gglo.ist -o $(NAME).gls $(NAME).glo; fi
	if [ -f $(NAME).idx ]; then makeindex -q -s gind.ist -o $(NAME).ind $(NAME).idx; fi
	if [ -f loccit.idx ]; then texindy -M icite.xdy loccit.idx >/dev/null; fi
	if [ -f primary.idx ]; then texindy -M icite.xdy primary.idx >/dev/null; fi
	$(CMP) --shell-escape --recorder --interaction=nonstopmode $(NAME).dtx > /dev/null
	$(CMP) --shell-escape --recorder --interaction=nonstopmode $(NAME).dtx > /dev/null
	@ echo "Make sample files..."
	if [ ! -d $(PWD)/TMP ]; then mkdir $(PWD)/TMP; fi
	cp $(PWD)/samples/*.bib $(PWD)/TMP
	$(foreach file,$(texsamples), $(call dosamples, $(file)))
	mv TMP/*.pdf samples/

samples: clean sty
	if [ ! -d $(PWD)/TMP ]; then mkdir $(PWD)/TMP; fi
	cp $(PWD)/samples/*.bib $(PWD)/TMP
	$(foreach file,$(texsamples), $(call dosamples, $(file)))
	mv TMP/*.pdf samples/

lualatex:
	$(CMP) --shell-escape --recorder --interaction=batchmode $(NAME).dtx >/dev/null

clean:
	rm -f $(NAME).bib $(PWD)/TMP/*.bib
	rm -rf .backup
	find -iname "*~" -or -iname "*.pdf" | xargs rm -rf
	find ./* -type f -iname "Makefile" $(findopts) > ls-R
	find ./* -type f -iname "*.tex" | grep '/samples/' >> ls-R
	rsync -avPr --files-from=ls-R . .backup
	rm -rf *
	cp -p -r .backup/* .
	rm -rf .backup
	pandoc -s README.md -o about.html

distclean: clean uninst

inst: uninst all
	mkdir -p $(UTREE)/{tex,source,doc}/latex/$(NAME)
	cp $(NAME).dtx $(UTREE)/source/latex/$(NAME)
	cp $(NAME).sty $(UTREE)/tex/latex/$(NAME)
	cp $(NAME).pdf $(UTREE)/doc/latex/$(NAME)
	cp -r samples/ $(UTREE)/doc/latex/$(NAME)

local: uninst
	$(CMP) $(NAME).ins
	mkdir -p $(UTREE)/{tex,source,doc}/latex/$(NAME)
	cp $(NAME).sty $(UTREE)/tex/latex/$(NAME)

uninst:
	rm -rf $(UTREE)/{tex,source,doc}/latex/$(NAME)

install: all
	sudo mkdir -p $(LOCAL)/{tex,source,doc}/latex/$(NAME)
	sudo cp $(NAME).dtx $(LOCAL)/source/latex/$(NAME)
	sudo cp $(NAME).sty $(LOCAL)/tex/latex/$(NAME)
	sudo cp $(NAME).pdf $(LOCAL)/doc/latex/$(NAME)
	cp -r samples/ $(LOCAL)/doc/latex/$(NAME)

uninstall:
	rm -rf $(LOCAL)/{tex,source,doc}/latex/$(NAME)

zip: all
	ln -sf . $(NAME)
	zip -Drq $(PWD)/$(NAME)-$(VERS).zip $(NAME)/{samples,README.md,$(NAME).{pdf,dtx,ins}}
	rm $(NAME)

package: distclean all
	mkdir $(NAME)/
	cp Makefile README.md $(NAME).{ins,dtx,pdf} $(NAME)/
	cp -r samples/ $(NAME)/
	mkdir -p tex/latex/$(NAME)/
	cp $(NAME).sty tex/latex/$(NAME)/
	mkdir -p doc/latex/$(NAME)/
	cp $(NAME).pdf doc/latex/$(NAME)/
	cp -r samples/ doc/latex/$(NAME)/
	mkdir -p source/latex/$(NAME)/
	cp Makefile README.md $(NAME).{dtx,ins} source/latex/$(NAME)/
	# zip -r $(NAME).tds.zip tex doc source
	rm -rf tex/ source/ doc/
	# tar czf $(NAME)-$(VERS).tar.gz $(NAME).tds.zip $(NAME)/
	tar czf $(NAME)-$(VERS).tar.gz $(NAME)/
	rm -rf $(NAME)/

.PHONY: all lualatex clean distclean inst local uninst install uninstall zip package samples
