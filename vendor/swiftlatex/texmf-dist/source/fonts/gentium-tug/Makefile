# This file is part of the Gentium package for TeX.
# It is licensed under the Expat License, see doc//README for details.
#
# Here is just a way to record the commands to test the new boundary
# ligatures to automatically make the final sigma with the lgr encoding.
# From Ralf Stubner, July 2019.

fontdir = ../../../fonts
tfmdir = $(fontdir)/tfm/public/gentium-tug

default: try-ital

# the diff should show differences, hence exit nonzero.
try-reg: lgr-gentiumplus-regular.pl
	afm2pl -p $(fontdir)/enc/dvips/gentium-tug/gentium-lgr.enc \
		-l lig/gentium-lgr.lig \
		$(fontdir)/afm/public/gentium-tug/GentiumPlus-R.afm \
	&& pltotf GentiumPlus-R \
	&& tftopl GentiumPlus-R GentiumPlus-R \
	&& ! diff -u lgr-gentiumplus-regular.pl GentiumPlus-R.pl
#
# clearly this could all be factored out, but maybe we will never touch
# this stuff again, so ...
try-ital: lgr-gentiumplus-italic.pl
	afm2pl -p $(fontdir)/enc/dvips/gentium-tug/gentium-lgr.enc \
		-l lig/gentium-lgr.lig \
		$(fontdir)/afm/public/gentium-tug/GentiumPlus-I.afm \
	&& pltotf GentiumPlus-I \
	&& tftopl GentiumPlus-I GentiumPlus-I \
	&& ! diff -u lgr-gentiumplus-italic.pl GentiumPlus-I.pl

# the original pl's, for comparison.
lgr-gentiumplus-regular.pl:
	tftopl $(tfmdir)/lgr-gentiumplus-regular $@ || rm -f $@
lgr-gentiumplus-italic.pl:
	tftopl $(tfmdir)/lgr-gentiumplus-italic $@ || rm -f $@

# dist just copies the working directory, so have to install and clean.
install:
	mv GentiumPlus-R.tfm $(tfmdir)/lgr-gentiumplus-regular.tfm
	mv GentiumPlus-I.tfm $(tfmdir)/lgr-gentiumplus-italic.tfm

clean:
	rm -f GentiumPlus-* lgr-gent*.pl

dist: clean
	./make-zip-4CTAN.sh
