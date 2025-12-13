%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% This is the `readme.txt' file of the ArmTeX project.
%%
%% This file is a part of the ArmTeX project [2014/04/09 v3.0-beta3]
%%
%% ArmTeX is a system for writing in Armenian with plain TeX and/or LaTeX(2e).
%%
%% Copyright 1997 - 2013:
%%   Serguei Dachian (Serguei.Dachian_AT_math.univ-bpclermont.fr),
%%   Arnak Dalalyan  (arnak.dalalyan_AT_ensae.fr),
%%   Vardan Akopian  (vakopian_AT_yahoo.com).
%%
%% ArmTeX may be distributed and/or modified under the conditions of the LaTeX
%% Project Public License, either version 1.3 of this license or (at your
%% option) any later version.
%%
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX version
%% 2005/12/01 or later.
%%
%% ArmTeX has the LPPL maintenance status `author-maintained'.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



1. Description

ArmTeX is a system for writing in Armenian with plain TeX and/or LaTeX(2e).
It can be used with a standard Latin keyboard without any special support for
Armenian letters.  It can also be used with an Armenian keyboard which
supports either Unicode (UTF8) encoding, or any single-byte encoding having
Armenian letters in the second half (characters 128-255) of the extended ASCII
table (however, single-byte encoding definition files are provided for
ArmSCII8 encoding only; for other single-byte encodings you will have to write
corresponding encoding definition files for plain TeX and/or for LaTeX
yourself, using respectively `armkb-a8.tex' and `armscii8.def' as examples).

This is a freeware system by Serguei Dachian, Arnak Dalalyan and Vardan
Akopian, and it can be distributed and/or modified under the conditions of the
LaTeX Project Public License (see above).



2. Installation

If you are upgrading from ArmTeX 1.0 or 2.0, you should first "uninstall" the
previous version.  Indeed, the changes between versions are important (see
also the ArmTeX manual).  Not only some files were changed, but some old files
were removed, some new files were added and some files were renamed.  Note
also, that between versions 1.0 and 2.0, the transliteration scheme was
modified, and so a slight (re)editing of your own documents typed with ArmTeX
1.0 is necessary.  So, first remove all the files related to the previous
version of ArmTeX (the files which are part of it, as well as, say, generated
PK files) and (if upgrading from ArmTeX 1.0) be sure to read the section of
the ArmTeX manual about the changes of the transliteration scheme.


The installation generally consists of the three following steps.

a) Copy ArmTeX 3.0 files somewhere your TeX system can find them.

b) Make your TeX system aware of the new files (update the TeX filename
   database).

c) Activate the map files `artm.map' and `arss.map', so that they can be used
   by programs like pdfTeX, dvips, dvipdf, dvipdfm, etc.


On TeXlive based systems (including MacTeX) we recommend installing ArmTeX 3.0
as administrator (root) to the local texmf tree (the location of which can be
found using "kpsewhich --var-value TEXMFLOCAL" command).  So, all the commands
need to be run either from the root account, or with the help of the "sudo"
command (it seems that "sudo -H" is preferable to "sudo").  For the step a),
just copy the folders `doc', `fonts' and `tex' to the chosen location.  For
the step b), use the command "mktexlsr" (or, on some systems, the command
"texhash").  Finally, the step c) is performed using the following commands:

updmap-sys --enable MixedMap artm.map
updmap-sys --enable MixedMap arss.map

It is also possible to install ArmTeX 3.0 to your personal texmf tree (the
location of which can be found using "kpsewhich --var-value TEXMFHOME"
command).  In this case the step b) is not needed, and the step c) is
performed using the following commands:

updmap --enable MixedMap artm.map
updmap --enable MixedMap arss.map

However, be warned that as soon as you have run "updmap" once, any consequent
calls to "updmap-sys" will be ineffective.  So, if some new maps are installed
system-wide, they will not be available to you until you rerun "updmap"
yourself.


On MikTeX based systems we recommend installing ArmTeX 3.0 in a separate
(dedicated to ArmTeX) tree.  The trees are managed via the MikTeX Maintenance
(or Settings) GUI.  Just add a tree pointing to some empty directory and copy
the folders `doc', `fonts' and `tex' to it.  The step b) can be performed via
the GUI or by running the command "initexmf --update-fndb".  Finally, for the
step c), run the command "initexmf --edit-config-file updmap", add the lines

