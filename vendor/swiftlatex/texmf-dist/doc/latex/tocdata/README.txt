The tocdata package.
Adds names to table of contents / list of figures entries.

v2.02 — 2019/03/21
Copyright 2016–2019 Brian Dunn — www.BDTechConcepts.com
LaTeX Project Public License, version 1.3


Summary:

The tocdata package may be used to add a small amount of data to an entry 
in the table of contents or list of figures, between the section or caption 
name and the page number.  The typical use would be to add the name of an 
author or artist of a chapter or section, such as in an anthology or a 
collection of papers.

Additionally, user-level macros are provided which add the author's
name to a chapter or section, along with an optional prefix and/or
suffix, and add to a figure the artist's name, prefix, and suffix,
plus optional additional text.  Author and artist names are also
added to the index.  Additional user-level macros control formatting.


Requirements:

Tocdata may be used with, but does not require, either the titletoc package
or the tocloft package.


Alternatives:

Tocdata places onto a single line the chapter/section name, author/artist
name, and page number.  Numerous other methods are available for adding
names to the TOC, but these usually place the chapter/section name and
page number onto one line, with the additional information on another line.
These methods would be preferable, and often required, if you wish
to place a lot of information in the TOC, or have long chapter or
section names.
