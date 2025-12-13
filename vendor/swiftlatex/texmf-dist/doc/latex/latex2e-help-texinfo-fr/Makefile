# $Id: Makefile 466 2015-10-27 11:31:20Z jhefferon $
# Public domain.  Originally written 2006, Karl Berry.
# Makefile for latexrefman.

# Adding a new langage xx (for instance xx is ru for Russian) is as
# follows:
#  1) add xx to the list in other_languages
#  2) add definition of xx_longname, for instance if xx is ru,
#  xx_longname:=russian
#  3) add definition of xx_updated_awk, script for formatting @set
#     UPDATED tag.

manual=latex2e
default_language=en
other_languages=fr es
languages=$(default_language) $(other_languages)

#
xref_suffixes := ky cp vr fn cp pg tp
xref_suffixes := $(xref_suffixes) $(addsuffix s,$(xref_suffixes))
xref_suffixes := aux log toc $(xref_suffixes)
tex_suffixes = dvi pdf
makeinfo_suffixes = dbk html info txt xml
suffixes=$(tex_suffixes) $(makeinfo_suffixes)
en_longname:=english
es_longname:=spanish
fr_longname:=french

define lang_template
dist-$(1):=$(manual)-help-texinfo-$(1)
$(1)_manual:=$$(subst -$(default_language),,$(manual)-$(1))
$(1)_tex_output := $$(addprefix $$($(1)_manual).,$(tex_suffixes))
$(1)_makeinfo_output := $$(addprefix $$($(1)_manual).,$(makeinfo_suffixes))
$(1)_output := $$($(1)_tex_output) $$($(1)_makeinfo_output)
tex_output+= $$($(1)_tex_output)
makeinfo_output+= $$($(1)_makeinfo_output)
endef
$(foreach lang,$(languages), $(eval $(call lang_template,$(lang))))

#
all_suffixes = dvi pdf $(makeinfo_suffixes)
all_manuals:=$(foreach lang,$(languages),$($(lang)_manual)) 


#  how to build.
# 
texi2dvi = texi2dvi --batch --tidy --build-dir=$*.t2dvi
texi2pdf = texi2pdf --batch --tidy --build-dir=$*.t2pdf
#
makeinfo = makeinfo
texi2docbook = $(makeinfo) --docbook
texi2html = $(makeinfo) --html --no-split $(texi2html_top)
texi2info = $(makeinfo) --no-split
texi2txt = $(makeinfo) --plaintext --no-split
texi2xml = $(makeinfo) --xml
#
# Go somewhere useful from Top.
texi2html_top = -c TOP_NODE_UP_URL=http://tug.org/texinfohtml/

$(addsuffix .pdf,$(all_manuals)):%.pdf: %.texi
	$(texi2pdf) $<
$(addsuffix .dvi,$(all_manuals)):%.dvi: %.texi
	$(texi2dvi) $<
#
$(addsuffix .dbk,$(all_manuals)):%.dbk: %.texi
	$(texi2docbook) -o $@ $<
$(addsuffix .html,$(all_manuals)):%.html: %.texi
	$(texi2html) $<

$(addsuffix /index.html,$(all_manuals)):%/index.html: %.texi
	$(makeinfo) --html $(texi2html_top) $<

$(addsuffix .info,$(all_manuals)):%.info: %.texi
	$(texi2info) $<
$(addsuffix .txt,$(all_manuals)):%.txt: %.texi
	$(texi2txt) -o $@ $<
$(addsuffix .xml,$(all_manuals)):%.xml: %.texi
	$(texi2xml) $<


#  targets follow.
#
default: check-en

# to test changes, build a subset: html and info (since these formats
# exercise significantly different code paths), and pdf for tex.
check_suffixes = html info pdf
#
.PHONY: check
check: $(addprefix check-,$(languages))
define lang_template
.PHONY:check-$(1)
check-$(1): spell-$(lang) $(addprefix $($(1)_manual)., $(check_suffixes)) license-check-$(lang)
endef
$(foreach lang,$(languages), $(eval $(call lang_template,$(lang))))



# Build per language.
define lang_template
.PHONY: $(1)
$(1): license-check-$(1) $($(1)_output)
endef
$(foreach lang,$(languages), $(eval $(call lang_template,$(lang))))


