NAME  = nameauth
ENGINE ?= pdflatex
# or latex, xelatex, lualatex, dvilualatex
SHELL = bash
PWD   = $(shell pwd)
VERS  = $(shell ltxfileinfo -v $(NAME).dtx|sed -e 's/^v//')
LOCAL = $(shell kpsewhich --var-value TEXMFLOCAL)
UTREE = $(shell kpsewhich --var-value TEXMFHOME)
release:    $(NAME).pdf
testing:    $(NAME).pdf examples.pdf
examples.pdf    : examples.tex
	$(ENGINE) examples >/dev/null
	if [ -f examples.idx ]; then makeindex -o examples.ind examples.idx; fi
	$(ENGINE) examples > /dev/null
$(NAME).pdf : $(NAME).dtx
	$(ENGINE) -shell-escape -recorder -interaction=batchmode $(NAME).dtx >/dev/null
	$(ENGINE) --recorder --interaction=nonstopmode $(NAME).dtx > /dev/null
	if [ -f $(NAME).glo ]; then makeindex -q -s gglo.ist -o $(NAME).gls $(NAME).glo; fi
	if [ -f $(NAME).idx ]; then makeindex -q -s gind.ist -o $(NAME).ind $(NAME).idx; fi
	$(ENGINE) --recorder --interaction=nonstopmode $(NAME).dtx > /dev/null
	$(ENGINE) --recorder --interaction=nonstopmode $(NAME).dtx > /dev/null
	test -e README.txt && mv README.txt README || exit 0
clean:
	rm -f $(NAME).{aux,fls,glo,gls,hd,idx,ilg,ind,ins,log,out,toc} README.txt
	rm -f examples.{aux,fls,glo,gls,hd,idx,ilg,ind,ins,log,out,toc}
distclean: clean
	rm -f $(NAME).{dvi,pdf,sty,synctex.gz} README
	rm -f examples.{dvi,pdf,sty,synctex.gz}
inst: release
	mkdir -p $(UTREE)/{tex,source,doc}/latex/$(NAME)
	cp $(NAME).dtx $(UTREE)/source/latex/$(NAME)
	cp Makefile $(UTREE)/source/latex/$(NAME)
	cp $(NAME).sty $(UTREE)/tex/latex/$(NAME)
	cp $(NAME).pdf $(UTREE)/doc/latex/$(NAME)
	cp examples.tex $(UTREE)/doc/latex/$(NAME)
	cp README $(UTREE)/doc/latex/$(NAME)
install: release
	sudo mkdir -p $(LOCAL)/{tex,source,doc}/latex/$(NAME)
	sudo cp $(NAME).dtx $(LOCAL)/source/latex/$(NAME)
	sudo cp Makefile $(LOCAL)/source/latex/$(NAME)
	sudo cp $(NAME).sty $(LOCAL)/tex/latex/$(NAME)
	sudo cp $(NAME).pdf $(LOCAL)/doc/latex/$(NAME)
	sudo cp examples.tex $(LOCAL)/doc/latex/$(NAME)
	sudo cp README $(LOCAL)/doc/latex/$(NAME)
zip: release
	ln -sf . $(NAME)
	zip -Drq $(PWD)/$(NAME)-$(VERS).zip $(NAME)/{README,examples.tex,Makefile,$(NAME).{pdf,dtx}}
	rm $(NAME)

