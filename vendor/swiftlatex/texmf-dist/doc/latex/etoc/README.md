<!-- -->

    Source:  etoc.dtx (v1.09b-2019/11/17)
    Author:  Jean-Francois Burnol
    Author:  Christine Roemer et al. (German tranlation)
    Info:    Completely customisable TOCs
    License: LPPL 1.3c
    Copyright (C) 2012-2019 Jean-Francois Burnol.
    Copyright (C) 2014-2019 Christine Roemer and collaborators for
    the translation into German of the documentation.
    <jfbu at free dot fr>    <Christine_Roemer at t-online dot de>

ABSTRACT
========

The etoc package gives to the user complete control on how the entries
of the table of contents should be constituted from the *name*,
*number*, and *page number* of each sectioning unit. This goes via the
definition of *line styles* for each sectioning level used in the
document. The package provides its own custom line styles. Simpler
ones are given as examples in the documentation. The simplest usage
will be to take advantage of the layout facilities of packages dealing
with list environments.

Regarding the *global toc display*, etoc provides pre-defined styles
based on a multi-column format, with, optionally, a ruled title or
framed contents.

The `\tableofcontents` command may be used arbitrarily many times and
it has a variant `\localtableofcontents` which prints tables of
contents 'local' to the current surrounding document unit. An
extension of the `\label/\ref` syntax allows to reproduce (with
another layout) a local table of contents defined somewhere else in
the document.

Via *depth tags*, one gets an even finer control for each table of
contents of which sectioning units it should, or not, display.

The formatting inherited (and possibly customized by other packages)
from the document class will be used when in compatibility mode.

The assignment of levels to the sectioning units can be changed at any
time, and etoc can thus be used in a quite general manner to create
custom ''lists of'', additionally to the tables of contents related to
the document sectioning units. No auxiliary file is used additionally
to the standard `.toc` file.

INSTALLATION
============

To extract the package (.sty) and driver (.tex) files from etoc.dtx,
execute `etex etoc.dtx`.

It is also possible to execute latex or pdflatex directly on etoc.dtx.

To produce etoc.pdf one can run pdflatex (thrice) directly on etoc.dtx or on
the file etoc.tex which was extracted from `etex etoc.dtx` step.

Options can be set in etoc.tex:

- scrdoc class options (paper size, font size, ...)
- with or without source code,
- with dvipdfmx or with latex+dvips or pdflatex.

Since release 1.08h pdflatex is the default in etoc.tex (prior it
was latex+dvipdfmx as it produces smaller PDFs) in order to allow
inclusion via the use of package `attachfile` of about 25 code
samples as file attachment annotations.

Installation:

    etoc.sty    -> TDS:tex/latex/etoc/etoc.sty
    etoc.dtx    -> TDS:source/latex/etoc/etoc.dtx
    etoc.pdf    -> TDS:doc/latex/etoc/etoc.pdf
    etoc-DE.pdf -> TDS:doc/latex/etoc/etoc-DE.pdf
    README.md   -> TDS:doc/latex/etoc/README.md

The other files may be discarded.

LICENSE
=======

This Work may be distributed and/or modified under the
conditions of the LaTeX Project Public License, in its
version 1.3c. This version of this license is in

> <http://www.latex-project.org/lppl/lppl-1-3c.txt>

and the latest version of this license is in

> <http://www.latex-project.org/lppl.txt>

and version 1.3 or later is part of all distributions of
LaTeX version 2005/12/01 or later.

The Authors of this Work are:

- Jean-Francois Burnol `<jfbu at free dot fr>` for the source code
  and English documentation, and
- Christine Roemer `<Christine_Roemer at t-online dot de>` and
  collaborators for the translation into German of the documentation.

This Work consists of the main source file etoc.dtx and the
derived files etoc.sty, etoc.tex, etoc-DE.tex,
etoc.pdf, etoc-DE.pdf, etoc.dvi, etoc-DE.dvi.

RECENT CHANGES
==============

v1.09a, v1.09b \[2019/11/17\]
-----------------------------

Sync with `memoir v3.7i` which has a better location of the TOC
hyperref anchor. The `\etocaftertitlehook` can now freely be
used also with memoir class (formerly its usage in case of
memoir class was preempted by etoc itself). For more details
refer to the section "Compatibility with the memoir class".

v1.09 \[2019/03/09\]
--------------------

New features: `\etoclocaltop`, `\localtableofcontentswithrelativedepth`.
Thanks to Tony Roberts for feature request.

