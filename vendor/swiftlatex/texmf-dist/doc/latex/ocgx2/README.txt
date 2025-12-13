==================================
 The `ocgx2' LaTeX Package

 https://gitlab.com/agrahn/ocgx2

 (C) 2015--\today Alexander Grahn
==================================


1. Introduction
===============

This package serves as a drop-in replacement for the already existing
packages `ocgx' by Paul Gaborit and `ocg-p' by Werner Moshammer for the
creation of PDF Layers.

It re-implements the functionality of the `ocg', `ocgx' and `ocg-p'
packages and adds support for all known engines and back-ends including

  *  LaTeX --> dvips --> ps2pdf/Distiller
  *  (Xe)LaTeX --> (x)dvipdfmx
  *  pdfLaTeX, luaLaTeX

To enable dvipdfmx support, pass `dvipdfmx' globally as a class option.

Also, it adds some minor improvements and bug fixes, such as package
options, remembering option settings of re-opened OCGs, correct behaviour
of layer switching links that were themselves placed on layers, correct
listing of (nested) OCGs in the layers tab of PDF viewers, compatibility
with the `animate' and `media9' packages.

  * New features:

    +  PDF layers extending over page breaks
    +  OCMDs (Optional Content Membership Dictionaries) for creating layers
       with complex visibility dependency
    +  grouping OCGs into Radio Button Groups
    +  additional keys for the TikZ interface of package `ocgx'
    +  re-implementing `hyperref's `ocgcolorlinks' option for creating
       OCG coloured links, which are printed on paper in the default
       text colour and which can, unlike the original `hyperref'
       implementation, extend over line and page breaks.


2. Usage
========

  \usepackage[<options>]{ocgx2}

  \begin{ocg}[<options>]{<layer name>}{<OCG id>}{<initial visibility>}
    ... material to be put on a PDF layer ...
  \end{ocg}

<layer name> is the name shown in the PDF viewer's "Layers" panel,
<OCG id> is an identifier used for referencing the layer elsewhere in the
document (e. g. layer switching buttons, visibility configuration of an `ocmd'
environment, re-opening the OCG at another place using the `ocg' environment).

<initial visibility> is `on', `true', `1' or `off', `false', `0'.

  \begin{ocmd}[<OCMD id>]{[<visibility policy>][,<visibility expression>]}
    ... material to be put on a PDF layer ...
    visibility calculated by <visibility expression> (Boolean expression) from
    other OCGs visibility, or according to <visibility policy>
  \end{ocmd}


Package and `ocg' environment options:

  viewocg = always | never | ifvisible
  printocg =  always | never | ifvisible
  exportocg =  always | never | ifvisible

  not in ocgx, ocg-p:

    showingui (to be preferred over `listintoolbar' of ocgx/ocg-p)
    radiobtngrps = {<group name 1>[,<group name 2>[, ...]]}

    tikz  (package-only option)
    ocgcolorlinks  (package-only option)

Package options have global scope. Environment options override package
options locally.

OCGs can be added to one or multiple Radio Button Groups using the new
option `radiobtngrps'. From all OCGs within a Radio Button Group only _one_
can be enabled at a time. Enabling an OCG, e. g. in the Layers tab of the PDF
viewer, automatically hides the previously visible OCG in the group. An OCG
can be added to multiple Radio Button Groups, passing a comma-separated list of
group names. Such a list must be enclosed in braces, `{...}'.

`ocg' as well as `ocmd' environments can be nested and span multiple pages.

See the `ocg-p' manual about the environment usage and the meaning of
the remaining options:

  texdoc ocg-p


3. The `ocmd' environment (Optional Content Membership Dictionary)
==================================================================

  \begin{ocmd}[<OCMD id>]{[<visibility policy>][,<visibility expression>]}
    ... material to be put on a PDF layer ...
  \end{ocmd}

This environment creates a PDF layer whose visibility is determined by the
current visibilities of other OCGs in the document according to at most one
visibility policy plus at most one visibility expression. If both are given
(with a comma in between) `<visibility expression>' takes precedence over
`<visibility policy>', but the latter may serve as a fallback in older PDF
viewers.

`<OCMD id>' is an optional identifier which can be used to re-open the same
layer with the same visibility setting at another place further down in the
document.

A `<visibility policy>' can be _one_ of

  \AllOn{<OCG id 1>, <OCG id 2>, ...}
  \AnyOn{<OCG id 1>, <OCG id 2>, ...}
  \AnyOff{<OCG id 1>, <OCG id 2>, ...}
  \AllOff{<OCG id 1>, <OCG id 2>, ...}

All four directives take a list of OCG ids from wich the OCMD visibility is
calculated. If the condition represented by the policy is met, the content
associated with the OCMD is shown. The listed OCGs can be defined anywhere in
the document. These directives can neither be combined nor nested in order to
define the policy. Thus, a visibility policy has limited capabilities.

A `<visibility expression>' is much more flexible than a policy. Arbitrarily
complex visibility relationships can be formulated, based on the Boolean
functions

  \And{<item a>, <item b>, ...}
  \Or{<item i>, <item j>, ...}
  \Not{<item n>}

In the argument list, items represent OCG/OCMD ids as well as nested Boolean
functions. As nesting of the three functions is possible, any thinkable
visibility relationship can be defined. Note that `\Not{...}' accepts only one
item, either an OCG/OCMD id or a nested function. Also note that Boolean functions
and policy directives cannot be intermixed.

As a trivial example, the visibility expression equivalent of the policy
directive `\AllOff{...}' is written as `\Not{ \Or{ ... } }'.


4. Clickable links for switching PDF layer visibility
=====================================================

The available commands are

  \switchocg[<trigger>]{<OCG ids to toggle, comma-separated>}{<link text>}
  \showocg[<trigger>]{<OCG ids to switch ON, comma-separated>}{<link text>}
  \hideocg[<trigger>]{<OCG ids to switch OFF, comma-separated>}{<link text>}
  \actionsocg[<trigger>]{<ids to toggle>}{<ids to switch ON>}{<ids to switch OFF>}{<link text>}

For details about their usage, read the `ocgx' package manual:

  texdoc ocgx

By default, links are triggered on mouse-click. Other triggers are possible
with `ocgx2'. For this, `ocgx2' provides the optional argument [<trigger>] to
the commands listed above. Choose one of

  onmousenter, onmouseexit, onmousedown, onmouseup, onmouseall

for  <trigger>. In order to listen to more than one mouse event, use
`onmouseall'. Layer ids in the mandatory argument(s) must then be grouped with
braces and commas as follows:

  {<mouse-enter group>}, {<mouse-exit group>}, {<mouse-down group>}, {<mouse-up group>}

Any of these groups may be left empty in order to configure only some
mouse triggers. Inside the groups, OCG ids are also separated by commas.
Therefore, braces must be put around the groups. For example:

  \switchocg[onmouseall]{
    , , {ocg1, ocg2, ocg3, ocg4}, {ocg1, ocg2, ocg3, ocg4}
  }{Toggle layers on mouse-down and -up}


5. Package option `ocgcolorlinks'
=================================

Is a re-implementation of the same `hyperref' option for creating OCG-
coloured links, which are printed on paper in the default text colour.

  \usepackage{hyperref} % do NOT set [ocgcolorlinks] here!
  \usepackage[ocgcolorlinks]{ocgx2}

Unlike the original `hyperref' implementation, OCG-coloured links are now
allowed to extend over line and page breaks. Moreover, with pdfLaTeX/LuaLaTeX,
OCG coloured links can be nested.

Breakable OCG coloured links work best with normal text as link text. If
the link text is mixed with graphical content, such as from external files or
inline graphics (e. g. TikZ) and even \fbox-ed text, these graphical parts must
be enclosed in

  \ocglinkprotect{...}

For example:

  \href{http://ctan.org}{Visit me on
                    \ocglinkprotect{\includegraphics{ctan-lion}}!}


5. Usage with TikZ
==================

`ocgx2' uses code from file `tikzlibraryocgx.code.tex' by P. Gaborit to
enable TikZ styles for creating PDF Layers and clickable layer switching
links in the `tikzpicture' context.

Just say:

  \usepackage[tikz]{ocgx2}

instead of

  \usepackage{tikz}
  \usetikzlibrary{ocgx}

to enable these TikZ styles and read the `ocgx' documentation about
their usage:

  texdoc ocgx

Package `ocgx2' adds the key `/tikz/ocg/opts' to the list in section ``How to
add TikZ scopes into OCGs'" in the `ocgx' manual:

  /tikz/ocg/opts={<OCG options>}

It can be used inside the `ocg' style

  \begin{scope}[
    ocg={ref=..., name=..., opts={..., ...}},
    ...
  ]
    ...
  \end{scope}

and allows passing `ocg'-environment options (`viewocg', `printocg', `exportocg',
`showingui', `radiobtngrps') to the TikZ scope.

The style `ocmd={...}' is another way for turning a TikZ scope into a PDF
layer (in addition to `ocg={...}'). It has two sub-keys, `ref={...}' and
`visibility={...}', which have the same meaning as the optional and the
mandatory arguments of the `ocmd' environment:

  \begin{scope}[
    ocmd={ref=..., visibility=...},
    ...
  ]
    ...
  \end{scope}


Moreover, TikZ objects to be turned into OCG switching hyperlinks (section "How
to transform nodes or paths into clickable links" in the `ocgx' manual) accept
the additional key

  /tikz/trigger ocg = onmousenter | onmouseexit | onmousedown | onmouseup
                      | onmouseall

which makes them listen to various mouse events, as explained above.


                     * * *


This material is subject to the LaTeX Project Public License. See

   http://mirrors.ctan.org/macros/latex/base/lppl.txt

for the details of that license.
