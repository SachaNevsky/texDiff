<!-- -->

    Source:  filecontentsdef.dtx (v1.5 2019/09/29)
    Author:  Jean-Francois Burnol
    Info:    filecontents + macro + verbatim
    License: LPPL 1.3c
    Copyright (C) 2016-2019 Jean-Francois Burnol.
    <jfbu at free dot fr>

INSTALLATION
============

Use your installation manager.

Else, for manual installation:

- To extract the package and at the same time produce the documentation,
  execute latex thrice on `filecontentsdef.dtx` then `dvipdfmx` on the
  `dvi` file.

  To customize the PDF documentation (paper size, etc...): execute `etex`
  once on `filecontentsdef.dtx` then follow instructions given inside the
  extracted file `filecontentsdef.tex`.

- To extract the package but not necessarily build the documentation:
  run `etex` on `filecontentsdef.dtx`.

Files should then be moved to appropriate locations:

    filecontentsdef.sty -> TDS:tex/latex/filecontentsdef/
    filecontentsdef.dtx -> TDS:source/latex/filecontentsdef/
    filecontentsdef.pdf -> TDS:doc/latex/filecontentsdef/
    README.md           -> TDS:doc/latex/filecontentsdef/
    INSTALL.md          -> TDS:doc/latex/filecontentsdef/

You can also place `filecontentsdef.sty` directly within the directory
of the project using it.
