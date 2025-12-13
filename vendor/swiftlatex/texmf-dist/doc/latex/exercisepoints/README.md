# The exercisepoints Package
A LaTeX package to count exercises and points

## Introduction and Usage
This package can be used to facilitate exercise counting and exercise point counting in a LaTeX-document. It counts the number of exercises and it sums all the points of the exercises in a document. 
Especially for exams it is also common to have an overview of all exercises and their maximal points. This is also supported by this package by providing a macro to retrieve the points of each exercise.

### Load the Package
To use this package type
```
    \usepackage{exercisepoints}
```
anywhere in your document’s preamble. If this does not work because the package is not contained in your LaTeX-distribution, simply copy the file ‘exercisepoints.sty’ into the same folder as your document (or, if you plan to use it more often, copy it into your local texmf directory). There are no options and this package does not require any other packages to be loaded (it loads the ifthen package).

### Typeset a First Exercise
Now you can typeset your first exercise using the following code.
```
\begin{exercise}[Simple Addition] 
    What is 1+1?\points{2.5}
\end{exercise}
```

### Further Information
For further information please read the package documentation in ‘exercisepoints.pdf’ (you can either obtain this file from the GitHub releases page or simply compile the file ‘exercisepoints.tex’ twice with pdflatex).

## Version History
- *2019/01/03 v1.2.3* Revised README.md
- *2019/01/02 v1.2.2* Revised documentation
- *2018/08/15 v1.2.1* Renamed the package from *hkexercise* to *exercisepoints* to comply with CTAN rules (see [CTAN](https://ctan.org/file/help/ctan/CTAN-upload-addendum))
- *2017/02/27 v1.2.0* Added the ``\setitempointsunit{...}  `` command.
- *2017/07/02 v1.1.0* This version introduces subexercises. Moreover several checks were added to avoid use of commands like ``\currentexercisepoints`` outside of exercise environments and to prevent nesting of exercises. New option ``customlayout`` disables built in exercise layout. Added ``\bonuspoint`` commands.
- *2017/06/26 v1.0.1* Redefined ``\currentexercisepoints`` so it can be used within section command. 
- *2017/06/26 v1.0* The initial version of this package is published on GitHub.

## Copyright and License
Copyright © 2017-2019 Henning Kerstan.

This work may be distributed and/or modified under the conditions of the LaTeX Project Public License, either version 1.3 of this license or (at your option) any later version. The latest version of this license is in

[http://www.latex-project.org/lppl.txt](http://www.latex-project.org/lppl.txt)

and version 1.3 or later is part of all distributions of LaTeX version 2005/12/01 or later.

This work has the LPPL maintenance status ‘maintained’.

The Current Maintainer of this work is Henning Kerstan.

This work consists of the files ‘exercisepoints.sty’ and ‘exercisepoints.tex’.