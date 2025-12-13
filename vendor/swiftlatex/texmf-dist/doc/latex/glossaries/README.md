# glossaries v4.46 (2020-03-19)

Author: Nicola Talbot ([contact](http://www.dickimaw-books.com/contact))

## LICENCE

This material is subject to the LaTeX Project Public License. 
See http://www.ctan.org/license/lppl1.3 
for the details of that license.

Copyright 2007-2020 Nicola Talbot

## DESCRIPTION

This package is provided to assist generating glossaries.
The package supports abbreviations and multiple glossaries.
New entries are defined to have a name and description (and
optionally an associated symbol). Plural forms can also be
specified.  New glossary styles can be defined, and preambles
and postambles can be specified. There is provision for loading
a database of terms where only terms used in the text will be added
to the relevant glossary.

*This package replaces the glossary package which is now obsolete.*

### Included supplementary files:

 - glossaries-prefix.sty: allows for the inclusion of a prefix (such
   as a determiner) before terms.

 - glossaries-accsupp.sty: an experimental package that uses the
   [accsupp](https://ctan.org/pkg/accsupp) package to 
   provide accessibility support for the glossaries package.

 - glossary style packages (such as glossary-list.sty and
   glossary-index.sty). Note that the list styles may be incompatible with 
   classes or packages that redefine the `description` environment.

 - a set of files containing lorem ipsum dummy entries for testing
   and debugging.

### Excluded supplementary packages (separate installation required):

  - language support packages, 
    e.g. [glossaries-english.sty](https://ctan.org/pkg/glossaries-english).

  - [glossaries-extra.sty](https://ctan.org/pkg/glossaries-extra) extends 
    glossaries.sty, providing more options and better abbreviation handling.

  - [bib2gls](https://ctan.org/pkg/bib2gls) alternative indexing
    application designed specifically for use with glossaries-extra.sty

## RELATED MATERIAL

 - [Package FAQ](http://www.dickimaw-books.com/faqs/glossariesfaq.html)

 - [Bug tracker](https://www.dickimaw-books.com/bugtracker.php?category=glossaries)

 - [Gallery](https://www.dickimaw-books.com/gallery/#glossaries)

 - [Document Build Advice](https://www.dickimaw-books.com/latex/buildglossaries/)

## INSTALLATION

The best and recommended method is through your TeX package manager, 
otherwise see INSTALL file for installation instructions.

To test your installation, compile `minimalgls.tex` which is provided
with the sample files:

```bash
pdflatex minimalgls
makeglossaries minimalgls
pdflatex minimalgls
```
or (if you don't have Perl installed):

```bash
pdflatex minimalgls
makeglossaries-lite minimalgls
pdflatex minimalgls
```

## REQUIREMENTS

 - amsgen
 - datatool-base
 - etoolbox
 - ifthen
 - mfirstuc
 - textcase
 - tracklang
 - xfor
 - xkeyval *at least version 2.5f (2006/11/18)*

If you want to use glossaries-accsupp.sty you will also need the accsupp package.

Some of the glossary styles require additional packages, which are
automatically loaded by the corresponding `glossary-`*name*`.sty`
package.

 - The `long` styles require longtable.sty.

 - The `super` styles require supertabular.sty.

 - The `ragged` styles required array.sty.

 - The `mcols` styles require multicol.sty.

 - The `booktab` styles require booktabs.sty.

If you want to use the `sm` acronym styles you will also need
relsizes.sty. This needs to be explicitly loaded in your document if
required.

If you want to use `\oldacronym` with `\xspace` you will also need
xspace.sty. This needs to be explicitly loaded in your document if
required. (Not recommended.)

## LaTeX2HTML

This package comes with a LaTeX2HTML style file glossaries.perl 
which should be placed in the relevant LaTeX2HTML
styles directory, but note that this style only supplies a sub-set
of the commands provided by glossaries.sty, so some
commands may not be implemented or may be implemented in a different
way. This file has not be tested with recent versions of
LaTeX2HTML and may no longer be compatible.