# Build per language with UPDATED flag refresh setttig LC_TIME to fr
# or es does not change the format %B under MSYS, neither with awk
# time function, nor with date bash command. This is why we emulate
# this.
define fr_updated_awk
function updated(){\
  monthes[1]="Janvier";\
  monthes[2]="Février";\
  monthes[3]="Mars";\
  monthes[4]="Avril";\
  monthes[5]="Mai";\
  monthes[6]="Juin";\
  monthes[7]="Juillet";\
  monthes[8]="Août";\
  monthes[9]="Septembre";\
  monthes[10]="Octobre";\
  monthes[11]="Novembre";\
  monthes[12]="Décembre";\
  return monthes[month] " " year;\
}
endef
define en_updated_awk
function updated(){\
  monthes[1]="January";\
  monthes[2]="February";\
  monthes[3]="March";\
  monthes[4]="April";\
  monthes[5]="May";\
  monthes[6]="June";\
  monthes[7]="July";\
  monthes[8]="August";\
  monthes[9]="September";\
  monthes[10]="October";\
  monthes[11]="November";\
  monthes[12]="December";\
  return monthes[month] " " year;\
}
endef
define es_updated_awk
function updated(){\
  monthes[1] = "Enero";\
  monthes[2] = "Febrero";\
  monthes[3] = "Marzo";\
  monthes[4] = "Abril";\
  monthes[5] = "Mayo";\
  monthes[6] = "Junio";\
  monthes[7] = "Julio";\
  monthes[8] = "Agosto";\
  monthes[09] = "Septiembre";\
  monthes[10] = "Octubre";\
  monthes[11] = "Noviembre";\
  monthes[12] = "Diciembre";\
  return monthes[month] " " year;\
}
endef
define set_updated_awk
$($(1)_updated_awk);\
BEGIN { time_stamp=systime();\
	year=strftime("%Y",time_stamp);\
	month=strftime("%m",time_stamp) + 0;\
      };\
/^ *@set +UPDATED/ { the_func="updated_" lang;\
                     $$$$0="@set UPDATED " updated();};\
                   { print}
endef
define lang_template
.PHONY: updated-$(1)
updated-date-$(1):
	LC_TIME=C; \
	awk -v lang=$(1) '$(call set_updated_awk,$(1))' $($(1)_manual).texi > temp.texi; \
	if diff $($(1)_manual).texi  temp.texi > /dev/null; then \
		rm temp.texi; \
	else \
		mv temp.texi $($(1)_manual).texi; \
	fi

updated-$(1): updated-date-$(1)
	$$(MAKE) $(1)
endef
$(foreach lang,$(languages), $(eval $(call lang_template,$(lang))))


# To build everything in all languages.
.PHONY: all
all: $(languages)

# Check license consistency
define get_license_awk
BEGIN { print_enb = 0 }; \
/^@comment end of License/ { exit(0) }; \
print_enb == 1 { print }; \
/^@comment start of License/ { print_enb = 1}
endef

define lang_template
.PHONY: license-check-$(1)
license-check-$(1): license.texi $($(1)_manual).texi
	awk '$(get_license_awk)' $($(1)_manual).texi > temp.texi; \
	if diff license.texi  temp.texi; then rm temp.texi; else \
		echo "ERROR: License in manual $($(1)_manual).texi is inconsistent with license.texi" > /dev/stderr; \
		exit -1;\
	fi
endef
$(foreach lang,$(other_languages), $(eval $(call lang_template,$(lang))))

.PHONY: license-check-$(default_language)
license-check-$(default_language): license.texi

license.texi: $($(default_language)_manual).texi
	awk '$(get_license_awk)' $< > $@
	if [ `wc -l $@ | cut -d " " -f 1` -le 2 ]; then \
		rm $@; \
		echo "ERROR: Can't find license in $<" > /dev/stderr; \
		exit -1; \
	fi



# following the GNU sequence of clean targets.
.PHONY: distclean clean mostlyclean
distclean clean mostlyclean:
	rm -rf $(manual)*.t2* license.texi
	rm -f $(patsubst %,node-list-%.txt,$(languages))

