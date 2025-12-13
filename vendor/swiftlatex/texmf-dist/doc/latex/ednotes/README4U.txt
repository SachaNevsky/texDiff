README4U: 

******************************************************************
***                                                            ***
***           Changes from ednotes.sty v0.64 to v1.0           *** 
***                                                            ***
***                  (Uwe Lueck, 2004/10/21)                   *** 
***                                                            ***
******************************************************************



* SUMMARY: *

  Since August 2004, the number of bundle files has been reduced. 
  Many of the remaining files have changed, some essentially, 
  others with respect to usage instructions. We explain how to 
  update your Ednotes installation accordingly. Optional 
  "patches", enhancements etc. that earlier had to be called by 
  loading separate files explicitly (mandatory arguments of 
  \usepackage) are now called by ednotes.sty package options 
  (optional arguments in \usepackage[<opt>]{ednotes}). New PDF 
  documentations/instructions have appeared. 


* Contents of this file: * 

  LN/MF_edn.zip -- ednotes/lineno/manyfoot/further changes -- 
  updating procedure -- new documentations 


* Some files you may have received: * 

  You may have received (by e-mail from us, e.g.) a distribution 
  containing files 

    LN_edn.zip 
    MF_edn.zip 

  They serve two purposes: 

  1. They contain the files README and CHANGES that reside in the 
     CTAN directories `[...]/lineno' and `[...]/ncctools' (from 
     which manyfoot.sty stems). In order to avoid that README and 
     CHANGES files overwrite each other, unzip them into separate 
     directories, and into another one than the README file (for 
     ednotes.sty) that you should have received as a plain text 
     file. 

  2. LEGAL, IMPORTANT: 

     The files README, manyfoot.dtx, and nccfoots.dtx contained in 
     MF_edn.zip are, by their copyright holder Alexander Rozhenko, 
     demanded to ACCOMPANY any (re)DISTRIBUTION of manyfoot.sty 
     and nccfoots.sty! 


* ednotes.sty changes: * 

  1. ednotes.sty version 1.0 has new package options `edtable', 
     `longtable', `nolongtablepatch', `edmacpara', 
     `countoccurrences', and `mathnotes' for handling "patch" or 
     enhancement etc. files. None of these files should be loaded 
     through the mandatory argument of \usepackage any more. E.g., 
     instead of \usepackage{edtable}, you now type 

       \usepackage[edtable,<further options>]{ednotes} .

     (So -- one advantage aimed at -- you must no longer worry 
     about the correct order of loading extension packages.)

  2. The above-mentioned option `nolongtablepatch' changes earlier 
     behaviour with respect to our longtable.sty patch file 
     ltabptch.sty, in avoiding an error message that otherwise 
     appears when ltabptch.sty is not present. This is convenient 
     when you deliberately want to avoid the patch. The error 
     message ensures that vertical spacing around a "longtable" 
     does not depend on the local TeX installation -- e.g., when 
     you send your source to a journal. 

  3. ednotes.sty has a new option `perpage' for making use of the 
     manyfoot.sty option `perpage' -- just see the Manyfoot 
     documentation for what it does. It requires perpage.sty, 
     which is available from [CTAN]/macros/latex/contrib/misc. 
 

* lineno.sty changes: * 

  1. The new version 4.1 of lineno.sty makes former extension 
     files linenox0.sty, linenox1.sty, and lnopatch.sty obsolete. 
     Don't load them any more! (We have installed a reminder for 
     the case that you don't obey this rule.)

  2. \firstlinenumber has slightly changed from its earlier 
     behaviour given by lnopatch.sty. See lineno.sty/tex/pdf. 


* manyfoot.sty changes: * 

  The new version 1.7 of manyfoot.sty provides a command 
  \ExtraParaSkip to replace our earlier \MFparaxbuffer. 
  (See the new ednotes.sty documentation to recall 
  \MFparaxbuffer -- search for `\ExtraParaSkip', e.g.) 
  This makes former extension file mfparxsp.sty obsolete. 
  Please replace \MFparaxbuffer by \ExtraParaSkip and don't 
  load mfparxsp.sty any more! For your earlier documents that 
  contain \usepackage{mfparxsp}, we offer a new version of 
  mfparxsp.sty which just reminds you of the change and 
  ("for this time") redirects your \MFparaxbuffer to 
  \ExtraParaSkip. You may as well just delete your copy of 
  mfparxsp.sty, if you are sure, e.g., that you won't anymore 
  compile a .tex containing \MFparaxbuffer and 
  \usepackage{mfparaxbuffer}. 


* Further corresponding changes: * 

  Extension files that still are used -- now required by the new 
  ednotes.sty package options -- have been changed at least with 
  respect to explanations that they contain. 


* UPDATING: * 

  1. (Mandatory:) overwrite your copies of 

       edcntwd0.sty 
       ednmath0.sty 
       ednotes.sty 
       edtable.sty
       lineno.sty 
       manyfoot.sty 
       mfparptc.sty 

     with the new versions. 

  2. Overwrite

       mfparxsp.sty 

     by our new "reminder" version, or just remove it from TeX's 
     searching scope -- as you like, recall `manyfoot.sty changes' 
     avove. 

  3. You may remove (from TeX's searching scope) linenox0.sty, 
     linenox1.sty, lnopatch.sty -- but they won't harm otherwise; 
     you will get an error message if you load one of them 
     inadvertently. 


* New documentation/instructions: * 
 
  1. An article on ednotes.sty is appearing in TUGboat vol. 24. 
     It describes the main commands and functions of Ednotes. 
     Moreover, it compares Ednotes to EDMAC and LEDMAC, two other 
     TeX macro packages for critical edition typesetting. 
     We provide a version of the article very near to the final 
     one as 

       tb77lueck.pdf . 

     (it is definitively not the final version.)

  2. The README for ednotes.sty has been rewritten very much and 
     may yield new insights. Detailed explanations addressing 
     non-TeXperts have been added. 

  3. lineno.tex has been updated according to the changes of 
     lineno.sty, of course. A pdflatex outcome 

       lineno.pdf 
 
     is available ([CTAN]/macros/latex/contrib/lineno/lineno.pdf). 
 
     A pdflatex outcome 
 
       ulineno.pdf 
 
     of the user's guide ulineno.tex is available as well. 
     It only deals with lineno.sty version 3.1, but will though 
     be helpful (I think). 
 
     Recall that lineno.sty offers many commands to control the 
     style of the marginal line numbers, so its documentation is 
     an essential contribution to ednotes.sty documentation. 

  4. Version 1.7 of manyfoot.sty is generated from the 
     corresponding version of 

       manyfoot.dtx 

     which is the TeX source for the documentation of 
     manyfoot.sty. Recently, the pdflatex output 

       manyfoot.pdf 

     has been added to CTAN directory ncctools. These two files 
     may be less essential for ednotes.sty users than 
     (u)lineno.tex/pdf. However, manyfoot.sty offers features 
     that you may find interesting: (i) customize rules between 
     footnote layers; (ii) \SplitNote (for paragraphed footnotes 
     at page breaks). (For nccfoots.sty, which manyfoot.sty 
     requires, there are nccfoots.dtx/pdf as well.)
 

Good Luck! 


[End of README4U]