MixedMap artm.map
MixedMap arss.map

to the opened file, save it, after which run the command "initexmf --mkmaps".


After completing the three steps, you should be able to compile the example
and documentation files from the `doc/generic/armenian/examples' directory.
The latter contains two subdirectories: `plain' and `latex'.  The files from
the first one should be compiled with plain TeX (usually "tex" and "pdftex"
commands), and the files from the second one should be compiled with LaTeX2e
(usually "latex" and "pdflatex" commands).

To type your own documents (in plain TeX or in LaTeX) read the ArmTeX manual.
The source of the Armenian version of the manual is in the `manual.tex' file
located in the `doc/generic/armenian/examples/latex' directory, while the
source of the English one is in the `manual-e.tex' file located in the same
place.  PDF files of both versions (`manual.pdf' and `manual-e.pdf') are also
included in ArmTeX 3.0 distribution (in the `doc/generic/armenian' directory,
along with this `readme.txt' file).



3. About fonts

The ArmTeX system includes two families of fonts:

  a) Artm (Armenian Times) family contains the fonts artmr10, artmsl10,
artmi10, artmb10, artmbs10 and artmbi10: a Serif font (something like Times
New Roman or Computer Modern Roman), along with its Slanted, Italic, Bold,
Bold Slanted and Bold Italic versions.

These fonts were initially converted from the TrueType font family
ArTarumianTimes created by Ruben Hakobian (Tarumian).  We would like to thank
Ruben once again for giving us the permission to use his fonts.

  b) Arss (Armenian SansSerif) family contains the fonts arssr10, arsssl10,
arssb10 and arssbs10: a SansSerif font (something like Arial or Computer
Modern SansSerif), along with its Slanted, Bold and Bold Slanted versions.

These fonts were initially converted from the PostScript font Sassoun created
by Raffi Kojian (n_w$$h).  We would like to thank Raffi once again for giving
us the permission to use his font.



4. List of files

Here is a complete list of ArmTeX 3.0 files (by directory).

