<!-- -->

    Source:  filecontentsdef.dtx (v1.5 2019/09/29)
    Author:  Jean-Francois Burnol
    Info:    filecontents + macro + verbatim
    License: LPPL 1.3c
    Copyright (C) 2016-2019 Jean-Francois Burnol.
    <jfbu at free dot fr>

ABSTRACT
========

This lightweight LaTeX2e package provides an environment `filecontentsdef`
which is like the `filecontents` environment of Scott Pakin's
[filecontents] [1] package but in addition to the file creation stores the
(verbatim) contents into a macro given as an additional argument (either as a
control sequence or as a name).

Displaying verbatim these contents is possible via `\filecontentsprint`,
and executing them (if they represent LaTeX code) via `\filecontentsexec`.

A variant environment `filecontentsdefmacro` stores the contents into a
macro, but skips the save-to-a-file part.

[1]: http://www.ctan.org/pkg/filecontents "filecontents package"

CHANGE LOG
==========

v1.5 \[2019/09/29\]
-------------------

- `\filecontentsexec` does not forcefully reset `\newlinechar`
  to its LaTeX default after execution.

- `\FCD@` as prefix for internal non public macros.

- drop usage of the legacy LaTeX mechanism which issued a warning
  in case of a form feed or horizontal tabulation character in the
  parsed contents.

- make handling of the tabulation and form feed characters
  customizable.

- treat especially the case when the `\end{filecontents...}`
  is not on a line of its own.

- add `filecontentsdefstarred` (et al.) as alias for
  `filecontentsdef*` (et al.) for easying up encapsulation in
  wrapping environments.

- breaking change: `filecontentsdef` and `filecontentsdefmacro`
  define a macro obeying the local scope. Use `filecontentsgdef`,
  resp. `filecontentsgdefmacro` for definitions with global scope.

- make the name of the environment used by `\filecontentsprint`
  customizable (it defaults to `verbatim`) and allow to pass options
  to it; has been tested with `fancyvrb` and `minted`.

- add `\filecontentsprintviascan` which allows to use verbatim-like
  environment such as `listings` which are incompatible with
  `\filecontentsprint`.

v1.4 \[2019/04/20\]
-------------------

- backport 2018/04/01 LaTeX release change to filecontents environment
  (`^^L` and `^^I` definitions).

- add `filecontentsdefmacro` environment.

- extend `filecontentsdef` and `filecontentsdefmacro` environments as
  well as `\filecontentsprint` and `\filecontentsexec` macros to accept
  indifferently either a control sequence or a name as argument.

- refactor documentation, explain how to define wrapper environments.

v1.2 \[2016/09/19\]
-------------------

Initial version.

LICENSE
=======

This Work may be distributed and/or modified under the
conditions of the LaTeX Project Public License 1.3c.
This version of this license is in

> <http://www.latex-project.org/lppl/lppl-1-3c.txt>

and the latest version of this license is in

> <http://www.latex-project.org/lppl.txt>

and version 1.3 or later is part of all distributions of
LaTeX version 2005/12/01 or later.

The Author of this Work is:

- Jean-Francois Burnol `<jfbu at free dot fr>`

This Work consists of the main source file filecontentsdef.dtx and
its derived files filecontentsdef.sty, filecontentsdef.pdf,
filecontentsdef.dvi, README.md, INSTALL.md, README, INSTALL.
