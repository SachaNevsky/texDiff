#
# Makefile for pedigree
# $Id: Makefile,v 2.2 2007-07-29 19:52:51 boris Exp $
# 
# This file is in public domain
#

PREFIX = /usr/local

PERLSCRIPTS=pedigree.pl

PERLLIBS = \
	Pedigree.pm

MANPAGES1=${PERLSCRIPTS:%.pl=%.1}
MANPAGES3=${PERLLIBS:%.pm=%.3}


all:  man
	cd Pedigree; ${MAKE} $@

man:  ${MANPAGES1} ${MANPAGES3}

docs:  
	cd doc; ${MAKE} all

install:  all 
	install pedigree.pl $(PREFIX)/bin/pedigree
	mkdir -p $(PREFIX)/lib/site_perl
	install -m 644 ${PERLLIBS} $(PREFIX)/lib/site_perl
	cd Pedigree; ${MAKE} $@

installman: 
	install -m 644 pedigree.1 $(PREFIX)/man/man1
	for x in ${MANPAGES3}; do install -m 644 $$x $(PREFIX)/man/man3/$$x; done
	cd Pedigree; ${MAKE} $@

%.1:	%.pl
	pod2man --section=1 -n $* -s 1 $< $@

%.3:	%.pm
	pod2man --section=3 -n $* -s 3 $< $@

clean:
	cd doc; ${MAKE} $@
	cd Pedigree; ${MAKE} $@

distclean: clean
	$(RM) ${MANPAGES1} ${MANPAGES3}
	cd doc; ${MAKE} $@
	cd Pedigree; ${MAKE} $@

#
# Archive for the distribution. Includes typeset documentation and man pages
#
archive:  all docs clean
	tar -czvf pedigree.tgz --exclude '*~' --exclude '*.tgz' --exclude CVS .
