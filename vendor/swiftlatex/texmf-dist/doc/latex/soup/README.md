**soup** is a package for facilitating the creation of word search
puzzles (aka alphabet soups) and variations using numbers or other
symbols in LaTeX documents.

A puzzle is a field of random letters in which a set of words are
hidden, and the reader seeks to find those words.

    A F N H L P
    K P L E F T
    L P N L U W
    G H A L C B
    I M D O T F

In the above example soup, two words are hidden: _hello_ and _left_.

The soup package generates alphabet soups, number soups, and soups
built from a user-specified list of symbols.


Dependencies
============

It relies on the following packages:

* expl3
* xparse
* l3keys2e
* tikz (unless [usetikz=false] specified at load)

Dependency on `tikz` is somewhat optional as the basic features have
also been implemented using a `tabular` environment.


Development Repository
======================

The development repository for this package is hosted at
 https://gitlab.com/simers/soup


License
=======

Copyright (C) 2017 by Thomas Simers

This file may be distributed and/or modified under the
conditions of the LaTeX Project Public License, either
version 1.3 of this license or (at your option) any later
version. The latest version of this license is in:
http://www.latex-project.org/lppl.txt
and version 1.3 or later is part of all distributions of
LaTeX version 2005/12/01 or later.