doc/generic/armenian:
manual.pdf      % PDF file of the Armenian version of the ArmTeX manual.
manual-e.pdf    % PDF file of the English version of the ArmTeX manual.
readme.txt      % This `readme.txt' file.

doc/generic/armenian/examples/latex:
alphabet.tex    % A LaTeX sample: Armenian alphabet with IPA transcriptions.
manual.tex      % Source of the Armenian version of the ArmTeX manual.
manual-e.tex    % Source of the English version of the ArmTeX manual.
raffi.tex       % A sample LaTeX document in transliteration.
raffi-a8.tex    % A sample LaTeX document in ArmSCII8.
raffi-u8.tex    % A sample LaTeX document in UTF-8.

doc/generic/armenian/examples/plain:
first.tex       % The first ever Armenian sample document in (plain) TeX.
plraf.tex       % A sample plain TeX document in transliteration.
plraf-a8.tex    % A sample plain TeX document in ArmSCII8.
plraf-u8.tex    % A sample plain TeX document in UTF-8.
table.tex       % A plain TeX sample: table of an Armenian OT6 font.

fonts/afm/public/armenian:
arssb10.afm     % AFM file for Armenian SansSerif Bold 10pt font.
arssbs10.afm    % AFM file for Armenian SansSerif Bold Slanted 10pt font.
arssr10.afm     % AFM file for Armenian SansSerif (Roman) 10pt font.
arsssl10.afm    % AFM file for Armenian SansSerif Slanted 10pt font.
artmb10.afm     % AFM file for Armenian Times Bold 10pt font.
artmbi10.afm    % AFM file for Armenian Times Bold Italic 10pt font.
artmbs10.afm    % AFM file for Armenian Times Bold Slanted 10pt font.
artmi10.afm     % AFM file for Armenian Times Italic 10pt font.
artmr10.afm     % AFM file for Armenian Times (Roman) 10pt font.
artmsl10.afm    % AFM file for Armenian Times Slanted 10pt font.

fonts/map/dvips/armenian:
arss.map        % MAP file for Armenian SansSerif fonts.
artm.map        % MAP file for Armenian Times fonts.

fonts/source/public/armenian:
arssb10.mf      % Source file for Armenian SansSerif Bold 10pt font.
arssbs10.mf	% Source file for Armenian SansSerif Bold Slanted 10pt font.
arssr10.mf	% Source file for Armenian SansSerif (Roman) 10pt font.
arsssl10.mf	% Source file for Armenian SansSerif Slanted 10pt font.
artmb10.mf	% Source file for Armenian Times Bold 10pt font.
artmbi10.mf	% Source file for Armenian Times Bold Italic 10pt font.
artmbs10.mf	% Source file for Armenian Times Bold Slanted 10pt font.
artmi10.mf	% Source file for Armenian Times Italic 10pt font.
artmr10.mf	% Source file for Armenian Times (Roman) 10pt font.
artmsl10.mf	% Source file for Armenian Times Slanted 10pt font.
ps2mfbas.mf     % Common METAFONT macros for Armenian fonts.

fonts/tfm/public/armenian:
arssb10.tfm     % TFM file for Armenian SansSerif Bold 10pt font.
arssbs10.tfm	% TFM file for Armenian SansSerif Bold Slanted 10pt font.
arssr10.tfm	% TFM file for Armenian SansSerif (Roman) 10pt font.
arsssl10.tfm	% TFM file for Armenian SansSerif Slanted 10pt font.
artmb10.tfm	% TFM file for Armenian Times Bold 10pt font.
artmbi10.tfm	% TFM file for Armenian Times Bold Italic 10pt font.
artmbs10.tfm	% TFM file for Armenian Times Bold Slanted 10pt font.
artmi10.tfm	% TFM file for Armenian Times Italic 10pt font.
artmr10.tfm	% TFM file for Armenian Times (Roman) 10pt font.
artmsl10.tfm	% TFM file for Armenian Times Slanted 10pt font.

fonts/type1/public/armenian:
arssb10.pfb     % PFB file for Armenian SansSerif Bold 10pt font.
arssb10.pfm	% PFM file for Armenian SansSerif Bold 10pt font.
arssbs10.pfb	% PFB file for Armenian SansSerif Bold Slanted 10pt font.
arssbs10.pfm	% PFM file for Armenian SansSerif Bold Slanted 10pt font.
arssr10.pfb	% PFB file for Armenian SansSerif (Roman) 10pt font.
arssr10.pfm	% PFM file for Armenian SansSerif (Roman) 10pt font.
arsssl10.pfb	% PFB file for Armenian SansSerif Slanted 10pt font.
arsssl10.pfm	% PFM file for Armenian SansSerif Slanted 10pt font.
artmb10.pfb	% PFB file for Armenian Times Bold 10pt font.
artmb10.pfm	% PFM file for Armenian Times Bold 10pt font.
artmbi10.pfb	% PFB file for Armenian Times Bold Italic 10pt font.
artmbi10.pfm	% PFM file for Armenian Times Bold Italic 10pt font.
artmbs10.pfb	% PFB file for Armenian Times Bold Slanted 10pt font.
artmbs10.pfm	% PFM file for Armenian Times Bold Slanted 10pt font.
artmi10.pfb	% PFB file for Armenian Times Italic 10pt font.
artmi10.pfm	% PFM file for Armenian Times Italic 10pt font.
artmr10.pfb	% PFB file for Armenian Times (Roman) 10pt font.
artmr10.pfm	% PFM file for Armenian Times (Roman) 10pt font.
artmsl10.pfb	% PFB file for Armenian Times Slanted 10pt font.
artmsl10.pfm	% PFM file for Armenian Times Slanted 10pt font.

tex/latex/armenian:
armscii8.def    % ArmSCII8 input encoding definition file.
armtex.sty      % LaTeX package for writing in Armenian.
ot6cmr.fd       % OT6/cmr font definition file.
ot6cmss.fd      % OT6/cmss font definition file.
ot6enc.def      % OT6 encoding definition file.
ot6enc.dfu      % Armenian UTF-8 input encoding definition file.

tex/plain/armenian:
arm.tex         % Plain TeX input file for writing in Armenian.
armkb-a8.tex    % ArmSCII8 input encoding for plain TeX.
armkb-u8.tex    % Armenian UTF-8 input encoding for plain TeX.



5. Known problems and limitations

The spacing and kerning of the fonts may not always look very nice (especially
when the Armenian intonation signs are involved).  Actually, using the
128-character encoding OT6, it seems difficult to do better.  The
256-character encoding T6 is reserved for future releases of ArmTeX.  This
encoding will probably include both Armenian and Latin characters, Armenian
ligatures, as well as some "accented" symbols to solve spacing and kerning
problems.

There is no automatic hyphenation of Armenian words.  However, as a
workaround, the "loosespace" option can be used to avoid overfull/underfull
problems caused by the absence of the hyphenation (see ArmTeX manual for
details).

If you have any other problem [normally you should not ;-)] do not hesitate to
contact us.  Any bug reports and/or suggestions for improving ArmTeX are
welcome.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Below we give a brief description of the new (posterior to ArmTeX 2.0)
features.  This description is temporary: it will be removed when the manuals
of the version 3.0 are ready (before this beta release becomes official).


1) Unicode (UTF8) input is now supported (both in plain TeX and in LaTeX).

For LaTeX, the Unicode support is in the `ot6enc.dfu' file.  To load it, just
use the command "\usepackage[utf8]{inputenc}" in the preamble (or,
alternatively, the command "\inputencoding{utf8}" in the desired place) of
your document).

