pkg := arabluatex
ver  := $(shell ltxfileinfo -v $(pkg).dtx|sed -e 's/^v//')
TEXMFDIR := $(shell kpsewhich -expand-var='$$TEXMFHOME')
HOMEDIR := $$HOME
CMP = lualatex-dev

sty: clean
	$(CMP) $(pkg).ins

doc: clean sty
	$(CMP) --shell-escape $(pkg).dtx
	biber arabluatex
	$(CMP) --shell-escape $(pkg).dtx
	makeindex -s gind.ist -o $(pkg).ind $(pkg).idx
	makeindex -s gglo.ist -o $(pkg).gls $(pkg).glo
	$(CMP) --shell-escape $(pkg).dtx
	$(CMP) --shell-escape $(pkg).dtx
	for i in samples/*.tex; \
	do latexmk -outdir=TMP -lualatex -e '$$lualatex=q/$(CMP) %O --shell-escape %S/' $$i; \
	done
	mv TMP/*.pdf samples/

all: clean sty doc

local: clean sty
	if [ ! -d "$(TEXMFDIR)/tex/lualatex/arabluatex" ]; then \
	mkdir -p $(TEXMFDIR)/tex/lualatex/arabluatex; \
	fi
	cp $(pkg)*.{sty,lua} $(TEXMFDIR)/tex/lualatex/arabluatex
	if [ ! -d "$(HOMEDIR)/.emacs.d/auctex/auto" ]; then \
	mkdir -p $(HOMEDIR)/.emacs.d/auctex/auto; \
	fi
	cp $(pkg)*.el $(HOMEDIR)/.emacs.d/auctex/auto

auctex: clean
	if [ ! -d "$(HOMEDIR)/.emacs.d/auctex/auto" ]; then \
	mkdir -p $(HOMEDIR)/.emacs.d/auctex/auto; \
	fi
	cp $(pkg)*.el $(HOMEDIR)/.emacs.d/auctex/auto

package: clean all
	mkdir -p arabluatex/samples/
	cp *.{lua,ins,dtx,md,pdf} makefile README.tex arabluatex/ # .bib is in dtx
	cp samples/*.{tex,pdf} arabluatex/samples/
	mkdir -p tex/lualatex/arabluatex/
	cp *.lua *.sty tex/lualatex/arabluatex/
	mkdir -p doc/lualatex/arabluatex/samples
	cp *.{pdf,el} doc/lualatex/arabluatex/
	cp samples/*.{tex,pdf} doc/lualatex/arabluatex/samples
	mkdir -p source/lualatex/arabluatex/
	cp *.{ins,dtx,tex,md}  makefile source/lualatex/arabluatex/ # .bib is in dtx
	zip -r arabluatex.tds.zip tex doc source
	tar czf arabluatex-$(ver).tar.gz arabluatex.tds.zip arabluatex/

clean:
	rm -rf $(TEXMFDIR)/tex/lualatex/arabluatex/
	rm -rf $(HOMEDIR)/.emacs.d/auctex/auto/arabluatex*.el
	rm -rf tex/ doc/ source/ auto/
	rm -rf arabluatex/
	rm -rf saved/ TMP/ _minted-arabluatex/
	find ./samples/ | grep -v "\./samples/$$" | grep -v ".*tex$$" | xargs rm -rf
	mkdir saved
	cp *.{lua,ins,dtx,tex,el} makefile saved # .bib is in dtx
	rm *.*
	cp saved/* .
	rm -rf saved/
	pandoc -s README.tex -o README.md && sed -i 's/{#.*}//g' README.md
	pandoc -s README.tex -o about.html

.PHONY: sty doc all local auctex package clean
