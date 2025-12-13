# $Id: Makefile 54278 2020-03-13 17:30:40Z karl $
# Public domain.  Originally written by Manuel Pegourie-Gonnard, 2008.

SRC = $(wildcard man1/*.1)
PDF = $(patsubst %.1, %.man1.pdf, $(SRC))

# these variables with automatic variables don't get passed to the
# submake; these definitions are repeated in man5/Makefile.
# All of this is more complicated than it needs to be.
PSPDF_MV   = $(PSPDF) - $@.tmp && mv $@.tmp $@ || rm $@.tmp
MKPDF      = $(GROFF) $(PDFOPTS) $< | $(PSPDF_MV)
MKPDF_UTF8 = env GROFF_FONT_PATH=../../../tlpkg/dev/groff-utf8 \
                 $(GROFF) -K utf8 $(PDFOPTS) $< | $(PSPDF_MV)

all: pdf 
pdf: $(PDF)
clean:
	@echo 'Removing pdf files.'
	rm -f -- $(PDF)

%.man1.pdf: %.1
	$(MKPDF)

# Special case for mendex.1 and upmendex.1, which contains multi-byte characters.
# leave it for Japanese maintainers
man1/mendex.man1.pdf: man1/mendex.1
	@echo 'Skipping mendex.1, leaving it to texjp.'
man1/upmendex.man1.pdf: man1/upmendex.1
	@echo 'Skipping upmendex.1.'

# man pages which use UTF-8; check via file *.1 | grep UTF-8;
# fgrep '\*~' *.1.
man1/findhyph.man1.pdf: man1/findhyph.1
	$(MKPDF_UTF8)
man1/latex-git-log.man1.pdf: man1/latex-git-log.1
	$(MKPDF_UTF8)
man1/luaotfload-tool.man1.pdf: man1/luaotfload-tool.1
	$(MKPDF_UTF8)

# 
# See ../Makefile for the so.rules target which generates this list of rules,
# and tlpkg/bin/tl-update-man for a way to verify the list.

man1/cslatex.man1.pdf: man1/cslatex.1 man1/latex.1
	$(MKPDF)

man1/ctangle.man1.pdf: man1/ctangle.1 man1/cweb.1
	$(MKPDF)

man1/ctwill-refsort.man1.pdf: man1/ctwill-refsort.1 man1/ctwill.1
	$(MKPDF)

man1/ctwill-twinx.man1.pdf: man1/ctwill-twinx.1 man1/ctwill.1
	$(MKPDF)

man1/cweave.man1.pdf: man1/cweave.1 man1/cweb.1
	$(MKPDF)

man1/dvigif.man1.pdf: man1/dvigif.1 man1/dvipng.1
	$(MKPDF)

man1/dvilj2p.man1.pdf: man1/dvilj2p.1 man1/dvilj.1
	$(MKPDF)

man1/dvilj4.man1.pdf: man1/dvilj4.1 man1/dvilj.1
	$(MKPDF)

man1/dvilj4l.man1.pdf: man1/dvilj4l.1 man1/dvilj.1
	$(MKPDF)

man1/dvilj6.man1.pdf: man1/dvilj6.1 man1/dvilj.1
	$(MKPDF)

man1/dvilualatex-dev.man1.pdf: man1/dvilualatex-dev.1 man1/latex-dev.1
	$(MKPDF)

man1/dvilualatex.man1.pdf: man1/dvilualatex.1 man1/latex.1
	$(MKPDF)

man1/dviluatex.man1.pdf: man1/dviluatex.1 man1/luatex.1
	$(MKPDF)

man1/dvipdfm.man1.pdf: man1/dvipdfm.1 man1/dvipdfmx.1
	$(MKPDF)

man1/ebb.man1.pdf: man1/ebb.1 man1/extractbb.1
	$(MKPDF)

man1/eptex.man1.pdf: man1/eptex.1 man1/ptex.1
	$(MKPDF)

man1/euptex.man1.pdf: man1/euptex.1 man1/ptex.1
	$(MKPDF)

man1/fmtutil-sys.man1.pdf: man1/fmtutil-sys.1 man1/fmtutil.1
	$(MKPDF)

man1/fmtutil-user.man1.pdf: man1/fmtutil-user.1 man1/fmtutil.1
	$(MKPDF)

man1/inimf.man1.pdf: man1/inimf.1 man1/mf.1
	$(MKPDF)

man1/initex.man1.pdf: man1/initex.1 man1/tex.1
	$(MKPDF)

man1/kpsepath.man1.pdf: man1/kpsepath.1 man1/kpsetool.1
	$(MKPDF)

man1/kpsexpand.man1.pdf: man1/kpsexpand.1 man1/kpsetool.1
	$(MKPDF)

man1/lamed.man1.pdf: man1/lamed.1 man1/aleph.1
	$(MKPDF)

man1/luahbtex.man1.pdf: man1/luahbtex.1 man1/luatex.1
	$(MKPDF)

man1/luajithbtex.man1.pdf: man1/luajithbtex.1 man1/luatex.1
	$(MKPDF)

man1/luajittex.man1.pdf: man1/luajittex.1 man1/luatex.1
	$(MKPDF)

man1/lualatex-dev.man1.pdf: man1/lualatex-dev.1 man1/latex-dev.1
	$(MKPDF)

man1/lualatex.man1.pdf: man1/lualatex.1 man1/latex.1
	$(MKPDF)

man1/mf-nowin.man1.pdf: man1/mf-nowin.1 man1/mf.1
	$(MKPDF)

man1/mktexfmt.man1.pdf: man1/mktexfmt.1 man1/fmtutil.1
	$(MKPDF)

man1/odvicopy.man1.pdf: man1/odvicopy.1 man1/dvicopy.1
	$(MKPDF)

man1/odvitype.man1.pdf: man1/odvitype.1 man1/dvitype.1
	$(MKPDF)

man1/otangle.man1.pdf: man1/otangle.1 man1/tangle.1
	$(MKPDF)

man1/pdfclose.man1.pdf: man1/pdfclose.1 man1/pdfopen.1
	$(MKPDF)

man1/pdfcslatex.man1.pdf: man1/pdfcslatex.1 man1/latex.1
	$(MKPDF)

man1/pdflatex-dev.man1.pdf: man1/pdflatex-dev.1 man1/latex-dev.1
	$(MKPDF)

man1/pdflatex.man1.pdf: man1/pdflatex.1 man1/pdftex.1
	$(MKPDF)

man1/platex-dev.man1.pdf: man1/platex-dev.1 man1/latex-dev.1
	$(MKPDF)

man1/platex.man1.pdf: man1/platex.1 man1/latex.1
	$(MKPDF)

man1/repstopdf.man1.pdf: man1/repstopdf.1 man1/epstopdf.1
	$(MKPDF)

man1/texconfig-sys.man1.pdf: man1/texconfig-sys.1 man1/texconfig.1
	$(MKPDF)

man1/texhash.man1.pdf: man1/texhash.1 man1/mktexlsr.1
	$(MKPDF)

man1/texlua.man1.pdf: man1/texlua.1 man1/luatex.1
	$(MKPDF)

man1/texluac.man1.pdf: man1/texluac.1 man1/luatex.1
	$(MKPDF)

man1/updmap-sys.man1.pdf: man1/updmap-sys.1 man1/updmap.1
	$(MKPDF)

man1/updmap-user.man1.pdf: man1/updmap-user.1 man1/updmap.1
	$(MKPDF)

man1/uplatex-dev.man1.pdf: man1/uplatex-dev.1 man1/latex-dev.1
	$(MKPDF)

man1/uplatex.man1.pdf: man1/uplatex.1 man1/latex.1
	$(MKPDF)

man1/uppltotf.man1.pdf: man1/uppltotf.1 man1/ppltotf.1
	$(MKPDF)

man1/uptex.man1.pdf: man1/uptex.1 man1/ptex.1
	$(MKPDF)

man1/uptftopl.man1.pdf: man1/uptftopl.1 man1/ptftopl.1
	$(MKPDF)

man1/xdvipdfmx.man1.pdf: man1/xdvipdfmx.1 man1/dvipdfmx.1
	$(MKPDF)

man1/xelatex-dev.man1.pdf: man1/xelatex-dev.1 man1/latex-dev.1
	$(MKPDF)

man1/xelatex.man1.pdf: man1/xelatex.1 man1/latex.1
	$(MKPDF)
