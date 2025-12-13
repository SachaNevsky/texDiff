
An alternative to \include's for large works consisting of
several subdocuments. Still alpha.

This is a tentative package aiming to provide a different approach
for multidocument works (mainly, books with a document per chapter).
Unlike the \include mechanism, every subdocument is a complete LaTeX
document and can be typeset separately.  What the package does is
sharing the aux files.  It's still an alpha version, and no attempt
has been done yet to make it to work with, say, hyperref.

This approach has the following advantages:
1) Packages can be loaded just when a part requires them.
2) Generated pdf/dvi/ps files are kept.

You need a driver tex file containing a \subdocuments command
listing the files. With an optional argument you can set
its behaviour:

\subdocuments[clear=double]{file1, file2, file3}

The option clear=double adds an empty page at the end to give a even
number of pages.  clear=single doesn't and it's the default.  Spaces
and new lines before and after commas are ignored, as well as empty
items.  It relies on the keyval package, so names containing = must
be given within braces.

This file can be used as a shared preample, with common settings
for all the documents.

Documents must have the folowing line:

\usepackage[master]{subdocs}

where master is the name of the file described above.

Since every subdocument reads all the aux files, \tableofcontents
may be used where desired. 

License:     MIT
________
Javier Bezos --- http://www.texnia.com


