Package polexpr README
======================

License
-------

Copyright (C) 2018-2020 Jean-François Burnol

See documentation of package [xint](http://www.ctan.org/pkg/xint) for
contact information.

This Work may be distributed and/or modified under the conditions of the
LaTeX Project Public License version 1.3c. This version of this license
is in

> <http://www.latex-project.org/lppl/lppl-1-3c.txt>

and version 1.3 or later is part of all distributions of LaTeX version
2005/12/01 or later.

This Work has the LPPL maintenance status author-maintained.

The Author of this Work is Jean-François Burnol.

This Work consists of the package file polexpr.sty, this README.md and
the documentation file polexpr.txt.

Abstract
--------

The package provides `\poldef`. This a parser of polynomial expressions
based upon the `\xintdeffunc` mechanism of xintexpr.

The parsed expressions use the operations of algebra (inclusive of
composition of functions) with standard operators, fractional numbers
(possibly in scientific notation) and previously defined polynomial
functions or other constructs as recognized by the `\xintexpr` numerical
parser.

The polynomials are then not only genuine `\xintexpr` (and
`\xintfloatexpr`) numerical functions but additionally are known to the
package via their coefficients. This allows dedicated macros to
implement polynomial algorithmics.

Releases
--------

- 0.1 (2018/01/11)
  Initial release (files README, polexpr.sty).
- 0.2 (2018/01/14)
  Documentation moved to polexpr.{txt,html}.
- 0.3 (2018/01/17)
  Make polynomials known to `\xintfloatexpr` and improve
    documentation.
- 0.3.1 (2018/01/18)
  Fix two typos in documentation.
- 0.4 (2018/02/16)
  - Revert 0.3 automatic generation of floating point variants.
  - Move CHANGE LOG from README.md to HTML documentation.
  - A few bug fixes and breaking changes. Please refer to
      `polexpr.html`.
  - Main new feature: root localization via [Sturm
      Theorem](https://en.wikipedia.org/wiki/Sturm%27s_theorem).
- 0.4.1 (2018/03/01)
  Synced with xint 1.3.
- 0.4.2 (2018/03/03)
  Documentation fix.
- 0.5 (2018/04/08)
  - new macros `\PolMakePrimitive` and `\PolIContent`.
  - main (breaking) change: `\PolToSturm` creates a chain of primitive
      integer coefficients polynomials.
- 0.5.1 (2018/04/22)
  The `'` character can be used in polynomial names.
- 0.6 (2018/11/20)
  New feature: multiplicity of roots.
- 0.7 (2018/12/08), 0.7.1 (bugfix), 0.7.2 (bugfix) (2018/12/09)
  New feature: finding all rational roots.
- 0.7.3 (2019/02/04)
  Bugfix: polynomial names ending in digits caused errors. Thanks to
  Thomas Söll for report.
- 0.7.4 (2019/02/12)
  Bugfix: 20000000000 is too big for \numexpr, shouldn't I know that?
  Thanks to Jürgen Gilg for report.
- 0.7.5 (2020/01/31)
  Synced with xint 1.4. Requires it.

Files of 0.7.5 release:

- README.md,
- polexpr.sty (package file),
- polexpr.txt (documentation),
- polexpr.html (conversion via
    [DocUtils](http://docutils.sourceforge.net/docs/index.html)
    rst2html.py)

Acknowledgments
---------------

Thanks to Jürgen Gilg whose question about
[xint](http://www.ctan.org/pkg/xint) usage for differentiating
polynomials was the initial trigger leading to this package, and to
Jürgen Gilg and Thomas Söll for testing it on some concrete problems.
