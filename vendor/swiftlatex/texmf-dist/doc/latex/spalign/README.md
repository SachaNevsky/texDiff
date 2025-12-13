spalign version dated 2016-10-05
================================

The purpose of this package is to decrease the number of keystrokes needed to
typeset small amounts of aligned material (matrices, arrays, etc.).  For
instance, it is inconvenient to type (using the `amsmath` package)
```latex
\[\begin{matrix}
   1 & 12 & -3 \\
  24 & -2 &  2 \\
   0 &  0 &  1
  \end{matrix}\]
```
in a document where several hundred such matrices must be typeset.  Of course
one can always define a macro `\mat` which puts its argument inside a `matrix`
environment, but it is still necessary to type the align character `&` and the
end-of-row control sequence `\\` many times for each matrix.

This package provides a facility for typesetting matrices, and for using other
alignment environments and macros, with spaces as the alignment delimiter and
semicolons (by default) as the end-of-row indicator.  So the above matrix could
be produced using the command:
```latex
\[ \spalignmat{1 12 -3; 24 -2 2; 0 0 1} \]
```
This package also contains utility macros for typesetting augmented matrices,
vectors, arrays, systems of equations, and more, and is easily extendable to
other situations that use alignments.


## License

Copyright (C) 2016 by Joseph Rabinoff

This material is subject to the 
[LaTeX Project Public License v1.3](http://www.latex-project.org/lppl.txt)

