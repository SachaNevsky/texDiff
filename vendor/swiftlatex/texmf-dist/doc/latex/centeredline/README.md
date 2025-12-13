<!-- -->

    Author:  Jean-Francois Burnol
    Package: centeredline
    Version: 1.1 (2019/05/03)
    License: LPPL 1.3c
    Copyright (C) 2019 Jean-Francois Burnol
    <jfbu at free dot fr>

# DESCRIPTION #

After `\usepackage{centeredline}` one can use

    \centeredline{....}

to get the argument centered, in a better way than with `\centerline`:

1. `\verb` or other catcode changes inside the argument are allowed,
2. the centering (with respect to the surrounding text paragraph) will
   be as expected if this all happens inside an item from a LaTeX list
   environment.

Material whose natural width exceeds the linewidth will get properly
centered too.

The macro itself may be encountered in paragraph or in vertical mode.
It places the argument inside a `\hbox` (inside an extra simple group).


# HISTORY #

I have used this macro since 2013 and it has served me well.

I am making it public as is, without any re-thinking about whether it may
have some limitations which I somehow did not encounter in my personal usage.
Suggestions for improvements are welcome, and will be recorded although I do
not expect to update the package anytime soon.


# CHANGE LOG #

- v1.0 (2019/04/27): First release.
- v1.1 (2019/05/03): Improved description (this file).


# LICENSE #

This Work may be distributed and/or modified under the
conditions of the LaTeX Project Public License 1.3c.
This version of this license is in

> <http://www.latex-project.org/lppl/lppl-1-3c.txt>

and the latest version of this license is in

> <http://www.latex-project.org/lppl.txt>

and version 1.3 or later is part of all distributions of
LaTeX version 2005/12/01 or later.

The Author of this Work is:

> Jean-Francois Burnol `<jfbu at free dot fr>`

This Work consists of the file `centeredline.sty` and
accompanying `README.md`.
