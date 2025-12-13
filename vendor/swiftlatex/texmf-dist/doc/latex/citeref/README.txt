 File:   README.txt
 Author: Bj"orn Briel (bjoern.briel@gmail.com)
 Date:   2018-04-07
 
This README describes citeref.sty

LICENSE: BSD (https://ctan.org/license/bsd4)

CREDITS
 Partially based on CITESIDX.STY by Frank Buchholz
 Contributions by Florian Werner Sauer
 

Main purpose:
 	Add reference-page-list to bibliography-items.

Features:
	- This is done WITHOUT using the index-facility.
 	- Full transparency - no special \cite-replacement
 	- Works with or without BibTeX
 	- No extra LaTeX runs needed, neither external programs
 	- Customizeable look of the back-references

Caveats:
 	- Does probably NOT work with other \cite-related style-options
 	  which redefine the (internal) \@citex macro
	- Citation tags may no longer contain a '=' char due to expansion
	  issues.

Usage:
 	\usepackage{citeref}
 	No Options declared

 	Change Style of printed page references by redefining the macro
 	'\bibitempages#1'. The parameter is a comma-separated list of 
	page references. The default macro puts it into brackets [...].

 	Print comments in the bibliography: Use the macro
	\bibintro{Blah...} before \thebibliography

Revision History:
	1999-01-05	Initial release
	1999-27-05	Got sometimes wrong page numbers;
	                Removed \immediate from \write of \citepageref-Macro
	                in redefinition of \@citex to fix this
	2018-04-07	Added licensing information