.PHONY: realclean maintainer-clean
realclean maintainer-clean: distclean
	rm -f $(addprefix $(manual)*., $(suffixes) $(xref_suffixes))
	rm -fr $(foreach lang,$(addprefix dist-,$(languages)),$($(lang)) $($(lang)).zip)
	rm -fr $(manual)-help-texinfo $(manual)-help-texinfo.zip


#  dist for CTAN.  Also update NEWS
# 
define txt_files
ChangeLog Makefile.1 common.texi \
$(addsuffix $(subst -$(default_language),,-$(1)),NEWS README) \
ltx-help.el
endef

define dist_output
$($(1)_makeinfo_output) $(addprefix $($(1)_manual).,pdf texi) aspell.$(1).pws
endef

# $(1) = to be created & zipped directory name
# $(2) = en fr es
# $(3) = reverse path for $(1)
# $(4) = list of source files and other text files to be distributed.
define make_dist_dir
mkdir -p $(1); \
cd $(1); \
$(foreach file,$(call dist_output,$(2)) $(4), \
	ln -s $(3)/$(file) \
	$(subst README-$(2),README,\
	$(subst Makefile.1,Makefile,\
	$(file)));) \
cd $(3);
endef

# Distribution per language.
define lang_template
.PHONY: dist-$(1)
dist-$(1): $(1) updated-$(1)
	@uncommited=`svn status $$(call dist_output,$(1)) $$(call txt_files,$(1))`; \
	echo -n "$$$$uncommited"; \
	if [ -n "$$$$uncommited" -a -z "$(DIST_FORCE)" ]; \
	then \
		echo ""; \
		echo "There are uncommited changes."; \
		echo "Commit them before making the distribution zip..."; \
		echo "or make again with DIST_FORCE=1."; \
		exit 2; \
	fi
	@echo ""
	rm -fr $(dist-$(1))
	$$(call make_dist_dir,$(dist-$(1)),$(1),..,$$(call txt_files,$(1)))
	-zip -qr $(dist-$(1)).zip $(dist-$(1)) 
	rm -fr $(dist-$(1))
	@ls -l $(dist-$(1)).zip; unzip -t $(dist-$(1)).zip
endef
$(foreach lang,$(languages), $(eval $(call lang_template,$(lang))))



dist = $(manual)-help-texinfo
#
.PHONY: dist
dist: all
	@uncommited=`svn status $(foreach lang,$(languages),$(call dist_output,$(lang)) $(call txt_files,$(lang)))`; \
	echo -n "$$uncommited"; \
	if [ -n "$$uncommited" -a -z "$(DIST_FORCE)" ]; \
	then \
		echo ""; \
		echo "There are uncommited changes."; \
		echo "Commit them before making the distribution zip..."; \
		echo "or make again with DIST_FORCE=1."; \
		exit 2; \
	fi
	@echo ""
	rm -fr $(dist)
	$(call make_dist_dir,$(dist),$(default_language),..,$(call txt_files,$(default_language)))
	$(foreach lang,$(other_languages), \
		$(call make_dist_dir,$(dist)/$($(lang)_longname),$(lang),../..,))
	-zip -qr $(dist).zip $(dist)
	rm -fr $(dist)
	@ls -l $(dist).zip; unzip -t $(dist)



# A hacky spell check target.
# Remove \commandnames to reduce exception list, but not {args} or
# [args], since they are often words.
.PHONY: spell
spell: $(addprefix spell-,$(languages))
define lang_template
.PHONY: spell-$(1)
spell-$(1):
	sed -e 's/\\[a-zA-Z]*//g' $($(1)_manual).texi \
	| aspell list --mode=texinfo --add-extra-dicts=`pwd`/aspell.$(1).pws \
        | sort -f -u
endef
$(foreach lang,$(languages), $(eval $(call lang_template,$(lang))))

# Check for doubled words.
# http://www.math.utah.edu/~beebe/software/file-tools.html#dw
.PHONY: check-dw
check-dw: $(addprefix check-dw-,$(languages))

define _1
.PHONY: check-dw-$(1)
check-dw-$(1): $($(1)_manual).texi
	grep -v '^@item' $$< | dw

endef
$(eval $(foreach LANG,$(languages),$(call _1,$(LANG))))

