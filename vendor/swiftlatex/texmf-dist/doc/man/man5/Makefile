# $Id: Makefile 47444 2018-04-11 18:06:43Z karl $
# Public domain.  Originally written by Manuel Pegourie-Gonnard, 2008.

SRC = $(wildcard man5/*.5)
PDF = $(patsubst %.5, %.man5.pdf, $(SRC))

PSPDF_MV   = $(PSPDF) - $@.tmp && mv $@.tmp $@ || rm $@.tmp
MKPDF      = $(GROFF) $(PDFOPTS) $< | $(PSPDF_MV)
MKPDF_UTF8 = env GROFF_FONT_PATH=../../../tlpkg/dev/groff-utf8 \
                 $(GROFF) -K utf8 $(PDFOPTS) $< | $(PSPDF_MV)

all: pdf 
pdf: $(PDF)
clean:
	@echo 'Removing pdf files.'
	rm -f -- $(PDF)

%.man5.pdf: %.5
	$(MKPDF)

man5/luaotfload.conf.man5.pdf: man5/luaotfload.conf.5
	$(MKPDF_UTF8)

