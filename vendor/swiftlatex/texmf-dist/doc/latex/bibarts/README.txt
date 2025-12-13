
BibArts is a package to administer bibliographical references in footnotes,
and for creating a bibliography from these references simultaneously;
it requires a program, for which source and Windows executable are provided. 
(A summary of contents is in English; the full documentation is in German.)

===

BibArts 2.2 is a LaTeX package to assist in making bibliographical features
common in the arts, and in the humanities (history, political science,
philosophy, etc.).  bibarts.sty provides commands for quotation, register
keywords, abbreviations, and especially for a formatted citation of
literature, journals (periodicals), published documents, and unpublished
archive documents.

BibArts will also copy the arguments of all those commands into lists for an
automatically generated appendix.  These lists are optionally referring to
page and footnote numbers in your text (index).  BibArts has nothing to do
with BibTeX, and it does not use any data bank except your own LaTeX text.

The lists are created by bibsort.  A file bibsort.exe is part of the package
( CTAN mirrors > BibArts > bibarts.zip ) and runs on newer Windows systems.
Other users first have to create a binary file from bibsort.c (ANSI-C) with
their own C-compiler.  BibArts 2.2 is developed and tested on Windows 10
with the 2018-12-01 LaTeX 2e distribution, but even LaTeX 2.09 should work.

 BibArts 2.2 (9 files, 8 dated 2019-03-03):
  README.txt     This file here
  bibarts.sty    The LaTeX style file
  ba-short.pdf   Short introduction (English)
  ba-short.tex   Source of ba-short.pdf
  bibarts.pdf    Full documentation (German)
  bibarts.tex    Source of bibarts.pdf
  bibsort.exe    Binary to create the lists
  bibsort.c      Source of bibsort.exe
  COPYING        License (dated 1993-11-28)

===

Changes from BibArts versions 1.x (1990s) to versions 2.x:

Version 2.0 was a completely new package with massive extensions.  Since,
bibarts.sty helps to use slanted fonts (italics), and is able to set ibidem
automatically in footnotes.  Therefore, it is now possible to add volume and
page numbers e.g. to the \vli command (\vli did also exist in 1.x for full
references to literature), and the new \kli command (shortened references).
Pre-defined text elements (captions) are provided as \bacaptionsenglish,
\bacaptionsfrench, and \bacaptionsgerman (default).

bibsort 2.x creates the index numbers (BibArts 2.x does not use MakeIndex).

bibarts.sty 2.x starts an emulation for 1.3 texts, when you type \makebar,
but you better keep copies of the package files of a BibArts 1.x, if you
wrote texts with it.  BibArts 2.x uses .aux files instead of a .bar file.
Even if you set \makebar, any changes to commands \schrift, \barschrift, and
\indschrift will be ignored.  \verw and \punctuation do not exist any more;
see examples for the new commands \frompagesep and \ntsep in bibarts.pdf.

===

Changes from BibArts version 2.0 (2015) to version 2.1 (2016):

BibArts 2.0 set \footnotesep to 2ex, whereas 2.1 and 2.2 do *not* change the
pre-set value.  If you want to continue with the 2.0-distance between two
footnotes, you will have to type \setlength{\footnotesep}{2ex} in your text.

Some of the pre-defined text elements (captions) have been modernized.  The 
\evkctitlename changed from {Short Titles} to {Shortened References}.  And
\gannouncektitname changed to "... im Folgenden".  To restore its 2.0 def.:
\renewcommand{\gannouncektitname}{ (\kern 0.015em im folgenden \baupcorr}

bibarts.sty will be even loaded, when ~":;!?'`<> are active (catcode 13);
and bibsort is sorting also "z (not only "s) as \ss now; see bibarts.pdf.

You now may choose your own order of page and footnote numbers in the index
(roman--arabic, arabic--roman, etc.).  Type  bibsort -s2 xxxx  for page and
... -f2 xxxx  for footnote numbers.  xxxx  are permutations of 4 letters
out of  nRrAas  (a=alph, A=Alph, n=arabic, R=Roman, r=roman, s=fnsymbol);
you always have to set n and s, and to choose R *or* A, and r *or* a.  E.g.
srnR  means, that you can use \Roman in your text, but you do not have to.

bibsort is able to evaluate the new fnsymbols (which expand to \TextOrMath).

If bibsort should write into files with a different prefix as the .aux input
file, you have to use -o <outfile> now.  And you may type  bibsort <infile>,
*or*  bibsort -i <infile>  (e.g. when the input file name begins with '-').

