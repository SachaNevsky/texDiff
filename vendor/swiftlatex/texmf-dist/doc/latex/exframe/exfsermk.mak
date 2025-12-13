SRCMAIN = exfserm
SRCSEC = exfser
SRCPRB = exfserp
SCRIPT = exfsermk.sh
MAKEFILE = exfsermk.mak
TRGLIST = Problems Solutions
SECNUM = 01 02 03 aa
PREREQS = $(SRCMAIN).tex

SRCSECFILES = $(SECNUM:%=$(SRCSEC)%.tex)
TRGMAINFILES = $(foreach trg,$(TRGLIST),$(trg).pdf)
TRGSECFILES = $(foreach trg,$(TRGLIST),$(trg).pdf $(SECNUM:%=$(trg)%.pdf))
GENFILES = $(foreach trg,$(TRGLIST),$(trg).tex $(SECNUM:%=$(trg)%.tex))
BAKFILES = $(PREREQS) $(SRCSECFILES) $(GENFILES)\
           $(MAKEFILE) $(SCRIPT) $(SRCPRB)*

default: sheets ;
main: $(TRGMAINFILES) ;
sheets: $(TRGSECFILES) ;
sheet%: $(foreach trg,$(TRGLIST),$(trg)%.pdf) ;
all: main sheets ;
sources: $(GENFILES) ;

$(TRGMAINFILES): $(SRCSECFILES) $(PREREQS)
	bash ./$(SCRIPT) $@
$(word 1,$(TRGLIST))%.pdf: $(SRCSEC)%.tex $(PREREQS)
	bash ./$(SCRIPT) $@
$(word 2,$(TRGLIST))%.pdf: $(SRCSEC)%.tex $(PREREQS)
	bash ./$(SCRIPT) $@
$(GENFILES):
	bash ./$(SCRIPT) $@

touch:
	touch $(SRCMAIN).tex
clean:
	rm -f $(foreach ext,.aux .log,$(SECNUM:%=$(SRCSEC)%$(ext)))
	rm -f $(foreach trg,$(TRGLIST),$(SECNUM:%=$(trg)%.log) $(trg).log)
	rm -f $(foreach ext,.aux .log .out .toc,$(SRCMAIN)$(ext))
	rm -f $(foreach ext,.mp .mpx -*.mps,$(SRCMAIN)$(ext))
	rm -f $(foreach ext,-tmp.log -tmp.mp -tmp.mpx,$(SRCMAIN)$(ext))
	rm -f mpxerr.tex mpxerr.log mpxerr.dvi texput.log
	rm -f $(patsubst %,$(SRCPRB)*%,.aux .log .mp .mpx -*.mps)
	rm -f $(patsubst %,$(SRCPRB)*%,-tmp.log -tmp.mp -tmp.mpx)
clean-bak:
	rm -f $(BAKFILES:%=%~) $(BAKFILES:%=%.bak)
clean-all:  clean
	rm -f $(TRGSECFILES) $(TRGMAINFILES) $(GENFILES)
	rm -f $(SECNUM:%=$(SRCSEC)%.pdf) $(SRCMAIN).pdf
	rm -f $(SRCPRB)*.pdf
