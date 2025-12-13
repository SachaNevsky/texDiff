#
# Makefile bestial pour un projet Latex
# 
# Attention : le cible dite "standard" sont en réalité dépendante de ce projet 
# (e.g. clean, distclean, ...)
# 
# Modif par Maurice Diamantini le 29/08/2006


########################################################################

FILE = "pst-uml-doc"
EXEMPLES = "pst-uml-exemples"
FIG = "pst-uml-encapsuled-pdf-fig"

########################################################################
all: docpdf expdf fig clean

doc:
	$(MAKE) tex       && \
	$(MAKE) tex       && \
	$(MAKE) ps        

ex:
	latex $(EXEMPLES).tex && \
	latex $(EXEMPLES).tex && \
	dvips $(EXEMPLES).dvi -o $(EXEMPLES).ps 

docpdf: 
	$(MAKE) doc       && \
	ps2pdf $(FILE).ps  $(FILE).pdf

expdf: 
	$(MAKE) ex       && \
	ps2pdf $(EXEMPLES).ps  $(EXEMPLES).pdf

fig: 
	latex $(FIG).tex			&& \
	dvips -E $(FIG).dvi  -o $(FIG).eps	&& \
	epstopdf $(FIG).eps
	

# full : la totale !  peut servir de réservoir pour l'étiquette par défaut
full:
	$(MAKE) tex       && \
	$(MAKE) pdftex    && \
	$(MAKE) dvipdf    && \
	$(MAKE) bib       && \
	$(MAKE) dvi       && \
	$(MAKE) psoffset  && \
	$(MAKE) ps        && \
	$(MAKE) vps       && \
	$(MAKE) pdf       && \
	$(MAKE) epdf      && \
	$(MAKE) vpdf        


########################################################################
# C'est pour construire le dvi correcte qu'il faudra rendre ce Makefile 
# plus intelligent !
# 

dvi : 
	$(MAKE) tex   && \
	$(MAKE) tex   && \
	$(MAKE) dvipdf

########################################################################
# 
# Quelques étiquettes symboliques standards (pour moi :-)
# 

tex:
	@echo
	@echo "=>   lancement d'UN latex"
	@echo
	latex $(FILE).tex 

dvipdf:
	@echo
	@echo "=>   lancement d'UN dvipdf"
	@echo
	dvipdf $(FILE).dvi

pdftex:
	@echo
	@echo "=>   lancement d'UN pdflatex"
	@echo
	pdflatex $(FILE).tex 

bib:
	@echo
	@echo "=>   lancement d'UN bibtex"
	@echo
	bibtex $(FILE)

ps : 
	@echo
	@echo "=>   création de $(FILE).ps :"
	@echo "=>   Un fichier récent $(FILE).dvi **DOIT** exister"
	@echo
	dvips $(FILE).dvi  -t a4 -o $(FILE).ps


txt:
	@echo
	@echo "=>   création d'une version texte pur par hevea :"
	@echo
	hevea -francais -text -o $(FILE).txt $(FILE).tex

html:
	@echo
	@echo "=>   création d'une version html par hevea :"
	@echo
	hevea -francais -o $(FILE).html $(FILE).tex

########################################################################
# psresize 
psoffset : 
	@echo
	@echo "=>   modif offset du fichier postscript :"
	@echo
	mv -f $(FILE).ps $(FILE).ori.ps 			&& \
	pstops "0(0cm,-1.5cm)"  $(FILE).ori.ps   $(FILE).ps	&& \
	rm $(FILE).ori.ps
	
	

2upps : 
	@echo
	@echo "=>   conversion postscript vers 2up "
	@echo
	psnup -2 -pa4 -m1.5cm $(FILE).ps $(FILE).2up.ps

2up : 2uppdf
2uppdf : 2upps
	@echo
	@echo "=>   conversion 2up postscript vers 2up pdf"
	@echo
	ps2pdf  $(FILE).2up.ps $(FILE).2up.pdf  && \
	rm $(FILE).2up.ps
# # pdf:
# # 	@echo
# # 	@echo "=>   création de $(FILE).pdf :"
# # 	@echo "=>   Un fichier récent $(FILE).ps **DOIT** exister"
# # 	@echo
# # 	ps2pdf $(FILE).ps  $(FILE).pdf
# Les options "-Pwww -G0" de dvips sont en vue de générer du PDF
pdf:
	@echo
	@echo "=>   création de $(FILE).pdf :"
	@echo "=>   Un fichier récent $(FILE).dvi **DOIT** exister"
	@echo
	dvips -Pwww -G0  $(FILE).dvi  -o $(FILE).ps4pdf && \
	ps2pdf $(FILE).ps4pdf  $(FILE).pdf && \
	rm $(FILE).ps4pdf