For plain TeX, it is in the `armkb-u8.tex' file.  To load it, just use the
command "\input armkb-u8".  By the way, `kbdencod.tex' file used to provide
ArmSCII8 input support in plain TeX was moved to `armkb-a8.tex' and, of
course, now must be loaded using the command "\input armkb-a8".


2) Armenian symbols can now be equally accessed (both in plain TeX and in
LaTeX) through macros like "\armayb", "\Armayb", "\armsep", "\armfullstop",
etc. (for the complete list, see `ot6enc.def' file).

Note that for ArmTeX 2.0 compatibility, "\armemdash" and "\armbl" are repeated
as "\textanjgic" and "\textbreaklig" respectively.

Note also, that the names of the macros (except "\armbl" and "\armuh") comply
with the "AST 34.001" standard.

Note finally, that in plain TeX, the primitives "\uppercase" and "\lowercase"
do not work with macro input, but only with ArmSCII8 and UTF8, as well as with
transliteration.  However, it is not a bug, it's a feature (this primitives
must ignore macros).  In LaTeX, these primitives work even worse (they work
only with transliteration).  However, in LaTeX, one can use the commands
"\MakeUppercase" and "\MakeLowercase" which work with all four types of input.


3) Since the symbol "\armew" does not have a standard position in ArmSCII8,
our ArmSCII8 input encoding files (both for plain TeX and for LaTeX) do not
support it by default.  However, it is now possible (when using ArmSCII8
input) to add the support of the "\armew" symbol with the help of the command
"\definearmew{X}", where "X" must be replaced by the character used as
"\armew" in your "version" of ArmSCII8 encoding (of course, this must be a
character from the second half of the extended ASCII table, that is, having a
charcode between 128 and 255).

Note that in order to make "\uppercase" and "\lowercase" macros work, the
plain TeX version of "\definearmew" defines the character with charcode 159
(which is normally unused in ArmSCII8) to be the "capital armew", that is, to
produce "\Armyech\Armvev".  If, for some reason, one prefers to use a
character with a different charcode as the "capital armew", the plain TeX
version of "\definearmew" has an additional optional argument, allowing to
specify the charcode value in the following way: "\definearmew[value]{X}",
where "X" must be replaced by the character used as "\armew" and "value" must
be between 128 and 255 (and different from the charcode of the character used
as "\armew").


4) Four new symbols are added to the fonts: "\armdram", "\armnum",
"\armeterity" and "\armabbrev".  For the latter, there is also a command
"\armabr" which puts the symbol on top of its argument.  So, now, all the
symbols present either in ArmSCII or in Armenian Unicode block are provided
(we do not provide Armenian ligatures located in Unicode at positions from
U+FB13 to U+FB17, but they can be used as input and, in this case, are
translated to the corresponding pairs of letters).


5) PostScript (Type 1) versions of the fonts are now provided (an AFM, a PFB
and a PFM file for each font).  This allows to obtain PDF and PS files which
look better on screen.  However, these fonts will be used only if the MAP
files `artm.map' and `arss.map' are "activated" during the installation (see
above).


6) Also, in order to make PDF files "searchable and copyable" in PDF viewers,
"ToUnicode" tables are set up using pdf(La)TeX primitives "\pdfgentounicode"
and "\pdfglyphtounicode".  However, "ToUnicode" tables work only with pdfLaTeX
and plain pdfTeX (they work neither in PS files, nor in PDF files produced in
a different from pdf(La)TeX way, like "(La)TeX + dvipdf" or "(La)TeX + dvips +
ps2pdf", etc.).


7) Macros dealing with Armenian numerals are now available.

