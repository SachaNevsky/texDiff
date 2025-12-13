---
author:
- Robert Alessi
title: 'The arabluatex package – README file'
---

Overview 
========

This package provides for [LuaLaTeX](http://luatex.org) an
[ArabTeX](http://ctan.org/pkg/arabtex)-like interface to generate Arabic
writing from an <span style="font-variant:small-caps;">ascii</span>
transliteration. It is particularly well-suited for complex documents
such as technical documents or critical editions where a lot of
left-to-right commands intertwine with Arabic writing. arabluatex is
able to process any ArabTeX input notation. Its output can be set in the
same modes of vocalization as ArabTeX, or in different roman
transliterations. It further allows many typographical refinements. It
will eventually interact with some other packages yet to come to produce
from `.tex` source files, in addition to printed books, `TEI xml`
compliant critical editions and/or lexicons that can be searched,
analyzed and correlated in various ways.

License and disclamer 
=====================

ArabLuaTeX – Processing ArabTeX notation under LuaLaTeX

Copyright ⓒ 2016–2020 Robert Alessi

Please send error reports and suggestions for improvements to Robert
Alessi:

-   email: <alessi@robertalessi.net>

-   website: <http://www.robertalessi.net/arabluatex>

-   comments, feature requests, bug reports:
    <https://gitlab.com/ralessi/arabluatex/issues>

This program is free software: you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the
Free Software Foundation, either version 3 of the License, or (at your
option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
Public License for more details.

You should have received a copy of the GNU General Public License along
with this program. If not, see &lt;http://www.gnu.org/licenses/&gt;.

This release of arabluatex consists of the following source files:

-   `arabluatex.ins`

-   `arabluatex.dtx`

-   `arabluatex.lua`

-   `arabluatex_voc.lua`

-   `arabluatex_fullvoc.lua`

-   `arabluatex_novoc.lua`

-   `arabluatex_trans.lua`

License applicable to the documentation 
---------------------------------------

Copyright ⓒ 2016–2020 Robert Alessi

The documentation file `arabluatex.pdf` that is generated from the
`arabluatex.dtx` source is licensed under the Creative Commons
Attribution-ShareAlike 4.0 International License. To view a copy of this
license, visit <http://creativecommons.org/licenses/by-sa/4.0/> or send
a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

Installation 
============

1.  Run `'lualatex arabluatex.ins'` to produce the `arabluatex.sty`
    file;

2.  To finish the installation you have to move the following files into
    a directory where LaTeX can find them. See the FAQ on `texfaq.org`
    at <https://texfaq.org/FAQ-inst-wlcf> for more on this:

    -   `arabluatex.sty`

    -   `arabluatex-patch.sty`

    -   `arabluatex.lua`

    -   `arabluatex_voc.lua`

    -   `arabluatex_fullvoc.lua`

    -   `arabluatex_novoc.lua`

    -   `arabluatex_trans.lua`

3.  Additionally, those who use emacs with AUCTeX may copy
    `arabluatex.el` to their `~/.emacs.d/auctex/auto` local directory.
    This will enable the appropriate hooks for ArabLuaTeX in AUCTeX.

Development, Git Repository 
===========================

Browse the code 
---------------

You can browse ArabLuaTeX repository on the web:
<http://git.robertalessi.net/arabluatex>

From this page, you can download all the releases of ArabLuaTeX. For
instructions on how to install ArabLuaTeX, please see above.

Comments, Feature requests, Bug Reports 
---------------------------------------

<https://gitlab.com/ralessi/arabluatex/issues>

Download the repository 
-----------------------

ArabLuaTeX development is facilitated by git, a distributed version
control system. You will need to install git (most GNU/Linux
distributions package it in their repositories).

Use this command to download the repository

    git clone http://git.robertalessi.net/arabluatex

A new directory named arabluatex will have been created, containing
ArabLuaTeX.

Git hosting 
-----------

Make an account on <https://gitlab.com> and navigate (while logged in)
to <https://gitlab.com/ralessi/arabluatex>. Click *Fork* and you will
have in your account your own repository of `arabluatex` where you will
be able to make whatever changes you like to.
