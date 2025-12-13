
 
--------------------------------------------------------
The RUBIK bundle (version 5) February 24, 2018

rubikcube package    : macros for typesetting 3x3x3 cubes
rubiktwocube package : macros for typesetting 2x2x2 cubes 
rubikrotation package: macros Perl program for rotations
rubikpatterns package: macros for typesetting
--------------------------------------------------------

The RUBIK bundle provides four complementary packages for
documenting the Rubik cube (3x3x3) and Twocube (2x2x2)
notation and configurations, and for processing rotation 
sequences for both cubes. A Perl program which processes 
rotation sequences on the fly is also included. The four 
packages are: 
(a) the rubikcube (3x3x3) package, 
(b) the rubiktwocube (2x2x2) package (NEW),
(c) the rubikrotation package, 
(d) the rubikpatterns package.


 (1) rubikcube package (3x3x3 cubes)

 The rubikcube package provides a collection of LaTeX 
 commands and macros for typesetting Rubik cube 
 configurations and rotation instructions using the 
 PGF/TikZ graphic languages.
 

 (2) rubiktwocube package (2x2x2 cubes) NEW

 The rubiktwocube package provides a collection of LaTeX 
 commands and macros for typesetting TwoCube configurations 
 and rotation instructions using the PGF/TikZ graphic 
 languages.


 (3) rubikrotation package

 The rubikrotation package, is a dynamic extension to the 
 rubikcube and rubiktwocube packages. It consists of the 
 Perl script rubikrotation.pl and style option 
 rubikrotation.sty. The rubikrotation package implements 
 rotation sequences and random scrambling of the Rubik cube 
 on-the-fly, using the RubikRotation command. It returns 
 the new Rubik state in a form which can then be typeset 
 using commands from the Rubik bundle.

 Since the RubikRotation command works by CALLing the Perl 
 script rubikrotation.pl, it follows that the rubikrotation 
 package requires 
 (a) Perl to be installed, and 
 (b) (Pdf/Lua)LaTeX to be run using the --shell-escape 
 command-line switch (available from the shellesc package). 


 (4) rubikpatterns package

 The RubikPatterns package is a small database of well-known 
 patterns and sequences in the form of named macros which 
 can be processed easily using the RubikRotation command.
  

 (5) New features

 rubikcube:
 --- Improved documentation.
 --- Minor improvements to log-file documentation.
 --- New commands for drawing cube sidebars adjacent to 
     cube edges. 
 --- Two new commands for setting up WY (White opposite 
     Yellow) and WB (White opposite Blue) `starter grey 
     cubes'. 
 --- Bugfix for the \ShowSequence command (fixes a problem 
     of fonts not being contained appropriately). 
 --- Added some missing lower case rotation notation. 
 --- A new \NoSidebar command for disabling sidebars of a 
     specified colour (mainly for use with OLL displays).
 
 rubiktwocube:
 --- this is new package dealing with 2x2x2 cubes, having 
 similar functionality to the rubikcube package. 
 
 rubikrotation:
 --- minor code improvements in Perl programme, and 
     improved syntax checking.
 --- some minor bugfixes in Perl programme 
     (eg: a zero or missing integer with random keyword
     now generates an error message).
 --- added new keyword `cubesize' to hold cube size
     ie either `three' or `two' to inform Perl programme
     as to which sort of cube is being processed.    

 rubikpatterns: 
 --- (no change from v4).


-------------------------------------------------------
RWD Nickalls    email: dick@nickalls.org
A Syropoulos    email: asyropoulos@yahoo.com
-------------------------------------------------------

Copyright 2018 RWD Nickalls & A Syropoulos

Licence

This work may be distributed and/or modified under the 
 conditions of the LaTeX Project Public License, either 
 version 1.3 of this license or (at your option) any 
 later version. The latest version of this license is 
 in http://www.latex-project.org/lppl.txt and 
 version 1.3 or later is part of all distributions of 
 LaTeX version 2005/12/01 or later.
-------------------------------------------------------

The RUBIK bundle consists of the following files

Package files:
 - rubikcube.ins,
 - rubikcube.dtx,
 - rubikcube.sty,
 - rubiktwocube.ins,
 - rubiktwocube.dtx,
 - rubiktwocube.sty,
 - rubikrotation.ins,
 - rubikrotation.dtx,
 - rubikrotation.sty,
 - rubikrotation.pl    (Perl script)
 - rubikpatterns.ins
 - rubikpatterns.dtx 
 - rubikpatterns.sty
Documentation and README:
 - rubikcube.pdf
 - rubiktwocube.pdf
 - rubikrotation.pdf,
 - rubikrotationPL.pdf (Perl script documentation)
 - rubikrotationPL.tex
 - rubikrotation.1     (MAN file for Perl script)
 - rubikpatterns.pdf
 - rubikpatternsLIST.pdf
 - rubikpatternsLIST.tex
 - README.txt (this file)
Examples:
 - rubikexamples.pdf,
 - rubikexamples.tex
Image files:
 - pdf files for rubikcube documentation (6 pictures)
 - pdf files for rubiktwocube documentation (1 picture)
 - pdf files for rubikrotation documentation (4 pictures)
 - pdf files for rubikpatterns documentation (1 picture)
Bash and bat files (for processing rubikexamples.tex and 
     rubikpatternsLIST.tex) 
-------------------------------------------------------

If you have any ideas, suggestions, questions, or bugs 
to report, please contact us.
-------------------------------------------------------