- "\armnumeral" prints an "arbitrary length" integer as Armenian numeral (from
1 to 9999 part is written using Armenian letters in a classical way, from
10000 to 99990000 part is over-lined once, etc.).  Note that "\armnumeral" is
slightly different from the TeX primitive "\romannumeral": for example,
"\armnumeral\pageno" does not work (since "\pageno" is a count register, not
an integer value).  However, "\armnumeral" first expands its argument, so you
can use "\armnumeral{\the\pageno}" and/or "\armnumeral{\number\pageno}".

- "\unarmnumeral" stores the numerical value of an Armenian numeral (given as
an argument) in the TeX count register "\armnumeralcount" and also prints it
(except if you use "\unarmnumeral*" which prints nothing).  Note that this
macro is limited to integers from 1 to 9999 (it seems difficult to have an
over-lined input) and does not work with transliterated arguments, but only
with the three remaining types of input (ArmSCII8, UTF8, and macros).

- LaTeX specific macros "\armnumber" and "\unarmnumber" deal with LaTeX
counters:

\armnumber{toto} prints the value of the counter "toto" as Armenian numeral;

\unarmnumber{xxx}{toto} stores the value of the Armenian numeral "xxx" in the
  counter "toto";

\pagenumbering{armnumber} makes page numbers to be printed as Armenian
  numerals.


8) Also, there are new LaTeX specific macros "\armalph" and "\Armalph" which
work like "\alph" and "\Alph" do for the Latin alphabet (this is different
from Armenian numerals since, for example, the number "12" will be
"\Armzhe\Armben" in "\armnumber", but "\Armlyun" in "\Armalph").

If the counter toto contains the value "n" (between 1 and 36):

- \armalph{toto} prints the "n"-th letter of the Armenian alphabet in
  lowercase;

- \Armalph{toto} prints the "n"-th letter of the Armenian alphabet in
  uppercase.

Note that if "n" = 34, "\armvovyun" (or "\Armvovyun") is printed (according to
eastern Armenian).

Besides, "\pagenumbering{armalph}" and "\pagenumbering{Armalph}" make page
numbers to be printed correspondingly.

Finally, "\armalphs" (note the final "s") redefines LaTeX "\alph" and "\Alph"
to be "\armalph" and "\Armalph" respectively.  The macro "\armalphsoff"
cancels this (restores "\alph" and "\Alph" to the values they had
"AtBeginDocument").  Note also, that if the document is entirely in Armenian
(the package "armtex" is loaded without the "latin" option), "\armalphs" is
executed "AtBeginDocument".  This behavior is exactly the same as the one of
the macros "\armnames" and "\armnamesoff".  In the same style, there are new
macros "\armfontsdefault" and "\armfontsdefaultoff" which respectively define
all the default font properties (encoding, family, series and shape) to be
Armenian, and restore them to the values they had "AtBeginDocument".
Normally, all these macros are not needed to a user, but can serve if
producing a "really multilingual" document.


9) In both plain TeX and LaTeX, "\armdate" and "\armdateoff" are no longer
executed (in contrary to ArmTeX 2.0) each time you enter and you leave
Armenian mode (this behavior was dangerous, since it could interfere with some
packages which use "\today", say, in page headers).  To compensate, a new
macro "\armtoday" is provided.  Besides, like "\armnames", "\armalphs", etc.,
"\armdate" is executed (in LaTeX) "AtBeginDocument" (making "\today"
equivalent to "\armtoday") if the document is entirely in Armenian (the
package "armtex" is loaded without the "latin" option).

Note that "\armhyph" and "\armhyphoff" are still executed (as in ArmTeX 2.0)
each time you enter and you leave Armenian mode.


10) As a workaround to the absence of the hyphenation, the option
"loosespace<=n>" (here "=n" is optional and "n" is an integer) is added to the
"armtex" package.  By default, "n" = 6 if the option is specified without
"=n".  If "n" is less than or equal to 1, the option has no effect.
Otherwise, the inter-word spaces are "n" times looser than usual.  Normally,
"n" = 6 avoids most overfull/underfull problems caused by the absence of the
hyphenation, but one can specify more (or less) "loose".

In plain TeX, to make spaces looser, one needs to add "\def\armloosespace{n}"
before loading the `arm.tex' file, and there is no default value for "n".
