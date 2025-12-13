#
# Makefile for pedigree
# $Id: Makefile,v 2.4 2007-07-09 22:49:33 boris Exp $
# 
# This file is in public domain
#

PREFIX = /usr/local


PERLLIBS = \
	AbortionNode.pm \
	Area.pm \
	ChildlessNode.pm \
	Language.pm \
	MarriageNode.pm \
	Node.pm \
	Parser.pm \
	PersonNode.pm \
	TwinsNode.pm

MANPAGES3=${PERLLIBS:%.pm=%.3}

all:  man

man:  ${MANPAGES3}

install:  all 
	mkdir -p $(PREFIX)/lib/site_perl/Pedigree
	install -m 644 ${PERLLIBS} $(PREFIX)/lib/site_perl/Pedigree

installman:  all
	for x in ${MANPAGES3}; do install -m 644 $$x $(PREFIX)/man/man3/Pedigree::$$x; done


%.3:	%.pm
	pod2man --section=3 -n Pedigree::$* -s 3 $< $@

clean:

distclean: clean
	$(RM) *.3
