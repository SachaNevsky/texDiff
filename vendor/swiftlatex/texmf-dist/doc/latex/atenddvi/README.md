# atenddvi

atenddvi package for LaTeX



LaTeX offers \AtBeginDvi. This package atenddvi
provides the counterpart \AtEndDvi. The execution of its
argument is delayed to the end of the document at the end of the
last page. Thus \special and \write remain effective, because
they are put into the last page. This is the main difference
to \AtEndDocument.

