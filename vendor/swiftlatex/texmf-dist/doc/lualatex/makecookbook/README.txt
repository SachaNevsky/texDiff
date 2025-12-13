VERSION
sdfsfsf

This is the README file for the MAKECOOKBOOK bundle, version 0.85 dated 
2018-12-02.

BRIEF DESCRIPTION

The MAKECOOKBOOK bundle contains the files needed to create (using 
LuaTex) a nice quality family cookbook in a form ready to submit to a 
print-on-demand printer. Modifiable choices have been made regarding 
standard book features such as trim size, margins, headers/footers, 
chapter heading formatting, front matter (copyright page, table of 
contents, etc.) and back matter (recipe index). Commands and environments 
have been created to format the food stories and recipes. The user will 
need to: (1) supply their own food stories and recipes(!), and (2) select 
(install if necessary) the needed OpenType fonts as briefly discussed 
below and further described in the documentation. Please note that no new 
document class or package is included here.  Rather, we provide a 
modifiable preamble and a small number of other files that, together, 
fully support creation of all of the internal pages of a cookbook (i.e., 
everything except the cover art).

COPYRIGHT AND LICENSE

Copyright 2018 Terrence P. Murphy and Rosalie A. D'Amico

This work may be distributed and/or modified under the conditions of the 
LaTeX Project Public License ("LPPL"), either version 1.3c of this 
license or (at your option) any later version. The latest version of this 
license is at:    

    http://www.latex-project.org/lppl.txt

This work is author-maintained and consists of the files listed in the 
FILES section of this README file.

CHANGE HISTORY

This is the initial version 0.85, dated 2018-12-02.

MAINTENANCE

Please report bugs or request features to Terrence P. Murphy:
   latex@rd-tpm.com

FILES

This work consists of the following files:

README                    this file
makecookbook-doc.tex      documentation file
makecookbook-doc.pdf      PDF of the above
makecookbook.tex          the "root" cookbook file
makecookbook.pdf          PDF of the cookbook
cb-preamble.tex           the preamble for the cookbook
cb-lettrine.cfl           config file for the lettrine package
cb-idxstyle.ist           config file for makeindex/imakeidx
cb-frontmatter.tex        the cookbook front matter
cb-chapterA.tex           a sample cookbook chapter
cb-chapterB.tex           a sample cookbook chapter
cb-imageA.jpg             a sample image (from mwe package)
cb-imageB.jpg             a sample image (from mwe package)

FILE DIRECTORIES

In the CTAN zip archive, the above files are organized into directories 
and subdirectories as follows:

makecookbook/             The top level makecookbook package directory
|   README        
|   makecookbook-doc.tex
|   makecookbook-doc.pdf
|   
|--- mycookbook/   
     |   makecookbook.tex
     |   makecookbook.pdf
     |   cb-preamble.tex 
     |   cb-lettrine.cfl
     |   cb-idxstyle.ist 
     |
     |--- tex/     
     |       cb-frontmatter.tex                      
     |       cb-chapterA.tex      
     |       cb-chapterB.tex        
     |
     |--- img/     
             cb-imageA.jpg
             cb-imageB.jpg

As described in the documentation, the idea is that the mycookbook/ 
directory will be the root directory of your cookbook project.  
All of your cookbook chapters will be held in mycookbook/tex/
All of your cookbook images will be held in mycookbook/img/

FONTS

The MAKECOOKBOOK bundle assumes you have installed the three fonts 
listed below. (All are OpenType, including TrueType, and all are 
licensed under the SIL Open Font License, Version 1.1). To have a 
successful compile "out of the box", these fonts must be installed 
on your system:

SERIF-------> EB Garamond (version from Google Fonts)
SANS SERIF--> Lato        (version from http://www.latofonts.com)
SCRIPT------> Italianno   (version from Google Fonts)

As described in the documentation, you can easily replace those three 
fonts with your favorite serif, sans serif and script fonts, so long 
as your replacement fonts have certain required font features.