pdfold:
	@echo
	@echo "=>   création de $(FILE).pdf :"
	@echo "=>   Un fichier récent $(FILE).dvi **DOIT** exister"
	@echo
	ps2pdf $(FILE).ps  $(FILE).pdf

# Pour créer une figure encapsulée pdf en utilisant pstricks
# 
# \documentclass[a4paper]{article}
#     \usepackage{times}%           xxxxxxxxxx IMPORTANT
#     \usepackage{pst-eps}%         xxxxxxxxxx IMPORTANT
#     \thispagestyle{empty}%        xxxxxxxxxx IMPORTANT
#     \usepackage{pst-uml}
# \begin{document}
# \TeXtoEPS%
# % put your own figure stuff here
# \umlActor[umlActorLineWidth=1mm]{Client}
# \endTeXtoEPS%
# \end{document}
# 
epdf:
	latex $(FILE).tex			&& \
	dvips -E $(FILE).dvi  -o $(FILE).eps	&& \
	epstopdf $(FILE).eps


########################################################################
# 
# étiquettes auxiliaires
# 


vdvi:
	xdvi  ${XDVI_ARGS}     $(FILE).dvi &

vps:
	gv    ${GV_ARGS}     $(FILE).ps &

# xpdf:
# vpdf:
# 	xpdf  ${XPDF_ARGS}   $(FILE).pdf &
xpdf:
vpdf:
	# echo `which xpdf`
	# echo "LD_LIBRARY_PATH=$$LD_LIBRARY_PATH"
	xpdf   ${XPDF_ARGS}    $(FILE).pdf &

ar: acroread
acroread:
	open -a acroread $(FILE).pdf &

pv: preview
preview:
	open -a Preview $(FILE).pdf &


########################################################################
## 

# pour mes essais
try:
	latex try.tex 
	dvips try.dvi  -o try.ps
	gv -pixmap -scale 2 -geo 1000x900+0+0 -watch try.ps &


# editeur stead pour latex  URL :  <http://www.ensta.fr/~diam/stead>
e:      edit
ed:     edit
edit:
	stead  $(FILE).tex  &


clean: 
	rm -f *.aux *.bbl *.blg  *.log *.lof *.lot *.tmp *.toc *.ps4pdf  *.idx
	rm -f *.out *.nav *.snm  $(FILE)*.dvi $(EXEMPLES).dvi
	rm -f $(FILE).ps $(EXEMPLES).ps $(FIG).dvi $(FIG).eps

dc: distclean
distclean: clean
	rm -f $(FILE)*.dvi $(FILE)*.ps $(FILE)*.pdf
	rm -f $($(EXEMPLES))*.dvi $($(EXEMPLES))*.ps $($(EXEMPLES))*.pdf
	rm -f $(FIG).pdf

########################################################################
# Archivage du répertoire courant dans le répertoire parent
# avec la date dans le nom du .zip créé
# 
# Description des options de zip utilisées :
#    -r   recurse into directories
#    -y   store symbolic links as the link instead of the referenced file
#    -9   compress better (-1 compress faster)
#    -v   verbose operation/print version info
#    -q   quiet operation
#    -o   make zipfile as old as latest entry
# Decompression par :
#    unzip leFichier.zip
#    le répertoire "projet" d'origine est alors recréer (ATTENTION
#    s'il existe déja)
arc: zip
zip:
	$(MAKE) clean
	date=`date +%Y%m%d-%Hh%Mmn` 			&& \
	lpath=`pwd`					&& \
	bname=`basename $$lpath`			&& \
	datename=$$bname-$$date				&& \
	cd ..						&& \
	cp -a $$bname $$datename 			&& \
	zip -r -y -o -q -9  $$datename.zip $$datename	&& \
	\rm -rf $$datename				&& \
	cd $$lpath

tgz:
	$(MAKE) clean
	date=`date +%Y%m%d-%Hh%Mmn` 			&& \
	lpath=`pwd`					&& \
	bname=`basename $$lpath`			&& \
	datename=$$bname-$$date				&& \
	cd ..						&& \
	cp -a $$bname $$datename 			&& \
	tar cf - $$datename | gzip > $$datename.tgz	&& \
	\rm -rf $$datename				&& \
	cd $$lpath

tbz:
	$(MAKE) clean
	date=`date +%Y%m%d-%Hh%Mmn` 			&& \
	lpath=`pwd`					&& \
	bname=`basename $$lpath`			&& \
	datename=$$bname-$$date				&& \
	cd ..						&& \
	cp -a $$bname $$datename 			&& \
	tar cf - $$datename | bzip2 > $$datename.tbz	&& \
	\rm -rf $$datename				&& \
	cd $$lpath


#./
