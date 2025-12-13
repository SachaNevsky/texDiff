# gridset

An experimental LaTeX package for semi-manual grid (a.k.a. in-register) setting

------------------------------------------------------------------------------

LaTeX package `gridset`  
Copyright (c) 2008—2020 Markus Kohm  
Release: 2020-02-12 v0.3  
License: LPPL 1.3c (see LICENSE.md)  
CTAN Location: https://ctan.org/pkg/gridset

------------------------------------------------------------------------------

## Summary

This package provides commands to save positions to and restore positions from
`aux`-file. This may be used for grid setting (a.k.a. strict in-register
setting).

## Status Note

This package should not have been released, because it was only a very
quick implementation of an idea. You should not use it for any productive
purpose.  It has been made for testing only.  I would prefer to retire it
from any distribution.  Nevertheless I know few persons using the package.
So it will be still there but without any support!

## Installation

The package is part of [TeX Live](https://tug.org/texlive) (and therefore
also [MacTeX](https://tug.org/mactex)) and [MiKTeX](http://miktex.org). Users
should use the packages provided by their TeX distribution.

However, manual extraction can be used to try out the developer version.

To extract the package use:

```bash
tex gridset.dtx
```

To create the manual use:

```bash
pdflatex gridset.dtx
mkindex gridset
pdflatex gridset.dtx
pdflatex gridset.dtx
```