bibsort sorts the 'official' $Greek variables$ since version 2.0.  To write
single words in Old Greek, BibArts 2.1 also provides \Alpha [A], \Beta [B],
\Epsilon [E], \Zeta [Z], \Eta [H=sort=>E], \Iota [I], \Kappa [K], \Mu [M], 
\Nu [N], \Rho [P==>R], \Tau [T], \Chi [X==>Ch], \Omicron [O], \omicron [o].

===

Changes from BibArts version 2.1 (2016) to version 2.2 (now, 2019):

(1)  bibsort 2.2, the sorting program of the package, has 3 new options:

Use   bibsort -h [...]   to sort hyphens  ( - \hy \fhy "= "~ )  as spaces.

Use   bibsort -b [...]   to begin the sorting of the title at \bago, e.g.:
       \vli{J.}{Smith}{The \bago \ktit{Book}, London 2005}

      bibsort -n1 [...]   will create blocks of footnote numbers only, if
the entries are from footnotes on the same page, e.g.:  10^{3-6}, 11^{7-9}

(2)  If there are two entries of  \kli{Smith}{Book}  from two successive
pages, but with *the same* footnote number, bibsort 2.2 will print out
e.g.  10^{3}, 11^{3} .  bibsort 2.0 and 2.1 ignored  11^{3}  in that case.

(3)  bibsort 2.2 checks your input concerning the \ktit{Shortened Title}.
You will find warnings on the screen and as comments in the created files.

(4)    \vli{J.}{Smith}{The \ktit{\onlyvoll{r}\onlykurz{R}ed Book}, 2006}
has to be used (for index and ibidem), if the shortened title is not just
a part of the full title ("red" and "Red").  In some cases, bibsort 2.1
printed out wrong only-arguments on the lists.  This error has been fixed.
And errors in the sorting of entries with only-commands were eliminated.

(5)  You may say now  \renewcommand{\ntsep}{\bapoint\ }  to print out a
full stop between name and title; BibArts is avoiding e.g. "Smith, J..".

(6)  If you '\renewcommand' a pre-defined text element (caption), you
sometimes will have to adapt the italic correction.  Bibarts 2.2 provides
the homogenous command  \bacorr  instead of the four different commands
\bakxxcorr, \baabkcorr, \balistcorr, and \bakntsepcorr  (but those old
commands are still valid).  To print the lists, you may say now e.g.:
       \renewcommand{\frompagesep}{\bacorr ; } \printnumvli \printnumvkc

(7)  If you use babel, BibArts 2.2 will not execute \originalTeX between
list items (that's prepared by bibsort, if the catcode of " changes):  It
was useless with germanb-babel and caused errors with french-babel.  With
german.sty or ngerman.sty, the use of \originalTeX is still reproduced.

(8)  bibarts.sty provides new commands for the hyphenation in German:
- \oldhyss to set a \ss, which is splitted s-s (to be used between vovels,
  e.g. au\oldhyss er; you have to use your sharp S else, e.g. da\ss);
- \newhyss to set a \ss, which is splitted s-s only in small caps, and
  else is printing a sharp S, which is splitted as \language says (-\ss);
- \hyss to execute \oldhyss, if \language is \l@german, and \newhyss else
  (e.g. if \language is \l@ngerman --- so, \hyss can be used *always*);
- commands for the handling of "tripple consonant before vovel" in German:
  E.g. Sto\hyf figur, Scha\hyl leistung, Sta\hym mutter, Ke\hyn nummer,
  Ste\hyp pullover, Sta\hyr rahmen, and Schri\hyt tempo:  If \language is
  \l@german, BibArts will PRINT AND SORT \hyf as f, and ELSE as ff, etc.
+ All commands are ready to be used in \MakeUppercase (also Dru\hyc ker).

(9)  If you \conferize, e.g. \kli{A}{B} will print a cross-reference to
\vli{}{A}{\ktit{B}}.  The INTERNAL KEYWORD is created from the letters,
and some accents you use in {A} and {B}.  The accents are REPRESENTED as
\`=[  \'=]  \"=*  \ss=(ss  \l=(l  \L=(L  \o=(o  \O=(O  \^=)  \~=-  \c=+
in the keyword.  The active " and \= \. \b \d are not represented any more.


===

Published under the terms of the GNU General Public License. 

BibArts 2.2  (C) Timo Baumann  2019
