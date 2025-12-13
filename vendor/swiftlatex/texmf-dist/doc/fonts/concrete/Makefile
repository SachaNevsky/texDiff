## Makefile for the installation of the `concrete' fonts:
##
## 1999-03-15, Ulrik Vieth <vieth@thphy.uni-duesseldorf.de>
##

## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

## Usage:
##
## say 'make install' to install the fonts
##

### package specifics (don't change!):

# package name, used in directories
SUPPLIER = public
TYPEFACE = concrete

# file names, used in dependencies

MFFILES = \
	odigs.mf	\
	ccr10.mf	\
	ccr9.mf		\
	ccr8.mf		\
	ccr7.mf		\
	ccr6.mf		\
	ccr5.mf		\
	ccsl10.mf	\
	ccsl9.mf	\
	ccti10.mf 	\
	cccsc10.mf 	\
	ccmi10.mf	\
	ccmic9.mf	\
	ccslc9.mf
TFMFILES = \
	ccr10.mf	\
	ccr9.mf		\
	ccr8.mf		\
	ccr7.mf		\
	ccr6.mf		\
	ccr5.mf		\
	ccsl10.mf	\
	ccsl9.mf	\
	ccti10.mf 	\
	cccsc10.mf 	\
	ccmi10.mf	\
	ccmic9.mf	\
	ccslc9.mf


### customizable variables:

# Where the TeX installation resides:
TEXMF   = `kpsewhich --expand-path='$$TEXMFMAIN'`
#TEXMF  = /usr/local/teTeX/share/texmf

# standard directories
srcdir = .
MFDIR  = $(TEXMF)/fonts/source/$(SUPPLIER)/$(TYPEFACE)
TFMDIR = $(TEXMF)/fonts/tfm/$(SUPPLIER)/$(TYPEFACE)


# How to install the files:
INSTALL = cp -p
#INSTALL = install -c

# How to cleanup the files:
CLEAN   = rm -f

# How to update the directory database:
TEXHASH = mktexlsr
#TEXHASH = texhash


### unpack targets:

default: all
all:
	@echo
	@echo "Please call \`make install' to install the font files!"
	@echo
	@true

### install targets:

install: install-fonts post-install
.PHONY:	install

install-fonts:
	test -d $(MFDIR) || mkdir $(MFDIR)
	(for f in $(MFFILES); \
	  do $(INSTALL) $(srcdir)/mf/$$f $(MFDIR); done)
	test -d $(TFMDIR) || mkdir $(TFMDIR)
	(for f in $(TFMFILES); \
	  do $(INSTALL) $(srcdir)/tfm/$$f $(TFMDIR); done)
.PHONY:	install-fonts

# uninstall target:

uninstall:
	(for f in $(MFFILES); \
	  do $(CLEAN) $(MFDIR)/$$f; done)
	(for f in $(TFMFILES); \
	  do $(CLEAN) $(TFMDIR)/$$f; done)
.PHONY: uninstall


# Update the directory database:
post-install:
	$(TEXHASH)
.PHONY:	post-install


### clean targets:
clean:
	rm -f *.log *.aux *.toc *.lof *.lot *.bbl *.blg
	rm -f *.idx *.ind *.ilg *.glo *.gls

distclean: clean
