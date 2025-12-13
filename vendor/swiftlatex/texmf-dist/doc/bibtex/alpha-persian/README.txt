%----------------------------------------------------------------------------------------------------------------------------%
%----------------------------------------------------------------------------------------------------------------------------%
Bib. style "alpha-persian", Persian (farsi)  version of alpha.bst and also for pdflatex compiler.
 by: Shapour Madadpour February 2019
E-mail: madad_sh@yahoo.com
This package is dependent to XePersian Package for persian language and also without it for pdflatex with help of the following commands:
%%%%%\let\lr\relax  %\let\setlatin\relax %\let\resetlatinfont\relax %\newenvironment{LTRbibitems}{}{}%%%%
This work is author-maintained (as per LPPL maintenance status)
by Shapour Madadpour 
%>>>%It has two user guide for persian language users (alpha-persian-p.userguide) and   english language users (alpha-persian-l.userguide).
%----------------------------------------------------------------------------------------------------------------------------%

Thanks to Mahmoud Amintoosi  and  Mostafa Vahedi for creating the other bibtex styles in persian.
%----------------------------------------------------------------------------------------------------------------------------%

For XePersian, a Persian Typesetting Package in XeTeX and also for pdflatex.
It may be distributed and/or modified under the
conditions of the LaTeX Project Public License (version 1.3c), 
either this version of this license or (at your option) any later version.
%-----------------------------------------------------------------------------------------------------------------------------%

% BibTeX standard bibliography style `alpha'
   % Version 0.99b (8-Dec-10 release) for BibTeX versions 0.99a or later.
   % Copyright (C) 1984, 1985, 1988, 2010 Howard Trickey and Oren Patashnik.
   % Unlimited copying and redistribution of this file are permitted as long as
   % it is unmodified.  Modifications (and redistribution of modified versions)
   % are also permitted, but only if the resulting file is renamed to something
   % besides btxbst.doc, plain.bst, unsrt.bst, alpha.bst, and abbrv.bst.
   % This restriction helps ensure that all standard styles are identical.
   % The file btxbst.doc has the documentation for this style.
%------------------------------------------------------------------------------------------------------------------------------%

 This style has all of properties alpha style. in addition to:
%++++++%%++++++++++++++++++++++++++++++++++++++++++++%    Changes    %++++++%%+++++++++++++++++++++++++++++++++++++++++++++++++%
%>>+ The title  structure, has essentially changed.
%>>+ isbn Added. It Writes in Persian style "شابک"..
%>>+ issn Added. It Writes in Persian style ""شاپا"".
%>>+ doi Added. It Writes in Persian style "شناسه‌ی دیجیتال".
%>>+ slabel Added. slabel field is used for arbitrary label.
%>>+ mlabel Added. mlabel field is used for a part of manual alpha style (just for author name and \etalchar) label in persian.
%>>+ madadurltest Added. madadurltest field  is needed for title (with link).
%>>+ murl Added. murl field is used for when you want to your title be with link.
%>>+ quotation  Added. quotation field is used for when you want to your title be with quotation mark.
%>>+ Compatible with hyperref, url, natbib and cite packages
%>>>+ This style has\noopsort command for sort the references manually.
%-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
%-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------%

address
author          % Set for english and persian language(LTR and RTL text).with et~al in persian and english.
booktitle
chapter         % Set for english and persian language(LTR and RTL text).
doi             %---Added and set for english and persian language(LTR and RTL text)---%It Writes in Persian style "شناسه‌ی دیجیتال".
edition         % Set for english and persian language(LTR and RTL text).
editor          % Set for english and persian language(LTR and RTL text).
howpublished
institution
isbn            %---Added and it set for english and persian language(LTR and RTL text)---%It Writes in Persian style "شابک".
issn            %---Added and it set for english and persian language(LTR and RTL text)---%It Writes in Persian style "شاپا".
journal
key
language        %---Added and  it set for  persian language(RTL text)---%
madadurltest    %---Added and  it set for english and persian language(LTR and RTL text)---%madadurltest={1},(with murl field)
                % is needed for title with link(this structure different from key structure). 
mlabel          %---Added and it set for english and persian language(LTR and RTL text)---%mlabel field is used for a part of manual alpha style (just for author name 
                %---and \etalchar) label in persian.
month
murl            %---Added and set for english and persian language(LTR and RTL text)---%murl field is used for when you want to your title be with link(with madadurltest={1} field).
note
number          % Set for english and persian language(LTR and RTL text).
organization
pages           % Set for english and persian language(LTR and RTL text).
publisher
quotation       %---Added and set for english and persian language(LTR and RTL text)---%quotation field is used for when you want to your title be with quotation mark.
school
series          % Set for english and persian language(LTR and RTL text).
slabel          %---Added and set for english and persian language(LTR and RTL text)---%slabel field is used for arbitrary label.(this structure different from key structure).
title           % The title  structure, has essentially changed. You can link it by fill in the murl field  with madadurltest={1} in the bibfile. Also you can show title with
                % or Without. quotation mark by fill in the questiton field in the bibfile.
type
url             %---Added and set for english and persian language(LTR and RTL text)---%   
volume          % Set for english and persian language(LTR and RTL text).
year