The forms16b3 Package
Author: D. P. Story
Dated: 2019-03-20

The forms16be package provides support for UTF-16BE Unicode character 
encoding (called a big-endian character string) for the text string 
type (PDF Reference, version 1.7, beginning on page 158). Text strings are 
used in "text annotations, bookmark names, article threads, document 
information, and so forth" (to partially quote page 158). The particular 
application is to set property values of form fields, at least those 
properties that take the text strings as its value. The package contains 
support for Basic Latin plus the ability to enter any unicode character using 
the notation \uXXXX, where 'XXXX' are four hex digits. Package 
works for dvips/Distiller, pdflatex, lualatex, and xelatex. 

What's New (2019-03-20) Changed when macros are expanded; changes are in 
response to new features of insdljs (2019/03/16) and eforms (2019/03/16).
     
Enjoy!

Now, I must get back to my retirement.

dps
dpstory at uakron dot edu
