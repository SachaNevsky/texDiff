# The `kvmap` package

This LaTeX package allows the creation of (even large) Karnaugh maps. It
provides a tabular-like input syntax and support for drawing bundles
(implicants) around adjacent values.

Code example:

    \begin{kvmap}
      \begin{kvmatrix}{a,b,c,d}
        0 & 1 & 1 & 0\\
        1 & 0 & 0 & 1\\
        0 & 0 & 0 & 1\\
        0 & 1 & 1 & 1\\
      \end{kvmatrix}
      \bundle{3}{3}{2}{3}
      \bundle[color=blue]{3}{2}{3}{1}
      \bundle[invert=true,reducespace=2pt,overlapmargins=6pt]{1}{0}{2}{3}
      \bundle[invert=true,reducespace=2pt]{0}{1}{3}{1}
    \end{kvmap}