Note to hackers: internal control sequence `\Etoc@localtop` is gone.

etoc now requires e-TeX (`\numexpr`, `\unless`).

v1.08p \[2018/07/04\]
---------------------

Fixed bug surfacing in case of `linktoc=page` option of hyperref.
Thanks to Denis Bitouzé for report (cf.
https://github.com/ho-tex/hyperref/issues/65,
https://github.com/dbitouze/yathesis/issues/61).

v1.08o \[2018/06/15\]
---------------------

Fixed bug showing up if an unnumbered TOC entry starts with a brace,
and document uses hyperref. Caused by a typo in a macro name at
previous release.

v1.08n \[2018/02/23\]
---------------------

Refactoring of core macros detecting `\numberline` and its variants.

v1.08m \[2018/02/07\]
---------------------

Fix to `1.08k`'s introduced incompatibility with KOMA-script
and tocbasic's `\nonumberline`.

v1.08l \[2017/10/23\]
---------------------

Workaround an issue with `Emacs/AUCTeX` wrongly reporting about
actually non-existent LaTeX errors, which was triggered by some
strings written (indirectly) to log file by etoc under some
circumstances.

v1.08k \[2017/09/28\]
---------------------

Adds `\etocsetlocaltop.toc`. See corresponding manual section for
details.

Adds `\etocsavedparttocline`, `\etocsavedchaptertocline`,
`\etocsavedsectiontocline`, ... They can be used in the context of
the technique explained in section "Another compatibility mode".

Formerly, etoc redefined for the duration of the TOC the memoir
macro `\chapternumberline` and its likes to have same meaning as
`\numberline` (of course, not when executed in compatibility mode),
for the sake of extraction of `\etocnumber`.

New method detects presence of any `\<foo>numberline` macro without
any change to originals; they can thus be used as is when applying
the approach of "Another compatibility mode" section from manual.

v1.08j \[2017/09/21\]
---------------------

Since `1.08a-2015/03/13` `\etocname`, `\etocnumber`, `\etocpage`
contain, if hyperref is present and configured for using
hyperlinks in the TOC, the link destination in already expanded
form. This means one can use them even if the style closes a
group (for example from a `&` in a tabular), if `\etocglobaldefs`
was issued; also one can save their meaning for delayed usage
(with for example `\LetLtxMacro` as they are robust).

But for some legacy reason `\etoclink`, contrarily to
`\etocthelink`, was handled differently. Now, `\etoclink` also
contains the link destination in already expanded form, and can
thus be used even if the line style issues a `&`, as long as
`\etocglobaldefs` is issued.

Also, bugs dating back to the early days of the package, but
surfacing only under relatively rare conditions such as usage
of hyperref with its option "linktoc=page" got fixed.

v1.08i \[2016/09/29\]
---------------------

This fixes an issue dating back to `1.08e-2015/04/17`: under
`\etocchecksemptiness` regime, some circumstances (such as adding to
an already compiled document a `\localtableofcontents` before the
main `\tableofcontents`) created an "`Undefined control sequence`
`\Etoc@localtop`" error. Thanks to Denis Bitouzé for reporting the
problem.

On this occasion, `\etocdoesnotcheckemptiness` has been
added to unset the flag.

A rather more exotic issue was fixed: the emptiness check for
local tocs could get confused if the `tocdepth` counter was varying
in some specific ways from inside the `toc` file.

After adding to a document a `\localtableofcontents`, two LaTeX
passes are needed for etoc to get a chance to print the
correct local contents. Formerly, etoc issued a Warning on
the first pass; it now also induces LaTeX into
announcing "There were undefined references", as this is nearer
to the end of the log file and console output.

v1.08h \[2016/09/25\]
---------------------

New functioning of `\etocsetnexttocdepth`: the tocdepth counter is
modified only at the time of the table of contents, not before. This
fixes an issue which arose when `\etocsetnexttocdepth` was used
multiple times with no intervening table of contents. Thanks to
Denis Bitouzé for reporting the problem.

The PDF documentation includes about 25 LaTeX code snippets also
as file attachment annotations, additionally to their verbatim
typesetting. The ordering of the documentation contents has been
slightly re-organized.

A previous documentation-only update on 2016/09/09 added a new
section with the (approximate) translation into etoc lingua of the
book class toc style, for easy customizability.

The latest translation into German of the additions made to the
documentation dates back to v1.08d \[2015/04/09\].

Thanks to Christine Römer!