# Convenience target to tag a delivery to CTAN
VC_USERID&=vincentb1
TAG?=ctan$(VERSION)
MESSAGE?=Delivery to CTAN $(VERSION)
CTANTAG?=svn copy svn+ssh://$(VC_USERID)@svn.gna.org.ua/latexrefman/trunk svn+ssh://$(VC_USERID)@svn.gna.org.ua/latexrefman/tags/$(TAG) -m "$(MESSAGE)"
.PHONY: tag
tag:
ifeq ($(VC_USERID),)
	echo 'Please define VC_USERID variable in your environment to your Puszcza user id'
	exit -1
else ifeq ($(TAG),ctan)
	@if test -z '$(VC_USERID)'; then \
		echo 'Please define VC_USERID variable in your environment to your Puszcza user id'; \
		exit -1; \
	else \
		$(MAKE) $@ "VERSION=$(shell date '+%Y-%m-%dT%T')"; \
	fi
else
	@echo 'Will you run the following command:'
	@echo '$(CTANTAG)'
	@select w in yes no; \
	do \
		case $$w in \
			yes) \
				$(CTANTAG); \
				break;; \
			no) \
				echo 'Cancelled'; \
				break;; \
		esac; \
	done
endif

# Convenience targets to svn revert the generated files,
# and svn diff the source files.
.PHONY: svr svd
svr:
	svn revert $(addprefix $(manual)*., $(all_suffixes))
svd:
	svn diff $(foreach lang,$(languages),$(call txt_files,$(lang))) $(patsubst %,aspell.%.pws,$(languages)) *.texi


# Target for comparing node lists between languages
# use target compare-nodes-fr to compare French & English together.
.PHONY: compare-nodes
#compare-nodes: $(addprefix compare-nodes-,$(other_languages))
# For the time being we compare only French/English as the Spanish
# translation does not reuse the same node names
compare-nodes: compare-nodes-fr

define _1
.PHONY: compare-nodes-$(1)
compare-nodes-$(1): node-list-$(1).txt node-list-$(default_language).txt 
	if diff $$^; then :; \
	else echo "=================================="; \
	  echo "Node list between $(1) and $(default_language) differ"; \
	  echo "=================================="; \
	fi

endef
$(eval $(foreach LANG,$(other_languages),$(call _1,$(LANG))))

define AWK_NODE_LIST
/^ *@node/ { gsub(/^ *@node +| *,.*$$$$/,""); print; }
endef

define _1
node-list-$(1).txt: $($(1)_manual).texi
	awk '$(AWK_NODE_LIST)' $$< > $$@

endef
$(eval $(foreach LANG,$(languages),$(call _1,$(LANG))))

# shorthands for compiling just one output <lang><ext>.
# for instance `make frinfo' is equivalent to `make latex2e-fr.info'
# `make enpdf`is is equivalent to `make latex2e.pdf'. etc.
define _1
.PHONY: $(1)$(2)
$(1)$(2): $($(1)_manual).$(2)

endef
$(eval $(foreach lang,$(languages),$(foreach suffix,$(suffixes),$(call _1,$(lang),$(suffix)))))

comma:=,
define make_list
in {$(join $(1),$(patsubst %,$(comma),$(filter-out $(firstword $(1)),$(1))))}
endef

.PHONY: help h ?
h ?:help
help:
	@echo "Target tag to set an SVN tag to delivered version"
	@echo "Target svr to revert all products"
	@echo "Target svd to make an svn diff over all deliverable sources"
	@echo "Target check-dw to check double words in .texi source for all languages"
	@echo "Target check-dw-L to check double words in .texi source for language L $(call make_list,$(languages))"
	@echo "Target updated-L to update version in .texi source for language L $(call make_list,$(languages))"
	@echo "Target L to make all format for language L $(call make_list,$(languages))"
	@echo "Target LF to make format F for language L $(call make_list,$(foreach L,$(languages),$(foreach F,$(suffixes),$(L)$(F))))"
	@echo "Target compare-nodes-L to compare node list of language L to node list of $(default_language), for L $(call make_list,$(other_languages))"

# Local Variables:
# coding: utf-8
# mode: makefile
# End:
